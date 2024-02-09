// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/SalesApp/Model/PurposeVisitModel.dart/PostPurpVisitModel.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class CheckOutNFPostAPi {
  static Future<PostPurposeVisitModel> getGlobalData(CheckOutNFPModel purpVisitModel) async {
    try {
      log(URL.url+ "Activities");
      final response = await http.post(
        Uri.parse(  URL.url+ "Activities"),
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
     "PreviousActivity": purpVisitModel.PreviousActivity
}), );
     
      log(json.encode({ 
    "CardCode": "${purpVisitModel.cardCode}",
    "Details": "${purpVisitModel.notes}",
    "Activity": "cn_Meeting",
    "SalesEmployee": purpVisitModel.SaleEmpCode,
    "U_PlanDate": "${purpVisitModel.U_PlanDate}",
    "U_PlanTime": "${purpVisitModel.U_PlanTime}",
    "Subject": purpVisitModel.subject,
     "PreviousActivity": purpVisitModel.PreviousActivity
}), );
      // print('B1SESSION='+ GetValues.sessionID.toString());
      // print('odata.maxpagesize=${GetValues.maximumfetchValue}');
     print("customer details: " + response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return PostPurposeVisitModel.fromJson( response.body,response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return PostPurposeVisitModel.fromJson( response.body,response.statusCode);
      }
    } catch (e) {
      //  throw Exception("Exception: $e");
      return PostPurposeVisitModel.fromJson(e.toString(),500);
    }
  }
}

class CheckOutNFPModel{
  String cardCode;
  String notes;
  String Activity;
  int SaleEmpCode;
  int subject;
  String U_PlanDate;
  String U_PlanTime;
  int PreviousActivity;



  CheckOutNFPModel({
    required this.Activity,
    required this.SaleEmpCode,
    required this.U_PlanDate,
    required this.U_PlanTime,
    required this.cardCode,
    required this.notes,
    required this.subject,
    required this.PreviousActivity,
  });

}