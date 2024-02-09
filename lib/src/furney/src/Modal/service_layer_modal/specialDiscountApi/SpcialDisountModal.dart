
// ignore_for_file: omit_local_variable_types, file_names


// ignore_for_file: omit_local_variable_types
class SpecialDisCountModal{
  String ?odatametadata;
  List<SpecialValue>? specialValue;
  String? error;
  SpecialDisCountModal({
   required this.odatametadata,
   this.specialValue,
   this.error,
  });
   factory SpecialDisCountModal.fromJson(Map<String, dynamic> jsons) {
     if (jsons['value'] != null &&jsons['value'].toString().isNotEmpty) {
      final list =  jsons['value'] as List; 
      List<SpecialValue> dataList = list
          .map((dynamic enquiries) => SpecialValue.fromJson(enquiries))
          .toList();
      return SpecialDisCountModal(
        specialValue: dataList,
        odatametadata: jsons['odata.metadata'].toString(),
      );
    } else {
      return SpecialDisCountModal(
        odatametadata: null,
          );
    }
  }

   factory SpecialDisCountModal.issue(String e) {
      return SpecialDisCountModal(
       odatametadata: null,
        error:e,
          );
  }
}

class SpecialValue{
double? discount;
double? Price;

SpecialValue({
required  this.discount,
required  this.Price,

});

 factory SpecialValue.fromJson(dynamic jsons) {      
    return SpecialValue(
      discount: jsons['Discount'] as double, 
      Price: jsons['Price']as double ,  
       );
 }
}



