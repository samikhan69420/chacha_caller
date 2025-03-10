import 'package:chacha_caller/features/user/domain/entity/user_entity.dart';

abstract class RemoteDataSource {
  Future<void> createUser(UserEntity user);
  Future<void> signInUser(UserEntity user);
  Future<void> signUpUser(UserEntity user);
  Stream<List<UserEntity>> getSingleUser(String uid);
  Future<String> getCurrentUid();
  Future<void> signOut();
  Future<bool> isSignedIn();
}
