// ignore_for_file: omit_local_variable_types, prefer_final_locals, avoid_redundant_argument_values, prefer_single_quotes

class CustomerModal{
  String ?odatametadata;
  List<CustomerValue>? Customervalue;
  String? error;
  String?nextLink;
  CustomerModal({
   required this.odatametadata,
   this.Customervalue,
   this.error,
   this.nextLink,
  });
   factory CustomerModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['value'] != null) {
      var list =  jsons['value'] as List; //jsonDecode
      // print(list);
      List<CustomerValue> dataList = list
          .map((dynamic enquiries) => CustomerValue.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return CustomerModal(
        Customervalue: dataList,
        odatametadata: jsons['odata.metadata'].toString(),
        nextLink:jsons['odata.nextLink'].toString(),
        error: null,
      );
    } else {
      return CustomerModal(
        odatametadata: null,
        Customervalue:null,
        nextLink:null,
         error: null,
          );
    }
  }

   factory CustomerModal.issue(String e) {
      return CustomerModal(
       odatametadata: null,
        Customervalue:null,
        error:e,
          );
    
  }
}

class CustomerValue{
BusinessPartners? businessPartners;
PaymentTermsTypes? paymentTermsTypes;
SalesPersons? salesPersons;
CustomerValue({
required this.businessPartners,
required this.paymentTermsTypes,
required this.salesPersons,
});

 factory CustomerValue.fromJson(dynamic jsons) {  
    return CustomerValue(
      businessPartners: BusinessPartners.fromJson(jsons),
      // businessPartners: BusinessPartners.fromJson(jsons['BusinessPartners']),
      paymentTermsTypes: PaymentTermsTypes.fromJson(jsons['PaymentTermsTypes']), 
      salesPersons: SalesPersons.fromJson(jsons['SalesPersons']), 
       
       );
 }
}


class BusinessPartners{
double? currentAccountBalance;
String? cardCode;
String ?cardName;
int?slpcode;
String? slpname;
String? pymntGroup;
String? ShipToDefault;
String? BilltoDefault;
String? U_CASHCUST;

BusinessPartners({
required  this.cardCode,
required  this.cardName,
required  this.slpcode,
required  this.slpname,
required  this.pymntGroup,
required  this.currentAccountBalance,
required  this.BilltoDefault,
required this.ShipToDefault,
required this.U_CASHCUST,
});

factory BusinessPartners.fromJson(dynamic jsons) {  
    return BusinessPartners( 
      slpcode: jsons['SlpCode']as int,
      slpname: jsons['CardCode'].toString(), 
      pymntGroup: jsons['CardName'].toString(),
      cardCode: jsons['CardCode'].toString(), 
      cardName: jsons['CardName'].toString(),
      ShipToDefault: jsons['ShipToDefault']==null?'': jsons['ShipToDefault']as String, 
      BilltoDefault: jsons['BilltoDefault']==null?'': jsons['BilltoDefault']as String,
       currentAccountBalance:  jsons['CurrentAccountBalance']==null?0.0: jsons['CurrentAccountBalance']as double, 
       U_CASHCUST:jsons['U_CASHCUST']==null?'':jsons['U_CASHCUST'].toString(),
       );
 }
}

class PaymentTermsTypes{
  String? paymentTermsGroupName;
  PaymentTermsTypes({
required  this.paymentTermsGroupName,

});

factory PaymentTermsTypes.fromJson(dynamic jsons) {  
    return PaymentTermsTypes(
      paymentTermsGroupName: jsons['PaymentTermsGroupName'].toString(), 
  
       );
 }
}

class SalesPersons{
   String? salesEmployeeName;
  SalesPersons({
required  this.salesEmployeeName,

});

factory SalesPersons.fromJson(dynamic jsons) {  
    return SalesPersons(
      salesEmployeeName: jsons['SalesEmployeeName'].toString(), 
  
       );
 }
}