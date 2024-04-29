// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, require_trailing_commas

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/SalesApp/Model/ProjectModel/ProjectModel.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class GetActiveProjectAPi {
  static Future<GetActiveProject> getGlobalData() async {
    try {
      final response = await http.post(Uri.parse(URL.dynamicUrl),
          headers: {
            'content-type': 'application/json',
          },
          body: json.encode({
              "constr":"Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=${GetValues.sapPassword};",

            // "constr":
                // "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
            "query": "Select name  from OPMG where STATUS not in ('P','T','F')",
          }));

      log(json.encode({
              "constr":"Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=${GetValues.sapPassword};",

        // "constr":
        //     "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
        "query": "Select name  from OPMG where STATUS not in ('P','T','F')",
      }));
      // log("test project statusCode: " + response.statusCode.toString());
      log("test project response: " + response.body);

      if (response.statusCode == 200) {
        return GetActiveProject.fromJson(response.body, response.statusCode);
      } else {
        throw Exception("Error!!...");
        // return GetActiveProject.fromJson( response.body,response.statusCode);
      }
    } catch (e) {
      log("wwwww22222::"+e.toString());
      throw Exception("Exception: $e");
      //return GetActiveProject.fromJson(e.toString(),500);
    }
  }
}
