import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  void setCurrentUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> login(String mobileNumber, String otp, String role) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await AuthService().verifyOtp(
        phone: mobileNumber,
        otp: otp,
        role: role,
      );
      if (response != null) {
        _currentUser = UserModel.fromJson(response);
      }
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    _currentUser = null;
    AuthService().setToken('');
    notifyListeners();
  }
}
