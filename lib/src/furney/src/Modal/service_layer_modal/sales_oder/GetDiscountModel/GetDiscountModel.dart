

// ignore_for_file: prefer_single_quotes

import 'dart:convert';

Discountdata logindataFromJson(String str) => Discountdata.fromJson(json.decode(str)as Map<String,dynamic>);

//String logindataToJson(Logindata data) => json.encode(data.toJson());

class Discountdata {
    Discountdata({
         this.odataMetadata,
         this.price,
         this.discount,
        this.error,
        this.exception,
    });

    String? odataMetadata;
    double? price;
    double?discount;
    Error? error ;
    String? exception;

    factory Discountdata.fromJson(Map<String, dynamic> json) {
          return Discountdata(
        odataMetadata: json["odata.metadata"] as String,
        price: json["Price"] as double,
        discount: json["Discount"] as double,
    );
      // }
     }
 factory Discountdata.exception(String e) {
      return Discountdata(
       exception: e,
          );
    
  }

   factory Discountdata.error(Map<String, dynamic> json) {
      return Discountdata(
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