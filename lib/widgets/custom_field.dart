// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Type {
  standard,
  infiniteList,
  list,
}

class CustomerField extends StatelessWidget {
  String? placeholder;
  Type type;
  bool disabled;
  Function? onChange;
  Function? onReset;
  TextEditingController controller = TextEditingController();
  CustomerField({
    super.key,
    required this.controller,
    required this.type,
    this.disabled = false,
    this.onChange,
    this.onReset,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Customer",
          style: TextStyle(color: Colors.grey[700]),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () {
              if (!disabled) {
                if (type == Type.infiniteList) {
                  showCustomModal(context);
                }
              }
            },
            child: TextField(
              controller: controller,
              onChanged: (value) {
                if (onChange != null && !disabled) {
                  onChange!(value);
                }
              },
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
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 184, 183, 183),
                    width: 1,
                  ),
                ),
                border: const OutlineInputBorder(),
                hintText: placeholder ?? "Search your data",
                hintStyle: TextStyle(color: Colors.grey[300]),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
              enabled: !disabled,
            )),
      ],
    );
  }

  void showCustomModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Membuat modal menggunakan tinggi penuh
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: Get.width,
            padding:
                EdgeInsets.only(top: 40, left: 20, right: 20), // Lebar penuh
            height: MediaQuery.of(context).size.height, // Tinggi penuh
            child: Column(
              children: [
                TextField(),
                Expanded(child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("PT. Jaya Abadi"),
                      subtitle: Text("Area 1"),
                    );
                  },
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
