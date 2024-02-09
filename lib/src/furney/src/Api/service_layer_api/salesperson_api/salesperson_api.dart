// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, file_names, use_raw_strings

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/salesperson_modal/salesPerson_modal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class SalesOPersonAPi{
  static String? sessionID;
  static String? slpCode;

  static Future<SalesPersonModal> getGlobalData() async {
    try {
    final response = await http.get(
        Uri.parse(
      URL.url+"SalesPersons?\$select=SalesEmployeeName&\$filter=SalesEmployeeCode eq $slpCode",
        
      ),
        headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+ GetValues.sessionID.toString(),
        },
      );
      if (response.statusCode == 200) {
       // print(json.decode(response.body));
        return SalesPersonModal.fromJson(json.decode(response.body)as Map<String,dynamic>);
      } else {
        throw Exception('Restart the app or contact the admin!!..');
      //return SalesPersonModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
       throw Exception('Restart the app or contact the admin!!..');
    //  return SalesPersonModal.issue('Restart the app or contact the admin!!..');
    }
  }
 
}
