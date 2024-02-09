import 'dart:convert';

InPaymentChartModal logindataFromJson(String str,int stcode) =>
    InPaymentChartModal.fromJson(json.decode(str) as Map<String, dynamic>,stcode);

class InPaymentChartModal {
  InPaymentChartModal(
      {required this.status,
      required this.message,
      required this.statusCode, this.CustomerData,
      this.error,
      this.exception,});

  bool? status;
  String? message;
  List<InPaymentChartData>? CustomerData;
  String? error;
  int statusCode;
  String? exception;

  factory InPaymentChartModal.fromJson(Map<String, dynamic> jsons,int StatusCode) {
    if (jsons['data'] != 'No data found') {
      final list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      // print(list);
      final dataList = list
          .map((dynamic enquiries) => InPaymentChartData.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return InPaymentChartModal(
        CustomerData: dataList,
        statusCode: StatusCode,
        message: jsons['msg'].toString(),
        status: jsons['status'] as bool,
      );
    } else {
      return InPaymentChartModal(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          statusCode: StatusCode,);
    }
  }
  factory InPaymentChartModal.issue(int Statuscode) {
    return InPaymentChartModal(
        status: null, message: null,statusCode: Statuscode,);
  }

  factory InPaymentChartModal.exception(String e,int statuscode) {
    return InPaymentChartModal(
        status: null,
        statusCode: statuscode,
        message: null,
        error: e,
        exception: e,);
  }
}

class InPaymentChartData {
  int slpcode;
  String slpname;
  double targetSales;
  double achSales;

  InPaymentChartData({
    required this.slpcode,
    required this.slpname,
    required this.targetSales,
    required this.achSales,
  });

  factory InPaymentChartData.fromJson(dynamic jsons) {
    return InPaymentChartData(
      slpcode: jsons['SlpCode'] as int,
      slpname: jsons['SlpName'].toString(),
      targetSales:
          jsons['Target Collection'] == null ? 0.0 : jsons['Target Collection'] as double,
      achSales: jsons['Ach Collection'] == null ? 0.0 : jsons['Ach Collection'] as double,
    );
  }
}
