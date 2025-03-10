import 'package:chacha_caller/features/calling/calling_injection_container.dart';
import 'package:chacha_caller/features/user/user_injection_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(
    () => auth,
  );
  sl.registerLazySingleton(
    () => firestore,
  );
  sl.registerLazySingleton(
    () => sharedPreferences,
  );

  await userInjectionContainer();
  await callingInjectionContainer();
}
