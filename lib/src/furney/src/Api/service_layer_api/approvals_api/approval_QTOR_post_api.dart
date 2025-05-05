// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, avoid_print, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/approvals_modal/approvalOTODPostApi.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class ApprovalsQuotPostAPi {
  static String? docDueDate;
  static String? docEntry;
  static String? orderDate;
  static String? orderType;
  static String? gpApproval;
  static String? orderTime;
  static String? custREfNo;
  static Future<ApprovalsOTORModal> getGlobalData() async {
    final data = json.encode({
      "Document": {
        "DocDueDate": "$docDueDate",
        "DocEntry": "$docEntry",
        "U_OrderDate": "$orderDate",
        "U_Order_Type": "$orderType",
        "U_GP_Approval": "$gpApproval",
        "U_Received_Time": "$orderTime",
        "NumAtCard": "$custREfNo",
      },
    });

    print("Body request:" + data);
    try {
      log(
        "api:" + URL.url + "DraftsService_SaveDraftToDocument",
      );
      final response = await http.post(
        Uri.parse(
          URL.url +
              "DraftsService_SaveDraftToDocument", //&\$filter= DocumentStatus eq 'bost_Open'
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + GetValues.sessionID.toString(),
          // "Prefer":"return-no-content"
        },
        body: json.encode({
          "Document": {
            "DocDueDate": "$docDueDate",
            "DocEntry": "$docEntry",
            "U_OrderDate": "$orderDate",
            "U_Order_Type": "$orderType",
            "U_GP_Approval": "$gpApproval",
            "U_Received_Time": "$orderTime",
            "NumAtCard": "$custREfNo",
          },
        }),
      );
      log("ApprovalsQuotPost sts " + response.statusCode.toString());
      log("ApprovalsQuotPost res " + response.body);

      log(
        'message::' +
            json.encode({
              "Document": {
                "DocDueDate": "$docDueDate",
                "DocEntry": "$docEntry",
                "U_OrderDate": "$orderDate",
                "U_Order_Type": "$orderType",
                "U_GP_Approval": "$gpApproval",
                "U_Received_Time": "$orderTime",
                "NumAtCard": "$custREfNo",
              },
            }),
      );
      if (response.statusCode == 200 || response.statusCode == 204) {
        // print("statucCode: "+response.statusCode.toString());
        return ApprovalsOTORModal.fromJson(
          response.statusCode.toString(),
        );
      } else {
        // print("resss22"+json.decode(response.body).toString());
        //   print("statucCode2222: "+response.statusCode.toString());
        // print("response.body: "+json.decode(response.body).toString());
        //  throw Exception('Restart the app or contact the admin!!..');
        return ApprovalsOTORModal.fromJson2(
          response.statusCode.toString(),
          json.decode(response.body) as Map<String, dynamic>,
        );
      }
    } catch (e) {
      log("Exception::" + e.toString());
      throw Exception(e);

      // return ApprovalsQuotModal.issue('Restart the app or contact the admin!!..');
    }
  }
}
