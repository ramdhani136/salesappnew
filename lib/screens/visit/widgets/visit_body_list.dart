import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salesappnew/models/visit_model.dart';
import 'package:salesappnew/widgets/rating.dart';

class VisitBodyList extends StatelessWidget {
  Visitmodel data;
  Color colorHeader;
  Color colorFontHeader;
  VisitBodyList({
    super.key,
    required this.data,
    required this.colorFontHeader,
    required this.colorHeader,
  });

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
                      Navigator.pop(context);
                    },
                    child: const Text("No"),
                  ),
                  TextButton(
                    onPressed: () async {},
                    child: const Text("Yes"),
                  ),
                ],
              );
            },
          );
        },
        onTap: () {},
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
                      "${data.customer?.name}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${data.contact?.name}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${data.contact?.phone}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Group :  ${data.customerGroup?.name}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Rating(1.0),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -0,
              child: Container(
                width: Get.width - 30,
                height: 40,
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
                        "${data.name}",
                        style: TextStyle(
                          color: colorFontHeader,
                          fontSize: 16.5,
                        ),
                      ),
                      Text(
                        "${data.workflowState}",
                        style: TextStyle(
                            color: colorFontHeader,
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
                          Text(
                            "6/16/2023 1:37 PM",
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
