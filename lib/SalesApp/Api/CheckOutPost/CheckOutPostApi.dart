// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, unnecessary_string_interpolations
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/SalesApp/Model/VisitAproval/VisitAproval.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/DB/DBModal/GetApprovedCust.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class CheckOutPatchAPi {
  static Future<PatchVisitModel> getGlobalData(CheckOutModel checkOut) async {
    try {
      log(URL.url + "Activities(${checkOut.clgCode})");
      final response = await http.patch(
        Uri.parse(URL.url + "Activities(${checkOut.clgCode})"),
        headers: {
          'content-type': 'application/json',
          "cookie": 'B1SESSION=' + GetValues.sessionID.toString()
        },
        body: json.encode({
          "Notes": "${checkOut.Notes}", //visit discussion
          "Closed": "${checkOut.Closed}",
          "CloseDate": "${checkOut.CloseDate}",
          "EndTime": "${checkOut.EndTime}",
          "Duration": "${checkOut.Duration}",
          "U_OrdProsValue": "${checkOut.U_OrdProsValue}",
          "U_PymntVal": "${checkOut.U_PymntVal}",
          "U_Complaints": "${checkOut.U_Complaints}",
          "U_Remarks1": "${checkOut.U_Remarks1}",
          "U_Remarks2": "${checkOut.U_Remarks2}",
          "U_COLatitude": "${checkOut.U_COLatitude}",
          "U_COLongitude": "${checkOut.U_COLongitude}",
          "U_Link1": "${checkOut.U_Link1}",
          "U_Link2": "${checkOut.U_Link2}",
          "U_Link3": "${checkOut.U_Link3}",
          "U_Link4": "${checkOut.U_Link4}",
          "U_Products": "${checkOut.U_Products}",
          "U_BrandContr": "${checkOut.U_BrandContr}",
          "U_PPComp": "${checkOut.U_PPComp}",
          "U_BrandinPromo": "${checkOut.U_BrandinPromo}",
          "U_CheckedIn": "${checkOut.U_CheckedIn}",
          "U_Advertise": "${checkOut.U_Advertise}",
          "U_AdvFormt": "${checkOut.U_AdvFormt}",
          "U_NxtFollowup": "${checkOut.U_NxtFollowup}",
          "U_Status": "${checkOut.U_status}",
          "U_Project": "${checkOut.U_Project}",
          "U_Customer": "${checkOut.U_Customer}",
          "U_Consultant": "${checkOut.U_Consultant}",
          "U_Subgroup": "${checkOut.U_Subgroup}",
          "U_CheckOutAdd": "${checkOut.U_CheckOutAdd}",
        }),
      );

      log('CheckOutPatchAPi::'+
        json.encode({
          "Notes": "${checkOut.Notes}", //visit discussion
          "Closed": "${checkOut.Closed}",
          "CloseDate": "${checkOut.CloseDate}",
          "EndTime": "${checkOut.EndTime}",
          "Duration": "${checkOut.Duration}",
          // "DurationType": ""${checkOut}",
          "U_OrdProsValue": "${checkOut.U_OrdProsValue}",
          "U_PymntVal": "${checkOut.U_PymntVal}",
          "U_Complaints": "${checkOut.U_Complaints}",
          "U_Remarks1": "${checkOut.U_Remarks1}",
          "U_Remarks2": "${checkOut.U_Remarks2}",
          "U_COLatitude": "${checkOut.U_COLatitude}",
          "U_COLongitude": "${checkOut.U_COLongitude}",
          "U_Link1": "${checkOut.U_Link1}",
          "U_Link2": "${checkOut.U_Link2}",
          "U_Link3": "${checkOut.U_Link3}",
          "U_Link4": "${checkOut.U_Link4}",
          "U_Products": "${checkOut.U_Products}",
          "U_BrandContr": "${checkOut.U_BrandContr}",
          "U_PPComp": "${checkOut.U_PPComp}",
          "U_BrandinPromo": "${checkOut.U_BrandinPromo}",
          "U_CheckedIn": "${checkOut.U_CheckedIn}",
          "U_Advertise": "${checkOut.U_Advertise}",
          "U_AdvFormt": "${checkOut.U_AdvFormt}",
          "U_NxtFollowup": "${checkOut.U_NxtFollowup}",
          "U_Status": "${checkOut.U_status}",
          "U_Project": "${checkOut.U_Project}",
          "U_Customer": "${checkOut.U_Customer}",
          "U_Consultant": "${checkOut.U_Consultant}",
          "U_Subgroup": "${checkOut.U_Subgroup}",
          "U_CheckOutAdd": "${checkOut.U_CheckOutAdd}",
        }),
      );
      print("check out: " + response.body);
      // print("Patch active code: " +response.statusCode .toString());
      return PatchVisitModel.fromJson(response.body, response.statusCode);
    } catch (e) {
      //  throw Exception("Exception: $e");
      return PatchVisitModel.fromJson(e.toString(), 500);
    }
  }
}

