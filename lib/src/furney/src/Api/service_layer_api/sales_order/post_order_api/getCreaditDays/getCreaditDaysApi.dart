// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, avoid_print, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_oder/CreditDaysModal/creditDaysModal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class GettCreditDaysAPi {
  static String? cardCode;
  static String? date;
  static Future<CreaditDaysModal> getGlobalData() async {
    // print("date: $date");
    print(URL.url +
        "SQLQueries('CreditDays')/List?CardCode='$cardCode'&TodayDt='$date'",);
    try {
      final response = await http.get(
        Uri.parse(
          URL.url +
              "SQLQueries('CreditDays')/List?CardCode='$cardCode'&TodayDt='$date'", //&\$filter= DocumentStatus eq 'bost_Open'
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + GetValues.sessionID.toString(),
          'Prefer': 'odata.maxpagesize=${GetValues.maximumfetchValue}',
        },
      );
      log("GettCreditDaysAPi:: " + json.decode(response.body).toString());

      if (response.statusCode == 200) {
        return CreaditDaysModal.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      } else {
        print(response.statusCode);
        // throw Exception('Restart the app or contact the admin!!..');
        return CreaditDaysModal.issue(
            'Restart the app or contact the admin!!..',);
      }
    } catch (e) {
      // throw Exception(e);
      return CreaditDaysModal.issue('Restart the app or contact the admin!!..');
    }
  }
}
