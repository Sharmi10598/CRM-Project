// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/item_modal/mainsubModal/subModal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';


class SubGroupAPi{
  static Future<SubModal> getGlobalData() async {
    try {
    final response = await http.get(
        Uri.parse(
      URL.url+"U_PRDSUBGRP",
      ),
        headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+ GetValues.sessionID.toString(),
        'Prefer': 'odata.maxpagesize=1000'
        },
      );
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return SubModal.fromJson(json.decode(response.body)as Map<String,dynamic>);
      } else {
         print(json.decode(response.body));
           print(json.decode(response.statusCode.toString()));
        throw Exception('Restart the app or contact the admin!!..');
   // return SubModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      throw Exception(e);
     // return SubModal.issue('Restart the app or contact the admin!!..');
    }
  } 
}
