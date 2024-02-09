// To parse this JSON data, do
//
//     final logindata = logindataFromJson(jsonString);

// ignore_for_file: avoid_init_to_null, omit_local_variable_types

import 'dart:convert';

CheckUserIddata logindataFromJson(String str) =>
    CheckUserIddata.fromJson(json.decode(str) as Map<String, dynamic>);

//String logindataToJson(Logindata data) => json.encode(data.toJson());

class CheckUserIddata {
  CheckUserIddata(
      {required this.status,
      required this.message,
      this.deviceData,
      this.error,
      this.exception,});

  bool? status;
  String? message;
  List<DeviceData>? deviceData;
  String? error;
  String? exception;

  factory CheckUserIddata.fromJson(Map<String, dynamic> jsons) {
    if (jsons['data'] != null) {
      final list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      // print(list);
      List<DeviceData> dataList = list
          .map((dynamic enquiries) => DeviceData.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return CheckUserIddata(
        deviceData: dataList,
        message: jsons['message'].toString(),
        status: jsons['status'] as bool,
      );
    } else {
      return CheckUserIddata(
        message: jsons['message'].toString(),
        status: jsons['status'] as bool,
      );
    }
  }
  factory CheckUserIddata.issue(String e) {
    return CheckUserIddata(status: null, message: null, error: e);
  }

  factory CheckUserIddata.exception(String e) {
    return CheckUserIddata(status: null, message: null, error: e,
    exception: e,
    );
  }
}

class DeviceData {
  String? Email;
  String? UserName;
  String? DeviceCode;

  DeviceData({
    this.Email,
    this.UserName,
    this.DeviceCode,
  });

  factory DeviceData.fromJson(dynamic jsons) {
    return DeviceData(
      Email: jsons['Email'] as String,
      UserName: jsons['UserCode'] as String,
      DeviceCode: jsons['DeviceCode'] as String,
    );
  }
}
