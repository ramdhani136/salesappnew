// ignore_for_file: unused_local_variable, non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salesappnew/config/Config.dart';
import 'package:salesappnew/models/user_model.dart';

class ProfilePicture extends StatelessWidget {
  UserModel data;
  ProfilePicture({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 65,
              height: 65,
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
              visible: data.img != null,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "${Config().baseUri}images/users/${data.img}"),
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
              visible: data.img == null,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 58,
                  height: 58,
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
                    data.name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "@${data.username}",
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
