// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, avoid_print, file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_oder/orderORDraftModal/orderOrdraftModal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';


class CheckOrderORDraftAPi{
  static String? deviceCode;
  static String? deviceTransID;
  static void urlss(){
  }

  static Future<OrderORDraftModal> getGlobalData() async {
    try {
    final response = await http.get(
        Uri.parse(
    URL.url+"Orders?\$filter=U_DeviceCode eq'$deviceCode' and U_DeviceTransID eq'$deviceTransID'",
     // URL.url+"Orders?&filter=U_DeviceCode eq '$deviceCode'&U_DeviceTransID='$deviceTransID'",//&\$filter= DocumentStatus eq 'bost_Open'
      ),
        headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+ GetValues.sessionID.toString(),
       // 'Prefer': 'odata.maxpagesize=${GetValues.maximumfetchValue}'
        },
      );
      if (response.statusCode == 200) {
         print("res od: "+json.decode(response.body).toString());
         print("res stcode: "+response.statusCode.toString());
        return OrderORDraftModal.fromJson(json.decode(response.body)as Map<String,dynamic>);
      } else {
         print('res od: '+json.decode(response.body).toString());
         print("res stcode: "+response.statusCode.toString());
        throw Exception('Restart the app or contact the admin!!..');
  //  return OrderORDraftModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      throw Exception(e);
     // return ApprovalsOrdersModal.issue('Restart the app or contact the admin!!..');
    }
  }
}
