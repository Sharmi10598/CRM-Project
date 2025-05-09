// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/customer_bp/new_customer_modal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class CustomerDetailsAPi {
  static String? sessionID;
  static String? cardCode;

  static Future<CustomerDetailsValue> getGlobalData() async {
    try {
      final response = await http.get(
        Uri.parse(
          URL.url + "BusinessPartners('$cardCode')",
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + GetValues.sessionID.toString(),
        },
      );
      //  log("CustomerDetailsAPi Res::"+  json.decode(response.body).toString());

      if (response.statusCode == 200) {
        return CustomerDetailsValue.fromJson(
            json.decode(response.body) as Map<String, dynamic>,);
      } else {
        log(json.decode(response.body).toString());
        //    print(response.statusCode);
        throw Exception('Restart the app or contact the admin!!..');
        // return CustomerDetailsValue.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      log(e.toString());

      throw Exception('$e');
      //return CustomerDetailsValue.issue('Restart the app or contact the admin!!..');
    }
  }
}
