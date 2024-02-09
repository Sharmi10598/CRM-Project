// ignore_for_file: prefer_single_quotes

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/Login_sap_modal/login_data.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class PostLoginAPi {
  static String? username;
  static String? password;

  static Future<Logindata> getGlobalData() async {
    try {
      log('${URL.url}Login');
      final response = await http.post(
        Uri.parse(
          //http://164.52.214.147:50001/b1s/v1
          '${URL.url}Login',
        ),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'CompanyDB': '${GetValues.sapDB}',
          'UserName': '$username', //crmapp
          'Password': '$password' //Tanzania
        }),
      );
      log(
        json.encode({
          'CompanyDB': '${GetValues.sapDB}',
          'UserName': '$username', //crmapp
          'Password': '$password' //Tanzania
        }),
      );
      print('saplogin: ${json.decode(response.body)}');
      print(response.statusCode);

      if (response.statusCode <= 210) {
        // || response.statusCode <= 210
        // print("saplogin: "+json.decode(response.body).toString());
        // print(response.statusCode.toString());
        return Logindata.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        print('saplogin: ${json.decode(response.body)}');
        print(response.statusCode);
        // throw Exception('Err');
        return Logindata.error(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      // throw Exception('Exceptionsss: $e');
      return Logindata.issue('Restart the app or contact the admin!!..', 500);
    }
  }
}
