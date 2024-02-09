// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, require_trailing_commas

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/SalesApp/Model/GetActivities/GetContApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';


class GetContAPi {
  static Future<GetcountModel> getGlobalData(String slpcode,String planDate) async {
    try {
      final response = await http.post(
        Uri.parse(URL.dynamicUrl),
        headers: {
          'content-type': 'application/json',
          },
         body: json.encode({
              "constr": "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
              "query": "Select count(*) Cnt From oclg where slpcode = $slpcode and U_CheckedIn = 'Yes' and U_Status = 'A' and U_PlanDate = '$planDate'",//'${GetValues.slpCode}'
          })
      );

      // log(json.encode({
      //         "constr": "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
      //         "query": "Select count(*) Cnt From oclg where slpcode = ${slpcode} and U_CheckedIn = 'Yes' and U_Status = 'A'",//'${GetValues.slpCode}'
      //     }).toString());
     
      // print('B1SESSION='+ GetValues.sessionID.toString());
      // print('odata.maxpagesize=${GetValues.maximumfetchValue}');
     //  print("count checked in: " + json.decode(response.body).toString());
      // print(response.statusCode);
      if (response.statusCode == 200) {
        return GetcountModel.fromJson( response.body,response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return GetcountModel.fromJson( response.body,response.statusCode);
      }
    } catch (e) {
      //  throw Exception("Exception: $e");
      return GetcountModel.fromJson(e.toString(),500);
    }
  }
}
