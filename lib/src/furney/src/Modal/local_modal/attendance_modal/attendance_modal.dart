// To parse this JSON data, do
//
//     final logindata = logindataFromJson(jsonString);

// ignore_for_file: avoid_init_to_null, omit_local_variable_types

import 'dart:convert';

AttendanceModal logindataFromJson(String str) =>
    AttendanceModal.fromJson(json.decode(str) as Map<String, dynamic>);

//String logindataToJson(Logindata data) => json.encode(data.toJson());

class AttendanceModal {
  AttendanceModal(
      {required this.status,
      required this.message,
      this.attendanceData,
      this.error,
      this.exception,});

  bool? status;
  String? message;
  List<AttendanceData>? attendanceData;
  String? error;
  String? exception;

  factory AttendanceModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['data'] != null) {
      final list = jsonDecode(jsons['data'] as String) as List; 
 
      List<AttendanceData> dataList = list
          .map((dynamic enquiries) => AttendanceData.fromJson(enquiries))
          .toList();
  
      return AttendanceModal(
        attendanceData: dataList,
        message: jsons['message'].toString(),
        status: jsons['status'] as bool,
      );
    } else {
      return AttendanceModal(
        message: jsons['message'].toString(),
        status: jsons['status'] as bool,
      );
    }
  }
  factory AttendanceModal.issue(String e) {
    return AttendanceModal(status: null, message: null, error: e);
  }

  factory AttendanceModal.exception(String e) {
    return AttendanceModal(status: null, message: null, error: e,
    exception: e,
    );
  }
}

class AttendanceData {
  String? msg;


  AttendanceData({
    this.msg,

  });

  factory AttendanceData.fromJson(dynamic jsons) {
    return AttendanceData(
      msg: jsons['Msg'] as String,

    );
  }
}
