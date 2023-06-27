// ignore_for_file: must_be_immutable
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Type { standard, infinite, select }

class CustomField extends StatefulWidget {
  String? placeholder;
  bool valid;
  String? title;
  Type type;
  bool disabled;
  Function? onChange;
  Function? onReset;
  Future<List>? getData;
  Function? onTap;
  List? data;
  bool loading;

  TextEditingController controller = TextEditingController();

  CustomField({
    super.key,
    required this.controller,
    required this.type,
    this.disabled = false,
    this.onChange,
    this.onReset,
    this.onTap,
    this.placeholder,
    this.title,
    this.valid = true,
    this.getData,
    this.data,
    this.loading = false,
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  Color colorBorder = Color.fromARGB(255, 182, 182, 182);

  void initState() {
    super.initState();
    if (!widget.valid) {
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
        Visibility(
          visible: widget.title != null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.title}",
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        Visibility(
          visible: widget.type == Type.select,
          child: InkWell(
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap!();
              }
            },
            child: TypeAheadField(
              loadingBuilder: (context) {
                return Visibility(
                    visible: widget.loading,
                    child: Center(child: CircularProgressIndicator()));
              },
              textFieldConfiguration: TextFieldConfiguration(
                style: TextStyle(
                  fontSize: 16, // Ubah ukuran font sesuai kebutuhan
                  color: widget.disabled ? Colors.grey[800] : Colors.grey[900],
                ),
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
                            if (!widget.valid) {
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
                  hintStyle: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 16,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
                controller: widget.controller,
                enabled: !widget.disabled,
              ),
              suggestionsCallback: (pattern) async {
                if (widget.data != null && widget.type == Type.select) {
                  return widget.data!;
                }
                return [];
              },
              itemBuilder: (context, suggestion) {
                if (widget.data != null && widget.type == Type.select) {
                  return ListTile(
                    title: Text("${suggestion['title']}"),
                    subtitle: Text('${suggestion['subTitle']}'),
                  );
                }
                return Container();
              },
              onSuggestionSelected: (suggestion) {
                if (widget.onChange != null) {
                  widget.onChange!(suggestion);
                }
              },
            ),
          ),
        ),
        Visibility(
          visible: widget.type == Type.infinite || widget.type == Type.standard,
          child: InkWell(
            onTap: () {
              if (!widget.disabled) {
                if (widget.type == Type.infinite) {
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

                if (!widget.valid) {
                  setState(() {
                    if (value != "") {
                      colorBorder = Color.fromARGB(255, 182, 182, 182);
                    } else {
                      colorBorder = Colors.red;
                    }
                  });
                }
              },
              style: TextStyle(
                color: widget.disabled ? Colors.grey[800] : Colors.grey[900],
              ),
              decoration: InputDecoration(
                // disabledBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(color: Colors.grey),
                // ),
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
                          if (!widget.valid) {
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
            ),
          ),
        ),
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
