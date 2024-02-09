
// ignore_for_file: omit_local_variable_types, file_names


// ignore_for_file: omit_local_variable_types
class MainModal{
  String ?odatametadata;
  List<MainModalValue>? itemValueValue;
  String? error;
  String? nextLink;
  MainModal({
   required this.odatametadata,
   this.itemValueValue,
   this.error,
   this.nextLink,
  });
   factory MainModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['value'] != null) {
      final list =  jsons['value'] as List; 
      List<MainModalValue> dataList = list
          .map((dynamic enquiries) => MainModalValue.fromJson(enquiries))
          .toList();
      return MainModal(
        itemValueValue: dataList,
        odatametadata: jsons['odata.metadata'].toString(),
        nextLink:  jsons['odata.nextLink'].toString(),
      );
    } else {
      return MainModal(
        odatametadata: null,
          );
    }
  }

   factory MainModal.issue(String e) {
      return MainModal(
       odatametadata: null,
        error:e,
          );
  }
}

class MainModalValue{
String? code;
String ?name;

MainModalValue({
required  this.code,
required  this.name,

});

 factory MainModalValue.fromJson(dynamic jsons) {      
    return MainModalValue(
      code: jsons['Code'].toString(), 
      name: jsons['Name'].toString(),  
       );
 }
}



