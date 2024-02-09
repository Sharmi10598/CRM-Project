// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, avoid_print, file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_quot/approvals_quot_modal/approvals_quot_modal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';


class ApprovalsQuotAPi{
  static String? sessionID;
  static String? nextUrl;
  static String? searchValue;
  static Future<ApprovalsQuotModal> getGlobalData() async {
    print("GetValues.sapUserID: ${GetValues.sapUserID}");
    try {
    final response = await http.get(
        Uri.parse(//http://102.69.164.12:50001/b1s/v1/DeliveryNotes(10)
      URL.url+"SQLQueries('ApprovedQuote')/List?USERID=${GetValues.sapUserID}",//&\$filter= DocumentStatus eq 'bost_Open'
        
      ),
        headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+ GetValues.sessionID.toString(),
        'Prefer': 'odata.maxpagesize=${GetValues.maximumfetchValue}'
        },
      );
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return ApprovalsQuotModal.fromJson(json.decode(response.body)as Map<String,dynamic>);
      } else {
        //  print(json.decode(response.body));
        //    print(json.decode(response.statusCode.toString()));
        // throw Exception('Restart the app or contact the admin!!..');
   return ApprovalsQuotModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      // throw Exception(e);
     return ApprovalsQuotModal.issue('Restart the app or contact the admin!!..');
    }
  }
}
