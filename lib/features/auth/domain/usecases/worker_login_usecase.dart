import 'package:sahaai/features/auth/data/models/login_request_model.dart';
import 'package:sahaai/features/auth/domain/entities/user_entity.dart';
import 'package:sahaai/features/auth/domain/repositories/auth_repositories.dart';

class WorkerLoginUseCase {
  final AuthRepository repository;

  WorkerLoginUseCase(this.repository);

  Future<UserEntity> call(LoginRequestModel model) {
    return repository.loginWorker(model);
  }
}
