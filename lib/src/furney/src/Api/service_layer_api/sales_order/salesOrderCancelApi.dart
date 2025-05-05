// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_oder/salesOrderCancelModal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class SalesOrdersCancelAPi {
  static String? sessionID;
  static String? nextUrl;
  static String? searchValue;
  static String? fromDate;
  static String? toDate;
  static Future<SalesOrderCancelModal> getGlobalData() async {
    try {
      final response = await http.get(
        Uri.parse(
          URL.url +
              "Orders?\$select=DocEntry,DocNum,DocDate,CardCode,CardName,DocumentStatus,CancelStatus&\$orderby=DocDate desc&\$filter=DocumentStatus eq 'bost_Close' and CancelStatus eq 'csNo' and CancelStatus eq 'csNo'and (contains(CardCode,'$searchValue') or contains(CardName,'$searchValue')) and DocDate ge '$fromDate' and DocDate le '$toDate'",
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + GetValues.sessionID.toString(),
          'Prefer': 'odata.maxpagesize=${GetValues.maximumfetchValue}',
        },
      );
      if (response.statusCode == 200) {
        log(json.decode(response.body).toString());
        return SalesOrderCancelModal.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      } else {
        //  print(json.decode(response.body));
        //    print(json.decode(response.statusCode.toString()));
        throw Exception('Restart the app or contact the admin!!..');
        // return SalesOrderCancelModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      throw Exception(e.toString());
      // return SalesOrderCancelModal.issue('Restart the app or contact the admin!!..');
    }
  }

  static Future<SalesOrderCancelModal> callNextLink() async {
    try {
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
      if (response.statusCode == 200) {
        log(json.decode(response.body).toString());
        return SalesOrderCancelModal.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      } else {
        // print(response.statusCode);
        throw Exception('Restart the app or contact the admin!!..');
        //  return SalesOrderCancelModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      throw Exception('$e');
      //  return SalesOrderCancelModal.issue('Restart the app or contact the admin!!..');
    }
  }

  static Future<SalesOrderCancelModal> searchData() async {
    try {
      final response = await http.get(
        Uri.parse(
          //http://102.69.164.12:50001/b1s/v1/DeliveryNotes(10)
          URL.url +
              "Quotations?\$select=DocEntry,DocNum,DocDate,CardCode,CardName,DocumentStatus,CancelStatus&\$orderby=DocDate desc&\$filter=DocumentStatus eq 'bost_Close'",
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + GetValues.sessionID.toString(),
          'Prefer': 'odata.maxpagesize=${GetValues.maximumfetchValue}',
        },
      );
      if (response.statusCode == 200) {
        log(json.decode(response.body).toString());
        return SalesOrderCancelModal.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      } else {
        //  print(json.decode(response.body));
        //    print(json.decode(response.statusCode.toString()));
        throw Exception('Restart the app or contact the admin!!..');
        // return SalesOrderCancelModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      throw Exception(e);
      // return SalesOrderCancelModal.issue('Restart the app or contact the admin!!..');
    }
  }
}
