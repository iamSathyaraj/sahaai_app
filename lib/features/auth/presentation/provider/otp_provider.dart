import 'package:flutter/material.dart';
import 'package:sahaai/features/auth/data/models/otp_veryfy_request_model.dart';
import 'package:sahaai/features/auth/domain/usecases/otp_verify_usecase.dart';

class OtpProvider extends ChangeNotifier {
  final VerifyOtpUseCase verifyOtpUseCase;

  OtpProvider(this.verifyOtpUseCase);

final List<TextEditingController>otpControllers= List.generate(6, (_) =>TextEditingController() );

  bool isLoading = false;
  String? errorMessage;

  String get otps {
    return otpControllers.map((c)=>c.text.trim()).join();

  }
   void clearOtp() {
    for (final controller in otpControllers) {
      controller.clear();
    }
    notifyListeners();
  }

    bool validateOtp() {
    if (otps.length != 6) {
      errorMessage = "Enter a valid 6-digit OTP";
      notifyListeners();
      return false;
    }
    errorMessage = null;
    return true;
  }


  Future<bool> submitOtp(String userId) async {

    if(!validateOtp()){
      return false;
    }
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {

   final  model=OtpVerifyRequestModel(userId: userId, otp: otps);

      final success = await verifyOtpUseCase.execute(model);

      isLoading = false;
      notifyListeners();
      return success;
    } catch (e) {
      errorMessage = e.toString();
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
   for(var controller in otpControllers){
    controller.dispose();
   }
    super.dispose();
  }
}
