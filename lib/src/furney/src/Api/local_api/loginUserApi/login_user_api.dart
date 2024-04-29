// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/Login_User_Modal/login_user_modal.dart';

class LoginUserAPi {
  static String? deviceId;
  static String? userCode;
  static String? password;

  static Future<CheckUserLogin> getGlobalData(String token) async {
    try {
      log('ANBUXXXXX:::'
          '${URL.urlLocal}GetLoginDetails/$userCode/$password/$deviceId/$token');
      final response = await http.get(
        //http://164.52.214.147:50001/b1s/v1/BusinessPartners?$select=CardCode,CardName,CardType
        Uri.parse(
          '${URL.urlLocal}GetLoginDetails/$userCode/$password/$deviceId/$token', //55555
        ),
        headers: {
          'content-type': 'application/json',
          // 'cookie': 'B1SESSION=cd7eff02-46e1-11ec-8000-000c29e6775e',
          // 'Prefer':'odata.maxpagesize=50'
        },
      );
      log('statusCode:::::::${response.statusCode}');

      log('LOGINUSERAPI:::::::${json.decode(response.body)}');

      if (response.statusCode == 200) {
        return CheckUserLogin.fromJson(
            json.decode(response.body) as Map<String, dynamic>,);
      } else {
        print(json.decode(response.body));
        // throw Exception("Error!!...");
        return CheckUserLogin.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      log("Exceptionsss catch: $e");
      //  throw Exception("Exceptionsss: $e");
      return CheckUserLogin.exception(
          'Restart the app or contact the admin!!..',);
    }
  }
}
