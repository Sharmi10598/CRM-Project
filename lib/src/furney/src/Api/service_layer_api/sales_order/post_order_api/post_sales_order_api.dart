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


class SalesOrderPostAPi{
  static String? sessionID;
  static String? cardCodePost;
  static String? cardNamePost;
  static List<AddItem>? docLineQout;
  static  String? docDate;
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
   
  static void method(String latitude,String longitude){
   
  final dat  =  CreateOrderDetailsState.isCameFromqutation == true?
          json.encode ({
          "AppVersion":AppVersion.version,
           "CardCode": "$cardCodePost",
          "CardName":"$cardNamePost",
          "DocumentStatus":"bost_Open",
          "DocDate":"$docDate",
          "DocDueDate":"$dueDate",
          "Comments":"$remarks",
          "U_OrderDate":"$orderDate",
          "U_Order_Type":"$orderType",
          "U_GP_Approval":"$gpApproval",
          "U_Received_Time":"$orderTime",
          "NumAtCard":"$custREfNo",
          'U_DeviceCode':deviceCode,
          'U_DeviceTransID':deviceTransID,
          'SalesPersonCode':'$slpCode',
          'Series':'${GetValues.seriresOrder}',
          "U_latitude ":latitude,
          "U_longitude":longitude,
          
          "DocumentLines": docLineQout!.map((e) => e.tojson2()).toList(),
          })
        :
        json.encode ({
          "AppVersion":AppVersion.version,
           "CardCode": "$cardCodePost",
          "CardName":"$cardNamePost",
          "DocumentStatus":"bost_Open",
          "DocDate":"$docDate",
          "DocDueDate":"$dueDate",
          "Comments":"$remarks",
          "U_OrderDate":"$orderDate",
          "U_Order_Type":"$orderType",
          "U_GP_Approval":"$gpApproval",
          "U_Received_Time":"$orderTime",
          "NumAtCard":"$custREfNo",
          'U_DeviceCode':deviceCode,
          'U_DeviceTransID':deviceTransID,
          'SalesPersonCode':'$slpCode',
          'Series':'${GetValues.seriresOrder}',
          "U_latitude ":latitude,
          "U_longitude":longitude,
          "DocumentLines": docLineQout!.map((e) => e.tojson()).toList(),
          });
 
 log("Jsons Sales ORder Post: "+dat);
  }
  static Future<SalesQuotStatus> getGlobalData(String latitude,String longitude) async {
    try {
    //  log(URL.url+"Orders  ${ CreateOrderDetailsState.isCameFromqutation}");
   //   print(sessionID);
   final data =    CreateOrderDetailsState.isCameFromqutation == true?
          json.encode ({
             "AppVersion":AppVersion.version,
           "CardCode": "$cardCodePost",
          "CardName":"$cardNamePost",
          "DocumentStatus":"bost_Open",
          "DocDate":"$docDate",
          "DocDueDate":"$dueDate",
          "Comments":"$remarks",
          "U_OrderDate":"$orderDate",
          "U_Order_Type":"$orderType",
          "U_GP_Approval":"$gpApproval",
          "U_Received_Time":"$orderTime",
          "NumAtCard":"$custREfNo",
          'U_DeviceCode':deviceCode,
          'U_DeviceTransID':deviceTransID,
          'SalesPersonCode':'$slpCode',
          'Series':'${GetValues.seriresOrder}',
          "U_latitude ":latitude,
          "U_longitude":longitude,
          "DocumentLines": docLineQout!.map((e) => e.tojson2()).toList(),
          })
        :
        json.encode ({
           "AppVersion":AppVersion.version,
           "CardCode": "$cardCodePost",
          "CardName":"$cardNamePost",
          "DocumentStatus":"bost_Open",
          "DocDate":"$docDate",
          "DocDueDate":"$dueDate",
          "Comments":"$remarks",
          "U_OrderDate":"$orderDate",
          "U_Order_Type":"$orderType",
          "U_GP_Approval":"$gpApproval",
          "U_Received_Time":"$orderTime",
          "NumAtCard":"$custREfNo",
          'U_DeviceCode':deviceCode,
          'U_DeviceTransID':deviceTransID,
          'SalesPersonCode':'$slpCode',
          'Series':'${GetValues.seriresOrder}',
          "U_latitude ":latitude,
          "U_longitude":longitude,
          "DocumentLines": docLineQout!.map((e) => e.tojson()).toList(),
          });
    final response = await http.post(
        Uri.parse(
      URL.url+"Orders",
      ),
        headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+sessionID!,
        "Prefer":"return-no-content"
        },
        
        body: 
     CreateOrderDetailsState.isCameFromqutation == true?
          json.encode ({
           "CardCode": "$cardCodePost",
          "CardName":"$cardNamePost",
          "DocumentStatus":"bost_Open",
          "DocDate":"$docDate",
          "DocDueDate":"$dueDate",
          "Comments":"$remarks",
          "U_OrderDate":"$orderDate",
          "U_Order_Type":"$orderType",
          "U_GP_Approval":"$gpApproval",
          "U_Received_Time":"$orderTime",
          "NumAtCard":"$custREfNo",
          'U_DeviceCode':deviceCode,
          'U_DeviceTransID':deviceTransID,
          'SalesPersonCode':'$slpCode',
          'Series':'${GetValues.seriresOrder}',
          "U_latitude ":latitude,
          "U_longitude":longitude,
          "U_Request":data,
          "DocumentLines": docLineQout!.map((e) => e.tojson2()).toList(),
          })
        :
        json.encode ({
           "CardCode": "$cardCodePost",
          "CardName":"$cardNamePost",
          "DocumentStatus":"bost_Open",
          "DocDate":"$docDate",
          "DocDueDate":"$dueDate",
          "Comments":"$remarks",
          "U_OrderDate":"$orderDate",
          "U_Order_Type":"$orderType",
          "U_GP_Approval":"$gpApproval",
          "U_Received_Time":"$orderTime",
          "NumAtCard":"$custREfNo",
          'U_DeviceCode':deviceCode,
          'U_DeviceTransID':deviceTransID,
          'SalesPersonCode':'$slpCode',
          'Series':'${GetValues.seriresOrder}',
          "U_latitude ":latitude,
          "U_longitude":longitude,
          "U_Request":data,
          "DocumentLines": docLineQout!.map((e) => e.tojson()).toList(),
          }),
      );

     CreateOrderDetailsState.isCameFromqutation== true?
         log( json.encode ({
           "CardCode": "$cardCodePost",
          "CardName":"$cardNamePost",
          "DocumentStatus":"bost_Open",
          "DocDate":"$docDate",
          "DocDueDate":"$dueDate",
          "Comments":"$remarks",
          "U_OrderDate":"$orderDate",
          "U_Order_Type":"$orderType",
          "U_GP_Approval":"$gpApproval",
          "U_Received_Time":"$orderTime",
          "NumAtCard":"$custREfNo",
          'U_DeviceCode':deviceCode,
          'U_DeviceTransID':deviceTransID,
          'SalesPersonCode':'$slpCode',
          'Series':'${GetValues.seriresOrder}',
          "U_latitude ":latitude,
          "U_longitude":longitude,
           "U_Request":data,
          "DocumentLines": docLineQout!.map((e) => e.tojson2()).toList(),
          }),)
        :
       log( json.encode ({
           "CardCode": "$cardCodePost",
          "CardName":"$cardNamePost",
          "DocumentStatus":"bost_Open",
          "DocDate":"$docDate",
          "DocDueDate":"$dueDate",
          "Comments":"$remarks",
          "U_OrderDate":"$orderDate",
          "U_Order_Type":"$orderType",
          "U_GP_Approval":"$gpApproval",
          "U_Received_Time":"$orderTime",
          "NumAtCard":"$custREfNo",
          'U_DeviceCode':deviceCode,
          'U_DeviceTransID':deviceTransID,
          'SalesPersonCode':'$slpCode',
          'Series':'${GetValues.seriresOrder}',
          "U_latitude ":latitude,
          "U_longitude":longitude,
           "U_Request":data,
          "DocumentLines": docLineQout!.map((e) => e.tojson()).toList(),
          }),);
        // print("ABCD: "+response.statusCode.toString());
         print("statucCode: "+response.statusCode.toString());
            log("bodyyy post order: "+response.body);
      if (response.statusCode >= 200 && response.statusCode <= 210) {///bedor 201
        // log("save : "+response.body.toString());
       // print("statucCode: "+response.statusCode.toString());
        return SalesQuotStatus.fromJson(response.statusCode
        
        );
      } else {
      //  print(response.body);
         //print("Responce post order: "+(json.decode(response.body).toString()));
         //  print("statucCode post order: "+response.statusCode.toString());
        // throw Exception('Restart the app or contact the admin!!..');
        return SalesQuotStatus.errorIN(json.decode(response.body)as Map<String,dynamic>,response.statusCode);
      }
      
    } catch (e) {
      print(e);
    //  throw Exception(e);
     return SalesQuotStatus.issue('Restart the app or contact the admin!!..\n');//+e.toString()
    }
  }
}
