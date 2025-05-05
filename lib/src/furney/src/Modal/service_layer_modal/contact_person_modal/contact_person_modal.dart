
// ignore_for_file: omit_local_variable_types
class ContactPersonModal{
  String ?BilltoDefault;
  List<ContactEmployeValue>? deliveryModaleValue;
  String? error;
  String? ShipToDefault;
  ContactPersonModal({
   required this.BilltoDefault,
   this.deliveryModaleValue,
   this.error,
   this.ShipToDefault,
  });
   factory ContactPersonModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['ContactEmployees'] != null) {
      final list =  jsons['ContactEmployees'] as List; //jsonDecode
      // print(list);
      final List<ContactEmployeValue> dataList = list
          .map((dynamic enquiries) => ContactEmployeValue.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return ContactPersonModal(
        deliveryModaleValue: dataList,
        BilltoDefault: jsons['BilltoDefault'].toString(),
        ShipToDefault:  jsons['ShipToDefault'].toString(),
      );
    } else {
      return ContactPersonModal(
        BilltoDefault: null,
          );
    }
  }

   factory ContactPersonModal.issue(String e) {
      return ContactPersonModal(
       BilltoDefault: null,
        error:e,
          );
  }
}

class ContactEmployeValue{
String? phone;
String? name;
String ?Cardcode;
 
ContactEmployeValue({
 required  this.Cardcode,
  required this.name,
   required this.phone,
  
});

 factory ContactEmployeValue.fromJson(dynamic jsons) {      
    return ContactEmployeValue(
      phone: jsons['Phone1']==null?'':jsons['Phone1'].toString(), 
      name: jsons['Name']==null?'':jsons['Name'].toString(), 
      Cardcode:  jsons['CardCode']==null?'':jsons['CardCode'].toString(), 
    
       );
 }
}

