// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/Login_User_Modal/login_user_modal.dart';

class CheckUserAPi {
  static String? deviceId;

  static Future<CheckUserLogin> getGlobalData(String token) async {
    log('CheckUserAPi url:::::'
        '${URL.urlLocal}GetUserDetails/$deviceId/$token'); //44f40157df6d90af  7d9ff2bd3c00f082
    try {
      final response = await http.get(
        Uri.parse(
          '${URL.urlLocal}GetUserDetails/$deviceId/$token', //8024b90145eda652
          // 68a663b95891ff97  66ddd81baeb5615f $deviceId 7941a216817499b1 megrth 32dd787281948a7c
        ),
        headers: {
          'content-type': 'application/json',
        },
      );
      log('UserDetails1: ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        // log('UserDetails2: ${json.decode(response.body)}');
        return CheckUserLogin.fromJson(
            json.decode(response.body) as Map<String, dynamic>);
      } else {
        print(json.decode(response.body));
        print(response.statusCode);
        throw Exception("Error!!...");
        //   return CheckUserLogin.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      print("Anbu" + e.toString());
      throw Exception("Exceptionsss: $e");
      //  return CheckUserLogin.exception('Restart the app or contact the admin!!..');
    }
  }
}
