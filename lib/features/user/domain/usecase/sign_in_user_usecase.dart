import 'package:chacha_caller/features/user/domain/entity/user_entity.dart';
import 'package:chacha_caller/features/user/domain/repository/user_repository.dart';

class SignInUserUsecase {
  final UserRepository repository;

  SignInUserUsecase({
    required this.repository,
  });
  Future<void> call(UserEntity user) {
    return repository.signInUser(user);
  }
}
