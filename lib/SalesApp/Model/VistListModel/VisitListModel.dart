

// ignore_for_file: prefer_final_locals, omit_local_variable_types, prefer_single_quotes, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';

class VistListModel {
  VistListModel({required this.status,
      required this.message,
     required this.purposeData,
     required this.error,
      required this.statusCode,});

  bool? status;
  String? message;
  List<GetVisitListData>? purposeData;
  String? error;
  int ? statusCode;

  factory VistListModel.fromJson(String resp, int stcode) {
    if(stcode >= 200 && stcode <= 210){
    var jsons =   json.decode(resp) as Map<String, dynamic>;
  log("json: "+jsons.toString());
        if (jsons['data'] != 'No data found') {
      var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      List<GetVisitListData> dataList = list
          .map((dynamic enquiries) => GetVisitListData.fromJson(enquiries))
          .toList();
      return VistListModel(
        purposeData: dataList,
        message: jsons['msg'].toString(),
        status: jsons['status'] as bool, 
        error: null, 
        statusCode: stcode,
      );
    } else {
      return VistListModel(
        message: jsons['data'].toString(),
        status: jsons['status'] as bool,
        purposeData:null,
         error: null, 
        statusCode: stcode,
      );
    }
    }else{
       return VistListModel(
        message: null,
        status: null,
        purposeData:null,
         error: resp, 
        statusCode: stcode,
      );
    }
  }
}

class GetVisitListData{
int ? ClgCode;
String? CardCode;
String? CardName;
String? Name;
String? Details;
String? U_Status;
String? VisitStatus;
String? LastVisit;
String? plannedDate;
String? plannedTime;
String? CntctSbjct;


GetVisitListData({
required  this.ClgCode,
required  this.CardCode,
required  this.CardName,
required  this.Name,
required  this.Details,
required  this.U_Status,
required this.VisitStatus,
required this.LastVisit,
required this.CntctSbjct,
required this.plannedTime,
required this.plannedDate,
});
 
factory GetVisitListData.fromJson(dynamic jsons) {  
    return GetVisitListData(
      ClgCode:  jsons['ClgCode']as int, 
      CardCode: jsons['CardCode'].toString(),
      CardName: jsons['CardName'].toString(),
      Name: jsons['Name'].toString(),
      Details: jsons['Details'].toString(),
      U_Status: jsons['U_Status'].toString(), 
      LastVisit: jsons['LastVisit'].toString(), 
      VisitStatus: jsons['VisitStatus'].toString(), 
      CntctSbjct: jsons['CntctSbjct'].toString(),
      plannedTime: jsons['U_PlanTime'].toString(),
      plannedDate: jsons['U_PlanDate'].toString(),
      );
 }
 }
