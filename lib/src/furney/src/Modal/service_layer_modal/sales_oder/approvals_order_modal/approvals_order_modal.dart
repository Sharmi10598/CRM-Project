
// ignore_for_file: omit_local_variable_types


// ignore_for_file: omit_local_variable_types
class ApprovalsOrdersModal{
  String ?odatametadata;
  List<ApprovalsOrdersValue>? approvalsOrdersValue;
  String? error;
  String? nextLink;
 
  ApprovalsOrdersModal({
   required this.odatametadata,
   this.approvalsOrdersValue,
   this.error,
   this.nextLink,
  });
   factory ApprovalsOrdersModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['value'] != null) {
      final list =  jsons['value'] as List; //jsonDecode
      // print(list);
      List<ApprovalsOrdersValue> dataList = list
          .map((dynamic enquiries) => ApprovalsOrdersValue.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return ApprovalsOrdersModal(
        approvalsOrdersValue: dataList,
        odatametadata: jsons['odata.metadata'].toString(),
       // nextLink:  jsons['odata.nextLink'].toString(),
      );
    } else {
      return ApprovalsOrdersModal(
        odatametadata: null,
          );
    }
  }

   factory ApprovalsOrdersModal.issue(String e) {
      return ApprovalsOrdersModal(
       odatametadata: null,
        error:e,
          );
  }
}

class ApprovalsOrdersValue{
int? docEntry;
String? cardCode;
String ?cardName;
 int ?DocNum;
 String ?DocDate;
  String? FromUser;
  String? ObjType;
  int? WddCode;
ApprovalsOrdersValue({
 required  this.docEntry,
 required  this.cardCode,
 required  this.cardName,
  required this.DocNum,
   required this.DocDate,
 required  this.ObjType,
 required  this.FromUser,
 required this.WddCode,
});

 factory ApprovalsOrdersValue.fromJson(dynamic jsons) {      
    return ApprovalsOrdersValue(
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
//  {\"WddCode\":965998,\"WtmCode\":69,\"ObjType\":\"17\",\"CurrStep\":62,\
//  "CreateDate\":\"2022-06-08T00:00:00\",\"CreateTime\":1550,\"DraftEntry\":
//  787512,\"FromUser\":\"HOORDER\",\"DocNum\":3853,\"DocDate\":\"2022-06-08'
//  T00:00:00\",\"CardCode\":\"D9121\",\"CardName\":\"ED\"}
}


