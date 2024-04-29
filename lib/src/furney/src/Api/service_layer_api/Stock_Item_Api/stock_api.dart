// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/stock_item_modal.dart/stock_item_modal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class StockItemAPi {
  static String? searchData;
  static String? mainGrp;
  static String? subGrp;
  static String? pack;

  static String? nextLink;
  static Future<StockItemModal> getGlobalData() async {
    print(URL.url +
        "Items?\$select=ItemCode,ItemName,QuantityOnStock,U_Pack_Size&\$filter=((contains(ItemCode,'$searchData') or contains(ItemName,'$searchData')) and contains(U_Pack_Size,'$pack.') And contains(U_Prd_MainGrp,'$mainGrp') and contains(U_Prd_SubGrp,'$subGrp')and Valid eq 'tYES' )");
    try {
      final response = await http.get(
        Uri.parse(URL.url +
            "Items?\$select=ItemCode,ItemName,QuantityOnStock,U_Pack_Size&\$filter=((contains(ItemCode,'$searchData') or contains(ItemName,'$searchData')) and contains(U_Pack_Size,'$pack.') And contains(U_Prd_MainGrp,'$mainGrp') and contains(U_Prd_SubGrp,'$subGrp')and Valid eq 'tYES' )"),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + GetValues.sessionID.toString(),
          'prefer':
              'odata.maxpagesize=${GetValues.maximumfetchValue}' //${GetValues.maximumfetchValue}
        },
      );
      // print("content-type:application/json");
      // print("cookie:'B!SESION'"+GetValues.sessionID.toString());
      // print("prefer:odata.maxpagesize="+GetValues.maximumfetchValue.toString());
      log('Stock response: '+response.body.toString());
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return StockItemModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>);
      } else {
        print(json.decode(response.body));
        throw Exception("Error!!...");
        //return StockItemModal.issue('Error!!..');
      }
    } catch (e) {
      throw Exception("Exception: $e");
      //return StockItemModal.issue(e.toString());
    }
  }

  static Future<StockItemModal> callNextLink() async {
    try {
      final response = await http.get(
        Uri.parse(
          URL.url + nextLink.toString(),
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + GetValues.sessionID.toString(),
          'Prefer': 'odata.maxpagesize=${GetValues.maximumfetchValue}'
        },
      );
      // print("content-type:application/json");
      // print("cookie:'B!SESION'"+GetValues.sessionID.toString());
      // print("prefer:odata.maxpagesize="+GetValues.maximumfetchValue.toString());
      // log('json body 2: '+response.body.toString());

      if (response.statusCode == 200) {
        print(json.decode(response.body));
        print(response.statusCode);
        return StockItemModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>);
      } else {
        print(json.decode(response.body));
        print(response.statusCode);
        throw Exception('Restart the app or contact the admin!!..');
        //  return StockItemModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      throw Exception('Restart the app or contact the admin!!..');
      //  return StockItemModal.issue('Restart the app or contact the admin!!..');
    }
  }
}
