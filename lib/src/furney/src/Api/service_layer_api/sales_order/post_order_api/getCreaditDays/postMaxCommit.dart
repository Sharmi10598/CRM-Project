// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';


class PostMaxCommitAPi{
  static String? cardCodePost;
  static String? value;
  static Future<void> getGlobalData() async {
     final data =json.encode ({
         "MaxCommitment" : "$value"     
          });
          print(data);
    try {
    final response = await http.patch(
        Uri.parse(
      URL.url+"BusinessPartners('$cardCodePost')",
      ),
        headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+ GetValues.sessionID.toString(),
        "Prefer":"return-no-content"
        },
        body: json.encode ({
           "MaxCommitment" : "$value"   
          }),
      );
     
      if (response.statusCode == 200 || response.statusCode == 204) {///bedor 201
        print(response.body);
        print("statucCode BusinessPartners: "+response.statusCode.toString());
        //return SalesQuotStatus.fromJson(response.statusCode.toString());
      } else {
      //  print(response.body);
         print("Responce: "+(json.decode(response.body).toString()));
           print("statucCode: "+response.statusCode.toString());
        //throw Exception('Restart the app or contact the admin!!..');
   //return SalesQuotStatus.errorIN(json.decode(response.body)as Map<String,dynamic>);
      }
      
    } catch (e) {
      print(e);
     // throw Exception(e);
  //   return SalesQuotStatus.issue('Restart the app or contact the admin!!..\n');//+e.toString()
    }
  }
}
