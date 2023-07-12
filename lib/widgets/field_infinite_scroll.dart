// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/contact/contact_bloc.dart';
import 'package:salesappnew/screens/contact/contact_form.dart';

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
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => CustomerList(),
            );
          },
          child: Container(
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
              )),
        )
      ],
    );
  }
}

class CustomerList extends StatefulWidget {
  const CustomerList({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerList> {
  TextEditingController customerC = TextEditingController();
  TextEditingController picC = TextEditingController();
  TextEditingController phonC = TextEditingController();
  // bool isPicEmpty = true;
  // bool isPoneEmpty = true;

  // @override
  // void initState() {
  //   super.initState();
  //   customerC =
  //       TextEditingController(text: "${widget.visitState.data.customer?.name}");
  //   picC = TextEditingController();
  //   phonC = TextEditingController();

  //   picC.addListener(() {
  //     setState(() {
  //       isPicEmpty = picC.text.isEmpty;
  //     });
  //   });

  //   phonC.addListener(() {
  //     setState(() {
  //       isPoneEmpty = phonC.text.isEmpty;
  //     });
  //   });
  // }

  @override
  void dispose() {
    // customerC.dispose();
    // picC.dispose();
    // phonC.dispose();
    super.dispose();
  }

  ContactBloc bloc = ContactBloc();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: FractionallySizedBox(
        widthFactor: 1.15,
        child: Container(
          width: Get.width * 0.95,
          height: Get.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Customer List",
                      style: TextStyle(
                        color: Color.fromARGB(255, 66, 66, 66),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                BlocBuilder<ContactBloc, ContactState>(
                  bloc: bloc,
                  builder: (context, state) {
                    picC.text = bloc.pic;
                    phonC.text = bloc.phone;
                    return TextField(
                      controller: customerC,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey[300]),
                        hintText: "Cth : CV Jaya Abadi",
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue, // Warna border yang diinginkan
                            width: 1.0, // Ketebalan border
                          ),
                          borderRadius: BorderRadius.circular(
                              4), // Sudut melengkung pada border
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                    child: Text("dd"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
