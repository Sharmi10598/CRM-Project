// ignore_for_file: omit_local_variable_types, prefer_final_locals, avoid_redundant_argument_values, prefer_single_quotes

class ApprovalsModal{
  String ?odatametadata;
  List<ApprovalsValue>? approvalsvalue;
  String? error;
  String?nextLink;
  ApprovalsModal({
   required this.odatametadata,
   this.approvalsvalue,
   this.error,
   this.nextLink,
  });
   factory ApprovalsModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['value'] != null) {
      var list =  jsons['value'] as List; //jsonDecode
      // print(list);
      List<ApprovalsValue> dataList = list
          .map((dynamic enquiries) => ApprovalsValue.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return ApprovalsModal(
        approvalsvalue: dataList,
        odatametadata: jsons['odata.metadata'].toString(),
        nextLink:jsons['odata.nextLink'].toString(),
      );
    } else {
      return ApprovalsModal(
        odatametadata: null,
        approvalsvalue:null,
        nextLink: null,
          );
    }
  }

   factory ApprovalsModal.issue(String e) {
      return ApprovalsModal(
       odatametadata: null,
        approvalsvalue:null,
        error:e,
        nextLink: null,
          );
    
  }
}

class ApprovalsValue{
//int groupCode;
String? cardCode;
String ?cardName;
String ?createDate;
int ?createTime;
int? CurrStep;
String? DocDate;
int? DocNum;
int? DraftEntry;
String? FromUser;
String? ObjType;
int? WddCode;
int? WtmCode;
// String? notes;
ApprovalsValue({
 // required this.groupCode,
  required this.cardCode,
 required  this.createDate,
 required  this.cardName,
 required  this.createTime,
 required  this.CurrStep,
  required this.DocDate,
 required  this.DocNum,
  required this.DraftEntry,
  required this.FromUser,
  required this.ObjType,
  required this.WddCode,
  required this.WtmCode,
 // this.notes,
});

 factory ApprovalsValue.fromJson(dynamic jsons) {
    return ApprovalsValue(
      cardCode: jsons['CardCode'].toString(), 
      cardName: jsons['CardName'].toString(), 
      createDate:  jsons['CreateDate'].toString(), 
      createTime:  jsons['CreateTime']==null?0:jsons['CreateTime']as int,
      CurrStep:  jsons['CurrStep']as int,
       DocDate:  jsons['DocDate'] as String,
       DocNum:jsons["DocNum"] as int, 
       DraftEntry:jsons['DraftEntry']==null?0:jsons['DraftEntry']as int,
       FromUser: jsons["FromUser"]==null?'':jsons['FromUser'].toString(),
       ObjType: jsons["ObjType"]==null?'':jsons['ObjType'].toString(),
       WddCode: jsons["WddCode"]as int,
       WtmCode: jsons["WtmCode"]as int,
      //  notes: jsons['Notes'].toString(),
       );
 }
}

