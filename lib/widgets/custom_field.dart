// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Type {
  standard,
  infiniteList,
  list,
}

class CustomField extends StatefulWidget {
  String? placeholder;
  bool mandatory;
  String title;
  Type type;
  bool disabled;
  Function? onChange;
  Function? onReset;
  TextEditingController controller = TextEditingController();

  CustomField({
    super.key,
    required this.controller,
    required this.type,
    this.disabled = false,
    this.onChange,
    this.onReset,
    this.placeholder,
    required this.title,
    this.mandatory = false,
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  Color colorBorder = Color.fromARGB(255, 182, 182, 182);

  void initState() {
    super.initState();
    if (widget.mandatory) {
      colorBorder = widget.controller.text != ""
          ? Color.fromARGB(255, 182, 182, 182)
          : Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(color: Colors.grey[700]),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () {
              if (!widget.disabled) {
                if (widget.type == Type.infiniteList) {
                  showCustomModal(context);
                }
              }
            },
            child: TextField(
              controller: widget.controller,
              onChanged: (value) {
                if (widget.onChange != null && !widget.disabled) {
                  widget.onChange!(value);
                }

                if (widget.mandatory) {
                  setState(() {
                    if (value != "") {
                      colorBorder = Color.fromARGB(255, 182, 182, 182);
                    } else {
                      colorBorder = Colors.red;
                    }
                  });
                }
              },
              decoration: InputDecoration(
                suffixIcon: Visibility(
                  visible: !widget.disabled,
                  child: IconButton(
                    onPressed: () async {
                      if (!widget.disabled) {
                        widget.controller.text = "";
                        if (widget.onReset != null) {
                          widget.onReset!();
                        }
                        setState(() {
                          if (widget.mandatory) {
                            colorBorder = Colors.red;
                          }
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorBorder),
                ),
                // border: const OutlineInputBorder(),
                hintText: widget.placeholder ?? "Search your data",
                hintStyle: TextStyle(color: Colors.grey[300]),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
              enabled: !widget.disabled,
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
