// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:salesappnew/bloc/fielddatascroll/fielddatascroll_bloc.dart';
import 'package:salesappnew/models/key_value_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:salesappnew/widgets/custom_field.dart';
import 'package:salesappnew/widgets/field_data_scroll.dart';

class CustomerFormWidget extends StatefulWidget {
  KeyValue? branch;
  KeyValue? group;
  String? name;
  CustomerFormWidget({
    this.branch,
    this.group,
    this.name,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomerFormWidget> createState() => _CustomerFormWidgetState();
}

class _CustomerFormWidgetState extends State<CustomerFormWidget> {
  FielddatascrollBloc branchFieldBloc = FielddatascrollBloc();
  FielddatascrollBloc groupFieldBloc = FielddatascrollBloc();
  TextEditingController nameC = TextEditingController();
  KeyValue? branch;
  KeyValue? group;

  @override
  void initState() {
    if (widget.branch != null) {
      branch = widget.branch;
    }
    if (widget.group != null) {
      group = widget.group;
    }
    if (widget.name != null) {
      nameC.text = widget.name!;
    }
    super.initState();
  }

  @override
  void dispose() {
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
        FieldDataScroll(
          bloc: branchFieldBloc,
          endpoint: Data.branch,
          // valid: visitBloc.group?.value == null || visitBloc.group?.value == ""
          //     ? false
          //     : true,
          value: branch?.name ?? "",
          title: "Branch",
          titleModal: "Branch List",
          onSelected: (e) {},
          onReset: () {},
          mandatory: true,
        ),
        const SizedBox(
          height: 15,
        ),
        FieldDataScroll(
          bloc: groupFieldBloc,
          endpoint: Data.customergroup,
          // valid: visitBloc.group?.value == null || visitBloc.group?.value == ""
          //     ? false
          //     : true,
          value: group?.name ?? "",
          title: "Group",
          titleModal: "Group List",
          onSelected: (e) {},
          onReset: () {},
          mandatory: true,
        ),
        const SizedBox(
          height: 15,
        ),
        CustomField(
          mandatory: true,
          // valid: validName,
          title: "Name",
          controller: nameC,
          type: Type.standard,
          onChange: (e) {},
          placeholder: "",
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(
              const Size(double.infinity, 48),
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return const Color.fromARGB(255, 92, 214, 96);
                }
                return const Color.fromARGB(255, 65, 170, 69);
              },
            ),
          ),
          child: const Text(
            "Save",
            style: TextStyle(fontSize: 16),
          ),
        )
      ],
    );
  }
}
