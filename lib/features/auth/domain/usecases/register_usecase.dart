import 'package:sahaai/features/auth/data/models/register_request_model.dart';
import 'package:sahaai/features/auth/data/models/register_response_model.dart';
import 'package:sahaai/features/auth/domain/repositories/auth_repositories.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<RegisterOtpData> call(RegisterRequestModel model) {
    return repository.registerUser(model
    );
  }

}
