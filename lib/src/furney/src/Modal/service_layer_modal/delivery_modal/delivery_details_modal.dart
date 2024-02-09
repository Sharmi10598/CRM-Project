
// ignore_for_file: omit_local_variable_types

// class DeliveryDetailsData{
//    List<DeliveryDetailsValue>? deliveryDetails;
//      DeliveryDetailsData({
//    this.deliveryDetails,
//   });
//     factory DeliveryDetailsData.fromJson(Map<String, dynamic> jsons) {
//     if (jsons['value'] != null) {
//       var list =  jsons['value'] as List; //jsonDecode
//       // print(list);
//       List<DeliveryDetailsValue> dataList = list
//           .map((dynamic enquiries) => DeliveryDetailsValue.fromJson(enquiries))
//           .toList();
//       // print(dataList[0]);
//       return DeliveryDetailsData(
//        deliveryDetails:dataList
//       );
//     } else {
//       return DeliveryDetailsData(
      
//           );
//     }
//   }
// }
class DeliveryDetailsValue{
int? docEntry;
String? cardCode;
String ?cardName;
 int ?DocNum;
 String ?DocDate;
 List<DocumentDeliveryValue>? documentLines;
 String? DocumentStatus;
 String? CancelStatus;
 String? DocCurrency;
 double? totalDiscount;
 double? vatSum;
 double? docTotal;
 String? comments;
int? salesPersonCode;
 dynamic numAtCard;
 String? taxDate;
 String? docDueDate;
 AddressExtension? addressExtension;
 int? transportationCode;
 String? error;
DeliveryDetailsValue({
   this.docEntry,
   this.cardCode,
   this.cardName,
   this.DocNum,
   this.DocDate,
   this.documentLines,
   this.DocumentStatus,
   this.CancelStatus,
   this.DocCurrency,

 this.salesPersonCode,
   this.numAtCard,
  this.taxDate,
   this.docDueDate,
  this.comments,
  this.docTotal,
   this.totalDiscount,
   this.vatSum,
   this.addressExtension,
   this.transportationCode,
   this.error,
});

 factory DeliveryDetailsValue.fromJson(dynamic jsons) {
     if (jsons['DocumentLines'] != null  && jsons['AddressExtension']!=null) {
      final list =  jsons['DocumentLines'] as List; //jsonDecode
      // print(list);
      List<DocumentDeliveryValue> dataList = list
          .map((dynamic enquiries) => DocumentDeliveryValue.fromJson(enquiries))
          .toList();
    return DeliveryDetailsValue(
    //  groupCode: jsons['GroupCode'] as int, 
    
      docEntry: jsons['DocEntry']as int, 
      cardCode: jsons['CardCode'].toString(),
      cardName:  jsons['CardName'].toString(), 
       DocDate:  jsons['DocDate'].toString(),
       DocNum:  jsons['DocNum']as int,
       DocumentStatus: jsons['DocumentStatus'].toString(),
       CancelStatus:jsons['CancelStatus'].toString(),
        DocCurrency: jsons['DocCurrency'].toString(),
       documentLines: dataList,

      salesPersonCode:jsons['SalesPersonCode']as int,
      numAtCard:jsons['NumAtCard'] ?? '',
      taxDate:  jsons['TaxDate'] .toString(),
      docDueDate:  jsons['DocDueDate'] .toString(),
      comments: jsons['Comments'].toString(),
      docTotal:jsons['DocTotal']as double, 
      totalDiscount: jsons['TotalDiscount']as double,
      vatSum:jsons['VatSum']as double,
      transportationCode: jsons['TransportationCode']as int,
       addressExtension:  AddressExtension.fromJson(jsons['AddressExtension']),
       );}else{
         return DeliveryDetailsValue(DocDate: jsons['DocDate'].toString(),);
       }
 }

  factory DeliveryDetailsValue.issue(String e) {
      return DeliveryDetailsValue(
        error:e,
          );
  }
}

