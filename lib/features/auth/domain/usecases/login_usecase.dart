import 'package:sahaai/features/auth/data/models/login_request_model.dart';
import 'package:sahaai/features/auth/domain/repositories/auth_repositories.dart';

import '../entities/user_entity.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity> call(
    
  LoginRequestModel model
  ) {
    return repository.loginUser(model);
  }
}
