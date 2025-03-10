import 'package:chacha_caller/features/calling/presentation/cubit/calling_cubit.dart';
import 'package:chacha_caller/features/calling/presentation/pages/calling_page.dart';
import 'package:chacha_caller/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:chacha_caller/features/user/presentation/cubit/auth/auth_state.dart';
import 'package:chacha_caller/features/user/presentation/cubit/credentials/credentials_cubit.dart';
import 'package:chacha_caller/features/user/presentation/cubit/user/user_cubit.dart';
import 'package:chacha_caller/features/user/presentation/pages/login_signup/signup.dart';
import 'package:chacha_caller/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'features/main_injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  dotenv.load(fileName: '.env');
  await di.init();
  Animate.restartOnHotReload = true;
  runApp(
    ToastificationWrapper(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<UserCubit>(
            create: (context) => di.sl<UserCubit>(),
          ),
          BlocProvider<AuthCubit>(
            create: (context) => di.sl<AuthCubit>(),
          ),
          BlocProvider<CredentialsCubit>(
            create: (context) => di.sl<CredentialsCubit>(),
          ),
          BlocProvider<CallingCubit>(
            create: (context) => di.sl<CallingCubit>(),
          ),
        ],
        child: ShadcnApp(
          theme: ThemeData(
            colorScheme: ColorSchemes.darkNeutral(),
            radius: 0.5,
          ),
          home: const MainApp(),
        ),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return const CallingPage();
        } else {
          return const SignUp();
        }
      },
    );
  }
}
