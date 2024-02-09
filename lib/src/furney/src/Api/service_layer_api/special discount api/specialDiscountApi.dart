// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/specialDiscountApi/SpcialDisountModal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';


class SpecialDiscountAPi{
  static String? itemCode;
  static String? cardCode;
  static Future<SpecialDisCountModal> getGlobalData() async {
    try {
    final response = await http.get(
        Uri.parse(
      URL.url+"SQLQueries('SpecialDiscount')/List?ItemCode='$itemCode'&CardCode='$cardCode'",
      ),
        headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+ GetValues.sessionID.toString(),
        'Prefer': 'odata.maxpagesize=${GetValues.maximumfetchValue}'
        },
      );
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return SpecialDisCountModal.fromJson(json.decode(response.body)as Map<String,dynamic>);
      } else {
         print(json.decode(response.body));
           print(json.decode(response.statusCode.toString()));
        throw Exception('Restart the app or contact the admin!!..');
   // return SpecialDisCountModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      throw Exception(e);
     // return SpecialDisCountModal.issue('Restart the app or contact the admin!!..');
    }
  } 
}
