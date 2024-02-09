// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/SalesApp/Api/VisitCreatePostApi/PursVisitPostApi.dart';
import 'package:ultimate_bundle/SalesApp/Model/PurposeVisitModel.dart/UpdatePlanModel.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class PatchPurposeVisitAPi {
  static Future<PatchVisitModel> getGlobalData(PurpVisitModel purpVisitModel) async {
    try {
      log( URL.url+ "Activities(${purpVisitModel.clgCode})");
      final response = await http.patch(
        Uri.parse(  URL.url+ "Activities(${purpVisitModel.clgCode})"),
        headers: {
          'content-type': 'application/json',
          "cookie": 'B1SESSION=' + GetValues.sessionID.toString()
          },
         body: json.encode({ 
    "CardCode": "${purpVisitModel.cardCode}",
    "Details": "${purpVisitModel.notes}",
    "Activity": "cn_Meeting",
    "SalesEmployee": purpVisitModel.SaleEmpCode,
    "U_PlanDate": "${purpVisitModel.U_PlanDate}",
    "U_PlanTime": "${purpVisitModel.U_PlanTime}",
    "Subject": purpVisitModel.subject,
    "U_Status":"O"
}),);
     
      log(json.encode( { 
    "CardCode": "${purpVisitModel.cardCode}",
    "Details": "${purpVisitModel.notes}",
    "Activity": "cn_Meeting",
    "SalesEmployee": purpVisitModel.SaleEmpCode,
    "U_PlanDate": "${purpVisitModel.U_PlanDate}",
    "U_PlanTime": "${purpVisitModel.U_PlanTime}",
    "Subject": purpVisitModel.subject,
    "U_Status":"O"
}),);
      // print('B1SESSION='+ GetValues.sessionID.toString());
      // print('odata.maxpagesize=${GetValues.maximumfetchValue}');
      // print("customer details: " +response.body.toString());
      // print("... "+response.statusCode.toString());
      if (response.statusCode == 200) {
        return PatchVisitModel.fromJson( response.body,response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return PatchVisitModel.fromJson( response.body,response.statusCode);
      }
    } catch (e) {
      //  throw Exception("Exception: $e");
      return PatchVisitModel.fromJson(e.toString(),500);
    }
  }
}
