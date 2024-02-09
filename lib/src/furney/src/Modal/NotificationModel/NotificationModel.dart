

// ignore_for_file: prefer_final_locals, omit_local_variable_types

import 'dart:convert';

class NotificationModel {
  NotificationModel(
      {required this.multicast_id,
      required this.failure,
     required this.result,
     required this.msg,
     required this.success,
      required this.statusCode,});

  int? multicast_id;
  int? success;
  int? failure;
  List<Result>? result;
  String? msg;
  int ? statusCode;

  factory NotificationModel.fromJson(String resp, int stcode) {
   
    if(stcode >= 200 && stcode <= 210){
       var jsons = json.decode(resp) as Map<String, dynamic>;
      var list = jsons['results']  as List; //jsonDecode
      List<Result> dataList = list
          .map((dynamic enquiries) => Result.fromJson(enquiries))
          .toList();
      return NotificationModel(
        multicast_id: jsons['multicast_id'] as int, 
        failure: jsons['failure'] as int, 
        result: dataList, 
        msg: 'Success', 
        success: jsons['success'] as int, 
        statusCode: stcode,
        );
  
    }else{
       return NotificationModel(
        multicast_id: null, 
        failure: null, 
        result: null, 
        msg: 'Something went wrong try again..!!', 
        success: null, 
        statusCode: stcode,
        );
    }
  }
}

class Result{

String? message_id;
String? error;

Result({
required  this.message_id,
required  this.error,
});
 
factory Result.fromJson(dynamic jsons) {  
    return Result(
      message_id: jsons['message_id'].toString(), 
      error: jsons['error'].toString(), 
      );
 }
 }
