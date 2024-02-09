// To parse this JSON data, do
//
//     final logindata = logindataFromJson(jsonString);

// ignore_for_file: avoid_init_to_null, omit_local_variable_types

import 'dart:convert';

NotesModal logindataFromJson(String str) =>
    NotesModal.fromJson(json.decode(str) as Map<String, dynamic>);

//String logindataToJson(Logindata data) => json.encode(data.toJson());

class NotesModal {
  NotesModal(
      {required this.status,
      required this.message,
      this.notesData,
      this.error,
      this.exception,});

  bool? status;
  String? message;
  List<NotesData>? notesData;
  String? error;
  String? exception;

  factory NotesModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['data'] != null) {
      final list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      // print(list);
      List<NotesData> dataList = list
          .map((dynamic enquiries) => NotesData.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return NotesModal(
        notesData: dataList,
        message: jsons['message'].toString(),
        status: jsons['status'] as bool,
      );
    } else {
      return NotesModal(
        message: jsons['message'].toString(),
        status: jsons['status'] as bool,
      );
    }
  }
  factory NotesModal.issue(String e) {
    return NotesModal(status: null, message: null, error: e);
  }

  factory NotesModal.exception(String e) {
    return NotesModal(status: null, message: null, error: e,
    exception: e,
    );
  }
}

class NotesData {
  int? HeaderId;
  int? ChildId;
   int? total;
  int? read;
  String? MsgDescription;
String? ViewedOn;
String? IsSeen; 
 String? MsgHeading;
 String? CreatedDate;
 String?CreatedTime;
  NotesData({
    this.HeaderId,
    this.ChildId,
    this.MsgDescription,
   this. ViewedOn,
   this. IsSeen,
   this.MsgHeading,
   this.total,
   this.read,
   this.CreatedDate,
   this.CreatedTime,
  });

  factory NotesData.fromJson(dynamic jsons) {
    return NotesData(
      HeaderId: jsons['HeaderId'] as int,
      ChildId: jsons['ChildId'] as int,
      MsgDescription: jsons['MsgDescription'] as String,
      ViewedOn: jsons['ViewedOn'] as String,
      IsSeen: jsons['IsSeen'] as String,
      MsgHeading:jsons['MsgHeading'] as String,
      read:  jsons['Read'] as int,
      total:  jsons['Total'] as int,
      CreatedDate: jsons['CreatedDate'] as String,
      CreatedTime:jsons['CreatedTime'] as String,
    );
  }
}
