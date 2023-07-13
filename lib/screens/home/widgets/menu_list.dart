// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeMenuList extends StatelessWidget {
  final String title;
  bool primary = false;
  final IconData icon;
  final Function RunFUnction;

  HomeMenuList(
      {super.key,
      required this.title,
      bool? primary,
      required this.icon,
      required this.RunFUnction}) {
    if (primary != null) {
      this.primary = primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RunFUnction();
      },
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 5,
          top: 5,
          right: 15,
          left: 5,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: primary ? Colors.red : Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: primary ? Colors.white : Colors.red[500],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.grey[700],
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
