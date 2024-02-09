// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, unnecessary_string_interpolations

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/SalesApp/Api/VisitCreatePostApi/PursVisitPostApi.dart';
import 'package:ultimate_bundle/SalesApp/Model/PurposeVisitModel.dart/PostPurpVisitModel.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class UnplannedVisitAPi {
  static Future<PostPurposeVisitModel> getGlobalData(PurpVisitModel purpVisitModel) async {
    try {
      //log(URL.url+ "Activities");
      final response = await http.post(
        Uri.parse(URL.url+ "Activities"),
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
    "U_Status":"A"
}),);
     
//       log(json.encode( { 
//      "CardCode": "${purpVisitModel.cardCode}",
//     "Details": "${purpVisitModel.notes}",
//     "Activity": "cn_Meeting",
//     "SalesEmployee": purpVisitModel.SaleEmpCode,
//     "U_PlanDate": "${purpVisitModel.U_PlanDate}",
//     "U_PlanTime": "${purpVisitModel.U_PlanTime}",
//     "Subject": purpVisitModel.subject,
//     "U_Status":"A"
// }));
      // log("Unplanned details: " + json.decode(response.body).toString());
      // log("resp code unplan: "+response.statusCode.toString());
      if (response.statusCode == 200) {
        return PostPurposeVisitModel.fromJson( response.body,response.statusCode);
      } else {
        return PostPurposeVisitModel.fromJson( response.body,response.statusCode);
      }
    } catch (e) {
      return PostPurposeVisitModel.fromJson(e.toString(),500);
    }
  }
}
