// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/SOafterApi/SOAfterApidel/SOAfterApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';

class SalesOrderAfterAPi {
  static String? sessionID;
  static String? baseEntry;
  static String? baseType;
  static String? baseLineTo;
  static String? schemeEntry;
  static String? discper;
  static String? disValue;

  static void method(List<SOafterdetails> salesOderSchene) {}

  static Future<SOafterStatus> getData(String uuids) async {
    final data = json.encode({
      //  salesOderSchene.map((e) => e.toMap()).toList(),
      "U_BaseEntry": "$baseEntry",
      "U_BaseType": "$baseType",
      "U_BaseLineNo": "$baseLineTo",
      "U_SchemeEntry": "$schemeEntry",
      "U_DiscPer": "$discper",
      "U_DiscValue": "$disValue",
      "U_DeviceCode": uuids,
    });
    print("SO After body: " + data);

    try {
      final response = await http.post(
        Uri.parse(
          URL.url + "U_OSCH",
        ),
        headers: {
          "content-type": "application/json",
          "cookie":
              'B1SESSION=' + sessionID!, // GetValues.sessionID.toString(),
          "Prefer": "return-no-content",
        },
        body: json.encode({
          //  SOAfterdata.map((e) => e.toMap()).toList(),
          "U_BaseEntry": "$baseEntry",
          "U_BaseType": "$baseType",
          "U_BaseLineNo": "$baseLineTo",
          "U_SchemeEntry": "$schemeEntry",
          "U_DiscPer": "$discper",
          "U_DiscValue": "$disValue",
          "U_DeviceCode": uuids,
        }),
      );
      log("response:::" + response.body);

      if (response.statusCode == 200 || response.statusCode == 204) {
        log("statucCode: " + response.statusCode.toString());
        return SOafterStatus.fromJson(response.statusCode);
      } else {
        print(
          "Responce post order: " + (json.decode(response.body).toString()),
        );
        print("statucCode post order: " + response.statusCode.toString());
        //throw Exception('Restart the app or contact the admin!!..');
        return SOafterStatus.errorIN(
          json.decode(response.body) as Map<String, dynamic>,
        );
      }
    } catch (e) {
      print(e);
      // throw Exception(e);
      return SOafterStatus.issue(
        'Restart the app or contact the admin!!..\n',
      ); //+e.toString()
    }
  }
}

class SOafterdetails {
  String? baseLineTo;
  String? schemeEntry;
  String? discper;
  String? disValue;

  SOafterdetails({
    required this.baseLineTo,
    required this.schemeEntry,
    required this.discper,
    required this.disValue,
  });

  Map<String, dynamic> toMap() {
    final map = <String, String>{
      "U_BaseLineNo": baseLineTo.toString(),
      "U_SchemeEntry": schemeEntry.toString(),
      "U_DiscPer": discper.toString(),
      "U_DiscValue": disValue.toString(),
    };

    return map;
  }
}
