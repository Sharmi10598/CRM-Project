

// ignore_for_file: prefer_final_locals, omit_local_variable_types

import 'dart:convert';
import 'package:ultimate_bundle/src/furney/src/DB/DBModal/GetApprovedCust.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class GetActivityApvdModel {
  GetActivityApvdModel(
      {required this.status,
      required this.message,
     required this.activitiesData,
     required this.error,
      required this.statusCode,});

  bool? status;
  String? message;
  List<GetActivityApvdData>? activitiesData;
  String? error;
  int ? statusCode;

  factory GetActivityApvdModel.fromJson(String resp, int stcode) {
    if(stcode >= 200 && stcode <= 210){
    var jsons = json.decode(resp) as Map<String, dynamic>;

        if (jsons['data'] != 'No data found') {
      var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      List<GetActivityApvdData> dataList = list
          .map((dynamic enquiries) => GetActivityApvdData.fromJson(enquiries))
          .toList();
      return GetActivityApvdModel(
        activitiesData: dataList,
        message: jsons['message'].toString(),//D3128
        status: jsons['status'] as bool, 
        error: null, 
        statusCode: stcode,
      );
    } else {
      return GetActivityApvdModel(
        message: jsons['data'].toString(),
        status: jsons['status'] as bool,
        activitiesData:null,
         error: jsons['data'].toString(), 
        statusCode: stcode,
      );
    }
    }else{
       return GetActivityApvdModel(
        message: resp,
        status: null,
        activitiesData:null,
         error: resp, 
        statusCode: stcode,
      );
    }
  }
}

class GetActivityApvdData{
int ? ClgCode;
String? CardCode;
String? CardName;
String? Name;
String? Details;
String? status;


GetActivityApvdData({
required  this.ClgCode,
required  this.CardCode,
required  this.CardName,
required  this.Name,
required this.Details,
this.status,
});
 
factory GetActivityApvdData.fromJson(dynamic jsons) {  
    return GetActivityApvdData(
      ClgCode: jsons['ClgCode']as int, 
      CardCode: jsons['CardCode']as String, 
      CardName: jsons['CardName']as String, 
      Name:  jsons['Name']==null?'':jsons['Name'].toString(), 
      Details:  jsons['Details']==null?'':jsons['Details'].toString(),);}
      
  Map<String , Object?> toMap()=> {
  ApprovedCustomer.CardCode:CardCode,
  ApprovedCustomer.CardName:CardName,
  ApprovedCustomer.ClgCode:ClgCode,
  ApprovedCustomer.Details:Details,
  ApprovedCustomer.Name:Name,
  ApprovedCustomer.status: status,
  ApprovedCustomer.slpCode:GetValues.slpCode,
};
}
