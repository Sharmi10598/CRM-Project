// ignore_for_file: file_names, prefer_single_quotes, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/LogoutModel/LogoutModel.dart';

class LogoutUserAPi {
  static Future<LogOutApiModel> getGlobalData(LogOutDataModel logout) async {
    try {
      log('${URL.urlLocal}ResetDevicecode');
      final response = await http.post(
        Uri.parse(
          '${URL.urlLocal}ResetDevicecode',
        ),
        headers: {
          'content-type': 'application/json',
        },
        body: json.encode({
          "DeviceCode": "${logout.deviceCode}",
          "UserCode": "${logout.userCode}",
        }),
      );
      // print(json.decode(response.statusCode.toString()));

      if (response.statusCode == 200) {
        // print(json.decode(response.body));
        return LogOutApiModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
          response.statusCode,
        );
      } else {
        //    print(json.decode(response.body));
        return LogOutApiModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
          response.statusCode,
        );
      }
    } catch (e) {
      // print(e);
      return LogOutApiModel.issue(
        'Restart the app or contact the admin!!..',
        500,
      );
    }
  }
}

class LogOutDataModel {
  String? userCode;
  String? deviceCode;
  LogOutDataModel({
    this.deviceCode,
    this.userCode,
  });
}
