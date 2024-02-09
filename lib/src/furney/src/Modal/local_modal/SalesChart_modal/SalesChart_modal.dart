import 'dart:convert';
import 'dart:developer';

SalesChartModal logindataFromJson(String str,int stcode) =>
    SalesChartModal.fromJson(json.decode(str) as Map<String, dynamic>,stcode);

class SalesChartModal {
  SalesChartModal(
      {required this.status,
      required this.message,
      required this.statuscode, this.CustomerData,
      this.error,
      this.exception,});

  bool? status;
  String? message;
  List<SalesChartData>? CustomerData;
  String? error;
  String? exception;
  int statuscode;

  factory SalesChartModal.fromJson(Map<String, dynamic> jsons,int Statuscode) {
    if (jsons['data'] != 'No data found') {
      log('stcode1$Statuscode');
      final list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      // print(list);
      final dataList = list
          .map((dynamic enquiries) => SalesChartData.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return SalesChartModal(
        CustomerData: dataList,
        message: jsons['msg'].toString(),
        status: jsons['status'] as bool,
        statuscode: Statuscode,

      );
    } else {
       log('stcode$Statuscode');
      return SalesChartModal(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          statuscode: Statuscode,);
    }
  }
  factory SalesChartModal.issue(int statuscode) {
    return SalesChartModal(
        status: null,
         message: null,statuscode: statuscode,);
  }

  factory SalesChartModal.exception(String e,int statuscode) {
    return SalesChartModal(
        status: null,
        message: null,
        error: e,
        exception: e,
        statuscode:statuscode,);
  }
}

class SalesChartData {
  int slpcode;
  String slpname;
  double targetSales;
  double achSales;

  SalesChartData({
    required this.slpcode,
    required this.slpname,
    required this.targetSales,
    required this.achSales,
  });

  factory SalesChartData.fromJson(dynamic jsons) {
    return SalesChartData(
      slpcode: jsons['SlpCode'] as int,
      slpname: jsons['SlpName'].toString(),
      targetSales:
          jsons['Target Sales'] == null ? 0.0 : jsons['Target Sales'] as double,
      achSales: jsons['Ach Sales'] == null ? 0.0 : jsons['Ach Sales'] as double,
    );
  }
}
