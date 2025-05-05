// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/checkversion_modal/check_version_modal.dart';

class CheckVersionAPi {
  static String? deviceId;

  static Future<CheckVersion> getGlobalData() async {
    try {
      final response = await http.get(
        Uri.parse(
          '${URL.urlLocal}GetVertion',
        ),
        headers: {
          'content-type': 'application/json',
        },
      );
      //     print('YYYYYY::${response.statusCode}');
      // print('Vesrionsres::${json.decode(response.body)}');
      if (response.statusCode == 200) {
        return CheckVersion.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      } else {
        //  print(json.decode(response.body));
        print(json.decode(response.statusCode.toString()));
        //  throw Exception("Error!!...");
        return CheckVersion.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      //  print(e);
      //  throw Exception("Exceptionsss: $e");
      return CheckVersion.exception('Restart the app or contact the admin!!..');
    }
  }
}
