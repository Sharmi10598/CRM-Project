// ignore_for_file: prefer_final_locals, omit_local_variable_types

import 'dart:convert';

class GetPackSizeModel {
  GetPackSizeModel({
    required this.status,
    required this.message,
    required this.activitiesData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<GetPackSizeData>? activitiesData;
  String? error;
  int? statusCode;

  factory GetPackSizeModel.fromJson(String resp, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'] != 'No data found') {
        var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
        List<GetPackSizeData> dataList = list
            .map((dynamic enquiries) => GetPackSizeData.fromJson(enquiries))
            .toList();

        return GetPackSizeModel(
          activitiesData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return GetPackSizeModel(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          activitiesData: null,
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return GetPackSizeModel(
        message: null,
        status: null,
        activitiesData: null,
        error: resp,
        statusCode: stcode,
      );
    }
  }
}

class GetPackSizeData {
  int? U_Tins_Per_Box;
  double? U_Pack_Size;

  GetPackSizeData({
    required this.U_Pack_Size,
    required this.U_Tins_Per_Box,
  });

  factory GetPackSizeData.fromJson(dynamic jsons) {
    return GetPackSizeData(
      U_Pack_Size: jsons['U_Pack_Size'] == null ? 0.0 : jsons['U_Pack_Size'] as double,
      U_Tins_Per_Box:
          jsons['U_Tins_Per_Box'] == null ? 0 : jsons['U_Tins_Per_Box'] as int,
    );
  }
}
