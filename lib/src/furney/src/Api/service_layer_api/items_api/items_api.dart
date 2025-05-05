// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, require_trailing_commas

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/item_modal/item_modal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class ItemsAPi {
  static String searchData = '';
  static String? sessionID;
  static String? nextUrl;
  static String? mainGroup;
  static String? subGroup;

  static Future<ItemModal> getGlobalData(String pack) async {
    log(URL.url +
        "Items?\$select=ItemCode,ItemName,SalesUnit,ItemPrices,U_Pack_Size,U_Tins_Per_Box&\$filter=((contains(ItemCode,'$searchData') or contains(ItemName,'$searchData')) and contains(U_Pack_Size,'$pack.') And contains(U_Prd_MainGrp,'$mainGroup') and contains(U_Prd_SubGrp,'$subGroup')and Valid eq 'tYES' )");
    try {
      final response = await http.get(
        Uri.parse(URL.url +
                "Items?\$select=ItemCode,ItemName,SalesUnit,ItemPrices,U_Pack_Size,U_Tins_Per_Box&\$filter=((contains(ItemCode,'$searchData') or contains(ItemName,'$searchData')) and contains(U_Pack_Size,'$pack.') And contains(U_Prd_MainGrp,'$mainGroup') and contains(U_Prd_SubGrp,'$subGroup')and Valid eq 'tYES' )"
            //"Items?\$select=ItemCode,ItemName,SalesUnit,ItemPrices&\$filter=((contains(ItemCode,'$searchData') or contains(ItemName,'$searchData')) And U_Prd_MainGrp  eq '$mainGroup' and U_Prd_SubGrp eq '$subGroup')",
            ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + GetValues.sessionID.toString(),
          'Prefer': 'odata.maxpagesize=${GetValues.maximumfetchValue}'
        },
      );
      log(GetValues.sessionID.toString());
      log(GetValues.maximumfetchValue);
      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        // print(response.body);
        return ItemModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>);
      } else {
        //  print(json.decode(response.body));
        //    print(json.decode(response.statusCode.toString()));
        throw Exception('Restart the app or contact the admin!!..');
        // return ItemModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      throw Exception(e);
      //  return ItemModal.issue('Restart the app or contact the admin!!..');
    }
  }

  static Future<ItemModal> callNextLink() async {
    try {
      final response = await http.get(
        Uri.parse(
          URL.url + nextUrl.toString(),
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + GetValues.sessionID.toString(),
          'Prefer': 'odata.maxpagesize=${GetValues.maximumfetchValue}'
        },
      );
      if (response.statusCode == 200) {
        //  print(json.decode(response.body));
        //   print(response.statusCode);
        return ItemModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>);
      } else {
        //  print(json.decode(response.body));
        //  print(response.statusCode);
        throw Exception('Restart the app or contact the admin!!..');
        //  return ItemModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      throw Exception('Restart the app or contact the admin!!..');
      //  return ItemModal.issue('Restart the app or contact the admin!!..');
    }
  }
}
