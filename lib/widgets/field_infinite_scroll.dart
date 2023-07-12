// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class FieldInfiniteScroll extends StatelessWidget {
  String? placeholder;
  bool valid;
  String? title;
  bool disabled;
  Function? onChange;
  Function? onReset;
  Future<List>? getData;
  Function? onTap;
  List? data;
  bool mandatory;
  bool loading;
  Function? InsertAction;

  TextEditingController controller = TextEditingController();
  FieldInfiniteScroll(
      {required this.controller,
      this.disabled = false,
      this.onChange,
      this.InsertAction,
      this.onReset,
      this.onTap,
      this.placeholder,
      this.title,
      this.valid = true,
      this.getData,
      this.data,
      this.mandatory = false,
      this.loading = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: title != null,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "${title}",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Visibility(
                        visible: mandatory && !disabled,
                        child: Text(
                          "*",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: InsertAction != null && !disabled,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 49, 49, 49),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0),
                      ),
                      onPressed: () async {
                        if (!disabled && InsertAction != null) {
                          InsertAction!();
                        }
                      },
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text("New"),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        TextField(
          controller: controller,
          onChanged: (value) {
            if (onChange != null && !disabled) {
              onChange!(value);
            }
          },
          style: TextStyle(
            color: disabled ? Colors.grey[800] : Colors.grey[900],
            fontSize: 16,
          ),
          decoration: InputDecoration(
            suffixIcon: Visibility(
              visible: !disabled,
              child: IconButton(
                onPressed: () async {
                  if (!disabled) {
                    controller.text = "";
                    if (onReset != null) {
                      onReset!();
                    }
                  }
                },
                icon: const Icon(
                  Icons.close,
                  size: 20,
                ),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: valid
                    ? const Color.fromARGB(255, 182, 182, 182)
                    : Colors.red,
              ),
            ),
            // border: const OutlineInputBorder(),
            hintText: placeholder ?? "Search your data",
            hintStyle: TextStyle(color: Colors.grey[300]),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
          enabled: !disabled,
        ),
      ],
    );
  }
}
