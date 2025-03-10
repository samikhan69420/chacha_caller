import 'package:chacha_caller/features/main_injection_container.dart';
import 'package:chacha_caller/features/user/data/remote_data_source/remote_data_source.dart';
import 'package:chacha_caller/features/user/data/remote_data_source/remote_data_source_implementation.dart';
import 'package:chacha_caller/features/user/data/repository/user_repository_implementation.dart';
import 'package:chacha_caller/features/user/domain/repository/user_repository.dart';
import 'package:chacha_caller/features/user/domain/usecase/create_user_usecase.dart';
import 'package:chacha_caller/features/user/domain/usecase/get_current_uid_usecase.dart';
import 'package:chacha_caller/features/user/domain/usecase/get_single_user_usecase.dart';
import 'package:chacha_caller/features/user/domain/usecase/is_signed_in_usecase.dart';
import 'package:chacha_caller/features/user/domain/usecase/sign_in_user_usecase.dart';
import 'package:chacha_caller/features/user/domain/usecase/sign_out_usecase.dart';
import 'package:chacha_caller/features/user/domain/usecase/sign_up_user_usecase.dart';
import 'package:chacha_caller/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:chacha_caller/features/user/presentation/cubit/credentials/credentials_cubit.dart';
import 'package:chacha_caller/features/user/presentation/cubit/user/user_cubit.dart';

Future<void> userInjectionContainer() async {
  // Cubit injection

  sl.registerFactory<UserCubit>(
    () => UserCubit(
      getSingleUserUsecase: sl.call(),
    ),
  );
  sl.registerFactory<CredentialsCubit>(
    () => CredentialsCubit(
      signInUserUsecase: sl.call(),
      signUpUserUsecase: sl.call(),
    ),
  );
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      getCurrentUidUsecase: sl.call(),
      isSignedInUsecase: sl.call(),
      signOutUsecase: sl.call(),
    ),
  );

  // Usecases Injection

  sl.registerLazySingleton<CreateUserUsecase>(
    () => CreateUserUsecase(repository: sl.call()),
  );
  sl.registerLazySingleton<GetCurrentUidUsecase>(
    () => GetCurrentUidUsecase(repository: sl.call()),
  );
  sl.registerLazySingleton<GetSingleUserUsecase>(
    () => GetSingleUserUsecase(repository: sl.call()),
  );
  sl.registerLazySingleton<IsSignedInUsecase>(
    () => IsSignedInUsecase(repository: sl.call()),
  );
  sl.registerLazySingleton<SignInUserUsecase>(
    () => SignInUserUsecase(repository: sl.call()),
  );
  sl.registerLazySingleton<SignUpUserUsecase>(
    () => SignUpUserUsecase(repository: sl.call()),
  );
  sl.registerLazySingleton<SignOutUsecase>(
    () => SignOutUsecase(repository: sl.call()),
  );

  // Repository

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImplementation(remoteDataSource: sl.call()),
  );

  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImplementation(firestore: sl.call(), auth: sl.call()),
  );
}
