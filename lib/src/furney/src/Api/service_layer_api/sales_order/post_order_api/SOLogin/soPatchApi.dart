// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/appVersion.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_quot/post_modal/post_quot_modal.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/screens/create_order.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/creation/content_order_creation.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class SalesOrderPatchAPi {
  static String? sessionID;
  static String? cardCodePost;
  static String? cardNamePost;
  static List<AddItem>? docLineQout;
  static String? docDate;
  static String? dueDate;
  static String? remarks;
  static String? orderDate;
  static String? orderType;
  static String? gpApproval;
  static String? orderTime;
  static String? custREfNo;
  static String? deviceCode;
  static String? deviceTransID;
  static String? slpCode;

  static Future<SalesQuotStatus> getGlobalData(
      String latitude, String longitude, int docentry) async {
    try {
      final data = CreateOrderDetailsState.isCameFromqutation == true
          ? json.encode({
              "AppVersion": AppVersion.version,
              "CardCode": "$cardCodePost",
              "CardName": "$cardNamePost",
              "DocumentStatus": "bost_Open",
              "DocDate": "$docDate",
              "DocDueDate": "$dueDate",
              "Comments": "$remarks",
              "U_OrderDate": "$orderDate",
              "U_Order_Type": "$orderType",
              "U_GP_Approval": "$gpApproval",
              "U_Received_Time": "$orderTime",
              "NumAtCard": "$custREfNo",
              'U_DeviceCode': deviceCode,
              'U_DeviceTransID': deviceTransID,
              'SalesPersonCode': '$slpCode',
              'Series': '${GetValues.seriresOrder}',
              "U_latitude ": latitude,
              "U_longitude": longitude,
              "DocumentLines": docLineQout!.map((e) => e.tojson2()).toList(),
            })
          : json.encode({
              "AppVersion": AppVersion.version,
              "CardCode": "$cardCodePost",
              "CardName": "$cardNamePost",
              "DocumentStatus": "bost_Open",
              "DocDate": "$docDate",
              "DocDueDate": "$dueDate",
              "Comments": "$remarks",
              "U_OrderDate": "$orderDate",
              "U_Order_Type": "$orderType",
              "U_GP_Approval": "$gpApproval",
              "U_Received_Time": "$orderTime",
              "NumAtCard": "$custREfNo",
              'U_DeviceCode': deviceCode,
              'U_DeviceTransID': deviceTransID,
              'SalesPersonCode': '$slpCode',
              'Series': '${GetValues.seriresOrder}',
              "U_latitude ": latitude,
              "U_longitude": longitude,
              "DocumentLines": docLineQout!.map((e) => e.tojson2()).toList(),
            });
      //log
      //
      CreateOrderDetailsState.isCameFromqutation == true
          ? log(
              json.encode({
                "CardCode": "$cardCodePost",
                "CardName": "$cardNamePost",
                "DocumentStatus": "bost_Open",
                "DocDate": "$docDate",
                "DocDueDate": "$dueDate",
                "Comments": "$remarks",
                "U_OrderDate": "$orderDate",
                "U_Order_Type": "$orderType",
                "U_GP_Approval": "$gpApproval",
                "U_Received_Time": "$orderTime",
                "NumAtCard": "$custREfNo",
                'U_DeviceCode': deviceCode,
                'U_DeviceTransID': deviceTransID,
                'SalesPersonCode': '$slpCode',
                'Series': '${GetValues.seriresOrder}',
                "U_latitude ": latitude,
                "U_longitude": longitude,
                "U_Request": data,
                "DocumentLines": docLineQout!.map((e) => e.tojson2()).toList(),
              }),
            )
          : log(
              json.encode({
                "CardCode": "$cardCodePost",
                "CardName": "$cardNamePost",
                "DocumentStatus": "bost_Open",
                "DocDate": "$docDate",
                "DocDueDate": "$dueDate",
                "Comments": "$remarks",
                "U_OrderDate": "$orderDate",
                "U_Order_Type": "$orderType",
                "U_GP_Approval": "$gpApproval",
                "U_Received_Time": "$orderTime",
                "NumAtCard": "$custREfNo",
                'U_DeviceCode': deviceCode,
                'U_DeviceTransID': deviceTransID,
                'SalesPersonCode': '$slpCode',
                'Series': '${GetValues.seriresOrder}',
                "U_latitude ": latitude,
                "U_longitude": longitude,
                "U_Request": data,
                "DocumentLines": docLineQout!.map((e) => e.tojson2()).toList(),
              }),
            );

      log("URL: " + URL.url + "Drafts($docentry)");
      final response = await http.patch(
        Uri.parse(
          URL.url + "Drafts($docentry)",
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + sessionID!,
          "Prefer": "return-no-content"
        },
        body: CreateOrderDetailsState.isCameFromqutation == true
            ? json.encode({
                "CardCode": "$cardCodePost",
                "CardName": "$cardNamePost",
                "DocumentStatus": "bost_Open",
                "DocDate": "$docDate",
                "DocDueDate": "$dueDate",
                "Comments": "$remarks",
                "U_OrderDate": "$orderDate",
                "U_Order_Type": "$orderType",
                "U_GP_Approval": "$gpApproval",
                "U_Received_Time": "$orderTime",
                "NumAtCard": "$custREfNo",
                'U_DeviceCode': deviceCode,
                'U_DeviceTransID': deviceTransID,
                'SalesPersonCode': '$slpCode',
                'Series': '${GetValues.seriresOrder}',
                "U_latitude ": latitude,
                "U_longitude": longitude,
                "U_Request": data,
                "DocumentLines": docLineQout!.map((e) => e.tojson2()).toList(),
              })
            : json.encode({
                "CardCode": "$cardCodePost",
                "CardName": "$cardNamePost",
                "DocumentStatus": "bost_Open",
                "DocDate": "$docDate",
                "DocDueDate": "$dueDate",
                "Comments": "$remarks",
                "U_OrderDate": "$orderDate",
                "U_Order_Type": "$orderType",
                "U_GP_Approval": "$gpApproval",
                "U_Received_Time": "$orderTime",
                "NumAtCard": "$custREfNo",
                'U_DeviceCode': deviceCode,
                'U_DeviceTransID': deviceTransID,
                'SalesPersonCode': '$slpCode',
                'Series': '${GetValues.seriresOrder}',
                "U_latitude ": latitude,
                "U_longitude": longitude,
                "U_Request": data,
                "DocumentLines": docLineQout!.map((e) => e.tojson2()).toList(),
              }),
      );

      print("statucCode: " + response.statusCode.toString());
      log("bodyyy post order: " + response.body);
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return SalesQuotStatus.fromJson(response.statusCode);
      } else {
        return SalesQuotStatus.errorIN(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      return SalesQuotStatus.issue(
          'Restart the app or contact the admin!!..\n $e'); //+e.toString()
    }
  }
}
