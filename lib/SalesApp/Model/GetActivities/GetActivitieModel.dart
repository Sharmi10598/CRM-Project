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
  int? clgCode;
  String? cardCode;
  String? cardName;
  String? purpose;
  String? uPlanDate;
  int? uPlanTime;
  String? details;
  int? slpCode;
  String? slpName;
  String? fcmToken;

  GetActivitiesData({
    required this.clgCode,
    required this.cardCode,
    required this.cardName,
    required this.details,
    required this.purpose,
    required this.slpCode,
    required this.slpName,
    required this.uPlanDate,
    required this.uPlanTime,
    required this.fcmToken,
  });

  factory GetActivitiesData.fromJson(dynamic jsons) {
    return GetActivitiesData(
      clgCode: jsons['ClgCode'] as int,
      cardCode: jsons['CardCode'] as String,
      cardName: jsons['CardName'] as String,
      details: jsons['Details'] == null ? '' : jsons['Details'].toString(),
      purpose: jsons['Purpose'] as String,
      slpCode: jsons['SlpCode'] as int,
      slpName: jsons['SlpName'] as String,
      uPlanDate: jsons['U_PlanDate'] as String,
      uPlanTime: jsons['U_PlanTime'] as int,
      fcmToken: jsons['FCMToken'].toString(),
    );
  }
}
