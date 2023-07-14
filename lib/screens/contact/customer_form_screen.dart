// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:salesappnew/bloc/customer/customer_bloc.dart';
import 'package:salesappnew/models/key_value_model.dart';
import 'package:salesappnew/widgets/custom_field.dart';

class CustomerFormScreen extends StatefulWidget {
  CustomerBloc bloc;
  KeyValue? group;
  CustomerFormScreen({
    Key? key,
    required this.bloc,
    required this.group,
  }) : super(key: key);

  @override
  State<CustomerFormScreen> createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends State<CustomerFormScreen> {
  late TextEditingController nameC;
  late TextEditingController branchC;
  late TextEditingController groupC;
  late bool validBranch;
  late bool validName;
  late KeyValue branch;
  @override
  void initState() {
    branch;
    nameC = TextEditingController();
    branchC = TextEditingController();
    groupC = TextEditingController(text: widget.group?.name ?? "");
    validBranch = false;
    validName = false;
    nameC.addListener(() {
      setState(() {
        if (nameC.text != "") {
          validName = true;
        } else {
          validName = false;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    nameC.dispose();
    groupC.dispose();
    branchC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "New Customer",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomField(
          mandatory: true,
          valid: true,
          title: "Branch",
          controller: branchC,
          type: Type.select,
          data: [],
        ),
        const SizedBox(
          height: 10,
        ),
        CustomField(
          title: "Group",
          controller: groupC,
          type: Type.standard,
          disabled: true,
        ),
        const SizedBox(
          height: 10,
        ),
        CustomField(
          mandatory: true,
          valid: validName,
          title: "Name",
          controller: nameC,
          type: Type.standard,
          onChange: (e) {},
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(
                  255, 57, 156, 60), // Mengatur warna latar belakang
            ),
            minimumSize: MaterialStateProperty.all<Size>(
              const Size(double.infinity, 48),
            ), // Mengatur lebar penuh dan tinggi tetap
          ),
          child: const Text(
            "Save",
            style: TextStyle(fontSize: 16),
          ),
        )
      ],
    );
    ;
  }
}
