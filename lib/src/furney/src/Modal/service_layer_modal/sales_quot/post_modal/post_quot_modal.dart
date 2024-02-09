// ignore_for_file: prefer_single_quotes, omit_local_variable_types, prefer_final_locals, prefer_interpolation_to_compose_strings


class SalesQuotStatus {
  SalesQuotStatus({
     this.statusCode,
    this.error,
    this.erros,
    this.docEntry,
  });
  int? statusCode;
  Error ? error;
  String? erros;
  int? docEntry;
  factory SalesQuotStatus.fromJson(int statusCode ) {

    return SalesQuotStatus(
      statusCode: statusCode,
       );

}
  factory SalesQuotStatus.errorIN(Map<String, dynamic> json,int statusCode,) {
    return SalesQuotStatus(
      statusCode: statusCode,
      error:Error.fromJson(json['error']),
       );

}
 factory SalesQuotStatus.issue(String e) {
    return SalesQuotStatus(
      erros: e,
       );
}

}

class Error{
  int? code;
  Message?message;
 Error({
   this.code,
  this.message,
 });

  factory Error.fromJson(dynamic jsons) {
    return Error(
      code: jsons['code']as int,
     message: Message.fromJson(jsons['message']),
       );
 }
}

class Message{
  String ?lang;
  String ? value; 
 Message({
   this.lang,
   this.value,
 });

  factory Message.fromJson(dynamic jsons) {
    return Message(
    //  groupCode: jsons['GroupCode'] as int, 
      lang: jsons['lang']as String,
      value: jsons['value'] as String,
   
       );
 }
 }

// class postData{
//   String docDate;
//   String dueDate;

// }
