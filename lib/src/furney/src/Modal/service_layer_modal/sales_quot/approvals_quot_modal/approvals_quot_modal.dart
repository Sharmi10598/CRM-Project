
// ignore_for_file: omit_local_variable_types


// ignore_for_file: omit_local_variable_types
class ApprovalsQuotModal{
  String ?odatametadata;
  List<ApprovalsQuotValue>? approvalsQuotValue;
  String? error;
  String? nextLink;
 
  ApprovalsQuotModal({
   required this.odatametadata,
   this.approvalsQuotValue,
   this.error,
   this.nextLink,
  });
   factory ApprovalsQuotModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['value'] != null) {
      final list =  jsons['value'] as List; //jsonDecode
      // print(list);
      List<ApprovalsQuotValue> dataList = list
          .map((dynamic enquiries) => ApprovalsQuotValue.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return ApprovalsQuotModal(
        approvalsQuotValue: dataList,
        odatametadata: jsons['odata.metadata'].toString(),
       // nextLink:  jsons['odata.nextLink'].toString(),
      );
    } else {
      return ApprovalsQuotModal(
        odatametadata: null,
          );
    }
  }

   factory ApprovalsQuotModal.issue(String e) {
      return ApprovalsQuotModal(
       odatametadata: null,
        error:e,
          );
  }
}

class ApprovalsQuotValue{
int? docEntry;
String? cardCode;
String ?cardName;
 int ?DocNum;
 String ?DocDate;
  String? FromUser;
  String? ObjType;
  int? WddCode;
ApprovalsQuotValue({
 required  this.docEntry,
 required  this.cardCode,
 required  this.cardName,
  required this.DocNum,
   required this.DocDate,
 required  this.ObjType,
 required  this.FromUser,
 required this.WddCode,
});

 factory ApprovalsQuotValue.fromJson(dynamic jsons) {      
    return ApprovalsQuotValue(
      docEntry: jsons['DraftEntry']as int, 
      cardCode: jsons['CardCode'].toString(),
      cardName:  jsons['CardName'].toString(), 
       DocDate:  jsons['DocDate'].toString(),
       DocNum:  jsons['DocNum']as int,
       FromUser: jsons['FromUser'].toString(),
       ObjType:jsons['ObjType'].toString(),
       WddCode: jsons['WddCode']as int,
       );
 }
}


