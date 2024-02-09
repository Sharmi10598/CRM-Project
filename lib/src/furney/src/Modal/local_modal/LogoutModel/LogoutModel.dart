class LogOutApiModel
{
  String? status;
  String? msg;
  String? excep;
  int? stCodel;

LogOutApiModel({
  required this.msg,
  required this.stCodel,
  required this.status,
  this.excep,
});
  
  factory LogOutApiModel.fromJson(Map<String, dynamic> jsons,int stc) {
    if (stc == 200) {
    

      return LogOutApiModel(
        msg: jsons['msg'].toString(),
       stCodel: stc, 
       status: jsons['status'].toString(),
       );
    } else {
      return LogOutApiModel(
        msg: null,
       stCodel: stc, 
       status: null,
       );
    }
  }
  factory LogOutApiModel.issue(String e,int stcode) {
    return LogOutApiModel(
        msg: null,
       stCodel: stcode, 
       status: null,
       excep: e,
       );
  }

}