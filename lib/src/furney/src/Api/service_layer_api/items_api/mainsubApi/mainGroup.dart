// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/item_modal/mainsubModal/mainModal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class MainGroupAPi {
  static Future<MainModal> getGlobalData() async {
    try {
      log('MainGroup Url::${URL.url + "U_PRDMAINGRP?\$orderby=Name"}');
      final response = await http.get(
        Uri.parse(
          URL.url + "U_PRDMAINGRP?\$orderby=Name",
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + GetValues.sessionID.toString(),
          'Prefer': 'odata.maxpagesize=1000',
        },
      );
      log("MAINGRP statusCode::" + response.statusCode.toString());

      // log("MAINGRP res::" + json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return MainModal.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      } else {
        // print(json.decode(response.body));
        // print(json.decode(response.statusCode.toString()));
        // throw Exception('Restart the app or contact the admin!!..');
        return MainModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      // throw Exception(e);
      return MainModal.issue('Restart the app or contact the admin!!..');
    }
  }
}
