import 'package:chacha_caller/features/user/domain/entity/user_entity.dart';

abstract class RemoteDataSource {
  Future<void> initialAppStart();
  Future<void> onesignalLogin(String uid);
  Future<void> sendNotification(String message, List<UserEntity> users);
  Stream<List<UserEntity>> getWorkers();
}
