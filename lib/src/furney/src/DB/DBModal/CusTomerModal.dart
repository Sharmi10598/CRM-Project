

// ignore_for_file: file_names, prefer_final_locals, omit_local_variable_types
const String tablename = 'CustomerDetails';
class Columns{
 static const String bPCode = 'BPCode';
 static const String bPName = 'BPName';
 static const String currency = 'Currency';
 static const String salesEmp = 'SalesEmp';
 static const String cusRefNo = 'CusRefNo';
 static const String status = 'Status';
 static const String postDate = 'PostDate';
 static const String validUntil = 'ValidUntil';
 static const String docDate = 'DocDate';
 static const String remarks = 'Remarks';
 static const String billTo = 'BillTo';
 static const String shipTo = 'ShipTo';
 static const String selectOrderType = 'SelectOrderType';
 static const String gPApprovalReq = 'GPApprovalReq';
 static const String orderRecTime = 'OrderRecTime';
 static const String orderRecDate = 'OrderRecDate';

//  static const String totalBD = 'TotalBD';
//  static const String discount = 'Discount';
//  static const String tax = 'Tax';
//  static const String total = 'Total';
}
class Documents{
  final String? cusID;
final String bPCode;
final String bPName ;
final String currency ;
final String salesEmp;
final String cusRefNo ;
final String status ;
final String postDate;
final String validUntil ;
final String docDate ;
final String remarks;
final String billTo ;
final String shipTo ;
final String selectOrderType ;
final String gPApprovalReq;
final String orderRecTime ;
final String orderRecDate ;

Documents({
  required this.bPCode, required this.bPName, required this.currency, required this.salesEmp, required this.cusRefNo, required this.status, required this.postDate, required this.validUntil, required this.docDate, required this.remarks, required this.billTo, required this.shipTo, required this.selectOrderType, required this.gPApprovalReq, required this.orderRecTime, required this.orderRecDate, this.cusID, 
});

Map<String , Object?> toMap()=>{
  Columns.bPCode:bPCode,
  Columns.bPName:bPName,
  Columns.currency:currency,
  Columns.salesEmp:salesEmp,
  Columns.cusRefNo:cusRefNo,
  Columns.status:status,
  Columns.postDate:postDate,
  Columns.validUntil:validUntil,
  Columns.docDate:docDate,
  Columns.remarks:remarks,
  Columns.billTo:billTo,
  Columns.shipTo:shipTo,
  Columns.selectOrderType:selectOrderType,
  Columns.gPApprovalReq:gPApprovalReq,
  Columns.orderRecTime:orderRecTime,
  Columns.orderRecDate:orderRecDate
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