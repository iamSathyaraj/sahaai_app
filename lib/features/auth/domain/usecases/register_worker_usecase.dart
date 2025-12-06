import 'package:sahaai/features/auth/data/models/register_request_model.dart';
import 'package:sahaai/features/auth/data/models/worker_register_response_model.dart';
import 'package:sahaai/features/auth/domain/repositories/auth_repositories.dart';

class RegisterWorkerUseCase {
  final AuthRepository repository;

  RegisterWorkerUseCase(this.repository);

  Future<WorkerRegisterOtpData> call(RegisterRequestModel model) {
    return repository.registerWorker(model);
  }
}
