
// ignore_for_file: omit_local_variable_types, file_names


// ignore_for_file: omit_local_variable_types
class SalesOrderCancelModal{
  String ?odatametadata;
  List<SalesOrdersCancelValue>? salesOrdercancelValue;
  String? error;
  String? nextLink;
 
  SalesOrderCancelModal({
   required this.odatametadata,
   this.salesOrdercancelValue,
   this.error,
   this.nextLink,
  });
   factory SalesOrderCancelModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['value'] != null) {
      final list =  jsons['value'] as List; //jsonDecode
      // print(list);
      List<SalesOrdersCancelValue> dataList = list
          .map((dynamic enquiries) => SalesOrdersCancelValue.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return SalesOrderCancelModal(
        salesOrdercancelValue: dataList,
        odatametadata: jsons['odata.metadata'].toString(),
        nextLink:  jsons['odata.nextLink'].toString(),
      );
    } else {
      return SalesOrderCancelModal(
        odatametadata: null,
          );
    }
  }

   factory SalesOrderCancelModal.issue(String e) {
      return SalesOrderCancelModal(
       odatametadata: null,
        error:e,
          );
  }
}

class SalesOrdersCancelValue{
int? docEntry;
String? cardCode;
String ?cardName;
 int ?DocNum;
 String ?DocDate;
 int? transportationCode;
  String? documentStatus;
  String? cancelStatus;
SalesOrdersCancelValue({
 required  this.docEntry,
 required  this.cardCode,
 required  this.cardName,
  required this.DocNum,
   required this.DocDate,
 required  this.cancelStatus,
 required  this.documentStatus,
});

 factory SalesOrdersCancelValue.fromJson(dynamic jsons) {      
    return SalesOrdersCancelValue(
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


