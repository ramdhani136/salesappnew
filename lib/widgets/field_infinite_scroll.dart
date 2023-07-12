// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                        "$title",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Visibility(
                        visible: mandatory && !disabled,
                        child: const Text(
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
        Container(
            width: Get.width * 0.95,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: valid
                    ? const Color.fromARGB(255, 182, 182, 182)
                    : Colors.red,
                width: 1.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Administrator",
                      style: TextStyle(
                        color: disabled ? Colors.grey[800] : Colors.grey[900],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                  iconSize: 20,
                ),
              ],
            ))
      ],
    );
  }
}
