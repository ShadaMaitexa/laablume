import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/admin_service.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();
    try {
      await AuthService().loadToken();
      if (AuthService().token != null) {
        final profile = await AuthService().getProfile();
        // The profile response usually wraps user data in 'user' or 'data'
        final data = profile['user'] ?? profile['data'] ?? profile;
        _currentUser = UserModel.fromJson(data);
      }
    } catch (e) {
      debugPrint('UserProvider init error: $e');
      await logout();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setCurrentUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> login(String mobileNumber, String otp, String role) async {
    _isLoading = true;
    notifyListeners();

    try {
      String phoneNumber = mobileNumber;
      if (role.toLowerCase() == 'admin') {
        String digits = mobileNumber.replaceAll(RegExp(r'\D'), '');
        if (digits.length >= 10) {
          phoneNumber = digits.substring(digits.length - 10);
        } else {
          phoneNumber = digits;
        }
      }

      Map<String, dynamic>? response;
      if (role.toLowerCase() == 'admin') {
        response = await AdminService().verifyOtp(phoneNumber, otp);
      } else {
        response = await AuthService().verifyOtp(
          phone: mobileNumber,
          otp: otp,
          role: role,
        );
      }

      if (response != null) {
        final user = UserModel.fromJson(response);

        // Enforce approval check for all roles except admin
        if (role != 'admin' && !user.isApproved) {
          throw Exception(
            'Your account is awaiting admin approval. Please try again later.',
          );
        }

        _currentUser = user;
      }
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    await AuthService().clearTokens();
    notifyListeners();
  }
}
