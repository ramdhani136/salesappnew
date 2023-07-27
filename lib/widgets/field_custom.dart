// ignore_for_file: must_be_immutable, non_constant_identifier_names
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';

enum Type { standard, select }

class FieldCustom extends StatefulWidget {
  String? placeholder;
  bool valid;
  bool border;
  String? title;
  Type type;
  bool disabled;
  Function? onChange;
  Function? onReset;
  Future<List>? getData;
  Function? onTap;
  TextInputType keyboardType;
  List? data;
  bool mandatory;
  bool obscureText;
  bool loading;
  Function? InsertAction;
  TextInputAction? textInputAction;

  TextEditingController controller = TextEditingController();

  FieldCustom({
    super.key,
    required this.controller,
    required this.type,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.disabled = false,
    this.obscureText = false,
    this.onChange,
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
  State<FieldCustom> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<FieldCustom> {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "${widget.title}",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Visibility(
                        visible: widget.mandatory && !widget.disabled,
                        child: const Text(
                          "*",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: widget.InsertAction != null && !widget.disabled,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 49, 49, 49),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0),
                      ),
                      onPressed: () async {
                        if (!widget.disabled && widget.InsertAction != null) {
                          widget.InsertAction!();
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
                    child: const Center(child: CircularProgressIndicator()));
              },
              textFieldConfiguration: TextFieldConfiguration(
                style: TextStyle(
                  fontSize: 16, // Ubah ukuran font sesuai kebutuhan
                  color: widget.disabled ? Colors.grey[800] : Colors.grey[900],
                ),
                textInputAction: widget.textInputAction,
                keyboardType: widget.keyboardType,
                obscureText: widget.obscureText,
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
                      color: widget.valid
                          ? const Color.fromARGB(255, 182, 182, 182)
                          : Colors.red,
                    ),
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
                  List filter = widget.data!
                      .where(
                        (item) => item['title']
                            .toLowerCase()
                            .contains(pattern.toLowerCase()),
                      )
                      .toList();
                  return filter;
                }
                return [];
              },
              itemBuilder: (context, suggestion) {
                if (widget.data != null && widget.type == Type.select) {
                  if (suggestion['subTitle'] != null) {
                    return ListTile(
                      title: Text("${suggestion['title']}"),
                      subtitle: Text('${suggestion['subTitle'] ?? ''}'),
                    );
                  } else {
                    return ListTile(
                      title: Text("${suggestion['title']}"),
                    );
                  }
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
          visible: widget.type == Type.standard,
          child: InkWell(
            onTap: () {
              if (!widget.disabled) {}
            },
            child: TextField(
              textInputAction: widget.textInputAction,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              controller: widget.controller,
              onChanged: (value) {
                if (widget.onChange != null && !widget.disabled) {
                  widget.onChange!(value);
                }
              },
              style: TextStyle(
                color: widget.disabled ? Colors.grey[800] : Colors.grey[900],
                fontSize: 16,
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
                    color: widget.valid
                        ? const Color.fromARGB(255, 182, 182, 182)
                        : Colors.red,
                  ),
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
}
