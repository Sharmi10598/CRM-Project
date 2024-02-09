// ignore_for_file: omit_local_variable_types, prefer_final_locals, avoid_redundant_argument_values, prefer_single_quotes, file_names

class SalesPersonModal {
  String? odatametadata;
  List<SalesPersonValue>? salesPersonvalue;
  String? error;
  SalesPersonModal({
    required this.odatametadata,
    this.salesPersonvalue,
    this.error,
  });
  factory SalesPersonModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['value'] != null) {
      var list = jsons['value'] as List; //jsonDecode
      // print(list);
      List<SalesPersonValue> dataList = list
          .map((dynamic enquiries) => SalesPersonValue.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return SalesPersonModal(
          salesPersonvalue: dataList,
          odatametadata: jsons['odata.metadata'].toString(),);
    } else {
      return SalesPersonModal(
        odatametadata: null,
        salesPersonvalue: null,
      );
    }
  }

  factory SalesPersonModal.issue(String e) {
    return SalesPersonModal(odatametadata: null, salesPersonvalue: null, error: e);
  }
}

class SalesPersonValue {
  String? slpName;

  SalesPersonValue({
    this.slpName,
  });

  factory SalesPersonValue.fromJson(dynamic jsons) {
    return SalesPersonValue(
      slpName: jsons['SalesEmployeeName'].toString(),
    );
  }
}
