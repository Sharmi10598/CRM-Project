// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_oder/sales_orderdetails_modal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class SalesOderDetailsAPi{
  static String? sessionID;
  static String? docEntry;

  static Future<SalesOrderDetailsValue> getGlobalData() async {
    try {
      log( "Sales order details: "+ URL.url+"Orders($docEntry)");
    final response = await http.get(
        Uri.parse(//http://102.69.164.12:50001/b1s/v1/DeliveryNotes(10)
      URL.url+"Orders($docEntry)",
        
      ),
        headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+ GetValues.sessionID.toString(), 
        },
      );
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return SalesOrderDetailsValue.fromJson(json.decode(response.body)as Map<String,dynamic>);
      } else {
        throw Exception('Restart the app or contact the admin!!..');
     // return SalesOrderDetailsValue.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
       throw Exception('Restart the app or contact the admin!!..');
      //return SalesOrderDetailsValue.issue('Restart the app or contact the admin!!..');
    }
  }
 
}
