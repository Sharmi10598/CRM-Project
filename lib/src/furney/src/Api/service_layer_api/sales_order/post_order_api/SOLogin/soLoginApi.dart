// ignore_for_file: file_names, avoid_print, prefer_single_quotes, require_trailing_commas, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_oder/soLoginModal/soLoginModal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class SOLoginAPi {
  static String? username;
  static String? password;

  static Future<SoLogindata> getGlobalData() async {
    try {
      final response = await http.post(
          Uri.parse(
            '${URL.url}Login',
          ),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'CompanyDB': '${GetValues.sapDB}',
            'UserName': '$username',
            'Password': '1234'
          }));

      log("Session user: " +
          json.encode({
            'CompanyDB': '${GetValues.sapDB}',
            'UserName': '$username', //crmapp
            'Password': '1234' //Tanzania
          }));

      if (response.statusCode <= 210) {
        // || response.statusCode <= 210
        log("relogin11: " + json.decode(response.body).toString());
        print(response.statusCode);
        return SoLogindata.fromJson(
            json.decode(response.body) as Map<String, dynamic>);
      } else {
        log("relogin22: " + json.decode(response.body).toString());
        print(response.statusCode);
        // throw Exception('Err');
        return SoLogindata.error(
            json.decode(response.body) as Map<String, dynamic>);
      }
    } catch (e) {
      // throw Exception('Exceptionsss: $e');
      return SoLogindata.issue('Restart the app or contact the admin!!..');
    }
  }
}
