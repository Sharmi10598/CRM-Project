// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, require_trailing_commas, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/SalesApp/Model/GetToken/GetCntryHeadToken.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class GetCountryHeadTokenAPi {
  static Future<GetCntyheadModel> getGlobalData() async {
    try {
      final response = await http.post(
        Uri.parse(URL.dynamicUrl),
        headers: {
          'content-type': 'application/json',
          },
         body: json.encode({
              "constr": "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=${GetValues.sapPassword};",

              // "constr": "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
              "query":"SELECT FCMToken FROM CRM.DBO.USERS WHERE UserCode = 'Navdish'"
          })
      );
     
      // print('B1SESSION='+ GetValues.sessionID.toString());
      // print('odata.maxpagesize=${GetValues.maximumfetchValue}');
      //  log("checkdddd innn: " + json.decode(response.body).toString());
       print(response.statusCode);
      if (response.statusCode == 200) {
        return GetCntyheadModel.fromJson( response.body,response.statusCode);
      } else {
        print("Exception: Error");
        return GetCntyheadModel.fromJson( response.body,response.statusCode);
      }
    } catch (e) {
      print("Exception: $e");
      //  throw Exception("Exception: $e");
      return GetCntyheadModel.fromJson(e.toString(),500);
    }
  }
}
