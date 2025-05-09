// ignore_for_file: prefer_single_quotes, omit_local_variable_types, prefer_final_locals, file_names

class ApprovalsOTORModal {
  ApprovalsOTORModal({
    required this.statusCode,
    this.erorrs,
  });
  Errors? erorrs;
  String statusCode;
  factory ApprovalsOTORModal.fromJson(String statusCode) {
    return ApprovalsOTORModal(
      statusCode: statusCode,
    );
  }

  factory ApprovalsOTORModal.fromJson2(
    String statusCode,
    Map<String, dynamic> jsons,
  ) {
    return ApprovalsOTORModal(
      statusCode: statusCode,
      erorrs: Errors.fromJson(jsons["error"]),
    );
  }
}

class Errors {
  String? code;
  Message? message;

  Errors({
    this.code,
    this.message,
  });

  factory Errors.fromJson(dynamic jsons) {
    return Errors(
      code: jsons['code'].toString(),
      message: Message.fromJson(jsons['message']),
    );
  }
}

class Message {
  String? value;
  Message({
    this.value,
  });
  factory Message.fromJson(dynamic jsons) {
    return Message(
      value: jsons['value'].toString(),
    );
  }
}
