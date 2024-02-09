

// ignore_for_file: omit_local_variable_types, file_names, eol_at_end_of_file


// ignore_for_file: omit_local_variable_types
import 'package:ultimate_bundle/src/furney/src/DB/DBModal/GetApprovedCust.dart';

class SubModal{
  String ?odatametadata;
  List<SubModalValue>? itemValueValue;
  String? error;
  String? nextLink;
  SubModal({
   required this.odatametadata,
   this.itemValueValue,
   this.error,
   this.nextLink,
  });
   factory SubModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['value'] != null) {
      final list =  jsons['value'] as List; 
      List<SubModalValue> dataList = list
          .map((dynamic enquiries) => SubModalValue.fromJson(enquiries))
          .toList();
      return SubModal(
        itemValueValue: dataList,
        odatametadata: jsons['odata.metadata'].toString(),
        nextLink:  jsons['odata.nextLink'].toString(),
      );
    } else {
      return SubModal(
        odatametadata: null,
          );
    }
  }

   factory SubModal.issue(String e) {
      return SubModal(
       odatametadata: null,
        error:e,
          );
  }
}

class SubModalValue{
  
String? code;
String ?name;
int? selected;

SubModalValue({
required  this.code,
required  this.name,
required this.selected,
});

 factory SubModalValue.fromJson(dynamic jsons) {      
    return SubModalValue(
      code: jsons['Code'].toString(), 
      name: jsons['Name'].toString(),  
      selected: 0,
       );
 }

   Map<String, Object?> toMap() => {
        SubGroupModel.code: code,
        SubGroupModel.name: name,
        SubGroupModel.selected: 0,
      };
}



