// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/SalesApp/Model/PurposeVisitModel.dart/PurposeVisitModel.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class GetPurposeVisitAPi {
  static Future<PurposeVisitModel> getGlobalData() async {
    try {
      final response = await http.post(
        Uri.parse(URL.dynamicUrl),
        headers: {
          'content-type': 'application/json',
          },
         body: json.encode({
              "constr": "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
              "query": "select * from ocls",//'${GetValues.slpCode}'
          }),
      );
     
      log(json.encode({
              "constr": "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
              "query": "select * from ocls",
   }),);
      // print('B1SESSION='+ GetValues.sessionID.toString());
      // print('odata.maxpagesize=${GetValues.maximumfetchValue}');
      print("customer details: " + json.decode(response.body).toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        return PurposeVisitModel.fromJson( response.body,response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return PurposeVisitModel.fromJson( response.body,response.statusCode);
      }
    } catch (e) {
      //  throw Exception("Exception: $e");
      return PurposeVisitModel.fromJson(e.toString(),500);
    }
  }
}
