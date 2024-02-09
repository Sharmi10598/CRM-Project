// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, require_trailing_commas, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/customer_bp/PamentGroupModel.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';


class GetPaymentGroupAPi {
  static Future<GetPaymentGroupModel> getGlobalData() async {
    try {
      final response = await http.post(
        Uri.parse(URL.dynamicUrl),
        headers: {
          'content-type': 'application/json',
          },
         body: json.encode({
              "constr": "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
              "query": "Select GroupNum, PymntGroup from OCTG",
          })
      );
     
      // print('B1SESSION='+ GetValues.sessionID.toString());
      // print('odata.maxpagesize=${GetValues.maximumfetchValue}');
       log("Terieri : " + json.decode(response.body).toString());
       print(response.statusCode);
      if (response.statusCode == 200) {
        return GetPaymentGroupModel.fromJson( response.body,response.statusCode);
      } else {
        print("Exception: Error");
        return GetPaymentGroupModel.fromJson( response.body,response.statusCode);
      }
    } catch (e) {
      print("Exception: $e");
      //  throw Exception("Exception: $e");
      return GetPaymentGroupModel.fromJson(e.toString(),500);
    }
  }
}
