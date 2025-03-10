import 'package:chacha_caller/features/calling/data/datasources/remote_data_source.dart';
import 'package:chacha_caller/features/calling/data/datasources/remote_data_source_impl.dart';
import 'package:chacha_caller/features/calling/data/repositories/calling_repository_impl.dart';
import 'package:chacha_caller/features/calling/domain/repositories/calling_repository.dart';
import 'package:chacha_caller/features/calling/domain/usecases/get_workers_usecase.dart';
import 'package:chacha_caller/features/calling/domain/usecases/initial_app_start_usecase.dart';
import 'package:chacha_caller/features/calling/domain/usecases/onesignal_login_usecase.dart';
import 'package:chacha_caller/features/calling/domain/usecases/send_notification_usecase.dart';
import 'package:chacha_caller/features/calling/presentation/cubit/calling_cubit.dart';
import 'package:chacha_caller/features/main_injection_container.dart';

Future<void> callingInjectionContainer() async {
  // Cubit

  sl.registerFactory<CallingCubit>(
    () => CallingCubit(
      getWorkersUsecase: sl.call(),
      initialAppStartUsecase: sl.call(),
      onesignalLoginUsecase: sl.call(),
      sendNotificationUsecase: sl.call(),
    ),
  );

  // Usecases

  sl.registerLazySingleton<InitialAppStartUsecase>(
    () => InitialAppStartUsecase(repository: sl.call()),
  );
  sl.registerLazySingleton<OnesignalLoginUsecase>(
    () => OnesignalLoginUsecase(repository: sl.call()),
  );
  sl.registerLazySingleton<SendNotificationUsecase>(
    () => SendNotificationUsecase(repository: sl.call()),
  );
  sl.registerLazySingleton<GetWorkersUsecase>(
    () => GetWorkersUsecase(repository: sl.call()),
  );

  // Repository

  sl.registerLazySingleton<CallingRepository>(
    () => CallingRepositoryImpl(
      remoteDataSource: sl.call(),
    ),
  );
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(),
  );
}
