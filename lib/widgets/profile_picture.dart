// ignore_for_file: unused_local_variable, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IsUser() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? user = prefs.getString('user');
      final Map<String, dynamic> thisUser = jsonDecode(user!);
      Map decodedMap = json.decode(user);
      return decodedMap;
    }

    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.red,
                    Colors.amber,
                  ],
                ),
              ),
            ),
            Visibility(
              // visible: datanya["img"] != null && datanya["img"] != "",
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 63,
                  height: 63,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(""),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.grey[300],
                    border: Border.all(
                      color: Colors.white,
                      width: 4,
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              // visible: datanya["img"] == null || datanya["img"] == "",
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 63,
                  height: 63,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(
                        "assets/icons/profile.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.grey[300],
                    border: Border.all(
                      color: Colors.white,
                      width: 4,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ilham Ramdhani",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "@Ramdhaniit",
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () async {
                  Get.back();
                },
                icon: Icon(
                  Icons.settings,
                  size: 20,
                  color: Colors.grey[800],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
