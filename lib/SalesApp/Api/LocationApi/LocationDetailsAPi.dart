// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, require_trailing_commas

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/SalesApp/Model/LocationModel/LocationModel.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class GetLocationDetailsAPi {
  static Future<GetLocDetModel> getGlobalData(String slpcode) async {
    try {
      final response = await http.post(
        Uri.parse(URL.dynamicUrl),
        headers: {
          'content-type': 'application/json',
          },
         body: json.encode({
              "constr": "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
              "query": "BZ_CRM_GetVisits_ForLocApproval '$slpcode'",//'${GetValues.slpCode}'
          })
      );
      log(json.encode({
              "constr": "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
              "query": "BZ_CRM_GetVisits_ForLocApproval'$slpcode'",
   }));
   log("resspp: ${response.body}");
      if (response.statusCode == 200) {
        return GetLocDetModel.fromJson( response.body,response.statusCode);
      } else {
        return GetLocDetModel.fromJson( response.body,response.statusCode);
      }
    } catch (e) {
      return GetLocDetModel.fromJson(e.toString(),500);
    }
  }
}
