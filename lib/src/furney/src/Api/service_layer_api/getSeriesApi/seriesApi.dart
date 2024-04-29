// ignore_for_file: file_names, prefer_single_quotes

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/seriesModal/seriesModal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';


class SeriesAPi{

  static Future<SeriesModal> getGlobalData() async {
    print("B1SESSIONsssssssssssssssss=${GetValues.sessionID}");
    try {
      final response = await http.post(
        Uri.parse(
           //http://164.52.214.147:50001/b1s/v1
       '${URL.url}SeriesService_GetDefaultSeries',
       
      ),
        headers: {
          'Content-Type': 'application/json',
          'Cookie':'B1SESSION=${GetValues.sessionID}'
        },
          body: json.encode ({
           "DocumentTypeParams":{
           "Document":"17"
            }
          }),
      );
        // log("SeriesAPiiiiiiiii: ${json.decode(response.body)}");
          
      if (response.statusCode <= 210) {// || response.statusCode <= 210
        print(response.statusCode);
        return SeriesModal.fromJson(json.decode(response.body)as Map<String,dynamic>);
      } else {
          print("SeriesAPiiiiiiii: ${json.decode(response.body)}");
        print(response.statusCode);
       // throw Exception('Err');
       return SeriesModal.error(json.decode(response.body)as Map<String,dynamic>);
      }
    } catch (e) {
     // throw Exception('Exceptionsss: $e');
      return SeriesModal.issue('Restart the app or contact the admin!!..');
    }
  }

}
