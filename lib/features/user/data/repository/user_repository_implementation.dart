import 'package:chacha_caller/features/user/data/remote_data_source/remote_data_source.dart';
import 'package:chacha_caller/features/user/domain/entity/user_entity.dart';
import 'package:chacha_caller/features/user/domain/repository/user_repository.dart';

class UserRepositoryImplementation extends UserRepository {
  final RemoteDataSource remoteDataSource;

  UserRepositoryImplementation({
    required this.remoteDataSource,
  });

  @override
  Future<void> createUser(UserEntity user) async =>
      remoteDataSource.createUser(user);

  @override
  Future<String> getCurrentUid() async => remoteDataSource.getCurrentUid();

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) =>
      remoteDataSource.getSingleUser(uid);

  @override
  Future<bool> isSignedIn() => remoteDataSource.isSignedIn();

  @override
  Future<void> signInUser(UserEntity user) => remoteDataSource.signInUser(user);

  @override
  Future<void> signUpUser(UserEntity user) => remoteDataSource.signUpUser(user);

  @override
  Future<void> signOut() => remoteDataSource.signOut();
}
