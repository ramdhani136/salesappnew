// ignore_for_file: public_member_api_docs, sort_constructors_first, use_key_in_widget_constructors
// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/field_infinite/field_infinite_bloc.dart';

class FieldInfiniteScroll extends StatelessWidget {
  String? placeholder;
  String? placeholderModal;
  bool valid;
  String? title;
  String? titleModal;
  bool disabled;
  Function? onChange;
  Function? onReset;
  Function? onTap;
  bool mandatory;
  bool loading;
  Function? InsertAction;
  FieldInfiniteBloc bloc;
  String value;

  TextEditingController controller = TextEditingController();
  FieldInfiniteScroll({
    required this.bloc,
    required this.value,
    this.disabled = false,
    this.onChange,
    this.InsertAction,
    this.onReset,
    this.onTap,
    this.placeholder,
    this.title,
    this.titleModal,
    this.valid = true,
    this.mandatory = false,
    this.loading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FieldInfiniteBloc, FieldInfiniteState>(
      bloc: bloc,
      builder: (context, state) {
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
                            backgroundColor:
                                const Color.fromARGB(255, 49, 49, 49),
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
                if (onTap != null) {
                  onTap!();
                }

                showDialog(
                  context: context,
                  builder: (context) => FieldInfiniteModal(),
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
                            value == "" ? placeholder ?? value : value,
                            style: TextStyle(
                              color: value == ""
                                  ? Colors.grey[300]
                                  : disabled
                                      ? Colors.grey[800]
                                      : Colors.grey[900],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          if (onReset != null) {
                            onReset!();
                          }
                        },
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
      },
    );
  }

  Widget FieldInfiniteModal() {
    return BlocBuilder<FieldInfiniteBloc, FieldInfiniteState>(
      bloc: bloc,
      builder: (context, state) {
        return Dialog(
          child: FractionallySizedBox(
            widthFactor: 1.2,
            child: Container(
              width: Get.width,
              height: Get.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          titleModal ?? "",
                          style: const TextStyle(
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
                    TextField(
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey[300]),
                        hintText: placeholderModal ?? "Search",
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.blue, // Warna border yang diinginkan
                            width: 1.0, // Ketebalan border
                          ),
                          borderRadius: BorderRadius.circular(
                            4,
                          ), // Sudut melengkung pada border
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                            print("refresh");
                          }
                          return false;
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Visibility(
                                visible: false,
                                child: Expanded(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.grey[300]),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: false,
                                child: Expanded(
                                  child: Center(
                                    child: Text(
                                      "No data",
                                      style: TextStyle(
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: true,
                                child: Expanded(
                                  child: ListView.builder(
                                    itemCount: bloc.data.length,
                                    itemBuilder: (context, index) {
                                      if (bloc.data[index].subTitle != null) {
                                        return ListTile(
                                          onTap: () {
                                            if (onChange != null) {
                                              onChange!(bloc.data[index].value);
                                            }
                                            Get.back();
                                          },
                                          title: Text(bloc.data[index].title),
                                          subtitle:
                                              Text(bloc.data[index].subTitle!),
                                        );
                                      } else {
                                        return ListTile(
                                          onTap: () {
                                            if (onChange != null) {
                                              onChange!(bloc.data[index].value);
                                            }
                                            Get.back();
                                          },
                                          title: Text(bloc.data[index].title),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// class FieldInfiniteModal extends StatelessWidget {
//   List<FieldInfiniteData> data;
//   FieldInfiniteModal({
//     required this.data,
//   });

//   TextEditingController customerC = TextEditingController();
//   TextEditingController picC = TextEditingController();
//   TextEditingController phonC = TextEditingController();

//   ContactBloc bloc = ContactBloc();

//   @override
//   Widget build(BuildContext context) {
//     // print(data);
//     return Dialog(
//       child: FractionallySizedBox(
//         widthFactor: 1.2,
//         child: Container(
//           width: Get.width,
//           height: Get.height,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "Customer List",
//                       style: TextStyle(
//                         color: Color.fromARGB(255, 66, 66, 66),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         Get.back();
//                       },
//                       icon: const Icon(Icons.close),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 BlocBuilder<ContactBloc, ContactState>(
//                   bloc: bloc,
//                   builder: (context, state) {
//                     picC.text = bloc.pic;
//                     phonC.text = bloc.phone;
//                     return TextField(
//                       controller: customerC,
//                       autocorrect: false,
//                       enableSuggestions: false,
//                       decoration: InputDecoration(
//                         hintStyle: TextStyle(color: Colors.grey[300]),
//                         hintText: "Cth : CV Jaya Abadi",
//                         contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 10),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colors.blue, // Warna border yang diinginkan
//                             width: 1.0, // Ketebalan border
//                           ),
//                           borderRadius: BorderRadius.circular(
//                               4), // Sudut melengkung pada border
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Expanded(
//                   child: NotificationListener<ScrollNotification>(
//                     onNotification: (ScrollNotification scrollInfo) {
//                       if (scrollInfo.metrics.pixels ==
//                           scrollInfo.metrics.maxScrollExtent) {
//                         print("refresh");
//                       }
//                       return false;
//                     },
//                     child: Container(
//                       child: Column(
//                         children: [
//                           Visibility(
//                             visible: false,
//                             child: Expanded(
//                               child: Center(
//                                 child: CircularProgressIndicator(
//                                     color: Colors.grey[300]),
//                               ),
//                             ),
//                           ),
//                           Visibility(
//                             visible: false,
//                             child: Expanded(
//                               child: Center(
//                                 child: Text(
//                                   "No data",
//                                   style: TextStyle(
//                                     color: Colors.grey[300],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Visibility(
//                             visible: true,
//                             child: Expanded(
//                               child: ListView.builder(
//                                 itemCount: 100,
//                                 itemBuilder: (context, index) {
//                                   return ListTile(
//                                     title: Text("Ekatunggal Tunas Mandiri"),
//                                     subtitle: Text("Area 2"),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class FieldInfiniteData {
  String title;
  String? subTitle;
  dynamic value;
  FieldInfiniteData({required this.title, required this.value, this.subTitle});
}
