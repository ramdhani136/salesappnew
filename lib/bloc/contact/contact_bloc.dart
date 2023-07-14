// ignore_for_file: library_prefixes, non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  String pic = "";
  String phone = "";
  ContactBloc() : super(ContactInitial()) {
    on<GetListInput>(_GetListInput);
    on<ContactInsertData>(_InsertData);
    on<ContactGetPhone>(_getByPhone);
    on<ContactFilterPhone>(_filterPhone);
    on<ContactSelectPhone>(
      (event, emit) {
        pic = event.data['pic'];
        phone = event.data['phone'] ?? "";

        emit(
          ContactInitial(),
        );
      },
    );
  }

  Future<void> _filterPhone(
    ContactFilterPhone event,
    Emitter<ContactState> emit,
  ) async {
    if (state is ContactPhoneIsloaded) {
      ContactPhoneIsloaded phoneData = state as ContactPhoneIsloaded;

      List<Contact> resultContact = phoneData.current.where(
        (element) {
          final name = element.displayName.toLowerCase();
          final value = event.filter.toLowerCase();
          var allFilter = name.contains(value);
          return allFilter;
        },
      ).toList();

      emit(
        ContactPhoneIsloaded(current: phoneData.current, data: resultContact),
      );
    }
  }

  Future<void> _GetListInput(
      GetListInput event, Emitter<ContactState> emit) async {
    try {
      if (event.isLoading) {
        emit(ContactIsLoading());
      }
      Map<String, dynamic> result = await FetchData(data: Data.contact).FINDALL(
        page: 1,
        filters: [
          ["customer", "=", event.customerId],
        ],
        fields: ["name", "phone"],
      );

      List<dynamic> setData = result['data'].map((item) {
        return {
          'title': item["name"],
          'subTitle': item["phone"] ?? "",
          'value': item["_id"],
        };
      }).toList();

      if (result['status'] != 200) {
        throw result;
      }

      emit(ContactIsLoaded(data: setData));
    } catch (e) {
      emit(ContactIsFailure(e.toString()));
    }
  }

  Future<void> _InsertData(
    ContactInsertData event,
    Emitter<ContactState> emit,
  ) async {
    try {
      EasyLoading.show(status: 'loading...');
      Map<String, dynamic> result =
          await FetchData(data: Data.contact).ADD(event.data);

      if (result['status'] != 200) {
        throw result['msg'];
      }
      Get.back();

      EasyLoading.dismiss();
    } catch (e) {
      Get.defaultDialog(
        // title: "Ups, someting wrong",

        content: Text(
          e.toString(),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
      );
      EasyLoading.dismiss();
      emit(ContactIsFailure(e.toString()));
    }
  }

  Future<void> _getByPhone(
    ContactGetPhone event,
    Emitter<ContactState> emit,
  ) async {
    try {
      if (await FlutterContacts.requestPermission()) {
        emit(ContactIsLoading());
        EasyLoading.show(status: 'loading...');
        List<Contact> contacts = await FlutterContacts.getContacts(
          withProperties: true,
          withPhoto: true,
        );
        emit(ContactPhoneIsloaded(
          data: contacts,
          current: contacts,
        ));

        EasyLoading.dismiss();
      }
    } catch (e) {
      Get.defaultDialog(
        // title: "Ups, someting wrong",

        content: Text(
          e.toString(),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
      );
      EasyLoading.dismiss();
      emit(ContactIsFailure(e.toString()));
    }
  }
}
