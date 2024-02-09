

// ignore_for_file: prefer_final_locals, omit_local_variable_types

import 'dart:convert';

class GetCheckedINModel {
  GetCheckedINModel(
      {required this.status,
      required this.message,
     required this.activitiesData,
     required this.error,
      required this.statusCode,});

  bool? status;
  String? message;
  List<GetCheckedINData>? activitiesData;
  String? error;
  int ? statusCode;

  factory GetCheckedINModel.fromJson(String resp, int stcode) {
    if(stcode >= 200 && stcode <= 210){
    var jsons = json.decode(resp) as Map<String, dynamic>;

        if (jsons['data'] != 'No data found') {
      var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      List<GetCheckedINData> dataList = list
          .map((dynamic enquiries) => GetCheckedINData.fromJson(enquiries))
          .toList();
          
      return GetCheckedINModel(
        activitiesData: dataList,
        message: jsons['message'].toString(),
        status: jsons['status'] as bool, 
        error: null, 
        statusCode: stcode,
      );
    } else {
      return GetCheckedINModel(
        message: jsons['message'].toString(),
        status: jsons['status'] as bool,
        activitiesData:null,
         error: jsons['data'].toString(), 
        statusCode: stcode,
      );
    }
    }else{
       return GetCheckedINModel(
        message: null,
        status: null,
        activitiesData:null,
         error: resp, 
        statusCode: stcode,
      );
    }
  }
}

class GetCheckedINData{
  int? ClgCode;
String ? CardCode;
String ? CardName;
String ? VisitReg;
int ? CntctTime;
String ? CntctDate;
String? Details;
int? CntctSbjct;



GetCheckedINData({
required  this.CardCode,
required this.CardName,
required this.VisitReg,
required this.CntctTime,
required this.CntctDate,
required this.ClgCode,
required this.Details,
required this.CntctSbjct,

});
 
factory GetCheckedINData.fromJson(dynamic jsons) {  
    return GetCheckedINData(
      ClgCode: jsons['ClgCode']== null ? -1:jsons['ClgCode']as int, 
      CardCode: jsons['CardCode'] == null ? '':jsons['CardCode'] as String, 
      CardName: jsons['CardName']== null ? '':jsons['CardName'] as String, 
      VisitReg: jsons['VisitReg']== null ? '':jsons['VisitReg']as String, 
      CntctTime: jsons['CntctTime']== null ? -1:jsons['CntctTime']as int, 
      CntctDate: jsons['CntctDate']== null ? '':jsons['CntctDate']as String, 
      Details: jsons['Details']== null ? '':jsons['Details']as String, 
      CntctSbjct: jsons['CntctSbjct']== null ? -1:jsons['CntctSbjct']as int, 
      );
 }
 }
