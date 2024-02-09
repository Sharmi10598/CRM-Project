

// ignore_for_file: prefer_final_locals, omit_local_variable_types

import 'dart:convert';

class GetAvalCardCodeModel {
  GetAvalCardCodeModel(
      {required this.status,
      required this.message,
     required this.activitiesData,
     required this.error,
      required this.statusCode,});

  bool? status;
  String? message;
  List<GetAvailCardCodeData>? activitiesData;
  String? error;
  int ? statusCode;

  factory GetAvalCardCodeModel.fromJson(String resp, int stcode) {
    if(stcode >= 200 && stcode <= 210){
    var jsons = json.decode(resp) as Map<String, dynamic>;

        if (jsons['data'] != 'No data found') {
      var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      List<GetAvailCardCodeData> dataList = list
          .map((dynamic enquiries) => GetAvailCardCodeData.fromJson(enquiries))
          .toList();
      return GetAvalCardCodeModel(
        activitiesData: dataList,
        message: jsons['message'].toString(),
        status: jsons['status'] as bool, 
        error: null, 
        statusCode: stcode,
      );
    } else {
      return GetAvalCardCodeModel(
        message: jsons['message'].toString(),
        status: jsons['status'] as bool,
        activitiesData:null,
         error: jsons['data'].toString(), 
        statusCode: stcode,
      );
    }
    }else{
       return GetAvalCardCodeModel(
        message: null,
        status: null,
        activitiesData:null,
         error: resp, 
        statusCode: stcode,
      );
    }
  }
}

class GetAvailCardCodeData{
String ? lastcardcode;


GetAvailCardCodeData({
required  this.lastcardcode,
});
 
factory GetAvailCardCodeData.fromJson(dynamic jsons) {  
    return GetAvailCardCodeData(
      lastcardcode: jsons['lastcardcode'].toString(),
      );
 }
 }
