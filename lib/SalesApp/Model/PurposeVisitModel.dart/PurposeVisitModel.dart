

// ignore_for_file: prefer_final_locals, omit_local_variable_types

import 'dart:convert';

class PurposeVisitModel {
  PurposeVisitModel(
      {required this.status,
      required this.message,
     required this.purposeData,
     required this.error,
      required this.statusCode,});

  bool? status;
  String? message;
  List<PurposeVisitData>? purposeData;
  String? error;
  int ? statusCode;

  factory PurposeVisitModel.fromJson(String resp, int stcode) {
    if(stcode >= 200 && stcode <= 210){
    var jsons =   json.decode(resp) as Map<String, dynamic>;

        if (jsons['data'] != 'No data found') {
      var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      List<PurposeVisitData> dataList = list
          .map((dynamic enquiries) => PurposeVisitData.fromJson(enquiries))
          .toList();
      return PurposeVisitModel(
        purposeData: dataList,
        message: jsons['message'].toString(),
        status: jsons['status'] as bool, 
        error: null, 
        statusCode: stcode,
      );
    } else {
      return PurposeVisitModel(
        message: jsons['message'].toString(),
        status: jsons['status'] as bool,
        purposeData:null,
         error: null, 
        statusCode: stcode,
      );
    }
    }else{
       return PurposeVisitModel(
        message: null,
        status: null,
        purposeData:null,
         error: resp, 
        statusCode: stcode,
      );
    }
  
  }

}

class PurposeVisitData{
int ? Code;
int? Type;
String? Name;
String ?DataSource;
int?UserSign;
// {\"Code\":1,\"Name\":\"01\",\"Type\":-1,\"DataSource\":\"I\",\"UserSign\":72,
// \"Active\":\"Y\"}
String? Active;


PurposeVisitData({
required  this.Code,
required  this.Type,
required  this.Name,
required  this.DataSource,
required  this.UserSign,
required  this.Active,
});
  //  slpcode: jsons['SlpCode']as int,
  //     slpname: 
factory PurposeVisitData.fromJson(dynamic jsons) {  
    return PurposeVisitData(
      Code:  jsons['Code']as int, 
      Type:  jsons['Type']as int, 
      Name: jsons['Name'].toString(),
      DataSource: jsons['DataSource'].toString(),
      UserSign:  jsons['UserSign']as int, 
      Active: jsons['Active'].toString(), 
      );
 }
 }
