// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salesappnew/bloc/user/user_bloc.dart';
import 'package:salesappnew/config/Config.dart';
import 'package:salesappnew/widgets/back_button_custom.dart';
import 'package:salesappnew/widgets/custom_field.dart';

class UserSetting extends StatefulWidget {
  UserBloc bloc;
  UserBloc userBloc = UserBloc();
  UserSetting({super.key, required this.bloc});

  @override
  State<UserSetting> createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  TextEditingController nameC = TextEditingController();
  TextEditingController userNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController erpSiteC = TextEditingController();
  TextEditingController erpTokenC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  @override
  void dispose() {
    nameC.dispose();
    userNameC.dispose();
    emailC.dispose();
    phoneC.dispose();
    erpSiteC.dispose();
    erpTokenC.dispose();
    passwordC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFE6212A),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BackButtonCustom(onBack: () {}),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.person_pin, size: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: Text(
                    " Profile Setting",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 121, 8, 14),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          widget.userBloc.add(
            GetUserLogin(),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder(
              bloc: widget.userBloc..add(GetUserLogin()),
              builder: (context, state) {
                if (state is UserLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey[400],
                    ),
                  );
                }

                if (state is UserLoginLoaded) {
                  nameC.text = state.data.name!;
                  userNameC.text = state.data.username!;
                  emailC.text = state.data.email ?? "";
                  phoneC.text = state.data.phone ?? "";
                  erpSiteC.text = state.data.erpSite ?? "";
                  erpTokenC.text = state.data.erpToken ?? "";

                  return ListView(
                    children: [
                      CustomField(
                        controller: nameC,
                        type: Type.standard,
                        title: "Name",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomField(
                        controller: userNameC,
                        type: Type.standard,
                        title: "Username",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomField(
                        controller: emailC,
                        type: Type.standard,
                        title: "Email",
                        placeholder: "Cth: it@ekatunggal.com",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomField(
                        controller: phoneC,
                        type: Type.standard,
                        title: "Phone",
                        placeholder: "Cth: 081283738823",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomField(
                        controller: erpSiteC,
                        type: Type.standard,
                        title: "Erp Uri",
                        placeholder: "",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomField(
                        controller: erpTokenC,
                        type: Type.standard,
                        title: "Erp Token",
                        placeholder: "",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomField(
                        controller: passwordC,
                        type: Type.standard,
                        title: "Password",
                        placeholder: "",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[100],
                              border: Border.all(
                                color: const Color.fromARGB(255, 232, 231, 231),
                              ),
                              image: state.data.img == "" &&
                                          widget.userBloc.img?.path == null ||
                                      widget.userBloc.img?.path == ""
                                  ? const DecorationImage(
                                      image: AssetImage(
                                        "assets/icons/profile.png",
                                      ),
                                      fit: BoxFit.contain,
                                    )
                                  : widget.userBloc.img?.path != null
                                      ? DecorationImage(
                                          image: FileImage(
                                            File(
                                                "${widget.userBloc.img?.path}"),
                                          ),
                                        )
                                      : DecorationImage(
                                          image: NetworkImage(
                                            "${Config().baseUri}images/users/${state.data.img!}",
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                            ),
                          ),
                          Container(
                            width: Get.width * 0.9,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                              color: Colors.black.withOpacity(0.4),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    widget.userBloc.add(
                                      UserSetImage(source: ImageSource.camera),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    widget.userBloc.add(
                                      UserSetImage(source: ImageSource.gallery),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.open_in_browser,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                }
                return Container();
              }),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 100.0,
        width: 70.0,
        child: FloatingActionButton(
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  title: const Text("Really?"),
                  content: const Text("You want to save this data??"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("No"),
                    ),
                    TextButton(
                      onPressed: () async {
                        Get.back();
                      },
                      child: const Text("Yes"),
                    ),
                  ],
                );
              },
            );
          },
          backgroundColor: const Color.fromARGB(255, 2, 1, 1),
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
