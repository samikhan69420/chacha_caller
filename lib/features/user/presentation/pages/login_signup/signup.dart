import 'package:chacha_caller/features/app/const/flutter_toast.dart' as toast;
import 'package:chacha_caller/features/calling/presentation/pages/calling_page.dart';
import 'package:chacha_caller/features/user/domain/entity/user_entity.dart';
import 'package:chacha_caller/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:chacha_caller/features/user/presentation/cubit/auth/auth_state.dart';
import 'package:chacha_caller/features/user/presentation/cubit/credentials/credentials_cubit.dart';
import 'package:chacha_caller/features/user/presentation/cubit/credentials/credentials_state.dart';
import 'package:chacha_caller/features/user/presentation/pages/login_signup/login.dart';
import 'package:chacha_caller/features/user/presentation/widgets/loading_dialog.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _LoginState();
}

class _LoginState extends State<SignUp> {
  int selected = -1;
  FocusNode usernameFocusNode = FocusNode();
  FocusNode gmailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController usernameController = TextEditingController();
  TextEditingController gmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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

  @override
  void dispose() {
    usernameFocusNode.dispose();
    gmailFocusNode.dispose();
    passwordFocusNode.dispose();
    //
    usernameController.dispose();
    gmailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void unfocusAll() {
    usernameFocusNode.unfocus();
    gmailFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        if (authState is Authenticated) {
          return const CallingPage();
        } else {
          return BlocBuilder<CredentialsCubit, CredentialsState>(
            builder: (context, credentialState) {
              return Stack(
                children: [
                  bodyWidget(context),
                  if (credentialState is CredentialLoading)
                    const LoadingDialog()
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
    String accountType = 'NULL';
    return GestureDetector(
      onTap: () {
        unfocusAll();
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
                    "Create\nAn Account",
                  ).h2(),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: usernameController,
                    focusNode: usernameFocusNode,
                    placeholder: 'Username',
                    leading: const Icon(RadixIcons.person),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: gmailController,
                    focusNode: gmailFocusNode,
                    placeholder: 'Email',
                    leading: const Icon(RadixIcons.envelopeClosed),
                  ),
                  const Gap(10),
                  TextField(
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                    placeholder: 'Password',
                    leading: const Icon(RadixIcons.lockClosed),
                    obscureText: true,
                  ),
                  const Gap(30),
                  Container(
                    height: 50,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.neutral.shade800),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Account Type:',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.neutral[400],
                          ),
                        ),
                        const Gap(10),
                        RadioGroup<int>(
                          value: selected,
                          onChanged: (value) {
                            setState(() {
                              selected = value;
                            });
                          },
                          child: const Row(
                            children: [
                              SizedBox(
                                height: 17,
                                child: RadioItem(
                                  value: 0,
                                  trailing: Text(
                                    'Employee',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                              Gap(10),
                              SizedBox(
                                height: 17,
                                child: RadioItem(
                                  value: 1,
                                  trailing: Text(
                                    'Worker',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(30),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: Button.primary(
                      onPressed: () async {
                        unfocusAll();
                        if (selected == 0) {
                          accountType = 'EMPLOYEE';
                        } else if (selected == 1) {
                          accountType = 'WORKER';
                        } else {
                          accountType = 'NULL';
                        }
                        BlocProvider.of<CredentialsCubit>(context)
                            .signUpUser(
                          user: UserEntity(
                            username: usernameController.text,
                            email: gmailController.text,
                            password: passwordController.text,
                            accountType: accountType,
                          ),
                        )
                            .then(
                          (value) {
                            BlocProvider.of<AuthCubit>(context).loggedIn();
                          },
                        );
                      },
                      child: const Text("Sign Up"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "or",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
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
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text('Login'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
