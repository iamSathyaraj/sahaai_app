import 'package:sahaai/features/auth/data/models/otp_veryfy_request_model.dart';
import 'package:sahaai/features/auth/domain/repositories/auth_repositories.dart';

class VerifyOtpUseCase {
  final AuthRepository repo;

  VerifyOtpUseCase(this.repo);

  Future<bool> execute(OtpVerifyRequestModel model) {
    return repo.verifyOtp(model);
  }
}
