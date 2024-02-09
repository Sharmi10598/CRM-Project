// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/delivery_modal/delivery_details_modal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class DeliveryDetailsAPi{
  static String? sessionID;
  static String? docEntry;

  static Future<DeliveryDetailsValue> getGlobalData() async {
    try {
    final response = await http.get(
        Uri.parse(//http://102.69.164.12:50001/b1s/v1/DeliveryNotes(10)
      URL.url+"DeliveryNotes($docEntry)",
        
      ),
        headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+ GetValues.sessionID.toString(),
        },
      );
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return DeliveryDetailsValue.fromJson(json.decode(response.body)as Map<String,dynamic>);
      } else {
      //  throw Exception('Restart the app or contact the admin!!..');
      return DeliveryDetailsValue.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      // throw Exception('Restart the app or contact the admin!!..');
      return DeliveryDetailsValue.issue('Restart the app or contact the admin!!..');
    }
  }
 
}
