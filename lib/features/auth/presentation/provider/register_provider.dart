import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {

RegisterProvider();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  

  String? usernameError;
  String? emailError;
  String? fullNameError;
  String? phoneError;
  String? passwordError;
  String? confirmPasswordError;

    bool isLoading = false;
    String? registeredUserId;
  String? generalErrorMessage;

  void resetErrors() {
    usernameError = null;
    emailError = null;
    fullNameError = null;
    phoneError = null;
    passwordError = null;
    confirmPasswordError = null;
    generalErrorMessage=null;
    notifyListeners();
  }

  bool validate() {
    resetErrors();
    bool isValid = true;

    if (usernameController.text.trim().isEmpty) {
      usernameError = 'Username is required';
      isValid = false;
    }

    final email = emailController.text.trim();
    if (email.isEmpty) {
      emailError = 'Email is required';
      isValid = false;
    } else if (!RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$").hasMatch(email)) {
      emailError = 'Enter a valid email';
      isValid = false;
    }

    final fullname = fullNameController.text.trim();
    if(fullname.isEmpty){
      fullNameError = 'Full name is required';
      isValid = false;

    }

    final phone = phoneController.text.trim();
    if (phone.isEmpty) {
      phoneError = 'Phone number is required';
      isValid = false;
    } else if (!RegExp(r'^\d{10}$').hasMatch(phone)) {
      phoneError = 'Enter a valid 10-digit phone number';
      isValid = false;
    }

 
    final pass = passwordController.text;
    if (pass.isEmpty) {
      passwordError = 'Password is required';
      isValid = false;
    } else if (pass.length < 8) {
      passwordError = 'Password must be at least 8 characters';
      isValid = false;
    }

      final confirmPass=confirmPasswordController.text;
    if (confirmPass.isEmpty) {
      confirmPasswordError = 'Confirm your password';
      isValid = false;
    } else if (pass != confirmPasswordController.text) {
      confirmPasswordError = 'Passwords do not match';
      isValid = false;
    }

    notifyListeners();
    return isValid;
  }

 

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
