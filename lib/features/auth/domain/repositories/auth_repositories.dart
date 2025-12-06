import 'package:sahaai/features/auth/data/models/login_request_model.dart';
import 'package:sahaai/features/auth/data/models/otp_veryfy_request_model.dart';
import 'package:sahaai/features/auth/data/models/register_request_model.dart';
import 'package:sahaai/features/auth/data/models/register_response_model.dart';
import 'package:sahaai/features/auth/data/models/resend_otp_request_model.dart';
import 'package:sahaai/features/auth/data/models/worker_register_response_model.dart';
import 'package:sahaai/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<RegisterOtpData> registerUser(RegisterRequestModel model);
  Future<WorkerRegisterOtpData> registerWorker(RegisterRequestModel model);

  Future<UserEntity> loginUser(LoginRequestModel model);
  Future<UserEntity> loginWorker(LoginRequestModel model);

  Future<bool> verifyOtp(OtpVerifyRequestModel model);
   Future<bool> resendOtp(ResendOtpRequestModel model);

  Future<void> logout();
  Future<bool> isLoggedIn();
}
