// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_quot/salesQuot_details_moda.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class SalesOuotDetailsAPi{
  static String? sessionID;
  static String? docEntry;

  static Future<SalesQuotDetailsValue> getGlobalData() async {
    try {
    final response = await http.get(
        Uri.parse(//http://102.69.164.12:50001/b1s/v1/DeliveryNotes(10)
      URL.url+"Quotations($docEntry)",
        
      ),
        headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+ GetValues.sessionID.toString(),
        },
      );
        log(json.decode(response.body).toString());

      if (response.statusCode == 200) {
        return SalesQuotDetailsValue.fromJson(json.decode(response.body)as Map<String,dynamic>);
      } else {
        throw Exception('Restart the app or contact the admin!!..');
     // return SalesQuotDetailsValue.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
       throw Exception('Restart the app or contact the admin!!..');
      //return SalesQuotDetailsValue.issue('Restart the app or contact the admin!!..');
    }
  }
 
}
