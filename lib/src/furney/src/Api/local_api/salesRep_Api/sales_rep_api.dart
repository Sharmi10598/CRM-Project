// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/sales_rep_modal/sales_rep_modal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';


class SalesRepAPi{
  static String? deviceId;
  static String? userCode;
  static String? password;

  static Future<SalesRepModal> getGlobalData() async {
   // print("${GetValues.idOfUser};;;;;;;;;;;;;;");
    try {
    final response = await http.get(//http://164.52.214.147:50001/b1s/v1/BusinessPartners?$select=CardCode,CardName,CardType
        Uri.parse(
      '${URL.urlLocal}GetReportingEmplyoees/${GetValues.crmUserID}',//55555
      ),
        headers: {
        'content-type': 'application/json',
        },
      );
        log(json.decode(response.body).toString());

      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return SalesRepModal.fromJson(json.decode(response.body)as Map<String,dynamic>);
      }
       else {
         print(json.decode(response.body));
          print(json.decode(response.body));
        // throw Exception("Error!!...");
      return SalesRepModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
     //  throw Exception("Exceptionsss: $e");
      return SalesRepModal.exception('Restart the app or contact the admin!!..');
    }
  }
 
}
