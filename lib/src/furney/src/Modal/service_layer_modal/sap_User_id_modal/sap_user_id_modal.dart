
// ignore_for_file: omit_local_variable_types

class SapUserIDModal{
  String ?odatametadata;
  List<SapUserIDValue>? sapUserIDValue;
  String? errors;
 Error? error;
  SapUserIDModal({
   required this.odatametadata,
   this.sapUserIDValue,
   this.error,
   this.errors,
  });
   factory SapUserIDModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['value'] != null) {
      final list =  jsons['value'] as List; //jsonDecode
      // print(list);
      List<SapUserIDValue> dataList = list
          .map((dynamic enquiries) => SapUserIDValue.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return SapUserIDModal(
        sapUserIDValue: dataList,
        odatametadata: jsons['odata.metadata'].toString(),
      );
    } else {
      return SapUserIDModal(
        odatametadata: null,
        // ignore: avoid_redundant_argument_values
        sapUserIDValue:null,
        error:Error.fromJson(jsons['error']),
          );
    }
  }
   factory SapUserIDModal.issue(Map<String, dynamic> jsons) {
      return SapUserIDModal(
       odatametadata: null,
        error: Error.fromJson(jsons['error']),
          );
  }
   factory SapUserIDModal.error(String jsons){
    return SapUserIDModal(
      errors: jsons, odatametadata: null,
    );
  }
}

class SapUserIDValue{
int? InternalKey;
SapUserIDValue({
  required this.InternalKey,
});
 factory SapUserIDValue.fromJson(dynamic jsons) {
    return SapUserIDValue(
      InternalKey: jsons['InternalKey']as int, 
    
       );
 }
}

class Error{
  int ?code;
  String? error;
  Error({
    this.code,
    this.error,
  });
  factory Error.fromJson(dynamic jsons){
    return Error(
      code: jsons['code']as int,
    );
  }

  factory Error.error(String jsons){
    return Error(
      error: jsons,
    );
  }
}