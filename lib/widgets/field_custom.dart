// ignore_for_file: must_be_immutable, non_constant_identifier_names
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';

enum Type { standard, select }

class FieldCustom extends StatelessWidget {
  String? placeholder;
  bool valid;
  bool border;
  String? title;
  Type type;
  bool disabled;
  Function? onSelect;
  Function? onReset;
  Function? onTap;
  TextInputType keyboardType;
  List? data;
  bool mandatory;
  bool obscureText;
  bool loading;
  Function? InsertAction;
  TextEditingController controller;
  TextInputAction? textInputAction;
  Function(String search)? getData;

  FieldCustom({
    super.key,
    required this.controller,
    required this.type,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.disabled = false,
    this.obscureText = false,
    this.onSelect,
    this.InsertAction,
    this.onReset,
    this.onTap,
    this.border = true,
    this.placeholder,
    this.title,
    this.valid = true,
    this.getData,
    this.data,
    this.mandatory = false,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: title != null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
        Visibility(
          visible: type == Type.select,
          child: InkWell(
            onTap: () {
              if (onTap != null) {
                onTap!();
              }
            },
            child: TypeAheadField(
              loadingBuilder: (context) {
                return Visibility(
                    visible: loading,
                    child: const Center(child: CircularProgressIndicator()));
              },
              textFieldConfiguration: TextFieldConfiguration(
                style: TextStyle(
                  fontSize: 16, // Ubah ukuran font sesuai kebutuhan
                  color: disabled ? Colors.grey[800] : Colors.grey[900],
                ),
                textInputAction: textInputAction,
                keyboardType: keyboardType,
                obscureText: obscureText,
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
                  hintStyle: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 16,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
                controller: controller,
                enabled: !disabled,
              ),
              suggestionsCallback: (pattern) async {
                if (getData != null) {
                  List data = await getData!(pattern);

                  return data;
                }

                return [];
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(
                    "${suggestion['name']}",
                  ),
                );
              },
              onSuggestionSelected: (suggestion) {
                if (onSelect != null) {
                  onSelect!(suggestion);
                }
              },
            ),
          ),
        ),
        Visibility(
          visible: type == Type.standard,
          child: InkWell(
            onTap: () {
              if (!disabled) {}
            },
            child: TextField(
              textInputAction: textInputAction,
              keyboardType: keyboardType,
              obscureText: obscureText,
              controller: controller,
              style: TextStyle(
                color: disabled ? Colors.grey[800] : Colors.grey[900],
                fontSize: 16,
              ),
              decoration: InputDecoration(
                suffixIcon: Visibility(
                  visible: disabled,
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
          ),
        ),
      ],
    );
  }
}
