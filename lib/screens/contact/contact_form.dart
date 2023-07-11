// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
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
                  bloc: bloc,
                  builder: (context, state) {
                    print(state);
                    if (state is ContactSelectedPhone) {
                      picC.text = state.data['pic'];
                      phonC.text = state.data['phone'];
                    }
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
                          onChanged: (value) {},
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
                            enabledBorder: picC.text.isEmpty
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
                            enabledBorder: phonC.text.isEmpty
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
                              onPressed: () async {
                                bloc.add(ContactGetPhone());
                                await getPhoneContact(context);
                              },
                              icon: const Icon(
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
                      backgroundColor: const Color.fromARGB(255, 65, 170, 69),
                    ),
                    onPressed: () async {
                      widget.contactBloc.add(
                        ContactInsertData(
                          data: {
                            "name": picC.text,
                            "phone": phonC.text,
                            "customer": widget.visitState.data.customer!.id
                          },
                        ),
                      );
                      widget.contactBloc.add(
                        GetListInput(
                            customerId: widget.visitState.data.customer!.id),
                      );
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

  getPhoneContact(context) async {
    TextEditingController searchContactC = TextEditingController();
    // EasyLoading.show(status: 'loading...');
    // if (await FlutterContacts.requestPermission()) {
    // List<Contact> contacts = await FlutterContacts.getContacts(
    //     withProperties: true, withPhoto: true);
    // List<Contact> resultContact = contacts;
    // EasyLoading.dismiss();
    Widget setupAlertDialoadContainer() {
      return BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          List<Contact> contacts = [];

          if (state is ContactPhoneIsloaded) {
            contacts = state.data;
          }

          List<Contact> resultContact = contacts;

          return SizedBox(
            height: Get.width,
            width: Get.width,
            child: Column(
              children: [
                TextField(
                  controller: searchContactC,
                  onChanged: (changed) async {
                    bloc.add(ContactFilterPhone(filter: changed));
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      ),
                    ),
                    hintText: "Search",
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    suffixIcon: Visibility(
                      visible: searchContactC.text != "",
                      child: IconButton(
                          onPressed: () {
                            resultContact = contacts;
                            searchContactC.text = "";
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.grey[400],
                            size: 20,
                          )),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible:
                      resultContact.isEmpty && state is ContactPhoneIsloaded,
                  child: Expanded(
                    child: Center(
                      child: Text(
                        'No result',
                        style: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible:
                      resultContact.isNotEmpty && state is ContactPhoneIsloaded,
                  child: Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: resultContact.length,
                      itemBuilder: (BuildContext context, int index) {
                        Uint8List? image = resultContact[index].photo;
                        String num = (resultContact[index].phones.isNotEmpty)
                            ? (resultContact[index].phones.first.number)
                            : "--";
                        return ListTile(
                          onTap: () async {
                            var cPhone =
                                resultContact[index].phones.first.number;
                            cPhone = cPhone.replaceAll("-", "");
                            cPhone = cPhone.replaceAll(" ", "");
                            cPhone = cPhone.replaceAll("+62", "0");

                            Get.back();
                            bloc.add(
                              ContactSelectPhone(
                                data: {
                                  'pic': resultContact[index].displayName,
                                  'phone': cPhone
                                },
                              ),
                            );
                          },
                          leading: (resultContact[index].photo == null)
                              ? const CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 230, 229, 229),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: MemoryImage(image!)),
                          title: Text(resultContact[index].displayName),
                          subtitle: Text(num),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Contact List'),
            content: setupAlertDialoadContainer(),
          );
        });
    // } else {
    //   EasyLoading.dismiss();
    // }
  }
}
