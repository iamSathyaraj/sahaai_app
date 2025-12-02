import 'package:flutter/material.dart';
import 'package:sahaai/core/enums/role.dart';
import 'package:sahaai/features/auth/data/models/register_request_model.dart';
import 'package:sahaai/features/auth/domain/usecases/register_usecase.dart';
import 'package:sahaai/features/auth/domain/usecases/register_worker_usecase.dart';

class RegisterProvider extends ChangeNotifier {

final RegisterUseCase registerUseCase;
final RegisterWorkerUseCase registerWorkerUseCase;

RegisterProvider(
  this.registerUseCase,
this.registerWorkerUseCase);

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
    int? registeredUserId;
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

  Future <bool> submitRegister(UserRole role)async{

    if(!validate()){
      return false;
    }

    isLoading=true;
    notifyListeners();

    try{
  final model=RegisterRequestModel(
    fullName: fullNameController.text.trim(),
     email: emailController.text.trim(),
     phone: phoneController.text.trim(),
       userName: usernameController.text.trim(),
        password: passwordController.text.trim(),
         confirmPassword: confirmPasswordController.text.trim()
         );
  print(" Sending register request… Role: $role");
  print(" Payload: ${model.toJson()}");

        
        if(role==UserRole.customer){
         final registerResponse = await registerUseCase.call(model); 
                  registeredUserId = registerResponse.userId ;
      print(" Customer registration success. User ID: ${registerResponse.userId}");


        }else{
          final worker= await registerWorkerUseCase.call(model);
                registeredUserId = worker.userId;
                      print("Worker registration success. User ID: ${worker.userId}");


            }


          isLoading = false;
      notifyListeners();
      return true;
} catch (e){  
  print(" Registration FAILED: $e");
  generalErrorMessage = e.toString();

  generalErrorMessage=e.toString();
  isLoading=false;
  notifyListeners();
  return false;
}

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