class CheckOutModel {
  int? clgCode;
  String? Notes;
  String? Closed;
  String? CloseDate;
  String? EndTime; //changed
  double? Duration;
  String? DurationType;
  double? U_OrdProsValue;
  double? U_PymntVal;
  String? U_Complaints;
  String? U_Remarks1;
  String? U_Remarks2;
  String? U_COLatitude;
  String? U_COLongitude;
  String? U_Link1;
  String? U_Link2;
  String? U_Link3;
  String? U_Link4;
  String? U_Products;
  String? U_BrandContr;
  String? U_PPComp;
  String? U_BrandinPromo;
  String? U_CheckedIn;
  String? U_Advertise;
  String? U_AdvFormt;
  String? U_NxtFollowup;
  String? U_status;
  String? U_Project;
  String? U_Customer;
  String? U_Consultant;
  String? U_Subgroup;
  String? U_CheckOutAdd;

  CheckOutModel({
    this.U_CheckOutAdd,
    this.clgCode,
    this.Closed,
    this.Duration,
    this.Notes,
    this.CloseDate,
    this.DurationType,
    this.EndTime,
    this.U_AdvFormt,
    this.U_Advertise,
    this.U_BrandContr,
    this.U_BrandinPromo,
    this.U_COLatitude,
    this.U_COLongitude,
    this.U_CheckedIn,
    this.U_Complaints,
    this.U_Link1,
    this.U_Link2,
    this.U_Link3,
    this.U_Link4,
    this.U_NxtFollowup,
    this.U_OrdProsValue,
    this.U_PPComp,
    this.U_Products,
    this.U_PymntVal,
    this.U_Remarks1,
    this.U_Remarks2,
    this.U_status,
    this.U_Consultant,
    this.U_Customer,
    this.U_Project,
    this.U_Subgroup,
  });

  Map<String, Object?> toMap() => {
        PostCheckOut.U_CheckOutAdd: U_CheckOutAdd,
        PostCheckOut.CloseDate: CloseDate,
        PostCheckOut.Closed: Closed,
        PostCheckOut.Duration: Duration,
        PostCheckOut.EndTime: EndTime,
        PostCheckOut.Notes: Notes,
        PostCheckOut.UAdvFormt: U_AdvFormt,
        PostCheckOut.UAdvertise: U_Advertise,
        PostCheckOut.UStatus: U_status,
        PostCheckOut.U_BrandContr: U_BrandContr,
        PostCheckOut.U_BrandinPromo: U_BrandinPromo,
        PostCheckOut.U_COLatitude: U_COLatitude,
        PostCheckOut.U_COLongitude: U_COLongitude,
        PostCheckOut.U_Complaints: U_Complaints,
        PostCheckOut.U_NxtFollowup: U_NxtFollowup,
        PostCheckOut.U_OrdProsValue: U_OrdProsValue,
        PostCheckOut.U_PPComp: U_PPComp,
        PostCheckOut.U_Products: U_Products,
        PostCheckOut.U_PymntVal: U_PymntVal,
        PostCheckOut.U_Remarks1: U_Remarks1,
        PostCheckOut.U_Remarks2: U_Remarks2,
        PostCheckOut.clgCode: clgCode,
        PostCheckOut.U_Project: U_Project,
        PostCheckOut.U_Consultant: U_Consultant,
        PostCheckOut.U_Customer: U_Customer,
        PostCheckOut.U_Subgroup: U_Subgroup,
      };
}
