import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

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

  Future<void> login(String mobileNumber, String otp) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await AuthService().verifyOtp(
        phone: mobileNumber,
        otp: otp,
        role: 'patient',
      );

      if (response != null && response is Map<String, dynamic>) {
        // After verification, we fetch the full profile to ensure all fields (like dob) are present
        // and onboarding status is correctly determined.
        final profileResponse = await AuthService().getProfile();
        final data = profileResponse['user'] ?? profileResponse['data'] ?? profileResponse;
        final user = UserModel.fromJson(data);

        // Enforce approval check
        if (!user.isApproved) {
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
