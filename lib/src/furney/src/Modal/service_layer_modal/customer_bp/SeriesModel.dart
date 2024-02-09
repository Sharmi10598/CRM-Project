

// ignore_for_file: prefer_final_locals, omit_local_variable_types, require_trailing_commas

import 'dart:convert';

class SeriesModel {
  SeriesModel({
    required this.status,
    required this.message,
    required this.groupcustData,
    required this.statusCode
    });

  bool? status;
  String? message;
  List<SeriesModelData>? groupcustData;
  int ? statusCode;

  factory SeriesModel.fromJson(String resp, int stcode) {
    if(stcode >= 200 && stcode <= 210){
    var jsons = json.decode(resp) as Map<String, dynamic>;

        if (jsons['data'] != 'No data found') {
      var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      List<SeriesModelData> dataList = list
          .map((dynamic enquiries) => SeriesModelData.fromJson(enquiries))
          .toList();
      return SeriesModel(
        groupcustData: dataList,
        message: jsons['message'].toString(),
        status: jsons['status'] as bool, 
        statusCode: stcode,
      );
    } else {
      return SeriesModel(
        message: jsons['data'].toString(),
        status: jsons['status'] as bool,
        groupcustData:null,
        statusCode: stcode,
      );
    }
    }else{
       return SeriesModel(
        message: resp,
        status: null,
        groupcustData:null,
        statusCode: stcode,
      );
    }
  }
}

class SeriesModelData{
  int? Series;
String ? SeriesName;

SeriesModelData({
required  this.Series,
required this.SeriesName,
});
     
factory SeriesModelData.fromJson(dynamic jsons) {  
    return SeriesModelData(
    Series:jsons['Series']==null? 0 : jsons['Series']as int,
    SeriesName:  jsons['SeriesName']==null? '' : jsons['SeriesName']as String);}}
