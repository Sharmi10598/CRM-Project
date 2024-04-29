// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sap_User_id_modal/sap_user_id_modal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';


class SapUserIDAPi{

  static Future<SapUserIDModal> getGlobalData() async {
    try {
    final response = await http.get(
        Uri.parse(
        URL.url+"/Users?\$select=InternalKey&\$filter=UserCode eq '${GetValues.sapUserName}'",
      ),
        headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+ GetValues.sessionID.toString(),
        },
      );
        log("SapUersID: "+json.decode(response.body).toString());
        log("SapUersID: "+ response.statusCode.toString());
      if (response.statusCode == 200) {
        print("SapUersID: "+json.decode(response.body).toString());
        return SapUserIDModal.fromJson(json.decode(response.body)as Map<String,dynamic>);
      } else {
        //throw Exception("Error!!...");
      return SapUserIDModal.issue(json.decode(response.body)as Map<String,dynamic>);
      }
    } catch (e) {
       //throw Exception("Exception: $e");
      return SapUserIDModal.error(e.toString());
    }
  }
 
}
