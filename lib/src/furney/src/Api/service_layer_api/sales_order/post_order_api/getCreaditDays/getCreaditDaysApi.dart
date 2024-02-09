// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, avoid_print, file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_oder/CreditDaysModal/creditDaysModal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';


class GettCreditDaysAPi{
  static String? cardCode;
  static String? date;
  static Future<CreaditDaysModal> getGlobalData() async {
    // print("date: $date");
    // print("carcode: $cardCode");
    try {
    final response = await http.get(
        Uri.parse(
      URL.url+"SQLQueries('CreditDays')/List?CardCode='$cardCode'&TodayDt='$date'",//&\$filter= DocumentStatus eq 'bost_Open'
        
      ),
        headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+ GetValues.sessionID.toString(),
        'Prefer': 'odata.maxpagesize=${GetValues.maximumfetchValue}'
        },
      );
      if (response.statusCode == 200) {
        print("GettCreditDaysAPi:: "+json.decode(response.body).toString());
        return CreaditDaysModal.fromJson(json.decode(response.body)as Map<String,dynamic>);
      } else {
         print("GettCreditDaysAPi:: "+json.decode(response.body).toString());
           print(response.statusCode);
        throw Exception('Restart the app or contact the admin!!..');
   // return ApprovalsOrdersModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      throw Exception(e);
     // return ApprovalsOrdersModal.issue('Restart the app or contact the admin!!..');
    }
  }
}
