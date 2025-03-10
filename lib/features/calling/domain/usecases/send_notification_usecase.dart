import 'package:chacha_caller/features/calling/domain/repositories/calling_repository.dart';
import 'package:chacha_caller/features/user/domain/entity/user_entity.dart';

class SendNotificationUsecase {
  final CallingRepository repository;
  SendNotificationUsecase({required this.repository});

  Future<void> call(String message, List<UserEntity> users) {
    return repository.sendNotification(message, users);
  }
}
