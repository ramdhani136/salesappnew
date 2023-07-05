// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:salesappnew/config/Config.dart';
import 'package:salesappnew/utils/local_data.dart';

enum Data {
  visit,
  callsheet,
  customer,
  customergroup,
  contact,
  memo,
  erp,
  visitnote,
  callsheetNote,
  users
}

class FetchData {
  final Data data;
  late final String doc;

  FetchData({
    required this.data,
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
      case Data.erp:
        doc = "erp";
        break;
      case Data.visitnote:
        doc = "visitnote";
        break;
      case Data.callsheetNote:
        doc = "callsheetnote";
        break;
      case Data.users:
        doc = "users";
        break;
      default:
    }
  }

  Config config = Config();
  LocalData localData = LocalData();

  Future<dynamic> ADD<T>(Map<String, dynamic> body) async {
    try {
      String uri = "${config.baseUri}$doc";
      final response = await http.post(
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

  Future<Map<String, dynamic>> FINDALL<T>({
    List<String>? fields,
    List<List<String>>? filters,
    String? orderBy,
    String? search,
    String? params,
    int page = 1,
    int limit = 10,
    String? nearby,
  }) async {
    try {
      final setFilter = jsonEncode(filters);
      final setFields = jsonEncode(fields);

      String uri =
          "${config.baseUri}$doc${params != null ? params : ""}?page=$page${filters != null ? "&filters=$setFilter" : ""}${search != null ? "&search=$search" : ""}&limit=$limit${fields != null ? "&fields=$setFields" : ""}${nearby != null ? nearby : ""}";
      print(uri);
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

  Future<dynamic> FINDONE<T>({required String id, String? params}) async {
    try {
      String uri = "${config.baseUri}$doc${params ?? ""}/$id";
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

  Future<dynamic> UPDATEONE<T>(String id, Map<String, dynamic> body) async {
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

  Future<dynamic> DELETEONE<T>(String id) async {
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
