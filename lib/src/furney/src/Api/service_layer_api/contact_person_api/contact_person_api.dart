// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/contact_person_modal/contact_person_modal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class ContactPersonsAPi{
  static String? sessionID;
  static String? cardCode;
  static Future<ContactPersonModal> getGlobalData() async {
    try {
      log(
      URL.url+r"BusinessPartners('D9219')?$select=BilltoDefault,ShipToDefault,ContactEmployees",
        
      );
    final response = await http.get(
        Uri.parse(
      URL.url+"BusinessPartners('$cardCode')?\$select=BilltoDefault,ShipToDefault,ContactEmployees",
        
      ),
        headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+ GetValues.sessionID.toString(),
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return ContactPersonModal.fromJson(json.decode(response.body)as Map<String,dynamic>);
      } else {
        //  print(json.decode(response.body));
        //  print(response.statusCode);
        throw Exception('Restart the app or contact the admin!!..');
     // return ContactPersonModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
       throw Exception('$e');
      //return ContactPersonModal.issue('Restart the app or contact the admin!!..');
    }
  }
 
 
}
