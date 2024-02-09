// ignore_for_file: prefer_final_locals, omit_local_variable_types

import 'dart:convert';

class GetActivitiesModel {
  GetActivitiesModel({
    required this.status,
    required this.message,
    required this.activitiesData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<GetActivitiesData>? activitiesData;
  String? error;
  int? statusCode;

  factory GetActivitiesModel.fromJson(String resp, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'] != 'No data found') {
        var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
        List<GetActivitiesData> dataList = list
            .map((dynamic enquiries) => GetActivitiesData.fromJson(enquiries))
            .toList();
        return GetActivitiesModel(
          activitiesData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return GetActivitiesModel(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          activitiesData: null,
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return GetActivitiesModel(
        message: null,
        status: null,
        activitiesData: null,
        error: resp,
        statusCode: stcode,
      );
    }
  }
}

class GetActivitiesData {
  int? ClgCode;
  String? CardCode;
  String? CardName;
  String? Purpose;
  String? U_PlanDate;
  int? U_PlanTime;
  String? Details;
  int? SlpCode;
  String? SlpName;
  String? FCMToken;

  GetActivitiesData({
    required this.ClgCode,
    required this.CardCode,
    required this.CardName,
    required this.Details,
    required this.Purpose,
    required this.SlpCode,
    required this.SlpName,
    required this.U_PlanDate,
    required this.U_PlanTime,
    required this.FCMToken,
  });

  factory GetActivitiesData.fromJson(dynamic jsons) {
    return GetActivitiesData(
      ClgCode: jsons['ClgCode'] as int,
      CardCode: jsons['CardCode'] as String,
      CardName: jsons['CardName'] as String,
      Details: jsons['Details'] == null ? '' : jsons['Details'].toString(),
      Purpose: jsons['Purpose'] as String,
      SlpCode: jsons['SlpCode'] as int,
      SlpName: jsons['SlpName'] as String,
      U_PlanDate: jsons['U_PlanDate'] as String,
      U_PlanTime: jsons['U_PlanTime'] as int,
      FCMToken: jsons['FCMToken'].toString(),
    );
  }
}
