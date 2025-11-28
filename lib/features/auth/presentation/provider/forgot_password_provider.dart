import 'package:flutter/material.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? errorMessage;
  String? successMessage;

  void resetMessages() {
    errorMessage = null;
    successMessage = null;
    notifyListeners();
  }

  Future<bool> sendResetLink(String email) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));

      successMessage = "Password reset link has been sent to your email.";
      errorMessage = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = "Failed to send reset link. Please try again.";
      successMessage = null;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
