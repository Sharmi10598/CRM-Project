

// ignore_for_file: prefer_final_locals, omit_local_variable_types

import 'dart:convert';

import 'package:ultimate_bundle/src/furney/src/DB/DBModal/GetApprovedCust.dart';

class GetActiveProject {
  GetActiveProject(
      {required this.status,
      required this.message,
     required this.activitiesData,
     required this.error,
      required this.statusCode,});

  bool? status;
  String? message;
  List<GetProjectData>? activitiesData;
  String? error;
  int ? statusCode;

  factory GetActiveProject.fromJson(String resp, int stcode) {
    if(stcode >= 200 && stcode <= 210){
    var jsons = json.decode(resp) as Map<String, dynamic>;

        if (jsons['data'] != 'No data found') {
      var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      List<GetProjectData> dataList = list
          .map((dynamic enquiries) => GetProjectData.fromJson(enquiries))
          .toList();
      return GetActiveProject(
        activitiesData: dataList,
        message: jsons['message'].toString(),
        status: jsons['status'] as bool, 
        error: null, 
        statusCode: stcode,
      );
    } else {
      return GetActiveProject(
        message: jsons['message'].toString(),
        status: jsons['status'] as bool,
        activitiesData:null,
         error: jsons['data'].toString(), 
        statusCode: stcode,
      );
    }
    }else{
       return GetActiveProject(
        message: null,
        status: null,
        activitiesData:null,
         error: resp, 
        statusCode: stcode,
      );
    }
  }
}

class GetProjectData{
String ? projectName;

GetProjectData({
required  this.projectName,
});
 
factory GetProjectData.fromJson(dynamic jsons) {  
    return GetProjectData(
      projectName: jsons['name'].toString(), 
      );
 }

    Map<String, Object?> toMap() => {
        GetProjectModel.projectName: projectName,
      };
 }
