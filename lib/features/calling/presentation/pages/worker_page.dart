import 'package:chacha_caller/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class WorkerPage extends StatelessWidget {
  const WorkerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingHeader: true,
        headers: [
          AppBar(
            leading: [
              OutlineButton(
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).signOut();
                },
                leading: const Icon(RadixIcons.pinLeft),
                child: const Text("Logout"),
              )
            ],
          ),
        ],
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              RadixIcons.person,
              size: 50,
            ),
            Gap(20),
            Center(
              child: Text("You are logged in as a worker"),
            ),
          ],
        ),
      ),
    );
  }
}
