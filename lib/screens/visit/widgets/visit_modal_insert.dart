import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/models/key_value_model.dart';
import 'package:salesappnew/widgets/custom_field.dart';

class VisitModalInsert extends StatelessWidget {
  VisitBloc bloc;
  VisitModalInsert({super.key, required this.bloc});

  TextEditingController namingC = TextEditingController();
  VisitBloc thisBloc = VisitBloc();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: FractionallySizedBox(
        widthFactor: 1.15,
        child: Container(
          width: Get.width * 0.95,
          height: 350,
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
                  "New Visit",
                  style: TextStyle(
                    color: Color.fromARGB(255, 66, 66, 66),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<VisitBloc, VisitState>(
                    bloc: thisBloc..add(VisitGetNaming()),
                    builder: (
                      context,
                      state,
                    ) {
                      print(thisBloc.naming != null);
                      namingC.text = thisBloc.naming?.name ?? "";
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomField(
                            // InsertAction: () {
                            //   showDialog(
                            //     context: context,
                            //     builder: (context) => ContactForm(
                            //       contactBloc: contactBloc,
                            //       visitState: state,
                            //     ),
                            //   );
                            // },

                            placeholder: "Cth : VST2020MMDD",
                            mandatory: true,
                            // disabled: state.data.status != "0",
                            title: "Naming Series",
                            controller: namingC,
                            valid: thisBloc.naming != null,
                            type: Type.select,
                            data: thisBloc.namingList ?? [],
                            onChange: (e) {
                              // namingC.text = e['title'];
                              // thisBloc.naming = KeyValue(
                              //   name: e['title'],
                              //   value: e['value'],
                              // );
                              thisBloc.add(
                                VisitSetNaming(
                                  data: KeyValue(
                                    name: e['title'],
                                    value: e['value'],
                                  ),
                                ),
                              );
                            },
                            onReset: () {
                              thisBloc.add(
                                VisitSetNaming(),
                              );
                            },
                          ),
                          // Text(
                          //   "Naming Series :",
                          //   style: TextStyle(color: Colors.grey[700]),
                          // ),
                          // const SizedBox(height: 10),
                          // TextField(
                          //   // enabled: (VisitC.status.value == "0" ||
                          //   //     VisitC.status.value == "1"),
                          //   autocorrect: false,
                          //   enableSuggestions: false,
                          //   decoration: InputDecoration(
                          //     hintStyle: TextStyle(color: Colors.grey[300]),
                          //     hintText: "Cth : VST2020MMDD",
                          //     contentPadding:
                          //         const EdgeInsets.symmetric(horizontal: 10),
                          //     // enabledBorder: picC.text.isEmpty
                          //     //     ? const OutlineInputBorder(
                          //     //         borderSide: BorderSide(
                          //     //           color: Colors.red,
                          //     //           width: 1,
                          //     //         ),
                          //     //       )
                          //     //     : null,
                          //     border: const OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //         color: Colors.blue,
                          //         width: 1.0,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(height: 20),
                          Text(
                            "Phone :",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            keyboardType: TextInputType.number,
                            autocorrect: false,
                            enableSuggestions: false,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey[300]),
                              hintText: "Contoh: 089637428874",
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              // enabledBorder: phonC.text.isEmpty
                              //     ? const OutlineInputBorder(
                              //         borderSide: BorderSide(
                              //           color: Colors.red,
                              //           width: 1,
                              //         ),
                              //       )
                              //     : null,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 1.0,
                                ),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () async {},
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
                    }),
                const SizedBox(height: 30),
                SizedBox(
                  width: Get.width,
                  height: 46,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 65, 170, 69),
                    ),
                    onPressed: () async {
                      print(thisBloc.naming);
                    },
                    child: const Text("Next"),
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
