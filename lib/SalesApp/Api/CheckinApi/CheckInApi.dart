// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, unnecessary_string_interpolations, require_trailing_commas

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/SalesApp/Model/VisitAproval/VisitAproval.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/DB/DBModal/GetApprovedCust.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class CheckinAPi {
  static Future<PatchVisitModel> getGlobalData(CheckinModel apdata) async {
    try {
      log("Activities::" + URL.url + "Activities");
      final response =
          await http.patch(Uri.parse(URL.url + "Activities(${apdata.clgcode})"),
              headers: {
                'content-type': 'application/json',
                "cookie": 'B1SESSION=' + GetValues.sessionID.toString()
              },
              body: json.encode({
                "ActivityDate": "${apdata.ActivityDate}",
                "ActivityTime": "${apdata.ActivityTime}",
                "StartDate": "${apdata.StartDate}",
                "StartTime": "${apdata.StartTime}",
                "U_Latitude": "${apdata.U_Latitude}",
                "U_Longitude": "${apdata.U_Longitude}",
                "U_CheckedIn": "${apdata.U_CheckedIn}",
                "U_CheckinAdd": "${apdata.U_CheckinAdd}",
              }));

      log('CheckinAPi::::' +
          json.encode({
            "ActivityDate": "${apdata.ActivityDate}",
            "ActivityTime": "${apdata.ActivityTime}",
            "StartDate": "${apdata.StartDate}",
            "StartTime": "${apdata.StartTime}",
            "U_Latitude": "${apdata.U_Latitude}",
            "U_Longitude": "${apdata.U_Longitude}",
            "U_CheckedIn": "${apdata.U_CheckedIn}",
            ".U_CheckinAdd": "${apdata.U_CheckinAdd}",
          }));
      log("statuscode: " + response.statusCode.toString());
      return PatchVisitModel.fromJson(response.body, response.statusCode);
    } catch (e) {
      //  throw Exception("Exception: $e");
      return PatchVisitModel.fromJson(e.toString(), 500);
    }
  }
}

class CheckinModel {
  int clgcode;
  String ActivityDate;
  String ActivityTime;
  String StartDate;
  String StartTime;
  String U_Latitude;
  String U_Longitude;
  String U_CheckedIn;
  String U_CheckinAdd;
  String status;

  CheckinModel(
      {required this.U_CheckinAdd,
      required this.clgcode,
      required this.ActivityDate,
      required this.ActivityTime,
      required this.StartDate,
      required this.StartTime,
      required this.U_Latitude,
      required this.U_Longitude,
      required this.U_CheckedIn,
      required this.status});

  Map<String, Object?> toMap() => {
        PostCheckInModel.U_CheckinAdd: U_CheckinAdd,
        PostCheckInModel.clgcode: clgcode,
        PostCheckInModel.StartDate: StartDate,
        PostCheckInModel.StartTime: StartTime,
        PostCheckInModel.ActivityDate: ActivityDate,
        PostCheckInModel.ActivityTime: ActivityTime,
        PostCheckInModel.U_Latitude: U_Latitude,
        PostCheckInModel.U_Longitude: U_Longitude,
        PostCheckInModel.U_CheckedIn: U_CheckedIn,
        PostCheckInModel.status: status,
      };
}
