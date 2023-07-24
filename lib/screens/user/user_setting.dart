import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesappnew/bloc/user/user_bloc.dart';
import 'package:salesappnew/widgets/back_button_custom.dart';
import 'package:salesappnew/widgets/custom_field.dart';

class UserSetting extends StatefulWidget {
  UserBloc bloc;
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder(
            bloc: widget.bloc,
            builder: (context, state) {
              if (state is UserLoginLoaded) {
                nameC.text = state.data.name!;
                userNameC.text = state.data.username!;
                emailC.text = state.data.email ?? "";
                phoneC.text = state.data.phone ?? "";
              }
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomField(
                    controller: phoneC,
                    type: Type.standard,
                    title: "Phone",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomField(
                    controller: passwordC,
                    type: Type.standard,
                    title: "Password",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
