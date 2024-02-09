

// ignore_for_file: prefer_final_locals, omit_local_variable_types

import 'dart:convert';

import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/SalesQutApiNew/GetAllSalesQutApi.dart';

class GetAllSalesQuaD {
  GetAllSalesQuaD(
      {required this.status,
      required this.message,
     required this.activitiesData,
     required this.error,
      required this.statusCode,});

  bool? status;
  String? message;
  List<ValueData>? activitiesData;
  String? error;
  int ? statusCode;

  factory GetAllSalesQuaD.fromJson(String resp, int stcode) {
    if(stcode >= 200 && stcode <= 210){
    var jsons = json.decode(resp) as Map<String, dynamic>;

        if (jsons['data'] != 'No data found'&&jsons['data'] !=null) {
      var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      List<ValueData> dataList = list
          .map((dynamic enquiries) => ValueData.fromJson(enquiries))
          .toList();
      return GetAllSalesQuaD(
        activitiesData: dataList,
        message: jsons['message'].toString(),
        status: jsons['status'] as bool, 
        error: null, 
        statusCode: stcode,
      );
    } else {
      return GetAllSalesQuaD(
        message: jsons['msg'].toString(),
        status: jsons['status'] as bool,
        activitiesData:null,
         error: jsons['msg'].toString(), 
        statusCode: stcode,
      );
    }
    }else{
       return GetAllSalesQuaD(
        message: null,
        status: null,
        activitiesData:null,
         error: resp, 
        statusCode: stcode,
      );
    }
  }
}

