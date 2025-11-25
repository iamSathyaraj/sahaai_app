// import 'package:flutter/material.dart';
// import 'package:sahaai/features/auth/domain/usecases/login_usecase.dart';

// class LoginProvider extends ChangeNotifier {

// final LoginUseCase loginUseCase;

//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//     String? emailError;
//     String? passwordError;

//     bool validate() {
//     bool isValid = true;

//     if (emailController.text.isEmpty) {
//       emailError = 'Please enter email';
//       isValid = false;
//     } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
//         .hasMatch(emailController.text)) {
//       emailError = 'Please enter a valid email';
//       isValid = false;
//     } else {
//       emailError = null;
//     }

//     if (passwordController.text.isEmpty) {
//       passwordError = 'Please enter password';
//       isValid = false;
//     } else if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$')
//         .hasMatch(passwordController.text)) {
//       passwordError = 'Password is not strong enough';
//       isValid = false;
//     } else {
//       passwordError = null;
//     }

//     notifyListeners();
//     return isValid;
//   }

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

// }


import 'package:flutter/material.dart';
import 'package:sahaai/features/auth/data/models/login_request_model.dart';
import 'package:sahaai/features/auth/domain/entities/user_entity.dart';
import 'package:sahaai/features/auth/domain/usecases/login_usecase.dart';

class LoginProvider extends ChangeNotifier {

  LoginProvider();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? emailError;
  String? passwordError;
  
  bool isLoading = false;
  String? generalErrorMessage;

  void resetErrors() {
    emailError = null;
    passwordError = null;
    generalErrorMessage = null;
    notifyListeners();
  }

  bool validate() {
    resetErrors();
    bool isValid = true;

    final email = emailController.text.trim();
    if (email.isEmpty) {
      emailError = 'Email is required';
      isValid = false;
    } else if (!RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$").hasMatch(email)) {
      emailError = 'Enter a valid email';
      isValid = false;
    }

    final password = passwordController.text;
    if (password.isEmpty) {
      passwordError = 'Password is required';
      isValid = false;
    }

    notifyListeners();
    return isValid;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
