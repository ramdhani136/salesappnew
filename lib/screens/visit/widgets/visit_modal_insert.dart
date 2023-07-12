import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/group/group_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/models/key_value_model.dart';
import 'package:salesappnew/widgets/custom_field.dart';
import 'package:salesappnew/widgets/field_infinite_scroll.dart';

class VisitModalInsert extends StatelessWidget {
  VisitBloc bloc;
  VisitModalInsert({super.key, required this.bloc});

  TextEditingController namingC = TextEditingController();
  VisitBloc thisBloc = VisitBloc();
  GroupBloc groupBloc = GroupBloc();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: FractionallySizedBox(
        widthFactor: 1.15,
        child: Container(
          width: Get.width * 0.95,
          height: 430,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<VisitBloc, VisitState>(
                          bloc: thisBloc..add(VisitGetNaming()),
                          builder: (
                            context,
                            state,
                          ) {
                            namingC.text = thisBloc.naming?.name ?? "";
                            return CustomField(
                              placeholder: "Cth : VST2020MMDD",
                              mandatory: true,
                              // disabled: state.data.status != "0",
                              title: "Naming Series",
                              controller: namingC,
                              valid: thisBloc.naming != null,
                              type: Type.select,
                              data: thisBloc.namingList ?? [],
                              onChange: (e) {
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
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        BlocBuilder<GroupBloc, GroupState>(
                          bloc: groupBloc..add(GroupGetData()),
                          builder: (context, state) {
                            TextEditingController groupC =
                                TextEditingController();
                            return FieldInfiniteScroll(
                              title: "Group",
                              mandatory: true,
                              controller: groupC,
                            );
                            // CustomField(
                            //   placeholder: "Cth : Jabodetabek",
                            //   // mandatory: true,
                            //   // disabled: state.data.status != "0",
                            //   title: "Group",
                            //   controller: namingC,
                            //   // valid: thisBloc.naming != null,
                            //   type: Type.select,
                            //   data: thisBloc.namingList ?? [],
                            //   onChange: (e) {
                            //     thisBloc.add(
                            //       VisitSetNaming(
                            //         data: KeyValue(
                            //           name: e['title'],
                            //           value: e['value'],
                            //         ),
                            //       ),
                            //     );
                            //   },
                            //   onReset: () {
                            //     thisBloc.add(
                            //       VisitSetNaming(),
                            //     );
                            //   },
                            // );
                          },
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Customer :",
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
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: Get.width,
                      height: 46,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 65, 170, 69),
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
            ],
          ),
        ),
      ),
    );
  }
}
