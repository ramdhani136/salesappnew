// ignore_for_file: non_constant_identifier_names, avoid_single_cascade_in_expression_statements

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:signature/signature.dart';

class DialogSignature extends StatelessWidget {
  const DialogSignature({super.key});

  @override
  Widget build(BuildContext context) {
    SignatureController signatureController = SignatureController();

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: Get.width * 0.95,
          height: Get.height * 0.85,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(children: [
            Expanded(
              child: RotatedBox(
                quarterTurns: -1,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                  child: Signature(
                    backgroundColor: Colors.white,
                    controller: signatureController,
                    height: double.infinity,
                    width: Get.width * 1.47,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.symmetric(vertical: 20),
              width: 55,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  left: BorderSide(
                      color: Color.fromARGB(255, 197, 197, 197), width: 1),
                ),
              ),
              child: Column(
                children: [
                  RotatedBox(
                    quarterTurns: -1,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (signatureController.isNotEmpty) {
                          // await VisitC.exportSignature();

                          Get.back();
                        } else {
                          Get.back();
                          // await VisitC.clearSignature();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                      ),
                      child: const Text("Save"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () async {
                          signatureController.value.clear();
                          // await VisitC.clearSignature();
                        },
                        child: const Text("Clear"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        )
      ],
    );
  }
}
