// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

enum Type { select, normal }

class Input extends StatelessWidget {
  Type type;
  Input({super.key, this.type = Type.normal});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Customer :",
          style: TextStyle(color: Colors.grey[700]),
        ),
        const SizedBox(height: 10),
        TextField(
          enabled: true,
          autocorrect: false,
          enableSuggestions: false,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 230, 228, 228), width: 1.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 69, 69, 69), width: 2.0),
            ),
            hintStyle: TextStyle(color: Colors.grey[300]),
            hintText: "Select Customer",
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
