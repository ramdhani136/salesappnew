// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:salesappnew/config/Config.dart';
import 'package:salesappnew/utils/local_data.dart';

enum Data { visit, callsheet, customer, customergroup, contact, memo }

class FetchData {
  final Data data;
  late final String doc;

  FetchData({
    required this.data,
    // this.fields,
    // this.filters,
    // this.orderBy,
    // this.params,
    // this.search,
    // this.limit = 10,
  }) {
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
  }

  Config config = Config();
  LocalData localData = LocalData();

  Future<Map<String, dynamic>> FIND<T>({
    List<String>? fields,
    List<List<String>>? filters,
    String? orderBy,
    String? search,
    String? params,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final setFilter = jsonEncode(filters);

      String uri =
          "${config.baseUri}$doc?page=$page${filters!.isNotEmpty ? "&filters=$setFilter" : ""}${search != null ? "&search=$search" : ""}&limit=$limit";
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

  Future<dynamic> Show<T>(String id) async {
    try {
      String uri = "${config.baseUri}$doc/$id";
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

  Future<dynamic> Update<T>(String id, Map<String, dynamic> body) async {
    try {
      String uri = "${config.baseUri}$doc/$id";
      final response = await http.put(
        Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader:
              'Bearer ${await localData.getToken()}',
        },
        body: jsonEncode(body),
      );
      final Map<String, dynamic> jsonData = await jsonDecode(response.body);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> Delete<T>(String id) async {
    try {
      String uri = "${config.baseUri}$doc/$id";
      final response = await http.delete(
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
