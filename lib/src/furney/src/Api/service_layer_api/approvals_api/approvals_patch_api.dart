// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, file_names, invariant_booleans

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/approvals_modal/approvals_patch_model.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class ApprovalsPatchAPi{
  static String? sessionID;
  static String? approvalID;
  static String? status;
  static String? remarks;
  static Future<StatusCode> getGlobalData() async {
    try {
    final response = await http.patch(
      Uri.parse(URL.url+"ApprovalRequests($approvalID)",),//$approvalID
      body: jsonEncode({
        "ApprovalRequestDecisions": [{
        "Status": "$status",
        "Remarks": "$remarks"
        }]
        }),
        headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+ GetValues.sessionID.toString(),
        },
     );
        if (response.statusCode == 204) {
            print('body: '+response.body);
            return StatusCode.fromJson(response.statusCode.toString());
        }else if (response.statusCode >= 400){
              print('body: '+response.body);
              print('rescode: '+response.statusCode.toString());

              return StatusCode.fromJson(response.statusCode.toString());// json.decode(response.body)as Map<String,dynamic>
            //  return ApprovalsPatchModal.fromJson(json.decode(response.body)as Map<String,dynamic>);
        }
    } catch (e) {
       //throw Exception('$e');
             return StatusCode.fromJson(e.toString());
    }
    return StatusCode.fromJson('null');
  }
 
}
