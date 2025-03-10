import 'package:chacha_caller/features/user/domain/repository/user_repository.dart';

class GetCurrentUidUsecase {
  final UserRepository repository;

  GetCurrentUidUsecase({required this.repository});

  Future<String> call() {
    return repository.getCurrentUid();
  }
}
