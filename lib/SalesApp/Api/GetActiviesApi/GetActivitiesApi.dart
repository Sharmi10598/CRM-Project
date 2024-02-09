// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, require_trailing_commas

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/SalesApp/Model/GetActivities/GetActivitieModel.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class GetActivitiesAPi {
  static Future<GetActivitiesModel> getGlobalData(String slpcode) async {
    try {
      final response = await http.post(
        Uri.parse(URL.dynamicUrl),
        headers: {
          'content-type': 'application/json',
          },
         body: json.encode({
              "constr": "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
              "query": "Select ClgCode, T1.CardCode, T1.CardName,T2.Name Purpose ,U_PlanDate, U_PlanTime, Details,T0.SlpCode, T3.SlpName,FCMToken from OCLG T0 Inner Join OCRD T1 on T1.CardCode = T0.CardCode Inner Join OCLS T2 on T2.Code = T0.CntctSbjct Inner join OSLP T3 on T3.SlpCode = T0.SlpCode Inner Join CRM.dbo.Users T4 on T4.SlpCode = T3.SlpCode where U_Status = 'O' and T3.SlpCode ='$slpcode'and FCMToken != 'null'",//'${GetValues.slpCode}'
          })
      );
     
      // print('B1SESSION='+ GetValues.sessionID.toString());
      // print('odata.maxpagesize=${GetValues.maximumfetchValue}');
      log("customer details: " + json.decode(response.body).toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        return GetActivitiesModel.fromJson( response.body,response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return GetActivitiesModel.fromJson( response.body,response.statusCode);
      }
    } catch (e) {
      //  throw Exception("Exception: $e");
      return GetActivitiesModel.fromJson(e.toString(),500);
    }
  }
}
