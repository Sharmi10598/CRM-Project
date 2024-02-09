// ignore_for_file: prefer_single_quotes, omit_local_variable_types, prefer_final_locals

class SOafterStatus {
  SOafterStatus({
     this.statusCode,
    this.error,
    this.erros,
  });
  int? statusCode;
  Error ? error;
  String? erros;
  factory SOafterStatus.fromJson(int statusCode) {
    return SOafterStatus(
      statusCode: statusCode,
       );

}
  factory SOafterStatus.errorIN(Map<String, dynamic> json) {
    return SOafterStatus(
      error: Error.fromJson(json['error']),
       );

}
 factory SOafterStatus.issue(String e) {
    return SOafterStatus(
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
