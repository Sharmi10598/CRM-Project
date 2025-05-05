// To parse this JSON data, do
//
//     final logindata = logindataFromJson(jsonString);

// ignore_for_file: avoid_init_to_null, omit_local_variable_types

import 'dart:convert';

CheckUserLogin logindataFromJson(String str) =>
    CheckUserLogin.fromJson(json.decode(str) as Map<String, dynamic>);

//String logindataToJson(Logindata data) => json.encode(data.toJson());

class CheckUserLogin {
  CheckUserLogin({
    required this.status,
    required this.message,
    this.loginUserData,
    this.error,
    this.exception,
  });

  bool? status;
  String? message;
  List<LoginUserData>? loginUserData;
  String? error;
  String? exception;

  factory CheckUserLogin.fromJson(Map<String, dynamic> jsons) {
    if (jsons['data'] != null) {
      final list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      // print(list);
      final List<LoginUserData> dataList = list
          .map((dynamic enquiries) => LoginUserData.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return CheckUserLogin(
        loginUserData: dataList,
        message: jsons['message'].toString(),
        status: jsons['status'] as bool,
      );
    } else {
      return CheckUserLogin(
        message: jsons['message'].toString(),
        status: jsons['status'] as bool,
      );
    }
  }
  factory CheckUserLogin.issue(String e) {
    return CheckUserLogin(status: null, message: null, error: e);
  }

  factory CheckUserLogin.exception(String e) {
    return CheckUserLogin(
      status: null,
      message: null,
      error: e,
      exception: e,
    );
  }
}

class LoginUserData {
  int? id;
  String? branch;
  String? userCode;
  String? userName;
  String? password;
  String? deviceCode;
  String? email;
  String? sapUserName;
  String? sapPassword;
  String? sapUrl;
  String? slpCode;
  String? active;
  int? userRoll;
  int? reportTo;
  String? sapDB;
  String? ManagerFCM;
  String? FCM;
  String? U_CrpUsr;

  LoginUserData({
    this.branch,
    this.userCode,
    this.id,
    this.userName,
    this.password,
    this.deviceCode,
    this.email,
    this.sapUserName,
    this.sapPassword,
    this.sapUrl,
    this.slpCode,
    this.active,
    this.userRoll,
    this.reportTo,
    this.sapDB,
    this.ManagerFCM,
    this.FCM,
    this.U_CrpUsr,
  });

  factory LoginUserData.fromJson(dynamic jsons) {
    return LoginUserData(
      id: jsons['Id'] as int,
      branch: jsons['Branch'].toString(),
      userCode: jsons['UserCode'].toString(),
      userName: jsons['UserName'].toString(),
      password: jsons['Password'].toString(),
      deviceCode: jsons['DeviceCode'].toString(),
      email: jsons['Email'].toString(),
      sapUserName: jsons['SAPUserName'].toString(),
      sapPassword: jsons['SAPPassword'].toString(),
      sapUrl: jsons['SAPUrl'].toString(),
      active: jsons['Active'].toString(),
      userRoll: jsons['UserRoll'] as int,
      reportTo: jsons['ReportTo'] as int,
      slpCode: jsons['SlpCode'] as String,
      sapDB: jsons['SapDB'] as String,
      ManagerFCM: jsons['ManagerFCM'].toString(),
      FCM: jsons['FCMToken'].toString(),
      U_CrpUsr: jsons['U_CrpUsr'].toString(),
      // ==null?"null":jsons['U_CrpUsr'].toString()
    );
  }
}
