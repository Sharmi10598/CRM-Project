// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/SalesApp/Model/VisitAproval/VisitAproval.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class ApproveVisitAPi {
  static Future<PatchVisitModel> getGlobalData(ApproveVisitModel apdata) async {
    try {
      log(URL.url+ "Activities");
      final response = await http.patch(
        Uri.parse(  URL.url+ "Activities(${apdata.clgCode})"),
        headers: {
          'content-type': 'application/json',
          "cookie": 'B1SESSION=' + GetValues.sessionID.toString(),
          },
         body: json.encode({ 
    "U_Status": "${apdata.status}",
}),
      );
     
      log(json.encode( { 
    "U_Status": "${apdata.status}",
}),);
        return PatchVisitModel.fromJson(response.body, response.statusCode);
    } catch (e) {
      //  throw Exception("Exception: $e");
    return PatchVisitModel.fromJson(e.toString(), 500);
    }
  }
}

class ApproveVisitModel{
  int clgCode;
  String status;


  ApproveVisitModel({
    required this.clgCode,
    required this.status,
  });

}