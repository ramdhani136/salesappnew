import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/auth/auth_bloc.dart';
import 'package:salesappnew/bloc/user/user_bloc.dart';
import 'package:salesappnew/widgets/profile_picture.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = UserBloc();
    return Drawer(
      child: Column(
        children: [
          BlocBuilder<UserBloc, UserState>(
            bloc: userBloc..add(GetUserLogin()),
            builder: (context, state) {
              if (state is UserLoading) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.grey[300],
                    ),
                  ),
                );
              }

              if (state is UserLoginLoaded) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromARGB(255, 239, 237, 237),
                          width: 1,
                        ),
                      ),
                    ),
                    width: Get.width,
                    height: 120,
                    child: ListView(
                      padding: const EdgeInsets.only(left: 15, top: 15),
                      children: [
                        const SizedBox(height: 25),
                        BlocProvider(
                          create: (context) => userBloc,
                          child: ProfilePicture(
                            data: state.data,
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                );
              }

              return Container();
            },
          ),
          Expanded(
            child: Container(
              width: Get.width,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                            Navigator.pushNamed(context, '/home');
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home,
                                size: 18,
                                color: Colors.grey[800],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Home",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                            Navigator.pushNamed(context, '/visit');
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.run_circle,
                                size: 18,
                                color: Colors.grey[800],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Visits",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                            Navigator.pushNamed(context, '/callsheet');
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.call,
                                size: 18,
                                color: Colors.grey[800],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Callsheets",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                            Navigator.pushNamed(context, '/so');
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.price_check_sharp,
                                size: 18,
                                color: Colors.grey[800],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Sales Order",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                            Navigator.pushNamed(context, '/invoice');
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.currency_exchange_outlined,
                                size: 18,
                                color: Colors.grey[800],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Invoice",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                            Navigator.pushNamed(context, '/dn');
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.fire_truck,
                                size: 18,
                                color: Colors.grey[800],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Delivery Note",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                            Navigator.pushNamed(context, '/item');
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.interests,
                                size: 18,
                                color: Colors.grey[800],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Items",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Version Beta 1.0.1',
              style: TextStyle(
                color: Colors.grey[500],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Color.fromARGB(255, 239, 237, 237),
                  width: 1,
                ),
              ),
            ),
            width: Get.width,
            height: 50,
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Really?"),
                      content: const Text("logout?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("No"),
                        ),
                        TextButton(
                          onPressed: () async {
                            BlocProvider.of<AuthBloc>(context).add(OnLogout());
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout,
                    size: 17,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
