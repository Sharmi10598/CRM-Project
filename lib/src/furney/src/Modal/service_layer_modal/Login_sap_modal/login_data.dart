
// Logindata logindataFromJson(String str,int st) =>
//     Logindata.fromJson(json.decode(str) as Map<String, dynamic>,st);

// //String logindataToJson(Logindata data) => json.encode(data.toJson());

class Logindata {
  Logindata(
      {required this.stCode, this.odataMetadata,
      this.sessionId,
      this.version,
      this.sessionTimeout,
      this.error,
      this.exception,
      });

  String? odataMetadata;
  String? sessionId;
  String? version;
  int? sessionTimeout;
  Error? error;
  String? exception;
  int? stCode;

  factory Logindata.fromJson(Map<String, dynamic> json,int stcode) {
  
    return Logindata(
        odataMetadata: json['odata.metadata'] as String,
        sessionId: json['SessionId'] as String,
        version: json['Version'] as String,
        sessionTimeout: json['SessionTimeout'] as int,
        // ignore: avoid_redundant_argument_values
        error: null,
        stCode:stcode,
        );
    // }
  }
  factory Logindata.issue(String e,int stcode) {
    return Logindata(
        exception: e,
        stCode:stcode,
        );
  }

  factory Logindata.error(Map<String, dynamic> json,int stcode) {
    return Logindata(
        error: Error.fromJson(json['error']),
        stCode:stcode,
        );
  }
}

class Error {
  int? code;
  Message? message;
  Error({this.code, this.message});

  factory Error.fromJson(dynamic jsons) {
    return Error(
      code: jsons['code'] as int,
      message: Message.fromJson(jsons['message']),
    );
  }
}

class Message {
  String? lang;
  String? value;
  Message({
    this.lang,
    this.value,
  });

  factory Message.fromJson(dynamic jsons) {
    return Message(
      //  groupCode: jsons['GroupCode'] as int,
      lang: jsons['lang'] as String,
      value: jsons['value'] as String,
    );
  }
}
