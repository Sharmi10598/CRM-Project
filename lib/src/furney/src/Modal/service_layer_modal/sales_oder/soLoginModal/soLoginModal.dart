

// ignore_for_file: file_names

import 'dart:convert';

SoLogindata logindataFromJson(String str) => SoLogindata.fromJson(json.decode(str)as Map<String,dynamic>);

//String logindataToJson(Logindata data) => json.encode(data.toJson());

class SoLogindata {
    SoLogindata({
         this.odataMetadata,
         this.sessionId,
         this.version,
         this.sessionTimeout,
        this.error,
        this.exception,
    });

    String? odataMetadata;
    String? sessionId;
    String? version;
    int? sessionTimeout;
    Error? error ;
    String? exception;

    factory SoLogindata.fromJson(Map<String, dynamic> json) {
    //   if(json['error'] != null){
    //     print("data1");
    //        return Logindata(
    //     odataMetadata: null,
    //     sessionId: null,
    //     version: null,
    //     sessionTimeout: null,
    //     error: Error.fromJson(json['error']),
    //     exception: null
    // );
    //   }
      // else{
        //  print("data2");
          return SoLogindata(
        odataMetadata: json['odata.metadata'] as String,
        sessionId: json['SessionId'] as String,
        version: json['Version'] as String,
        sessionTimeout: json['SessionTimeout'] as int,
        // ignore: avoid_redundant_argument_values
        error:null,
    );
      // }
     }
 factory SoLogindata.issue(String e) {
      return SoLogindata(
       exception: e,
          );
    
  }

   factory SoLogindata.error(Map<String, dynamic> json) {
      return SoLogindata(
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