// ignore_for_file: non_constant_identifier_names, avoid_single_cascade_in_expression_statements, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';

import 'package:signature/signature.dart';

class DialogSignature extends StatelessWidget {
  VisitBloc visitBloc;
  String id;
  DialogSignature({super.key, required this.visitBloc, required this.id});

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
                          visitBloc.add(UpdateSignature(
                              controller: signatureController, id: id));

                          Get.back();
                        } else {
                          Get.back();
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
                          signatureController.clear();
                          visitBloc.add(ClearSignature(id: id));
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
