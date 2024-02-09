// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, omit_local_variable_types

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_oder/sales_order_modal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class SalesOderAPi {
  static String? sessionID;
  static String? nextUrl;
  static String? searchValue;
  // static String? fromDate;
  // static String? toDate;
  static String callWhichApi = '';
  static meth(String? fromDate, String? toDate) async {
    String open =
        "Orders?\$select=DocEntry,DocNum,DocDate,CardCode,CardName,DocumentStatus,CancelStatus&\$orderby=DocDate desc&\$filter=DocumentStatus eq 'bost_Open' and CancelStatus eq 'csNo' and CancelStatus eq 'csNo'and (contains(CardCode,'$searchValue') or contains(CardName,'$searchValue')) and DocDate ge '$fromDate' and DocDate le '$toDate'";
    String closed =
        "Orders?\$select=DocEntry,DocNum,DocDate,CardCode,CardName,DocumentStatus,CancelStatus&\$orderby=DocDate desc&\$filter=DocumentStatus eq 'bost_Close' and CancelStatus eq 'csNo' and CancelStatus eq 'csNo'and (contains(CardCode,'$searchValue') or contains(CardName,'$searchValue')) and DocDate ge '$fromDate' and DocDate le '$toDate'";

    print("callWhichApi: " + callWhichApi);
    final String url = callWhichApi == "Open"
        ? open
        : callWhichApi == "Closed"
            ? closed
            : '';
    print("url: " + (URL.url + url));
  }

  static Future<SalesOrderModal> getGlobalData(
      String? fromDate, String? toDate) async {
    String open =
        "Orders?\$select=DocEntry,DocNum,DocDate,CardCode,CardName,DocumentStatus,CancelStatus&\$orderby=DocDate desc&\$filter=DocumentStatus eq 'bost_Open' and CancelStatus eq 'csNo' and CancelStatus eq 'csNo'and (contains(CardCode,'$searchValue') or contains(CardName,'$searchValue')) and DocDate ge '$fromDate' and DocDate le '$toDate'";
    String closed =
        "Orders?\$select=DocEntry,DocNum,DocDate,CardCode,CardName,DocumentStatus,CancelStatus&\$orderby=DocDate desc&\$filter=DocumentStatus eq 'bost_Close' and CancelStatus eq 'csNo' and CancelStatus eq 'csNo'and (contains(CardCode,'$searchValue') or contains(CardName,'$searchValue')) and DocDate ge '$fromDate' and DocDate le '$toDate'";

    final String url = callWhichApi == "Open"
        ? open
        : callWhichApi == "Closed"
            ? closed
            : '';
    try {
      final response = await http.get(
        Uri.parse(
          //http://102.69.164.12:50001/b1s/v1/DeliveryNotes(10)
          URL.url + url,
          //"Orders?\$select=DocEntry,DocNum,DocDate,CardCode,CardName,DocumentStatus,CancelStatus&\$orderby=DocDate desc&\$filter=DocumentStatus eq 'bost_Open' and CancelStatus eq 'csNo' and CancelStatus eq 'csNo'and (contains(CardCode,'$searchValue') or contains(CardName,'$searchValue')) and DocDate ge '$fromDate' and DocDate le '$toDate'"
          //"Orders?\$select=DocEntry,DocNum,DocDate,CardCode,CardName,CardName,DocumentStatus,CancelStatus",
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + GetValues.sessionID.toString(),
          'Prefer': 'odata.maxpagesize=${GetValues.maximumfetchValue}'
        },
      );
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return SalesOrderModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>);
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

  static Future<SalesOrderModal> callNextLink() async {
    try {
      final response = await http.get(
        Uri.parse(
          //http://102.69.164.12:50001/b1s/v1/DeliveryNotes(10)
          URL.url + nextUrl.toString(),
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + GetValues.sessionID.toString(),
          'Prefer': 'odata.maxpagesize=${GetValues.maximumfetchValue}'
        },
      );
      if (response.statusCode == 200) {
        ///   print(json.decode(response.body));
        return SalesOrderModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Restart the app or contact the admin!!..');
        //  return SalesOrderModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      throw Exception('Restart the app or contact the admin!!..');
      //  return SalesOrderModal.issue('Restart the app or contact the admin!!..');
    }
  }

  static Future<SalesOrderModal> searchData() async {
    try {
      final response = await http.get(
        Uri.parse(
          //http://102.69.164.12:50001/b1s/v1/DeliveryNotes(10)
          URL.url +
              "Orders?\$select=DocEntry,DocNum,DocDate,CardCode,CardName,DocumentStatus,CancelStatus&\$filter=(contains(CardCode,'$searchValue') or contains(CardName,'$searchValue'))", // and DocumentStatus eq 'bost_Open'
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + GetValues.sessionID.toString(),
          'Prefer': 'odata.maxpagesize=${GetValues.maximumfetchValue}'
        },
      );
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return SalesOrderModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>);
      } else {
        print(json.decode(response.body));
        print(json.decode(response.statusCode.toString()));
        throw Exception('Restart the app or contact the admin!!..');
        // return SalesOrderModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      throw Exception(e);
      // return SalesOrderModal.issue('Restart the app or contact the admin!!..');
    }
  }
}
