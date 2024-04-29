// To parse this JSON data, do
//
//     final logindata = logindataFromJson(jsonString);

// ignore_for_file: avoid_init_to_null, omit_local_variable_types

import 'dart:convert';

CheckVersion logindataFromJson(String str) =>
    CheckVersion.fromJson(json.decode(str) as Map<String, dynamic>);

//String logindataToJson(Logindata data) => json.encode(data.toJson());

class CheckVersion {
  CheckVersion(
      {required this.status,
      required this.message,
      this.deviceData,
      this.error,
      this.exception,});

  bool? status;
  String? message;
  List<CheckVersionData>? deviceData;
  String? error;
  String? exception;

  factory CheckVersion.fromJson(Map<String, dynamic> jsons) {
    if (jsons['data'] != null) {
      final list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      print("jsons['data']::"+list.toString());
      List<CheckVersionData> dataList = list
          .map((dynamic enquiries) => CheckVersionData.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return CheckVersion(
        deviceData: dataList,
        message: jsons['message'].toString(),
        status: jsons['status'] as bool,
      );
    } else {
      return CheckVersion(
        message: jsons['message'].toString(),
        status: jsons['status'] as bool,
      );
    }
  }
  factory CheckVersion.issue(String e) {
    return CheckVersion(status: null, message: null, error: e);
  }

  factory CheckVersion.exception(String e) {
    return CheckVersion(status: null, message: null, error: e,
    exception: e,
    );
  }
}

class CheckVersionData {
  String? Version;
  String? Url;
  String? Content;

  CheckVersionData({
    this.Version,
    this.Url,
    this.Content,
  });

  factory CheckVersionData.fromJson(dynamic jsons) {
    return CheckVersionData(
      Version: jsons['Vertion'] as String,
      Url: jsons['Url'] as String,
      Content: jsons['Content'] as String,
    );
  }
}
