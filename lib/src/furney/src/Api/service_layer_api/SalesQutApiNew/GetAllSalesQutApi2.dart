// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, require_trailing_commas, unused_import, always_use_package_imports, duplicate_ignore

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/helpers/uikit_model.dart';
import '../../../../../../SalesApp/Model/GetActivities/GetContApi.dart';
// ignore: always_use_package_imports
import '../../../Modal/SalesQuaModel/AllSalesQuaModel.dart';
import '../../../widgets/Drawer.dart';
import '../../url/url.dart';

class GetAllSalesQuaAPi {
  static Future<GetAllSalesQuaD> getGlobalData() async {
    try {
      log(URL.dynamicUrl);
      final response = await http.post(Uri.parse(URL.dynamicUrl),
          headers: {
            'content-type': 'application/json',
          },
          body: json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=${GetValues.sapPassword};",

                // "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
            "query":
                "[BZ_CRM_GET_QUOTATION_BY_SLPCODE] '${GetValues.slpCode}'", //'${GetValues.slpCode}'
          }));
          log(json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=${GetValues.sapPassword};",

                // "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
            "query":
                "[BZ_CRM_GET_QUOTATION_BY_SLPCODE] '${GetValues.slpCode}'", //'${GetValues.slpCode}'
          }));
      log("New Api::" + response.statusCode.toString());
            // log("New Api::" + response.body);

      if (response.statusCode == 200) {
        return GetAllSalesQuaD.fromJson(response.body, response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return GetAllSalesQuaD.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      //  throw Exception("Exception: $e");
      return GetAllSalesQuaD.fromJson(e.toString(), 500);
    }
  }
}
