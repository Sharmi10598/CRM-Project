// ignore_for_file: omit_local_variable_types

// ignore_for_file: omit_local_variable_types
import 'dart:convert';
import 'dart:developer';

class SalesQuotModal {
  String? odatametadata;
  List<SalesQuotValue>? salesQuotValue;
  String? error;
  String? nextLink;

  SalesQuotModal({
    this.odatametadata,
    this.salesQuotValue,
    this.error,
    this.nextLink,
  });
  factory SalesQuotModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['data'].toString() != 'No data found'
        // ||  jsonDecode(jsons['data'].toString()) != null
        ) {
      log(jsonDecode(jsons['data'].toString()).toString());

      final list = jsonDecode(jsons['data'].toString()) as List; //jsonDecode
      List<SalesQuotValue> dataList = list
          .map((dynamic enquiries) => SalesQuotValue.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return SalesQuotModal(
        salesQuotValue: dataList,
        // odatametadata: jsons['odata.metadata'].toString(),
        // nextLink:  jsons['odata.nextLink'].toString(),
      );
    } else {
      // log(" jsons['data'].toString():::${jsons['data'].toString()}");
      return SalesQuotModal(
        odatametadata: null,
        error: jsons['data'].toString(),
        salesQuotValue: [],
      );
    }
  }

  factory SalesQuotModal.issue(Map<String, dynamic> jsons) {
    return SalesQuotModal(
      odatametadata: null,
      error:null,
    );
  }
  factory SalesQuotModal.exception(String e) {
    return SalesQuotModal(
      odatametadata: null,
      error: e,
    );
  }
}

class SalesQuotValue {
  int? docEntry;
  String? cardCode;
  String? cardName;
  int? DocNum;
  String? DocDate;
  int? transportationCode;
  String? documentStatus;
  String? cancelStatus;
  SalesQuotValue({
    required this.docEntry,
    required this.cardCode,
    required this.cardName,
    required this.DocNum,
    required this.DocDate,
    this.cancelStatus,
    required this.documentStatus,
  });
//{"DocEntry":52763,"DocNum":6684,"DocDate":"2024-01-25T00:00:00","CardCode":"D0022",
//"CardName":"HETNA HARDWARE - MOROG.","DocStatus":"O"}
  factory SalesQuotValue.fromJson(dynamic jsons) {
    return SalesQuotValue(
      docEntry: int.parse(jsons['DocEntry'].toString()),
      cardCode: jsons['CardCode'].toString(),
      cardName: jsons['CardName'].toString(),
      DocDate: jsons['DocDate'].toString(),
      DocNum: int.parse(jsons['DocNum'].toString()),
      documentStatus: jsons['DocStatus'].toString(),
      //  cancelStatus:jsons['CancelStatus'].toString(),
    );
  }
}
