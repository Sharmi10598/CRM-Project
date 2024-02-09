

// ignore_for_file: file_names

import 'dart:convert';

SeriesModal logindataFromJson(String str) => SeriesModal.fromJson(json.decode(str)as Map<String,dynamic>);

class SeriesModal {
    SeriesModal({
         this.Series,
        this.error,
        this.exception,
    });

    int? Series;
    Error? error ;
    String? exception;

    factory SeriesModal.fromJson(Map<String, dynamic> json) {
          return SeriesModal(
       
        Series: json['Series'] as int,
    );
     }
 factory SeriesModal.issue(String e) {
      return SeriesModal(
      
        exception: e,
          );
    
  }

   factory SeriesModal.error(Map<String, dynamic> json) {
      return SeriesModal(
     
        error:Error.fromJson(json['error']),
          );
    
  }
 
}

class Error{
  int? code;
  Message?message;
 Error({
   this.code,
  this.message,
 });

  factory Error.fromJson(dynamic jsons) {
    return Error(
      code: jsons['code']as int,
     message: Message.fromJson(jsons['message']),
       );
 }
}
 class Message{
  String ?lang;
  String ? value; 
 Message({
   this.lang,
   this.value,
 });

  factory Message.fromJson(dynamic jsons) {
    return Message(
    //  groupCode: jsons['GroupCode'] as int, 
      lang: jsons['lang']as String,
      value: jsons['value'] as String,
   
       );
 }
 }