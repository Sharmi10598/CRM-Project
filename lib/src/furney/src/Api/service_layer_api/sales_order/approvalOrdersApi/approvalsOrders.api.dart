// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, avoid_print, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_oder/approvals_order_modal/approvals_order_modal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';


class ApprovalsOrdersAPi{
  static String? sessionID;
  static String? nextUrl;
  static String? searchValue;
  static Future<ApprovalsOrdersModal> getGlobalData(String fromDate,String todate) async {
    print( URL.url+"SQLQueries('ApprovedSaleOrder')/List?USERID=${GetValues.slpCode}");
    try {
    final response = await http.get(
        Uri.parse(
          URL.url+"SQLQueries('ApprovedSaleOrder')/List?USERID=${GetValues.slpCode}",
          //http://102.69.164.12:50001/b1s/v1/DeliveryNotes(10)
     // URL.url+"SQLQueries('ApprovedSaleOrder')/List?USERID=${GetValues.slpCode}",//&\$filter= DocumentStatus eq 'bost_Open'
        
      ),
        headers: {
        //"content-type": "application/json",
        "cookie": 'B1SESSION='+ GetValues.sessionID.toString(),
        'Prefer': 'odata.maxpagesize=20',//${GetValues.maximumfetchValue}
        // "Accept":"*/*",
        // "Accept-Encoding":"gzip, deflate, br",
         //"Host":"<calculated when request is sent>",
        // "Connection":"keep-alive",
        //  "Cache-Control":"no-cache"
        },
      );
       log(response.statusCode.toString());
      
       log(response.body);

      if (response.statusCode == 200) {
      //  print(json.decode(response.body));
        return ApprovalsOrdersModal.fromJson(json.decode(response.body)as Map<String,dynamic>);
      } else {
        //  print(json.decode(response.body));
        //    print(json.decode(response.statusCode.toString()));
        throw Exception('Restart the app or contact the admin!!..');
   // return ApprovalsOrdersModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      throw Exception(e);
     // return ApprovalsOrdersModal.issue('Restart the app or contact the admin!!..');
    }
  }
}
