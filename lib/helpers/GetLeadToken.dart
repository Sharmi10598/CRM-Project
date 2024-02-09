// ignore_for_file: file_names, prefer_single_quotes, prefer_final_locals, omit_local_variable_types, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/Login_User_Modal/login_user_modal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class GetLeadToken {
  static Future<String> getGlobalData() async {
    print(
        '${URL.urlLocal}GetUserDetails/${GetValues.deviceID}/${GetValues.UserToken}'); //44f40157df6d90af  7d9ff2bd3c00f082
    try {
      final response = await http.get(
        Uri.parse(
          '${URL.urlLocal}GetUserDetails/${GetValues.deviceID}/${GetValues.UserToken}',
        ),
        headers: {
          'content-type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        print("GetLeadToken: " + json.decode(response.body).toString());
        CheckUserLogin data = CheckUserLogin.fromJson(
            json.decode(response.body) as Map<String, dynamic>);

        return data.loginUserData![0].ManagerFCM!;
      } else {
        print(json.decode(response.body));
        print(response.statusCode);
        return 'Error...!!';
      }
    } catch (e) {
      print(e);
      return 'Error...!!';
    }
  }
}
