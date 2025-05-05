// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, unnecessary_string_interpolations, unused_local_variable, prefer_final_locals, omit_local_variable_types

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/customer_bp/CreateCustPostModel.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class CustCreateAPi {
  static Future<CreateCustPostModel> getGlobalData(
    NewCutomerCrtModel newCutomerModel,
  ) async {
    try {
      log(URL.url + "BusinessPartners");
      final response = await http.post(
        Uri.parse(URL.url + "BusinessPartners"),
        headers: {
          'content-type': 'application/json',
          "cookie": 'B1SESSION=' + GetValues.sessionID.toString(),
        },
        body: json.encode({
          "CardCode": "${newCutomerModel.cardCode}",
          "CardName": "${newCutomerModel.cardName}",
          "CardType": "${newCutomerModel.cardType}",
        }),
      );

      log(
        json.encode({
          "CardCode": "${newCutomerModel.cardCode}",
          "CardName": "${newCutomerModel.cardName}",
          "CardType": "${newCutomerModel.cardType}",
        }),
      );
      // print('B1SESSION='+ GetValues.sessionID.toString());
      // print('odata.maxpagesize=${GetValues.maximumfetchValue}');
      // log("customer creation: " + json.decode(response.body).toString());
      log("customer creation codeeresp " + response.statusCode.toString());
      if (response.statusCode == 200) {
        return CreateCustPostModel.fromJson(response.body, response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return CreateCustPostModel.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      //  throw Exception("Exception: $e");
      return CreateCustPostModel.fromJson(e.toString(), 500);
    }
  }
}

class NewCutomerCrtModel {
  String? cardCode;
  String? cardType;
  String? cardName;

  NewCutomerCrtModel({
    this.cardName,
    this.cardType,
    this.cardCode,
  });
}
