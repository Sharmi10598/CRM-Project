
// ignore_for_file: omit_local_variable_types, file_names


// ignore_for_file: omit_local_variable_types
class SalesQuotCancelModal{
  String ?odatametadata;
  List<SalesQuotCancelValue>? salesQuotcancelValue;
  String? error;
  String? nextLink;
 
  SalesQuotCancelModal({
   required this.odatametadata,
   this.salesQuotcancelValue,
   this.error,
   this.nextLink,
  });
   factory SalesQuotCancelModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['value'] != null) {
      final list =  jsons['value'] as List; //jsonDecode
      // print(list);
      final List<SalesQuotCancelValue> dataList = list
          .map((dynamic enquiries) => SalesQuotCancelValue.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return SalesQuotCancelModal(
        salesQuotcancelValue: dataList,
        odatametadata: jsons['odata.metadata'].toString(),
        nextLink:  jsons['odata.nextLink'].toString(),
      );
    } else {
      return SalesQuotCancelModal(
        odatametadata: null,
          );
    }
  }

   factory SalesQuotCancelModal.issue(String e) {
      return SalesQuotCancelModal(
       odatametadata: null,
        error:e,
          );
  }
}

class SalesQuotCancelValue{
int? docEntry;
String? cardCode;
String ?cardName;
 int ?DocNum;
 String ?DocDate;
 int? transportationCode;
  String? documentStatus;
  String? cancelStatus;
SalesQuotCancelValue({
 required  this.docEntry,
 required  this.cardCode,
 required  this.cardName,
  required this.DocNum,
   required this.DocDate,
 required  this.cancelStatus,
 required  this.documentStatus,
});

 factory SalesQuotCancelValue.fromJson(dynamic jsons) {      
    return SalesQuotCancelValue(
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


