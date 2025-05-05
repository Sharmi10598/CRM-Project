// ignore_for_file: omit_local_variable_types

class StockWarehouseModal {
  String? odatametadata;
  List<ItemWarehouseInfoCollection>? itemWarehouse;
  String? error;
  StockWarehouseModal({
    required this.odatametadata,
    this.itemWarehouse,
    this.error,
  });
  factory StockWarehouseModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['ItemWarehouseInfoCollection'] != null) {
      final list = jsons['ItemWarehouseInfoCollection'] as List; //jsonDecode
      // print(list);
      final List<ItemWarehouseInfoCollection> dataList = list
          .map((dynamic enquiries) =>
              ItemWarehouseInfoCollection.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return StockWarehouseModal(
        itemWarehouse: dataList,
        odatametadata: jsons['odata.metadata'].toString(),
      );
    } else {
      return StockWarehouseModal(
        odatametadata: null,
      );
    }
  }

  factory StockWarehouseModal.issue(String e) {
    return StockWarehouseModal(
      odatametadata: null,
      error: e,
    );
  }
}

class ItemWarehouseInfoCollection {
  String? warehouseCode;
  double? inStock;
  double? committed;
// String ?cardType;
  double? ordered;
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
  ItemWarehouseInfoCollection({
    required this.warehouseCode,
    //  this.cardName,
    required this.ordered,
    this.inStock,
    this.committed,
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

  factory ItemWarehouseInfoCollection.fromJson(dynamic jsons) {
    return ItemWarehouseInfoCollection(
      //  groupCode: jsons['GroupCode'] as int,
      warehouseCode: jsons['WarehouseCode'] as String,
      inStock: jsons['InStock'] as double,
      committed: jsons['Committed'] as double,
      ordered: jsons['Ordered'] as double,
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
