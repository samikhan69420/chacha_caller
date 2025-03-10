import 'package:chacha_caller/features/calling/domain/repositories/calling_repository.dart';
import 'package:chacha_caller/features/user/domain/entity/user_entity.dart';

class GetWorkersUsecase {
  final CallingRepository repository;

  GetWorkersUsecase({required this.repository});

  Stream<List<UserEntity>> call() {
    return repository.getWorkers();
  }
}
