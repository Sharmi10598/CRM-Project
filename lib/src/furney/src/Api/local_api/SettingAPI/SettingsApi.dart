// ignore_for_file: file_names, prefer_single_quotes, require_trailing_commas, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/SchemeQuteModel/SchemeQuteModel.dart';

import '../../../Modal/local_modal/SettingModel/SettingModels.dart';

class SettingModelAPi {
  static String countryCode = '';
  static Future<SettingModelData> getGlobalData() async {
    try {
      final response = await http.get(
        Uri.parse('${URL.settingurl}$countryCode'),
        headers: {
          'content-type': 'application/json',
        },
      );
      log('Local URL----->${URL.settingurl}$countryCode');

      log("json res: " + response.body);
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return SettingModelData.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        print(json.decode(response.body));

        // throw Exception("Error!!...");
        return SettingModelData.issue(
          json.decode(response.body) as Map<String, dynamic>,
          response.statusCode,
        );
      }
    } catch (e) {
      //  throw Exception("Exceptionsss: $e");
      return SettingModelData.exception(
          'Restart the app or contact the admin!!..', 500);
    }
  }
}
