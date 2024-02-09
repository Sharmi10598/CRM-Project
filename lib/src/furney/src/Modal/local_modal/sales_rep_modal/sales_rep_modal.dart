// To parse this JSON data, do
//
//     final logindata = logindataFromJson(jsonString);

// ignore_for_file: avoid_init_to_null, omit_local_variable_types

import 'dart:convert';

SalesRepModal logindataFromJson(String str) =>
    SalesRepModal.fromJson(json.decode(str) as Map<String, dynamic>);

//String logindataToJson(Logindata data) => json.encode(data.toJson());

class SalesRepModal {
  SalesRepModal(
      {required this.status,
      required this.message,
      this.salesrepData,
      this.error,
      this.exception,});

  bool? status;
  String? message;
  List<SalesRepData>? salesrepData;
  String? error;
  String? exception;

  factory SalesRepModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['data'] != null) {
      final list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      // print(list);
      List<SalesRepData> dataList = list
          .map((dynamic enquiries) => SalesRepData.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return SalesRepModal(
        salesrepData: dataList,
        message: jsons['message'].toString(),
        status: jsons['status'] as bool,
      );
    } else {
      return SalesRepModal(
        message: jsons['message'].toString(),
        status: jsons['status'] as bool,
      );
    }
  }
  factory SalesRepModal.issue(String e) {
    return SalesRepModal(status: null, message: null, error: e);
  }

  factory SalesRepModal.exception(String e) {
    return SalesRepModal(status: null, message: null, error: e,
    exception: e,
    );
  }
}

class SalesRepData {
 
  String? employeName;
  String? email;
  String? branch;
  String? roll;
  String? phone;
  SalesRepData({
  required  this.employeName,
   required this.email,
   required this.branch,
  required  this.phone,
  required  this.roll,
  });

  factory SalesRepData.fromJson(dynamic jsons) {
    return SalesRepData(
      employeName: jsons['EmployeeName'] as String,
      email: jsons['Email'] as String,
      branch: jsons['Branch']as String,
       phone:jsons['Phone']as String,
       roll: jsons['Roll']as String,
    );
  }
}
