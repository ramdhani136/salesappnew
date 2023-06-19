import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:salesappnew/config/Config.dart';
import 'package:salesappnew/utils/local_data.dart';

enum Data { visit, callsheet, customer, customergroup, contact, memo }

class FetchData {
  final Data data;
  List<String>? fields = [];
  List<dynamic>? filters = [];
  String? orderBy;
  String? search;
  String? params;

  FetchData({
    required this.data,
    this.fields,
    this.filters,
    this.orderBy,
    this.params,
    this.search,
  });

  Config config = Config();
  LocalData localData = LocalData();
  Future<T> FIND<T>() async {
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

      final response = await http.get(
        Uri.parse("${config.baseUri}$doc"),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader:
              'Bearer ${await localData.getToken()}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = await jsonDecode(response.body);
        return jsonData['data'];
      } else {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        throw jsonData;
      }
    } catch (e) {
      rethrow;
    }
  }
}