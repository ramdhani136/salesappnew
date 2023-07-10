// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:salesappnew/bloc/contact/contact_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';

class ContactForm extends StatefulWidget {
  final ContactBloc contactBloc;
  final IsShowLoaded visitState;

  const ContactForm({
    Key? key,
    required this.contactBloc,
    required this.visitState,
  }) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  late TextEditingController customerC;
  late TextEditingController picC;
  late TextEditingController phonC;
  bool isPicEmpty = true;
  bool isPoneEmpty = true;

  @override
  void initState() {
    super.initState();
    customerC =
        TextEditingController(text: "${widget.visitState.data.customer?.name}");
    picC = TextEditingController();
    phonC = TextEditingController();

    picC.addListener(() {
      setState(() {
        isPicEmpty = picC.text.isEmpty;
      });
    });

    phonC.addListener(() {
      setState(() {
        isPoneEmpty = phonC.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    customerC.dispose();
    picC.dispose();
    phonC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: FractionallySizedBox(
        widthFactor: 1.2,
        child: Container(
          width: Get.width * 0.95,
          height: 450,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Form Contact",
                  style: TextStyle(
                    color: Color.fromARGB(255, 66, 66, 66),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<ContactBloc, ContactState>(
                  bloc: widget.contactBloc,
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Customer :",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: customerC,
                          enabled: false,
                          autocorrect: false,
                          enableSuggestions: false,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey[300]),
                            hintText: "Cth : CV Jaya Abadi",
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "PIC :",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: picC,
                          // enabled: (VisitC.status.value == "0" ||
                          //     VisitC.status.value == "1"),
                          autocorrect: false,
                          enableSuggestions: false,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey[300]),
                            hintText: "Cth : Ilham",
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            enabledBorder: isPicEmpty
                                ? const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1,
                                    ),
                                  )
                                : null,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Phone :",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: phonC,
                          keyboardType: TextInputType.number,
                          autocorrect: false,
                          enableSuggestions: false,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey[300]),
                            hintText: "Contoh: 089637428874",
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            enabledBorder: isPoneEmpty
                                ? const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1,
                                    ),
                                  )
                                : null,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 1.0,
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                // contactC.getPhoneContact(context);
                              },
                              icon: Icon(
                                Icons.contact_phone,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: Get.width,
                  height: 46,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 49, 49, 49),
                    ),
                    onPressed: () async {
                      // await contactC.onsubmit(context);
                    },
                    child: const Text("Save"),
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
