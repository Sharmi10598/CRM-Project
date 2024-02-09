// ignore_for_file: omit_local_variable_types, prefer_final_locals, avoid_redundant_argument_values, prefer_single_quotes

class ApprovalsPatchModal{

  ErrorPatch? errorPatch;
  String? issue;
  ApprovalsPatchModal({
   required this.errorPatch,
   this.issue,
  });
   factory ApprovalsPatchModal.fromJson(Map<String, dynamic> jsons) {
      return ApprovalsPatchModal(
      errorPatch: ErrorPatch.fromJson(jsons['error']),
      );
  }

   factory ApprovalsPatchModal.issue(String e) {
      return ApprovalsPatchModal(
      errorPatch: null,
      issue: e,
      );
  }
}

class ErrorPatch{
int? Code;
 Message ?message;

ErrorPatch({
   this.Code,
   this.message,
});

 factory ErrorPatch.fromJson(dynamic jsons) {
    return ErrorPatch(
      Code: jsons['code']as int, 
      message:Message.fromJson(jsons['message']), 
       );
 }
}

class Message{
  String? Value;
  Message({
    this.Value,
  });
   factory Message.fromJson(dynamic jsons) {
    return Message(
      Value: jsons['value'].toString(), 

       );
 }
}

class StatusCode{
  String? Value;
  StatusCode({
    this.Value,
  });
   factory StatusCode.fromJson(String statusCode) {
    return StatusCode(
      Value: statusCode,);
 }
}

