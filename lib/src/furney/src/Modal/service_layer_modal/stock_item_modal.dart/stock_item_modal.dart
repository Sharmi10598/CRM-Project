// ignore_for_file: omit_local_variable_types

class StockItemModal {
  String? odatametadata;
  List<StockValue>? value;
  String? error;
  String? nextURl;
  StockItemModal({
    required this.odatametadata,
    this.value,
    this.error,
    this.nextURl,
  });
  factory StockItemModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['value'] != null) {
      final list = jsons['value'] as List; //jsonDecode
      // print(list);
      final List<StockValue> dataList = list
          .map((dynamic enquiries) => StockValue.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return StockItemModal(
        value: dataList,
        odatametadata: jsons['odata.metadata'].toString(),
        nextURl: jsons['odata.nextLink'].toString(),
      );
    } else {
      return StockItemModal(
        odatametadata: null,
      );
    }
  }

  factory StockItemModal.issue(String e) {
    return StockItemModal(
      odatametadata: null,
      error: e,
    );
  }
}

class StockValue {
  String? itemCode;
  String? itemName;
  double? quantityOnStock;
// String ?cardType;
// String ?phone1;
// String? phone2;
// double currentAccountBalance;
// double openDeliveryNotesBalance;
// dynamic creditLimit;
// dynamic priceListNum;
// String? emailAddress;
// String? website;
// String? contactPerson;
// String? billToState;
// String? shipToState;
  StockValue({
    required this.itemCode,
    required this.itemName,
    required this.quantityOnStock,
    //  this.cardName,
    // required this.phone1,
    // required this.phone2,
    // required this.currentAccountBalance,
    // required this.openDeliveryNotesBalance,
    // required this.creditLimit,
    // required this.priceListNum,
    // required this.emailAddress,
    // required this.website,
    // required this.contactPerson,
    // required this.billToState,
    // required this.shipToState
  });

  factory StockValue.fromJson(dynamic jsons) {
    return StockValue(
      //  groupCode: jsons['GroupCode'] as int,
      itemCode: jsons['ItemCode'] as String,
      itemName: jsons['ItemName'].toString(),
      quantityOnStock: jsons['QuantityOnStock'] as double,
      // phone1:  jsons['phone1'].toString(),
      // phone2:  jsons['phone2'].toString(),
      //  currentAccountBalance:  jsons['CurrentAccountBalance'] as double,
      //  openDeliveryNotesBalance:  jsons['OpenDeliveryNotesBalance'] as double,
      //  creditLimit: jsons['CreditLimit'],
      //  priceListNum:jsons["PriceListNum"],
      //  emailAddress:jsons['EmailAddress'].toString(),
      //  website: jsons["Website"].toString(),
      //  contactPerson: jsons["ContactPerson"].toString(),
      //  billToState: jsons["BillToState"].toString(),
      //  shipToState: jsons["ShipToState"].toString(),
    );
  }
}
