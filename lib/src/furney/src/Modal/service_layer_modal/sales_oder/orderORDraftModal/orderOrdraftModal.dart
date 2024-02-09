
// ignore_for_file: omit_local_variable_types, file_names
// ignore_for_file: omit_local_variable_types

class OrderORDraftModal{
  String ?odatametadata;
  List<OrderORDraft>? orderORDraftValue;
  String? error;
  OrderORDraftModal({
   required this.odatametadata,
   this.orderORDraftValue,
   this.error,
   
  });
   factory OrderORDraftModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['value'] != null) {
      final list =  jsons['value'] as List; //jsonDecode
      // print(list);
      List<OrderORDraft> dataList = list
          .map((dynamic enquiries) => OrderORDraft.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return OrderORDraftModal(
        orderORDraftValue: dataList,
        odatametadata: jsons['odata.metadata'].toString(),
        
      );
    } else {
      return OrderORDraftModal(
        odatametadata: null,
          );
    }
  }

   factory OrderORDraftModal.issue(String e) {
      return OrderORDraftModal(
       odatametadata: null,
        error:e,
          );
  }
}

class OrderORDraft{
// int? docEntry;
String? cardCode;
String ?cardName;
//  int ?DocNum;
//  String ?DocDate;
//  int? transportationCode;
//  String? documentStatus;
//   String? cancelStatus;
OrderORDraft({
// required  this.docEntry,
 required  this.cardCode,
 required  this.cardName,
//   required this.DocNum,
//    required this.DocDate,
//   required  this.cancelStatus,
//  required  this.documentStatus
});

 factory OrderORDraft.fromJson(dynamic jsons) {      
    return OrderORDraft(
     // docEntry: jsons['DocEntry']as int, 
      cardCode: jsons['CardCode'].toString(),
      cardName:  jsons['CardName'].toString(), 
      //  DocDate:  jsons['DocDate'].toString(),
      //  DocNum:  jsons['DocNum']as int,
      //  documentStatus: jsons['DocumentStatus'].toString(),
      //  cancelStatus:jsons['CancelStatus'].toString(),
       );
 }
}




