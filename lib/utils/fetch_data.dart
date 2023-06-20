import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:salesappnew/config/Config.dart';
import 'package:salesappnew/utils/local_data.dart';

enum Data { visit, callsheet, customer, customergroup, contact, memo }

class FetchData {
  final Data data;
  List<String>? fields = [];
  List<List<String>>? filters = [];
  String? orderBy;
  String? search;
  String? params;
  int page = 1;

  FetchData(
      {required this.data,
      this.fields,
      this.filters,
      this.orderBy,
      this.params,
      this.search,
      setPage}) {
    this.page = setPage;
  }

  Config config = Config();
  LocalData localData = LocalData();
  Future<Map<String, dynamic>> FIND<T>() async {
    try {
      late String doc;
      switch (data) {
        case Data.visit:
          doc = "visit";
          break;
        case Data.callsheet:
          doc = "callsheet";
          break;
        case Data.contact:
          doc = "contact";
          break;
        case Data.customer:
          doc = "customer";
          break;
        case Data.customergroup:
          doc = "customergroup";
          break;
        case Data.memo:
          doc = "memo";
          break;
        default:
      }

      final setFilter = jsonEncode(filters);
      print(filters!.isNotEmpty);
      print(
          "${config.baseUri}$doc?page=${page}${filters!.isNotEmpty ? "&filters=$setFilter" : ""}");
      final response = await http.get(
        Uri.parse(
            "${config.baseUri}$doc?page=${page}${filters!.isNotEmpty ? "&filters=$setFilter" : ""}"),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader:
              'Bearer ${await localData.getToken()}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = await jsonDecode(response.body);
        return jsonData;
      } else {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        throw jsonData;
      }
    } catch (e) {
      rethrow;
    }
  }
}
