// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/approvals_modal/approvals_modal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class RejectAPi{
  static String? sessionID;
  static String? cardCode;
  static String? nextUrl;
  static String url= "SQLQueries('ApprovalListApproved')/List?UserID=${GetValues.sapUserID}";
  static Future<ApprovalsModal> getGlobalData() async {
    try {
    final response = await http.get(
        Uri.parse(
      URL.url+"SQLQueries('ApprovalListRajected')/List?UserID=${GetValues.sapUserID}",
        
      ),
        headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+ GetValues.sessionID.toString(),
        },
      );
      if (response.statusCode == 200) {
       // print(json.decode(response.body));
        return ApprovalsModal.fromJson(json.decode(response.body)as Map<String,dynamic>);
      } else {
        //  print(json.decode(response.body));
        //  print(response.statusCode);
       // throw Exception('Restart the app or contact the admin!!..');
      return ApprovalsModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
       //throw Exception('$e');
      return ApprovalsModal.issue('Restart the app or contact the admin!!..');
    }
  }
 
 static Future<ApprovalsModal> callNextLink() async {
    try {
    final response = await http.get(
        Uri.parse(//http://102.69.164.12:50001/b1s/v1/DeliveryNotes(10)
      URL.url+'/'+nextUrl.toString(),
        
      ),
        headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+ GetValues.sessionID.toString(),
        'Prefer': 'odata.maxpagesize=${GetValues.maximumfetchValue}',
        },
      );
      if (response.statusCode == 200) {
      //  print(json.decode(response.body));
        return ApprovalsModal.fromJson(json.decode(response.body)as Map<String,dynamic>);
      } else {
        throw Exception('Restart the app or contact the admin!!..');
    //  return SalesOrderModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
       throw Exception('$e');
    //  return SalesOrderModal.issue('Restart the app or contact the admin!!..');
    }
  }
}
