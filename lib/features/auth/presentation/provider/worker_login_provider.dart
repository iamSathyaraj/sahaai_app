import 'package:flutter/material.dart';
import 'package:sahaai/features/auth/data/models/login_request_model.dart';
import 'package:sahaai/features/auth/domain/entities/user_entity.dart';
import 'package:sahaai/features/auth/domain/usecases/worker_login_usecase.dart';

class WorkerLoginProvider extends ChangeNotifier {
  final WorkerLoginUseCase workerLoginUseCase;

  WorkerLoginProvider(this.workerLoginUseCase);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? emailError;
  String? passwordError;
  bool isLoading = false;
  String? generalErrorMessage;
  UserEntity? loggedInWorker;

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

  Future<bool> submitLogin() async {
    if (!validate()) return false;

    isLoading = true;
    notifyListeners();

    try {
      final model = LoginRequestModel(
        userName: emailController.text.trim(),
        password: passwordController.text,
      );

      final worker = await workerLoginUseCase.call(model);
      loggedInWorker = worker;

      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      generalErrorMessage = e.toString();
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
