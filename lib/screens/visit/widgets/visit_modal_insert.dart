import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/field_infinite/field_infinite_bloc.dart';
import 'package:salesappnew/bloc/group/group_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/models/group_model.dart';
import 'package:salesappnew/models/key_value_model.dart';
import 'package:salesappnew/widgets/custom_field.dart';
import 'package:salesappnew/widgets/field_infinite_scroll.dart';

class VisitModalInsert extends StatelessWidget {
  VisitBloc bloc;
  VisitModalInsert({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    VisitBloc thisBloc = VisitBloc();
    GroupBloc groupBloc = GroupBloc();
    FieldInfiniteBloc groupFieldBloc = FieldInfiniteBloc();
    TextEditingController namingC = TextEditingController();
    String groupId = "";

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
                          bloc: groupBloc,
                          builder: (context, state) {
                            List<FieldInfiniteData> data = [];
                            if (state is GroupIsLoaded) {
                              List<Set<FieldInfiniteData>> nestedData =
                                  state.data.map((item) {
                                return {
                                  FieldInfiniteData(
                                      title: item.name!, value: item)
                                };
                              }).toList();

                              data = nestedData.expand((set) => set).toList();

                              groupFieldBloc.add(
                                FieldInfiniteSetData(data: data),
                              );
                            }

                            return FieldInfiniteScroll(
                              onTap: () {
                                groupBloc.add(GroupGetData());
                              },
                              onChange: (GroupModel e) {
                                groupId = e.id.toString();
                              },
                              title: "Group",
                              mandatory: true,
                              bloc: groupFieldBloc,
                            );
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
                          // print(thisBloc.naming);
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
