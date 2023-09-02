// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, invalid_use_of_visible_for_testing_member
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesappnew/bloc/customer/customer_bloc.dart';
import 'package:salesappnew/bloc/fielddatascroll/fielddatascroll_bloc.dart';
import 'package:salesappnew/models/key_value_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:salesappnew/widgets/custom_field.dart';
import 'package:salesappnew/widgets/field_data_scroll.dart';

class CustomerFormWidget extends StatefulWidget {
  KeyValue? branch;
  KeyValue? group;
  String? name;
  final void Function() onSuccess;
  CustomerFormWidget({
    this.branch,
    this.group,
    this.name,
    required this.onSuccess,
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
  CustomerBloc bloc = CustomerBloc();

  @override
  void initState() {
    if (widget.branch != null) {
      bloc.branch = widget.branch;
    }
    if (widget.group != null) {
      bloc.group = widget.group;
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
    return BlocProvider(
      create: (context) => CustomerBloc(),
      child: Column(
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
          BlocBuilder<CustomerBloc, CustomerState>(
            bloc: bloc,
            builder: (context, state) {
              return Column(
                children: [
                  FieldDataScroll(
                    endpoint: Data.branch,
                    valid:
                        bloc.branch?.value == null || bloc.branch?.value == ""
                            ? false
                            : true,
                    value: bloc.branch?.name ?? "",
                    title: "Branch",
                    titleModal: "Branch List",
                    onSelected: (e) {
                      bloc.branch = KeyValue(name: e["name"], value: e["_id"]);
                      bloc.group = KeyValue(name: "", value: "");
                      bloc.emit(CustomerIsLoading());
                    },
                    onReset: () {
                      bloc.branch = KeyValue(name: "", value: "");
                      bloc.group = KeyValue(name: "", value: "");

                      bloc.emit(CustomerIsLoading());
                    },
                    mandatory: true,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  FieldDataScroll(
                    endpoint: Data.customergroup,
                    valid: bloc.group?.value == null || bloc.group?.value == ""
                        ? false
                        : true,
                    value: bloc.group?.name ?? "",
                    title: "Group",
                    titleModal: "Group List",
                    onSelected: (e) {
                      bloc.group = KeyValue(name: e["name"], value: e["_id"]);
                      bloc.emit(CustomerIsLoading());
                    },
                    onReset: () {
                      bloc.group = KeyValue(name: "", value: "");
                      bloc.emit(CustomerIsLoading());
                    },
                    mandatory: true,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomField(
                    mandatory: true,
                    valid: nameC.text != "",
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
                    onPressed: () {
                      bloc.add(
                        CustomerInsert(
                          data: {
                            "branch": branch?.value,
                            "customerGroup": group?.value,
                            "name": nameC.text,
                            "status": "1",
                            "workflowState": "Submitted"
                          },
                        ),
                      );
                    },
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
            },
          )
        ],
      ),
    );
  }
}
