// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/SalesApp/Model/VisitAproval/VisitAproval.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';


class LocationApproveAPi {
  static Future<PatchVisitModel> getGlobalData(LocationStatusModel apdata) async {
    try {
      final response = await http.post(
        Uri.parse(URL.dynamicUrl),
        headers: {
          'content-type': 'application/json',
          },
         body: json.encode({
              "constr": "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
              "query": "BZ_CRM_ApproveVists_ForLocApproval ${apdata.clgCode},'${apdata.status}'",
          }),);

          log( json.encode({
              "constr": "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
              "query": "BZ_CRM_ApproveVists_ForLocApproval ${apdata.clgCode},'${apdata.status}'",
          }),);
     log("sssssssss  ${response.body}");
    return PatchVisitModel.fromJson(response.body, response.statusCode);
    } catch (e) {
    return PatchVisitModel.fromJson(e.toString(), 500);
    }
  }
}

class LocationStatusModel{
  int clgCode;
  String status;
  LocationStatusModel({
    required this.clgCode,
    required this.status,
  });

}