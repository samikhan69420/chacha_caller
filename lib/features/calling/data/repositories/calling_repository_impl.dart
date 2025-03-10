import 'package:chacha_caller/features/calling/data/datasources/remote_data_source.dart';
import 'package:chacha_caller/features/calling/domain/repositories/calling_repository.dart';
import 'package:chacha_caller/features/user/domain/entity/user_entity.dart';

class CallingRepositoryImpl extends CallingRepository {
  final RemoteDataSource remoteDataSource;

  CallingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> initialAppStart() => remoteDataSource.initialAppStart();

  @override
  Future<void> onesignalLogin(String uid) =>
      remoteDataSource.onesignalLogin(uid);

  @override
  Future<void> sendNotification(String message, List<UserEntity> users) =>
      remoteDataSource.sendNotification(message, users);

  @override
  Stream<List<UserEntity>> getWorkers() => remoteDataSource.getWorkers();
}
