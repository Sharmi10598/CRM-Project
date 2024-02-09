

// ignore_for_file: prefer_final_locals, omit_local_variable_types, prefer_single_quotes

import 'dart:convert';
import 'dart:developer';

class PatchVisitModel {
  PatchVisitModel(
      {
     required this.Msg,
      required this.statusCode,
      required this.ErrorMsg,
      });

  String? Msg;
  int ? statusCode;
  Errors? ErrorMsg;

  factory PatchVisitModel.fromJson(String resp, int stcode) {
    if(stcode >= 200 && stcode <= 210){
      return PatchVisitModel(
         Msg: "Successfully Approved..!!", 
        statusCode: stcode,
        ErrorMsg:null,
      );
    }else if(stcode >= 400 && stcode <= 410){
    var jsons =   json.decode(resp) as Map<String, dynamic>;
    log(jsons.toString());
       return PatchVisitModel(
         Msg: null, 
        statusCode: stcode,
        ErrorMsg:jsons["error"] ==null?null: Errors.fromJson(jsons["error"]),
      );
    }   
    else {
       return PatchVisitModel(
         Msg: resp, 
        statusCode: stcode,
        ErrorMsg:null,
      );
    }
  }
}

class Errors{
String? Code;
 Message ?message;

Errors({
   this.Code,
   this.message,
});

 factory Errors.fromJson(dynamic jsons) {
    return Errors(
      Code: jsons['code'].toString(), 
      message:Message.fromJson(jsons['message']), 
       );
 }
}

class Message{
  String? Value;
  Message({
    this.Value,
  });
   factory Message.fromJson(dynamic jsons) {
    return Message(
      Value: jsons['value'].toString(), 
       );
 }
}