class DocumentDeliveryValue{
String? ItemCode;
String? ItemDescription;
double ?Quantity;
double ?Price;
 String ?TaxCode;
 double ? LineTotal;
 double ? UnitPrice;
double?TaxTotal;
double? discountPercent;
 double? grossTotal;
 String? warehouseCode;
 DocumentDeliveryValue({
   this.ItemCode,
   this.ItemDescription,
   this.LineTotal,
   this.Price,
   this.Quantity,
   this.TaxCode,
   this.UnitPrice,
   this.TaxTotal,
    this.discountPercent,
   this.grossTotal,
   this.warehouseCode,
 });

  factory DocumentDeliveryValue.fromJson(dynamic jsons) {
    return DocumentDeliveryValue(
    //  groupCode: jsons['GroupCode'] as int, 
      ItemCode: jsons['ItemCode'].toString(),
      ItemDescription: jsons['ItemDescription'].toString(),
      LineTotal:  jsons['LineTotal']as double, 
       Price:  jsons['Price']as double,
      Quantity:  jsons['Quantity']as double,
       TaxCode:  jsons['TaxCode'] .toString(),
       UnitPrice:  jsons['UnitPrice'] as double,
        TaxTotal: jsons['TaxTotal']as double,
      discountPercent: jsons['DiscountPercent']as double,
      grossTotal:jsons['GrossTotal']as double, 
     warehouseCode: jsons['WarehouseCode'] ==null?'':jsons['WarehouseCode'].toString(),
       );
 }
}

class AddressExtension{
  String? billToStreet;
  dynamic billToStreetNo;
  String ?billToBlock;
  dynamic billToBuilding;
  String ?billToCity;
  String ? billToZipCode;
  String ? billToCounty;
  String? billToState;
  String? shipToStreet;
  String? shipToStreetNo;
  String? shipToBlock;
  String? shipToBuilding;
  String? shipToCity;
  String? shipToZipCode;
  String? shipToCounty;
  String? shipToState;
  String? shipToCountry;
 AddressExtension({
   this.billToStreet,
   this.billToStreetNo,
   this.billToBlock,
   this.billToBuilding,
   this.billToCity,
   this.billToZipCode,
   this.billToCounty,
   this.billToState,
    this.shipToStreet,
    this.shipToStreetNo,
    this.shipToBlock,
    this.shipToBuilding,
    this.shipToCity,
    this.shipToZipCode,
    this.shipToCounty,
    this.shipToState,
    this.shipToCountry,
  //  this.grossTotal
 });

  factory AddressExtension.fromJson(dynamic jsons) {
    return AddressExtension(
      billToStreet: jsons['BillToStreet']==null?'':jsons['BillToStreet'].toString(),
      billToStreetNo: jsons['BillToStreetNo'],
      billToBlock:  jsons['BillToBlock'].toString(), 
      billToBuilding:  jsons['BillToBuilding'].toString(),
      billToCity:  jsons['BillToCity']==null?'':jsons['BillToCity'].toString(),
      billToZipCode:  jsons['BillToZipCode'] .toString(),
      billToCounty:  jsons['billToCounty'] ==null?'':jsons['billToCounty'].toString(),
      billToState :jsons['BillToState']==null?'':jsons['BillToState'].toString(),
      shipToStreet:  jsons['ShipToStreet']==null?'':jsons['ShipToStreet'].toString(),
      shipToStreetNo: jsons['ShipToStreetNo'].toString(),
      shipToBlock:  jsons['ShipToBlock'].toString(),
      shipToBuilding: jsons['ShipToBuilding'].toString(),
      shipToCity: jsons['ShipToCity']==null?'':jsons['ShipToCity'].toString(),
      shipToZipCode:jsons['ShipToZipCode'].toString(), 
      shipToCounty:jsons['ShipToCounty'].toString(),
      shipToState: jsons['ShipToState']==null?'':jsons['ShipToState'].toString(),
      shipToCountry: jsons['ShipToCountry']==null?'':jsons['ShipToCountry'].toString(),
       );
 }
}