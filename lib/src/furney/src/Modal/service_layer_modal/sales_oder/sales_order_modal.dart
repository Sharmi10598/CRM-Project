
// ignore_for_file: omit_local_variable_types


// ignore_for_file: omit_local_variable_types
class SalesOrderModal{
  String ?odatametadata;
  List<SalesOrderValue>? salesOrderValue;
  String? error;
  String? nextLink;
  SalesOrderModal({
   required this.odatametadata,
   this.salesOrderValue,
   this.error,
   this.nextLink,
  });
   factory SalesOrderModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['value'] != null) {
      final list =  jsons['value'] as List; //jsonDecode
      // print(list);
      final List<SalesOrderValue> dataList = list
          .map((dynamic enquiries) => SalesOrderValue.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return SalesOrderModal(
        salesOrderValue: dataList,
        odatametadata: jsons['odata.metadata'].toString(),
        nextLink:  jsons['odata.nextLink'].toString(),
      );
    } else {
      return SalesOrderModal(
        odatametadata: null,
          );
    }
  }

   factory SalesOrderModal.issue(String e) {
      return SalesOrderModal(
       odatametadata: null,
        error:e,
          );
  }
}

class SalesOrderValue{
int? docEntry;
String? cardCode;
String ?cardName;
 int ?DocNum;
 String ?DocDate;
 int? transportationCode;
 String? documentStatus;
  String? cancelStatus;
SalesOrderValue({
 required  this.docEntry,
 required  this.cardCode,
 required  this.cardName,
  required this.DocNum,
   required this.DocDate,
  required  this.cancelStatus,
 required  this.documentStatus,
});

 factory SalesOrderValue.fromJson(dynamic jsons) {      
    return SalesOrderValue(
      docEntry: jsons['DocEntry']as int, 
      cardCode: jsons['CardCode'].toString(),
      cardName:  jsons['CardName'].toString(), 
       DocDate:  jsons['DocDate'].toString(),
       DocNum:  jsons['DocNum']as int,
       documentStatus: jsons['DocumentStatus'].toString(),
       cancelStatus:jsons['CancelStatus'].toString(),
       );
 }
}




