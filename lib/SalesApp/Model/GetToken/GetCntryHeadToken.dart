

// ignore_for_file: prefer_final_locals, omit_local_variable_types

import 'dart:convert';

class GetCntyheadModel {
  GetCntyheadModel(
      {required this.status,
      required this.message,
     required this.activitiesData,
     required this.error,
      required this.statusCode,});

  bool? status;
  String? message;
  List<GetCntyheadData>? activitiesData;
  String? error;
  int ? statusCode;

  factory GetCntyheadModel.fromJson(String resp, int stcode) {
    if(stcode >= 200 && stcode <= 210){
    var jsons = json.decode(resp) as Map<String, dynamic>;

        if (jsons['data'] != 'No data found') {
      var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      List<GetCntyheadData> dataList = list
          .map((dynamic enquiries) => GetCntyheadData.fromJson(enquiries))
          .toList();
          
      return GetCntyheadModel(
        activitiesData: dataList,
        message: jsons['message'].toString(),
        status: jsons['status'] as bool, 
        error: null, 
        statusCode: stcode,
      );
    } else {
      return GetCntyheadModel(
        message: jsons['message'].toString(),
        status: jsons['status'] as bool,
        activitiesData:null,
         error: jsons['data'].toString(), 
        statusCode: stcode,
      );
    }
    }else{
       return GetCntyheadModel(
        message: null,
        status: null,
        activitiesData:null,
         error: resp, 
        statusCode: stcode,
      );
    }
  }
}

class GetCntyheadData{

String ? token;




GetCntyheadData({
required  this.token,


});
 
factory GetCntyheadData.fromJson(dynamic jsons) {  
    return GetCntyheadData( 
      token: jsons['FCMToken'] == null ? '':jsons['FCMToken'] as String, 
      );
 }
 }
