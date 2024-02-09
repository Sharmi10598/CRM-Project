// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, unnecessary_string_interpolations, cascade_invocations, require_trailing_commas

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';


class CallGetAPi {
  static Future<Responce> getGlobalData(String methodname) async {
     Responce data = Responce();
    try {
      log(URL.url+methodname);// "Activities"
      final response = await http.get(
        Uri.parse(  URL.url+ methodname),
        headers: {
          'content-type': 'application/json',
          "cookie": 'B1SESSION=' + GetValues.sessionID.toString()
          },
 );
     
      print("customer details: " + response.body);
      print(response.statusCode);
     
    
          data.body = response.body;

          data.stcode = response.statusCode;

        //return GetAllSQModel.fromJson( response.body,response.statusCode);
        return data;
    } catch (e) {
      data.body = e.toString();

          data.stcode = 500;
          return data;
     // return GetAllSQModel.fromJson(e.toString(),500);
    }
  }
}

class Responce{
  String body = '';
  int stcode = 00;
}




// ignore_for_file: prefer_final_locals, omit_local_variable_types, prefer_single_quotes


class GetAllSQModel {

  static Future<GetAllSQModel> getValues(String meth)async{
    Responce res = Responce();

    res = await CallGetAPi.getGlobalData(meth);

   return GetAllSQModel.fromJson(res.body, res.stcode);

  }
  GetAllSQModel({
      required this.value,
     required this.errorMsg,
      required this.statusCode,
      required this.Error,
      required this.nextLink
      });

  String? errorMsg;
  int ? statusCode;
  List<ValueData> ? value;
  String? nextLink;
  Errors? Error;

  factory GetAllSQModel.fromJson(String resp, int stcode) {
    var jsons =   json.decode(resp) as Map<String, dynamic>;
    if(stcode >= 200 && stcode <= 210){
      var list = jsons['value']  as List;

      if(list.isEmpty){
          return GetAllSQModel(
        value: null,
         errorMsg: "No data..!!", 
        statusCode: stcode,
        Error:null,
        nextLink: null
      );
      }else{
          List<ValueData> dataList = list.map((dynamic enquiries) => ValueData.fromJson(enquiries))
          .toList();
           return GetAllSQModel(
        value: dataList,
         errorMsg: null, 
        statusCode: stcode,
        Error:null,
        nextLink: jsons['odata.nextLink'].toString()
      );
      }
     
   
    }else if(stcode >= 400 && stcode <= 410){
       return GetAllSQModel(
        value: null,
         errorMsg: null, 
        statusCode: stcode,
        Error:jsons["error"] ==null?null: Errors.fromJson(jsons["error"]),
        nextLink: null
      );
    }
    else {
       return GetAllSQModel(
        value: null,
         errorMsg: resp, 
        statusCode: stcode,
        Error:null,
        nextLink: null
      );
    }
  }
}

class ValueData{
  String? odata;
  int docEntry;
  int docnum;
  String docDate;
  String CardCode;
  String CardName;
  String docStatus;

   ValueData({
    required this.CardCode,
    required this.CardName,
    required this.docDate,
    required this.docEntry,
    required this.docStatus,
    required this.docnum,
    required this.odata
   });

     factory ValueData.fromJson(dynamic resp) {
      return ValueData(
        CardCode: resp["CardCode"].toString(), 
        CardName: resp["CardName"].toString(), 
        docDate: resp["DocDate"].toString(), 
        docEntry: resp["DocEntry"] as int, 
        docStatus: resp["DocStatus"].toString(), 
        docnum: resp["DocNum"] as int, 
        odata: resp["odata.etag"].toString()
        );
   
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
    this.Value
  });
   factory Message.fromJson(dynamic jsons) {
    return Message(
      Value: jsons['value'].toString(), 
       );
 }
}




