// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, require_trailing_commas

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/SalesApp/Model/GetSaleEmpModel/GetSaleEmpModel.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class GetSaleEmpAPi {
  static Future<GetSalesEmpModel> getGlobalData() async {
    try {
      log('Location query::' +
          json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=${GetValues.sapPassword};",

            // "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
            "query":
                "select slpcode, slpname from oslp where U_RepotingTo = '${GetValues.slpCode}", //'${GetValues.slpCode}'
          }));
      log('URL.dynamicUrl::${URL.dynamicUrl}');
      final response = await http.post(Uri.parse(URL.dynamicUrl),
          headers: {
            'content-type': 'application/json',
          },
          body: json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=${GetValues.sapPassword};",

            // "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
            "query":
                "select slpcode, slpname from oslp where U_RepotingTo = '${GetValues.slpCode}'", //'${GetValues.slpCode}'
          }));

      log("SaleEmpAPi details: " + json.decode(response.body).toString());
      log("SaleEmpAPi::" + response.statusCode.toString());
      if (response.statusCode == 200) {
        return GetSalesEmpModel.fromJson(response.body, response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return GetSalesEmpModel.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      //  throw Exception("Exception: $e");
      return GetSalesEmpModel.fromJson(e.toString(), 500);
    }
  }
}
