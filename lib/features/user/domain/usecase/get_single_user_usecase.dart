import 'package:chacha_caller/features/user/domain/entity/user_entity.dart';
import 'package:chacha_caller/features/user/domain/repository/user_repository.dart';

class GetSingleUserUsecase {
  final UserRepository repository;

  GetSingleUserUsecase({
    required this.repository,
  });
  Stream<List<UserEntity>> call(String uid) {
    return repository.getSingleUser(uid);
  }
}
