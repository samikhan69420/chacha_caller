import 'package:chacha_caller/features/user/domain/entity/user_entity.dart';
import 'package:chacha_caller/features/user/domain/repository/user_repository.dart';

class CreateUserUsecase {
  final UserRepository repository;

  CreateUserUsecase({
    required this.repository,
  });
  Future<void> call(UserEntity user) {
    return repository.createUser(user);
  }
}
