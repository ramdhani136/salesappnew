// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesappnew/bloc/branch/branch_bloc.dart';
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
  late KeyValue? branch;
  final BranchBloc branchBloc = BranchBloc()..add(BranchGetAll());

  @override
  void initState() {
    branch = null;
    nameC = TextEditingController(text: widget.bloc.search);
    branchC = TextEditingController();
    groupC = TextEditingController(text: widget.group?.name ?? "");
    validBranch = false;
    validName = true;
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
        BlocBuilder<BranchBloc, BranchState>(
          bloc: branchBloc,
          builder: (context, state) {
            List branchList = [];
            if (state is BranchIsLoaded) {
              branchList = state.data.map((item) {
                return {
                  "value": item["_id"],
                  "title": item["name"],
                };
              }).toList();
            }

            if (branchList.length == 1) {
              branchC.text = branchList[0]['title'] ?? "";
              branch = KeyValue(
                  name: branchList[0]['title'] ?? "",
                  value: branchList[0]['value'] ?? "");
            }

            return CustomField(
              mandatory: true,
              valid: branch != null,
              title: "Branch",
              controller: branchC,
              type: Type.select,
              data: branchList,
              onChange: (e) {
                setState(() {
                  branchC.text = e['title'] ?? "";
                  branch = KeyValue(
                    name: e['title'] ?? "",
                    value: e['value'] ?? "",
                  );
                });
              },
              onReset: () {
                setState(() {
                  branch = null;
                  branchC.text = "";
                });
              },
            );
          },
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
          onPressed: () {
            if (nameC.text.isNotEmpty && branchC.text.isNotEmpty) {
              widget.bloc.add(
                CustomerInsert(
                  data: {
                    'name': nameC.text,
                    'branch': branch!.value,
                    'customerGroup': widget.group!.value!,
                    'status': "1",
                    "workflowState": 'Submitted',
                  },
                ),
              );
              widget.bloc.add(
                GetAllCustomer(
                  search: widget.bloc.search,
                  filters: [
                    ["customerGroup", "=", widget.group?.value ?? ""]
                  ],
                ),
              );
            }
          },
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(
              const Size(double.infinity, 48),
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled) ||
                    nameC.text.isEmpty ||
                    branchC.text.isEmpty) {
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
