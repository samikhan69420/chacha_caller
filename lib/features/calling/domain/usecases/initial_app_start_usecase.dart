import 'package:chacha_caller/features/calling/domain/repositories/calling_repository.dart';

class InitialAppStartUsecase {
  final CallingRepository repository;

  InitialAppStartUsecase({required this.repository});
  Future<void> call() {
    return repository.initialAppStart();
  }
}
