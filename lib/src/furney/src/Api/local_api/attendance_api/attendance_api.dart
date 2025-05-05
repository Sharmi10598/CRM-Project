// ignore_for_file: file_names, prefer_single_quotes, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/attendance_modal/attendance_modal.dart';

class AttendanceAPi {
  static String? userid;
  static String? deviceID;
  static String? timeStamp;
  static String? latitude;
  static String? longitude;
  static String? location;
  static String comments = '';
  static String? locationType;
  static Future<AttendanceModal> getGlobalData() async {
    try {
      log('${URL.urlLocal}AttendenceInfo');
      final response = await http.post(
        Uri.parse(
          '${URL.urlLocal}AttendenceInfo', //55555 12123123123
        ),
        headers: {
          'content-type': 'application/json',
        },
        body: json.encode({
          "UserId": "$userid",
          "DeviceCode": "$deviceID",
          "TimeStamp": "$timeStamp",
          "Latitude": "$latitude",
          "Longitude": "$longitude",
          "Location": "$location",
          "Comments": "$comments",
          "LocationType": "$locationType",
        }),
        //
        //
      );

      log(
        'AttendenceInfo:::${json.encode({
              "UserId": "$userid",
              "DeviceCode": "$deviceID",
              "TimeStamp": "$timeStamp",
              "Latitude": "$latitude",
              "Longitude": "$longitude",
              "Location": "$location",
              "Comments": "$comments",
              "LocationType": "$locationType",
            })}',
      );
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return AttendanceModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>,);
      } else {
        print(json.decode(response.body));
        print(json.decode(response.statusCode.toString()));
        // throw Exception("Error!!....");
        return AttendanceModal.issue(
            'Restart the app or contact the admin!!..',);
      }
    } catch (e) {
      //throw Exception("Exceptionsss: $e");
      return AttendanceModal.exception(
          'Restart the app or contact the admin!!..',);
    }
  }
}
