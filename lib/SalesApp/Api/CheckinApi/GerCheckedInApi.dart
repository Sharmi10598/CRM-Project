// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, require_trailing_commas, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/SalesApp/Model/GetActivities/GetCheckedInModel.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class GetCheckedINAPi {
  static Future<GetCheckedINModel> getGlobalData(
      String slpcode, String currentDate) async {
    try {
      final response = await http.post(Uri.parse(URL.dynamicUrl),
          headers: {
            'content-type': 'application/json',
          },
          body: json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=${GetValues.sapPassword};",
            //     "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
            "query":
                "Select T0.ClgCode, T0.CardCode , CardName,T2.Name VisitReg,CntctTime,CntctDate,T0.Details,CntctSbjct From oclg T0 Inner Join OCRD T1 on T0.CardCode = T1.CardCode Inner Join OCLS T2 on T2.Code = T0.CntctSbjct where T0.slpcode = ${GetValues.slpCode!} and U_CheckedIn = 'Yes' and U_Status = 'A' ", //and U_PlanDate='${currentDate}'  '${GetValues.slpCode}'
          }));

      // print('B1SESSION='+ GetValues.sessionID.toString());
      // print('odata.maxpagesize=${GetValues.maximumfetchValue}');
      log("checkdddd innn: " + json.decode(response.body).toString());
      log("checkdddd response::${response.statusCode}");
      if (response.statusCode == 200) {
        return GetCheckedINModel.fromJson(response.body, response.statusCode);
      } else {
        print("Exception: Error");
        return GetCheckedINModel.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      print("Exception: $e");
      //  throw Exception("Exception: $e");
      return GetCheckedINModel.fromJson(e.toString(), 500);
    }
  }
}
