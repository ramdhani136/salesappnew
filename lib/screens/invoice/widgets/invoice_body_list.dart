// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:salesappnew/screens/invoice/invoice_form.dart';

class InvoiceBodyList extends StatelessWidget {
  Map<String, dynamic> data;
  Color colorHeader;
  Color colorFontHeader;
  InvoiceBodyList({
    super.key,
    required this.data,
    required this.colorFontHeader,
    required this.colorHeader,
  });

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(
      locale: 'id',
    );

    return InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return InvoiceFormScreen(
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
                    const SizedBox(height: 5),
                    Text(
                      "Group :  ${data['customer_group']}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          formatCurrency.format(data['grand_total']),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Visibility(
                      visible: data['docstatus'] == 1
                          ? 100 -
                                  (data['outstanding_amount'] /
                                      (data['grand_total'] / 100)) !=
                              0
                          : false,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearPercentIndicator(
                          center: Text(
                            "${100 - (data['outstanding_amount'] / (data['grand_total'] / 100))}%",
                            style: const TextStyle(color: Colors.white),
                          ),
                          animation: true,
                          lineHeight: 20.0,
                          animationDuration: 2000,
                          width: Get.width * 0.80,
                          percent: double.parse(
                                  "${100 - (data['outstanding_amount'] / (data['grand_total'] / 100))}") /
                              100,
                          backgroundColor: Colors.grey[300],
                          progressColor: 100 -
                                      (data['outstanding_amount'] /
                                          (data['grand_total'] / 100)) <
                                  100
                              ? Colors.amber
                              : Colors.green[400],
                          barRadius: const Radius.circular(16),
                        ),
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
                        "${data['status']}",
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
