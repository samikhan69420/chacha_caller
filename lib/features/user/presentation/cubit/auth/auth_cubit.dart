import 'package:bloc/bloc.dart';
import 'package:chacha_caller/features/user/domain/usecase/get_current_uid_usecase.dart';
import 'package:chacha_caller/features/user/domain/usecase/is_signed_in_usecase.dart';
import 'package:chacha_caller/features/user/domain/usecase/sign_out_usecase.dart';
import 'package:chacha_caller/features/user/presentation/cubit/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignOutUsecase signOutUsecase;

  final IsSignedInUsecase isSignedInUsecase;
  final GetCurrentUidUsecase getCurrentUidUsecase;
  AuthCubit({
    required this.isSignedInUsecase,
    required this.signOutUsecase,
    required this.getCurrentUidUsecase,
  }) : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      bool isSignIn = await isSignedInUsecase.call();
      final uid = await getCurrentUidUsecase.call();
      if (isSignIn == true) {
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticted());
      }
    } catch (_) {
      emit(AuthFailure());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUidUsecase.call();
      emit(Authenticated(uid: uid));
    } catch (_) {
      emit(UnAuthenticted());
    }
  }

  Future<void> signOut() async {
    try {
      await signOutUsecase.call();
      emit(UnAuthenticted());
    } catch (_) {
      emit(AuthFailure());
    }
  }

  Future<String> getUid() async {
    return await getCurrentUidUsecase.call();
  }
}
