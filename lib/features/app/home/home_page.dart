import 'package:chacha_caller/classes/notification_handler.dart';
import 'package:chacha_caller/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final UserCredential? credential;
  final SharedPreferences sharedPreferences;
  const HomePage({
    super.key,
    this.credential,
    required this.sharedPreferences,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();

  FocusNode focusNode = FocusNode();
  NotificationHandler notificationHandler = NotificationHandler();

  bool isChacha = false;

  Future<void> setName(String name) async {
    widget.sharedPreferences.setString('name', name);
  }

  Future<String> getName() async {
    return widget.sharedPreferences.getString('name') ?? 'Name';
  }

  Future<void> setNameToController(TextEditingController controller) async {
    Future<String> name = getName();
    controller.text = await name;
  }

  @override
  void initState() {
    setNameToController(nameController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IntrinsicWidth(
                    child: TextField(
                      controller: nameController,
                      textAlign: TextAlign.center,
                      focusNode: focusNode,
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                      decoration: const InputDecoration(
                        hintText: "Name",
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(width: 10),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    " Called you.",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              FilledButton(
                onPressed: () async {
                  setName(nameController.text);
                },
                child: const Text("Call"),
              ),
              FilledButton(
                onPressed: () async {
                  BlocProvider.of<AuthCubit>(context).signOut();
                },
                child: const Text("Log Out"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
