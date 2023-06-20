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
  int limit = 10;

  FetchData(
      {required this.data,
      this.fields,
      this.filters,
      this.orderBy,
      this.params,
      this.search,
      this.limit = 10,
      setPage}) {
    page = setPage;
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

      String uri =
          "${config.baseUri}$doc?page=${page}${filters!.isNotEmpty ? "&filters=$setFilter" : ""}${search != null ? "&search=${search}" : ""}&limit=$limit";
      final response = await http.get(
        Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader:
              'Bearer ${await localData.getToken()}',
        },
      );

      final Map<String, dynamic> jsonData = await jsonDecode(response.body);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }
}
