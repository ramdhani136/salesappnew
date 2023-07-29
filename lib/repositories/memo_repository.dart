// ignore_for_file: non_constant_identifier_names

import 'package:salesappnew/utils/fetch_data.dart';

Future<Map<String, dynamic>> RepositoryGetAllMemo({
  List<String>? fields,
  List<List<String>>? filters,
  String? orderBy,
  String? search,
  String? params,
  int page = 1,
  int limit = 0,
}) async {
  try {
    Map<String, dynamic> response = await FetchData(data: Data.memo).FINDALL(
      limit: limit,
      page: page,
      filters: filters,
      fields: fields,
      search: search,
    );
    if (response['status'] != 200) {
      throw response['msg'];
    }

    return response;
  } catch (e) {
    rethrow;
  }
}
