

// ignore_for_file: prefer_final_locals, omit_local_variable_types

import 'dart:convert';

class GetcountModel {
  GetcountModel(
      {required this.status,
      required this.message,
     required this.activitiesData,
     required this.error,
      required this.statusCode,});

  bool? status;
  String? message;
  List<GetcountData>? activitiesData;
  String? error;
  int ? statusCode;

  factory GetcountModel.fromJson(String resp, int stcode) {
    if(stcode >= 200 && stcode <= 210){
    var jsons = json.decode(resp) as Map<String, dynamic>;

        if (jsons['data'] != 'No data found') {
      var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      List<GetcountData> dataList = list
          .map((dynamic enquiries) => GetcountData.fromJson(enquiries))
          .toList();
      return GetcountModel(
        activitiesData: dataList,
        message: jsons['message'].toString(),
        status: jsons['status'] as bool, 
        error: null, 
        statusCode: stcode,
      );
    } else {
      return GetcountModel(
        message: jsons['message'].toString(),
        status: jsons['status'] as bool,
        activitiesData:null,
         error: jsons['data'].toString(), 
        statusCode: stcode,
      );
    }
    }else{
       return GetcountModel(
        message: null,
        status: null,
        activitiesData:null,
         error: resp, 
        statusCode: stcode,
      );
    }
  }
}

class GetcountData{
int ? count;

GetcountData({
required  this.count,
});
 
factory GetcountData.fromJson(dynamic jsons) {  
    return GetcountData(
      count: jsons['Cnt']as int, 
      );
 }
 }
