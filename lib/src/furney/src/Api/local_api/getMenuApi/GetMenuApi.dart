// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';

import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/MenuAuthModel.dart';

class GetMenuAuthAPi {
  static String? deviceId;
  static String? userCode;
  static String? password;

  static Future<StockSnapModel> getGlobalData(String id) async {
    try {
      log('ANBUXXXXX:::'
          '${URL.urlLocal}GetSelectedId/$id');
      final response = await http.get(
        //http://164.52.214.147:50001/b1s/v1/BusinessPartners?$select=CardCode,CardName,CardType
        Uri.parse(
          '${URL.urlLocal}GetSelectedId/$id', //55555
        ),
        headers: {
          'content-type': 'application/json',
          // 'cookie': 'B1SESSION=cd7eff02-46e1-11ec-8000-000c29e6775e',
          // 'Prefer':'odata.maxpagesize=50'
        },
      );
      log('statusCode:::::::${response.statusCode}');

      log('GetMenuAuthAPi:::::::${response.body}');

      if (response.statusCode == 200) {
        return StockSnapModel.fromJson(response.body, response.statusCode);
      } else {
        print(json.decode(response.body));
        return StockSnapModel.issue(
          'Restart the app or contact the admin!!..',
          response.statusCode,
        );
      }
    } catch (e) {
      log('Exceptionsss catch: $e');
      //  throw Exception("Exceptionsss: $e");
      return StockSnapModel.issue(
        'Restart the app or contact the admin!!..',
        500,
      );
    }
  }
}
