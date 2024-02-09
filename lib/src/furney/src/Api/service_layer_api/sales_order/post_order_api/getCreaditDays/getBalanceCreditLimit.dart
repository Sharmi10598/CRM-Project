// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, avoid_print, file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_oder/CreditDaysModal/BalanceCredit.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';


class GetBalanceCreditAPi{
  static String? cardCode;
  static Future<BalanceCreaditModal> getGlobalData() async {
    print("carcode: $cardCode");
    try {
    final response = await http.get(
        Uri.parse(
      URL.url+"SQLQueries('CreditLimit')/List?CardCode='$cardCode'",//&\$filter= DocumentStatus eq 'bost_Open'
        
      ),
        headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+ GetValues.sessionID.toString(),
        'Prefer': 'odata.maxpagesize=${GetValues.maximumfetchValue}'
        },
      );
      if (response.statusCode == 200) {
        print("GetBalanceCreditAPi:: "+json.decode(response.body).toString());
        return BalanceCreaditModal.fromJson(json.decode(response.body)as Map<String,dynamic>);
      } else {
         print(json.decode(response.body));
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
