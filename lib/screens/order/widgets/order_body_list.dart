// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salesappnew/screens/order/order_form.dart';

class OrderBodyList extends StatelessWidget {
  Map<String, dynamic> data;
  Color colorHeader;
  Color colorFontHeader;
  OrderBodyList({
    super.key,
    required this.data,
    required this.colorFontHeader,
    required this.colorHeader,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return OrderFormScreen(
                  id: data['name'],
                );
              },
            ),
          );
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
                      "${data['customer']}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Visibility(
                    //   visible: data.contact != null,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         "${data.contact?.name}",
                    //         style: TextStyle(
                    //           fontSize: 15,
                    //           color: Colors.grey[600],
                    //         ),
                    //       ),
                    //       const SizedBox(
                    //         height: 5,
                    //       ),
                    //       Text(
                    //         "${data.contact?.phone}",
                    //         style: TextStyle(
                    //           fontSize: 15,
                    //           color: Colors.grey[700],
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(height: 5),
                    Text(
                      "Group :  ${data['customer_group']}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -0,
              child: Container(
                width: Get.width - 30,
                height: 35,
                margin: const EdgeInsets.only(
                  bottom: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: colorHeader,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${data['name']}",
                        style: TextStyle(
                          color: colorFontHeader,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "${data['workflow_state']}",
                        style: TextStyle(
                            color: colorFontHeader,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: Get.width - 30,
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
                        data['owner'].toString(),
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
                          Text(
                            // ignore: unnecessary_string_interpolations
                            "${DateFormat.yMd().add_jm().format(
                                  DateTime.parse("${data['modified']}")
                                      .toLocal(),
                                )}",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.bold,
                              fontSize: 12.5,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
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
