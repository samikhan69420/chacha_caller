import 'package:chacha_caller/features/calling/domain/repositories/calling_repository.dart';

class OnesignalLoginUsecase {
  final CallingRepository repository;

  OnesignalLoginUsecase({required this.repository});
  Future<void> call(String uid) {
    return repository.onesignalLogin(uid);
  }
}
