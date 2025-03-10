import 'package:chacha_caller/features/user/domain/repository/user_repository.dart';

class IsSignedInUsecase {
  final UserRepository repository;

  IsSignedInUsecase({required this.repository});

  Future<bool> call() {
    return repository.isSignedIn();
  }
}
