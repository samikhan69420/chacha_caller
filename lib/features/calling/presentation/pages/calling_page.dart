import 'package:chacha_caller/features/calling/presentation/cubit/calling_cubit.dart';
import 'package:chacha_caller/features/calling/presentation/pages/employee_page.dart';
import 'package:chacha_caller/features/calling/presentation/pages/worker_page.dart';
import 'package:chacha_caller/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:chacha_caller/features/user/presentation/cubit/user/user_cubit.dart';
import 'package:chacha_caller/features/user/presentation/cubit/user/user_state.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CallingPage extends StatefulWidget {
  const CallingPage({super.key});

  @override
  State<CallingPage> createState() => _CallingPageState();
}

class _CallingPageState extends State<CallingPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CallingCubit>(context).initApp().then(
          (value) => _initAppStart(),
        );
  }

  void _initAppStart() async {
    final uid = await BlocProvider.of<AuthCubit>(context).getUid();
    BlocProvider.of<CallingCubit>(context).oneSignalLogin(uid);
    BlocProvider.of<UserCubit>(context).getSingleUser(uid: uid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
          final user = userState.user;
          if (user.accountType == "WORKER") {
            return const WorkerPage();
          } else {
            return const EmployeePage();
          }
        } else {
          return const Scaffold(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            ),
          );
        }
      },
    );
  }
}
