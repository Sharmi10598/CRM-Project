// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/stock_item_modal.dart/stock_warehouse_modal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';


class StockWarehouseAPi{
  static String? sessionID;
  static String? itemcode;

  static Future<StockWarehouseModal> getGlobalData() async {
    try {
      print(URL.url+"Items('$itemcode')/ItemWarehouseInfoCollection");
    final response = await http.get(
        Uri.parse(
        URL.url+"Items('$itemcode')/ItemWarehouseInfoCollection",
      ),
        headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+ GetValues.sessionID.toString(),
        },
      );
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return StockWarehouseModal.fromJson(json.decode(response.body)as Map<String,dynamic>);
      } else {
       // throw Exception("Error!!...");
      return StockWarehouseModal.issue('Error!!..');
      }
    } catch (e) {
     //  throw Exception("Exception: $e");
      return StockWarehouseModal.issue(e.toString());
    }
  }
 
}
