import 'package:chacha_caller/features/user/domain/repository/user_repository.dart';

class SignOutUsecase {
  final UserRepository repository;

  SignOutUsecase({required this.repository});

  Future<void> call() {
    return repository.signOut();
  }
}
