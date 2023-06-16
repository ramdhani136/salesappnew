import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salesappnew/widgets/rating.dart';

class VisitBodyList extends StatelessWidget {
  const VisitBodyList({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onLongPress: () async {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Really?"),
                content: const Text("You want to delete this data??"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("No"),
                  ),
                  TextButton(
                    onPressed: () async {
                      // Get.back();
                      // LocalProvider localP =
                      //     LocalProvider();
                      // EasyLoading.show(
                      //     status: 'loading...');
                      // try {
                      //   var response =
                      //       await http.delete(
                      //     Uri.parse(
                      //         "${config.defultUri}visit/${visitC.finalData[index].id}"),
                      //     headers: {
                      //       HttpHeaders
                      //               .authorizationHeader:
                      //           'Bearer ${await localP.getLocalToken()}',
                      //     },
                      //   );
                      //   EasyLoading.dismiss();
                      //   if (response.statusCode ==
                      //       200) {
                      //     await visitC.getByStatus();
                      //   } else {
                      //     var data = await json
                      //         .decode(response.body);
                      //     EasyLoading.showError(
                      //         '${data['message']}');
                      //   }
                      // } catch (e) {
                      //   // EasyLoading.showError(
                      //   //     'Failed with Error');
                      //   // EasyLoading.dismiss();
                      // }
                    },
                    child: const Text("Yes"),
                  ),
                ],
              );
            },
          );
        },
        onTap: () {
          // Get.toNamed(Routes.VISITFORMUTAMA,
          //     arguments: visitC.finalData[index]);
        },
        child: Stack(
          children: [
            Container(
              width: Get.width,
              // height: 180,
              constraints: const BoxConstraints(
                maxHeight: double.infinity,
              ),
              margin: const EdgeInsets.only(
                bottom: 15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color.fromARGB(255, 230, 228, 228),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 48),
                    Text(
                      "ddddd",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Group :  ddd",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "eessssssssssssssssssssssssssssssssssss ssssssssssssssssssssssss ssssssssssssssssse",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "ddd",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -0,
              child: Container(
                width: Get.width - 40,
                height: 40,
                margin: const EdgeInsets.only(
                  bottom: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.amber,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "tes",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.5,
                        ),
                      ),
                      Text(
                        "Draft",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: Get.width - 40,
                height: 40,
                margin: const EdgeInsets.only(
                  bottom: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Colors.white,
                  border: Border.all(
                      color: const Color.fromARGB(255, 230, 228, 228)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ilham Ramdhani",
                        // "${value.finalData[index].user?.name}",
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2.5,
                            ),
                            child: Icon(
                              Icons.date_range_outlined,
                              size: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                          // Text(
                          //   DateFormat.yMMMMd('en_US')
                          //       .format(
                          //     DateTime.parse(
                          //             "${soC.finalData[index]['creation']}")
                          //         .toLocal(),
                          //   ),
                          //   style: TextStyle(
                          //     color: Colors.grey[500],
                          //     fontWeight:
                          //         FontWeight.bold,
                          //     fontSize: 12.5,
                          //     fontStyle:
                          //         FontStyle.italic,
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
