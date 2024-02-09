
// ignore_for_file: omit_local_variable_types
class DeliveryModal{
  String ?odatametadata;
  List<DeliveryModaleValue>? deliveryModaleValue;
  String? error;
  String? nextLink;
  DeliveryModal({
   required this.odatametadata,
   this.deliveryModaleValue,
   this.error,
   this.nextLink,
  });
   factory DeliveryModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['value'] != null) {
      final list =  jsons['value'] as List; //jsonDecode
      // print(list);
      List<DeliveryModaleValue> dataList = list
          .map((dynamic enquiries) => DeliveryModaleValue.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return DeliveryModal(
        deliveryModaleValue: dataList,
        odatametadata: jsons['odata.metadata'].toString(),
        nextLink:  jsons['odata.nextLink'].toString(),
      );
    } else {
      return DeliveryModal(
        odatametadata: null,
          );
    }
  }

   factory DeliveryModal.issue(String e) {
      return DeliveryModal(
       odatametadata: null,
        error:e,
          );
  }
}

class DeliveryModaleValue{
int? docEntry;
String? cardCode;
String ?cardName;
 int ?DocNum;
 String ?DocDate;
 int? transportationCode;
DeliveryModaleValue({
 required  this.docEntry,
 required  this.cardCode,
 required  this.cardName,
  required this.DocNum,
   required this.DocDate,
  
});

 factory DeliveryModaleValue.fromJson(dynamic jsons) {      
    return DeliveryModaleValue(
      docEntry: jsons['DocEntry']as int, 
      cardCode: jsons['CardCode'].toString(),
      cardName:  jsons['CardName'].toString(), 
       DocDate:  jsons['DocDate'].toString(),
       DocNum:  jsons['DocNum']as int,
       );
 }
}

