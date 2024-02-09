

// ignore_for_file: prefer_final_locals, omit_local_variable_types

import 'dart:convert';

class GetSalesEmpIDModel {
  GetSalesEmpIDModel(
      {required this.status,
      required this.message,
     required this.purposeData,
     required this.error,
      required this.statusCode,});

  bool? status;
  String? message;
  List<GetSalesEmpData>? purposeData;
  String? error;
  int ? statusCode;

  factory GetSalesEmpIDModel.fromJson(String resp, int stcode) {
    if(stcode >= 200 && stcode <= 210){
    var jsons =   json.decode(resp) as Map<String, dynamic>;

        if (jsons['data'] != 'No data found') {
      var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      List<GetSalesEmpData> dataList = list
          .map((dynamic enquiries) => GetSalesEmpData.fromJson(enquiries))
          .toList();
      return GetSalesEmpIDModel(
        purposeData: dataList,
        message: jsons['message'].toString(),
        status: jsons['status'] as bool, 
        error: null, 
        statusCode: stcode,
      );
    } else {
      return GetSalesEmpIDModel(
        message: jsons['message'].toString(),
        status: jsons['status'] as bool,
        purposeData:null,
         error: null, 
        statusCode: stcode,
      );
    }
    }else{
       return GetSalesEmpIDModel(
        message: null,
        status: null,
        purposeData:null,
         error: resp, 
        statusCode: stcode,
      );
    }
  }
}

class GetSalesEmpData{
int ? slpcode;
String? slpname;

GetSalesEmpData({
required  this.slpcode,
required  this.slpname,
});
 
factory GetSalesEmpData.fromJson(dynamic jsons) {  
    return GetSalesEmpData(
      slpcode:  jsons['slpcode']as int, 
      slpname: jsons['slpname'].toString(),
      );
 }
 }
