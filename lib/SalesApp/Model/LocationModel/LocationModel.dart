

// ignore_for_file: prefer_final_locals, omit_local_variable_types, require_trailing_commas

import 'dart:convert';

class GetLocDetModel {
  GetLocDetModel(
      {required this.status,
      required this.message,
     required this.purposeData,
     required this.error,
      required this.statusCode});

  bool? status;
  String? message;
  List<GetLocDetData>? purposeData;
  String? error;
  int ? statusCode;

  factory GetLocDetModel.fromJson(String resp, int stcode) {
    if(stcode >= 200 && stcode <= 210){
    var jsons =   json.decode(resp) as Map<String, dynamic>;

        if (jsons['data'] != 'No data found') {
      var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      List<GetLocDetData> dataList = list
          .map((dynamic enquiries) => GetLocDetData.fromJson(enquiries))
          .toList();
      return GetLocDetModel(
        purposeData: dataList,
        message: jsons['message'].toString(),
        status: jsons['status'] as bool, 
        error: null, 
        statusCode: stcode,
      );
    } else {
      return GetLocDetModel(
        message: jsons['data'].toString(),
        status: jsons['status'] as bool,
        purposeData:null,
         error: null, 
        statusCode: stcode,
      );
    }
    }else{
       return GetLocDetModel(
        message: null,
        status: null,
        purposeData:null,
         error: resp, 
        statusCode: stcode,
      );
    }
  }
}

class GetLocDetData{
int ? ClgCode;
String? CardCode;
String? CardName;
String? Purpose;
String? U_PlanDate;
String? U_Latitude;
String? U_Longitude;

GetLocDetData({
required  this.CardCode,
required  this.ClgCode,
required  this.CardName,
required  this.Purpose,
required  this.U_Latitude,
required  this.U_Longitude,
required  this.U_PlanDate,
});
   
factory GetLocDetData.fromJson(dynamic jsons) {  
    return GetLocDetData(
      CardCode: jsons['CardCode'].toString(), 
      ClgCode:  jsons['ClgCode']as int, 
      CardName: jsons['CardName'].toString(), 
      Purpose: jsons['Purpose'].toString(), 
      U_Latitude: jsons['U_Latitude'].toString(), 
      U_Longitude: jsons['U_Longitude'].toString(), 
      U_PlanDate: jsons['U_PlanDate'].toString()
      );}}
