import 'package:chacha_caller/features/calling/presentation/cubit/calling_cubit.dart';
import 'package:chacha_caller/features/user/domain/entity/user_entity.dart';
import 'package:chacha_caller/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:chacha_caller/features/app/const/flutter_toast.dart' as t;

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CallingCubit>(context).getWorkers();
  }

  List<UserEntity> selectedUsers = [];
  String? selectedRoom;

  final FocusNode nameFocusNode = FocusNode();

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CallingCubit, CallingState>(
      listener: (context, state) {
        if (state is CallingFailure) {
          t.showToast(state.message);
        }
      },
      child: Scaffold(
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
        child: BlocBuilder<CallingCubit, CallingState>(
          builder: (context, state) {
            if (state is CallingLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: nameController,
                            focusNode: nameFocusNode,
                            useNativeContextMenu: true,
                            onTapOutside: (event) {
                              nameFocusNode.unfocus();
                            },
                            placeholder: "Enter your name",
                          ),
                        ),
                        const Gap(10),
                        SizedBox(
                          height: 55,
                          child: Select<String>(
                            placeholder: const Text("Room"),
                            value: selectedRoom,
                            itemBuilder: (context, item) {
                              return Text(item);
                            },
                            onChanged: (value) {
                              setState(() {
                                selectedRoom = value;
                              });
                            },
                            children: const [
                              SelectItemButton(
                                value: "Room 1",
                                child: Text("Room 1"),
                              ),
                              SelectItemButton(
                                value: "Room 2",
                                child: Text("Room 2"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    Container(
                      constraints: const BoxConstraints(
                        minHeight: 100,
                        minWidth: double.infinity,
                      ),
                      child: StreamBuilder<List<UserEntity>>(
                        stream: state.users,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text("Loading...");
                          }

                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Basic(
                              leading: Icon(RadixIcons.circleBackslash),
                              title: Text('No Workers Available'),
                            );
                          }

                          List<UserEntity> users = snapshot.data!;

                          List<SelectItemButton<UserEntity>> userWidgets =
                              users.map((user) {
                            return SelectItemButton<UserEntity>(
                              value: user,
                              child: Text(user.username!),
                            );
                          }).toList();

                          return MultiSelect<UserEntity>(
                            autoClosePopover: true,
                            itemBuilder: (context, user) {
                              return Text(user.username!);
                            },
                            searchFilter: (item, query) {
                              return item.username!
                                      .toLowerCase()
                                      .contains(query.toLowerCase())
                                  ? 1
                                  : 0;
                            },
                            popupConstraints: const BoxConstraints(
                              maxHeight: 300,
                              maxWidth: 200,
                            ),
                            onChanged: (value) {
                              setState(() {
                                selectedUsers = value;
                              });
                            },
                            value: selectedUsers,
                            placeholder: const Text('Select Workers to call'),
                            children: userWidgets,
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        nameFocusNode.unfocus();
                        final name = nameController.text;
                        if (nameController.text.isEmpty) {
                          t.showToast("Please enter your name");
                        } else if (selectedUsers.isEmpty) {
                          t.showToast("Please select at least one worker");
                        } else {
                          if (selectedRoom == '' || selectedRoom == null) {
                            BlocProvider.of<CallingCubit>(context)
                                .sendNotificationUsecase(
                              "$name called you",
                              selectedUsers,
                            )
                                .then(
                              (value) {
                                // setState(() {
                                //   selectedUsers = [];
                                // });
                              },
                            );
                          } else {
                            BlocProvider.of<CallingCubit>(context)
                                .sendNotificationUsecase(
                              "$name called you in $selectedRoom",
                              selectedUsers,
                            )
                                .then(
                              (value) {
                                // setState(() {
                                //   selectedUsers = [];
                                // });
                              },
                            );
                          }
                        }
                      },
                      child: Container(
                        height: 55,
                        width: double.infinity,
                        color: Colors.white,
                        child: const Center(
                          child: Text(
                            "Send Notification",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
