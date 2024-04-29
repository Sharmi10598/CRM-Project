// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, require_trailing_commas

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/SalesApp/Model/GetSaleEmpIDModel/GetSalesEmpIDModel.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class GetSaleEmpIDAPi {
  static Future<GetSalesEmpIDModel> getGlobalData() async {
    try {
      final response = await http.post(
        Uri.parse(URL.dynamicUrl),
        headers: {
          'content-type': 'application/json',
          },
         body: json.encode({
              "constr":"Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=${GetValues.sapPassword};",
              
              // "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
              "query": "select slpcode, slpname from oslp",//'${GetValues.slpCode}' 
          })
      );
     
      log(json.encode({
              "constr": 
                "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=${GetValues.sapPassword};",
              
              // "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
              "query": "select slpcode, slpname from oslp",
   }));
      // print('B1SESSION='+ GetValues.sessionID.toString());
      // print('odata.maxpagesize=${GetValues.maximumfetchValue}');
      print("SaleEmpIDAPi: " + json.decode(response.body).toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        return GetSalesEmpIDModel.fromJson( response.body,response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return GetSalesEmpIDModel.fromJson( response.body,response.statusCode);
      }
    } catch (e) {
      //  throw Exception("Exception: $e");
      return GetSalesEmpIDModel.fromJson(e.toString(),500);
    }
  }
}
