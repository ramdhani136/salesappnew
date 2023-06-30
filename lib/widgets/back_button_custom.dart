// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';

class BackButtonCustom extends StatelessWidget {
  Function? onBack;
  BackButtonCustom({
    Key? key,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return IconButton(
        onPressed: () {
          if (onBack != null) {
            onBack!();
          }
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Color.fromARGB(255, 121, 8, 14),
          size: 22,
        ),
      );
    });
  }
}
