// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, noop_primitive_operations, unnecessary_statements, unnecessary_parenthesis

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_quot/post_modal/post_quot_modal.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/creation/content_creation.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';


class SalesQuotPostAPi{
  static String? sessionID;
  static String? cardCodePost;
  static List<AddItem>? docLineQout;
  static  String? docDate;
  static String? dueDate;
   static String? remarks;
  static void method(String? deviceTransID){
     final data =json.encode ({
           "CardCode": "$cardCodePost",
           "DocumentStatus":"bost_Open",
           "DocDate":"$docDate",
           "DocDueDate":"$dueDate",
           "Comments":"$remarks",
           "U_DeviceTransID":deviceTransID,
           "DocumentLines": docLineQout!.map((e) => e.tojson()).toList(),
          });
        //  log("post q data : "+data.toString());
  }
  static Future<SalesQuotStatus> getGlobalData(String? deviceTransID) async {
    try {
      log(URL.url+"Quotations");
    final response = await http.post(
        Uri.parse(
      URL.url+"Quotations",
      ),
        headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+ GetValues.sessionID.toString(),
        // "Prefer":"return-no-content"
        },
        body: json.encode ({
           "CardCode": "$cardCodePost",
           "DocumentStatus":"bost_Open",
           "DocDate":"$docDate",
           "DocDueDate":"$dueDate",
           "Comments":"$remarks",
           "U_DeviceTransID":deviceTransID,
           "DocumentLines": docLineQout!.map((e) => e.tojson()).toList(),
          }),
      );

      log("datatatat: "+ json.encode ({
           "CardCode": "$cardCodePost",
           "DocumentStatus":"bost_Open",
           "DocDate":"$docDate",
           "DocDueDate":"$dueDate",
           "Comments":"$remarks",
           "U_DeviceTransID":deviceTransID,
           "DocumentLines": docLineQout!.map((e) => e.tojson()).toList(),
          }),);
                log("Responce: "+(json.decode(response.body).toString()));
            log("statucCode: "+response.statusCode.toString());
     // log("Quotations post: "+json.decode(response.body.toString()).toString());
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        final dynamic data = json.decode(response.body.toString());
        return SalesQuotStatus.fromJson(response.statusCode
        
        );
      } else {
    
       // throw Exception('Restart the app or contact the admin!!..');
   return SalesQuotStatus.errorIN(json.decode(response.body)as Map<String,dynamic>,response.statusCode);
      }
    } catch (e) {
      print(e);
    //  throw Exception(e);
     return SalesQuotStatus.issue('Restart the app or contact the admin!!..\n');
    }
  }
}