// ignore_for_file: non_constant_identifier_names

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:salesappnew/utils/fetch_data.dart';

Future<Map<String, dynamic>> BranchRepositoryGetAll({
  List<String>? fields,
  List<List<String>>? filters,
  String? orderBy,
  String? search,
  String? params,
  int page = 1,
  int limit = 0,
}) async {
  EasyLoading.show(status: 'loading...');
  try {
    Map<String, dynamic> response = await FetchData(data: Data.branch).FINDALL(
      limit: limit,
      page: page,
      filters: filters,
      fields: fields,
    );
    if (response['status'] != 200) {
      throw response['msg'];
    }
    EasyLoading.dismiss();
    return response;
  } catch (e) {
    EasyLoading.dismiss();
    return {};
  }
}
