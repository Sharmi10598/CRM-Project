// ignore_for_file: prefer_final_locals, omit_local_variable_types, prefer_single_quotes, prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class SchemeQuteModal {
  SchemeQuteModal(
      {required this.status,
      required this.message,
      required this.statuscode, this.saleOrder,
      this.exception,});

  bool? status;
  String? message;
  List<SchemeQuteModalData>? saleOrder;
  String? exception;
  int statuscode;

  factory SchemeQuteModal.fromJson(Map<String, dynamic> jsons, int Statuscode) {
    if (jsons['saleQuoatation'] != null) {
      // log("stcode1"+Statuscode.toString());
      var list = jsons['saleQuoatation'] as List;
      //jsonDecode(jsons['data'] as String) as List; //jsonDecode
      // print(list);
      List<SchemeQuteModalData> dataList = list
          .map((dynamic enquiries) => SchemeQuteModalData.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return SchemeQuteModal(
          saleOrder: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          statuscode: Statuscode,);
    } else {
      log("stcode" + Statuscode.toString());
      return SchemeQuteModal(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          statuscode: Statuscode,);
    }
  }
  factory SchemeQuteModal.issue(int statuscode) {
    return SchemeQuteModal(
        status: null, message: null, statuscode: statuscode,);
  }

  factory SchemeQuteModal.exception(String e, int statuscode) {
    return SchemeQuteModal(
        status: null,
        message: null,
        exception: e,
        statuscode: statuscode,);
  }
}

class SchemeQuteModalData {
  int docEntry;
  String schemeEntry;
  int lineNum;
  double discPer;
  double discVal;

  SchemeQuteModalData(
      {required this.docEntry,
      required this.schemeEntry,
      required this.lineNum,
      required this.discPer,
      required this.discVal,});

  factory SchemeQuteModalData.fromJson(dynamic jsons) {
    return SchemeQuteModalData(
      docEntry: int.parse(jsons['docEntry'].toString()),
      schemeEntry: jsons['schemeEntry'].toString(),
      lineNum: int.parse(jsons['lineNum'].toString()),
      discPer: double.parse(jsons['discPer'].toString()),
      discVal: double.parse(jsons['discVal'].toString()),
    );
  }
}

// for api

class SalesQuteScheme {
  String lineno;
  String ItemCode;
  String Quantity;
  String PriceBefDi;
  String UCartons;
  String balance;
  String customer;

  SalesQuteScheme(
      {required this.ItemCode,
      required this.PriceBefDi,
      required this.Quantity,
      required this.UCartons,
      required this.lineno,
      required this.balance,
      required this.customer,});

  Map<String, dynamic> toMap() {
    Map<String, String> map = {
      "LineNum": lineno,
      "ItemCode": ItemCode,
      "Quantity": Quantity,
      "PriceBefDi": PriceBefDi,
      "U_Cartons": UCartons,
      "Balance": balance,
      "Customer": customer,
      "Warehouse": GetValues.branch.toString(),
    };

    return map;
  }

  //   Map<String, dynamic> tojson() {
  //   Map<String, String> map = {
  //     "ItemCode": itemCode,
  //     "ItemDescription": itemName,
  //     "DiscountPercent": discounpercent.toString(),
  //     "TaxCode": taxCode.toString(),
  //     "Quantity": qty.toString(),
  //     "UnitPrice": price.toString(),
  //     "Currency": "TZS",
  //     "ShipToCode": LogisticOrderState.shipto.toString(),
  //     "WarehouseCode": GetValues.branch.toString(),
  //   };
  //   return map;
  // }

  //  "LineNum": "1",
  //           "ItemCode": "1000002D",
  //           "Quantity": "1000.000000",
  //           "PriceBefDi": "18000.00000",
  //           "UCartons": "0"
}
