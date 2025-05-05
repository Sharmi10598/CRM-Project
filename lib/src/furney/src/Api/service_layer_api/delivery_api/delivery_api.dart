// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/delivery_modal/delivery_modal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class DeliveryAPi {
  static String? sessionID;
  static String? nextUrl;
  static String? searchValue;
  static Future<DeliveryModal> getGlobalData() async {
    try {
      final response = await http.get(
        Uri.parse(
          URL.url +
              "DeliveryNotes?\$select=DocEntry,DocNum,DocDate,CardCode,CardName&\$filter= DocumentStatus eq 'bost_Open'",
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + GetValues.sessionID.toString(),
          'Prefer': 'odata.maxpagesize=${GetValues.maximumfetchValue}',
        },
      );
      log('DeliveryModal::' + json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return DeliveryModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>,);
      } else {
        print(json.decode(response.body));
        print(json.decode(response.statusCode.toString()));
        // throw Exception('Restart the app or contact the admin!!..');
        return DeliveryModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      // throw Exception(e);
      return DeliveryModal.issue('Restart the app or contact the admin!!..');
    }
  }

  static Future<DeliveryModal> callNextLink() async {
    try {
      log('message::${URL.url + nextUrl.toString()}');
      final response = await http.get(
        Uri.parse(
          //http://102.69.164.12:50001/b1s/v1/DeliveryNotes(10)
          URL.url + nextUrl.toString(),
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + GetValues.sessionID.toString(),
          'Prefer': 'odata.maxpagesize=${GetValues.maximumfetchValue}',
        },
      );
      log(json.decode(response.body).toString());

      if (response.statusCode == 200) {
        ///   print(json.decode(response.body));
        return DeliveryModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>,);
      } else {
        // throw Exception('Restart the app or contact the admin!!..');
        return DeliveryModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      // throw Exception('Restart the app or contact the admin!!..');
      return DeliveryModal.issue('Restart the app or contact the admin!!..');
    }
  }

  static Future<DeliveryModal> searchData() async {
    try {
      final response = await http.get(
        Uri.parse(
          //http://102.69.164.12:50001/b1s/v1/DeliveryNotes(10)
          URL.url +
              "DeliveryNotes?\$select=DocEntry,DocNum,DocDate,CardCode,CardName&\$filter=(contains(CardCode,'$searchValue') or contains(CardName,'$searchValue')) and DocumentStatus eq 'bost_Open'",
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + GetValues.sessionID.toString(),
          'Prefer': 'odata.maxpagesize=${GetValues.maximumfetchValue}',
        },
      );
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return DeliveryModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>,);
      } else {
        print(json.decode(response.body));
        print(json.decode(response.statusCode.toString()));
        throw Exception('Restart the app or contact the admin!!..');
        // return DeliveryModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      throw Exception(e);
      // return DeliveryModal.issue('Restart the app or contact the admin!!..');
    }
  }
}
