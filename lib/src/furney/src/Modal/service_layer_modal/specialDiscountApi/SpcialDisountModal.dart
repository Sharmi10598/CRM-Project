class SpecialDisCountModal {
  String? odatametadata;
  List<SpecialValue>? specialValue;
  String? error;
  SpecialDisCountModal({
    required this.odatametadata,
    this.specialValue,
    this.error,
  });
  factory SpecialDisCountModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['value'] != null && jsons['value'].toString().isNotEmpty) {
      final list = jsons['value'] as List;
      final dataList = list
          .map((dynamic enquiries) => SpecialValue.fromJson(enquiries))
          .toList();
      return SpecialDisCountModal(
        specialValue: dataList,
        odatametadata: jsons['odata.metadata'].toString(),
      );
    } else {
      return SpecialDisCountModal(
        odatametadata: null,
        specialValue: [],
      );
    }
  }

  factory SpecialDisCountModal.issue(String e) {
    return SpecialDisCountModal(
      odatametadata: null,
      specialValue: [],
      error: e,
    );
  }
}

class SpecialValue {
  double? discount;
  double? price;

  SpecialValue({
    required this.discount,
    required this.price,
  });

  factory SpecialValue.fromJson(dynamic jsons) {
    return SpecialValue(
      discount: jsons['Discount'] as double,
      price: jsons['Price'] as double,
    );
  }
}
