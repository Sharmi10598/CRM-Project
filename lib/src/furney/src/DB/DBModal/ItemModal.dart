// ignore_for_file: file_names, prefer_final_locals, omit_local_variable_types
const String itemTable = 'ItemDetails';

class ItemColumn {
  static const String cusID = 'CusId';
  static const String itemCode = 'ItemCode';
  static const String itemName = 'ItemName';
  static const String price = 'Price';
  static const String qty = 'Qty';
  static const String discount = 'DisCount';
  static const String total = 'Total';
  static const String wareHouseCose = 'WareHouseCose';
  static const String deliveryDate = 'DeliveryDate';

  static const String tax = 'Tax';
  static const String taxCode = 'TaxCode';
  static const String discounpercent = 'Discounpercent';
  static const String taxCodeName = 'TaxCodeName';
  static const String cartoon = 'cartoon';
  static const String valueAFDisc = 'ValueAFDisc';
}

class ItemDocuments {
  final String cusID;
  final String itemCode;
  final String itemName;
  final String price;
  final String qty;
  final String discount;
  final String total;
  final String wareHouseCose;
  final String tax;
  final String taxCode;
  final String deliveryDate;

  final String discounpercent;
  final String taxCodeName;
  final String carton;
  final double? valueAFDisc;

  ItemDocuments({
    required this.cusID,
    required this.valueAFDisc,
    required this.itemCode,
    required this.itemName,
    required this.price,
    required this.qty,
    required this.deliveryDate,
    required this.discount,
    required this.total,
    required this.wareHouseCose,
    required this.tax,
    required this.taxCode,
    required this.discounpercent,
    required this.taxCodeName,
    required this.carton,
  });

  Map<String, Object?> toMap() => {
        ItemColumn.cusID: cusID,
        ItemColumn.valueAFDisc: valueAFDisc,
        ItemColumn.itemCode: itemCode,
        ItemColumn.itemName: itemName,
        ItemColumn.discount: discount,
        ItemColumn.price: price,
        ItemColumn.qty: qty,
        ItemColumn.tax: tax,
        ItemColumn.total: total,
        ItemColumn.wareHouseCose: wareHouseCose,
        ItemColumn.taxCode: taxCode,
        ItemColumn.discounpercent: discounpercent,
        ItemColumn.taxCodeName: taxCodeName,
        ItemColumn.cartoon: carton,
        ItemColumn.deliveryDate: deliveryDate,
      };

// Map<String, dynamic> toJson() => <String, dynamic>{
//       'DocEntry': docEntry,
//         'ItemCode': itemCode,
//         'BinLocation': binCode,
//         'SerialNo': serialNum,
//         'LineNum': lineNum.toString(),
//       };
}




//  Map<String, dynamic> tojson() {
//   Map<String, dynamic> map = {
//         'DocEntry': docEntry,
//         'ItemCode': itemCode,
//         'BinLocation': binCode,
//         'SerialNo': serialNum,
//         'LineNum': lineNum.toString(),
//       };
//      return map;
//   }