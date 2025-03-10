import 'package:chacha_caller/features/calling/presentation/pages/calling_page.dart';
import 'package:chacha_caller/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:chacha_caller/features/user/presentation/cubit/auth/auth_state.dart';
import 'package:chacha_caller/features/user/presentation/cubit/credentials/credentials_cubit.dart';
import 'package:chacha_caller/features/user/presentation/cubit/credentials/credentials_state.dart';
import 'package:chacha_caller/features/user/presentation/pages/login_signup/signup.dart';
import 'package:chacha_caller/features/user/presentation/widgets/loading_dialog.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../classes/notification_handler.dart';
import 'package:chacha_caller/features/app/const/flutter_toast.dart' as toast;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FocusNode gmailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController gmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  NotificationHandler notificationHandler = NotificationHandler();

  @override
  void dispose() {
    gmailFocusNode.dispose();
    passwordFocusNode.dispose();
    gmailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthCubit>(context).appStarted();
    BlocListener<CredentialsCubit, CredentialsState>(
      listener: (context, state) {
        if (state is CredentialFailure) {
          toast.showToast(state.message ?? 'An error occured please try again');
        }
      },
    );
  }

  // Build Method

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        if (authState is Authenticated) {
          return const CallingPage();
        } else {
          return BlocBuilder<CredentialsCubit, CredentialsState>(
            builder: (context, credState) {
              return Stack(
                children: [
                  bodyWidget(context),
                  if (credState is CredentialLoading) const LoadingDialog(),
                ],
              );
            },
          );
        }
      },
    );
  }

  // Body Widget

  Widget bodyWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        gmailFocusNode.unfocus();
        passwordFocusNode.unfocus();
      },
      child: Scaffold(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Login",
                  ).h2(),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: gmailController,
                    focusNode: gmailFocusNode,
                    placeholder: 'Email',
                    leading: const Icon(RadixIcons.envelopeClosed),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                    placeholder: 'Password',
                    leading: const Icon(RadixIcons.lockClosed),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      onPressed: () {
                        final String email = gmailController.text.trim();
                        final String password = passwordController.text.trim();
                        gmailFocusNode.unfocus();
                        passwordFocusNode.unfocus();
                        BlocProvider.of<CredentialsCubit>(context)
                            .signInUser(email: email, password: password)
                            .then(
                              (value) => BlocProvider.of<AuthCubit>(context)
                                  .loggedIn(),
                            );
                      },
                      child: const Text("Login"),
                    ),
                  ),
                  const Gap(20),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("or"),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Button.outline(
                      child: const Text('Create an account'),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUp(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
