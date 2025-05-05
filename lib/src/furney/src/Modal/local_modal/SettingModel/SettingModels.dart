// {
//     "countryClass": {
//         "countryName": "Tanzania",
//         "queryURL": "http://102.69.167.106:1705/api/SellerKit",
//         "localURL": "http://102.69.167.106:80/Api/",
//         "reportURL": "http://102.69.167.106:84/api/"
//     },
//     "status": true,
//     "message": "Success"
// }

class SettingModelData {
  CountryClass? countryClass;
  bool? status;
  String? message;
  int? stsCode;
  String? excep;
  SettingModelData(
      {this.stsCode, this.countryClass, this.status, this.message, this.excep,});

  factory SettingModelData.fromJson(Map<String, dynamic> json, int statusCode) {
    if (json['countryClass'] != null) {
      return SettingModelData(
        countryClass: CountryClass.fromJson(json['countryClass']),
        status: json['status'] as bool,
        message: json['message'].toString(),
        stsCode: statusCode,
      );
    } else {
      return SettingModelData(
        status: json['status'] as bool,
        message: json['message'].toString(),
        stsCode: statusCode,
      );
    }
  }

  factory SettingModelData.issue(Map<String, dynamic> json, int statusCode) =>
      SettingModelData(
        status: json['status'] as bool,
        message: json['message'].toString(),
        stsCode: statusCode,
      );
  factory SettingModelData.exception(String e, int statusCode) =>
      SettingModelData(
        excep: e,
        stsCode: statusCode,
      );
  Map<String, dynamic> toJson() => {
        'countryClass': countryClass,
        'status': status,
        'message': message,
      };
}

class CountryClass {
  String countryName;
  String queryUrl;
  String localUrl;
  String reportUrl;
  bool schemeReq;

  CountryClass({
    required this.countryName,
    required this.queryUrl,
    required this.localUrl,
    required this.reportUrl,
    required this.schemeReq,
  });

  factory CountryClass.fromJson(dynamic json) => CountryClass(
        countryName: json['countryName'].toString(),
        queryUrl: json['queryURL'].toString(),
        localUrl: json['localURL'].toString(),
        reportUrl: json['reportURL'].toString(),
        schemeReq: json['schemeReq'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'countryName': countryName,
        'queryURL': queryUrl,
        'localURL': localUrl,
        'reportURL': reportUrl,
        'schemeReq': schemeReq,
      };
}
