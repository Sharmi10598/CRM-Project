import 'dart:convert';


VolumeChartModal logindataFromJson(String str,int stcode) =>
    VolumeChartModal.fromJson(json.decode(str) as Map<String, dynamic>,stcode);

class VolumeChartModal {
  VolumeChartModal(
      {required this.status,
      required this.message,
      required this.statuscode, this.CustomerData,
      this.error,
      this.exception,});
int statuscode;
  bool? status;
  String? message;
  List<VolumeChartData>? CustomerData;
  String? error;
  String? exception;

  factory VolumeChartModal.fromJson(Map<String, dynamic> jsons,int Statuscode) {
    if (jsons['data'] != 'No data found') {
      final list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      // print(list);
      final dataList = list
          .map((dynamic enquiries) => VolumeChartData.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return VolumeChartModal(
        CustomerData: dataList,
        message: jsons['msg'].toString(),
        status: jsons['status'] as bool,
        statuscode: Statuscode,
      );
    } else {
      return VolumeChartModal(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          statuscode: Statuscode,);
    }
  }
  factory VolumeChartModal.issue(int Statuscode) {
    return VolumeChartModal(
        status: null, message: null,
        statuscode: Statuscode,);
  }

  factory VolumeChartModal.exception(String e,int Statuscode) {
    return VolumeChartModal(
        status: null,
        message: null,
        error: e,
        exception: e,
        statuscode: Statuscode,);
  }
}

class VolumeChartData {
  int slpcode;
  String slpname;
  double targetSales;
  double achSales;

  VolumeChartData({
    required this.slpcode,
    required this.slpname,
    required this.targetSales,
    required this.achSales,
  });

  factory VolumeChartData.fromJson(dynamic jsons) {
    return VolumeChartData(
      slpcode: jsons['SlpCode'] as int,
      slpname: jsons['SlpName'].toString(),
      targetSales:
          jsons['Target Volume'] == null ? 0.0 : jsons['Target Volume'] as double,
      achSales: jsons['Target Volume'] == null ? 0.0 : jsons['Target Volume'] as double,
    );
  }
}
