// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/approvals_modal/approvals_details.modal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class SalesDetailsQtAPi{
 static String url= "SQLQueries${GetValues.sessionID}";
  static Future<ApprovalDetailsValue> getGlobalData(String? draftEntry) async {
    try {
      log("qut->: "+URL.url+"Quotations($draftEntry)");
    final response = await http.get(
        Uri.parse(
      URL.url+"Quotations($draftEntry)",
      ),
      
        headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+ GetValues.sessionID.toString(),
        },
      );
        log("SalesDetails rescode::"+response.statusCode.toString());

        log("SalesDetails res::"+response.body.toString());

      if (response.statusCode == 200) {
        return ApprovalDetailsValue.fromJson(json.decode(response.body)as Map<String,dynamic>);
      } else {
        //  print(json.decode(response.body));
        //  print(response.statusCode);
        // throw Exception('Restart the app or contact the admin!!..');
      return ApprovalDetailsValue.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
       log("EXXXX: ${e.toString()}");
      //  throw Exception('$e');
     return ApprovalDetailsValue.issue('Restart the app or contact the admin!!..');
    }
  }
 
}
