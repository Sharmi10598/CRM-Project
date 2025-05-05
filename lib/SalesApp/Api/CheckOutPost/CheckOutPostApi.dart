import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/SalesApp/Model/VisitAproval/VisitAproval.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/DB/DBModal/GetApprovedCust.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class CheckOutPatchAPi {
  static checkoutMethod(CheckOutModel checkOut) {
    log(
      'CheckOutPatchAPi::${json.encode({
            "notes": "${checkOut.notes}", //visit discussion
            "closed": "${checkOut.closed}",
            "closedate": "${checkOut.closedate}",
            "endTime": "${checkOut.endTime}",
            "duration": "${checkOut.duration}",
            // "durationType": ""${checkOut}",
            "U_OrdProsValue": "${checkOut.uOrdProsValue}",
            "U_PymntVal": "${checkOut.uPymntVal}",
            "U_Complaints": "${checkOut.uComplaints}",
            "U_Remarks1": "${checkOut.uRemarks1}",
            "U_Remarks2": "${checkOut.uRemarks2}",
            "U_COLatitude": "${checkOut.uCOLatitude}",
            "U_COLongitude": "${checkOut.uCOLongitude}",
            "U_Link1": "${checkOut.uLink1}",
            "U_Link2": "${checkOut.uLink2}",
            "U_Link3": "${checkOut.uLink3}",
            "U_Link4": "${checkOut.uLink4}",
            "U_Products": "${checkOut.uProducts}",
            "U_BrandContr": "${checkOut.uBrandContr}",
            "U_PPComp": "${checkOut.uPPComp}",
            "U_BrandinPromo": "${checkOut.uBrandinPromo}",
            "U_CheckedIn": "${checkOut.uCheckedIn}",
            "U_Advertise": "${checkOut.uAdvertise}",
            "U_AdvFormt": "${checkOut.uAdvFormt}",
            "U_NxtFollowup": "${checkOut.uNxtFollowup}",
            'U_Status': "${checkOut.ustatus}",
            "U_Project": "${checkOut.uProject}",
            "U_Customer": "${checkOut.uCustomer}",
            "U_Consultant": "${checkOut.uConsultant}",
            "U_Subgroup": "${checkOut.uSubgroup}",
            "U_CheckOutAdd": "${checkOut.uCheckOutAdd}",
          })}',
    );
  }

  static Future<PatchVisitModel> getGlobalData(CheckOutModel checkOut) async {
    try {
      log('${GetValues.sessionID}');
      log('${URL.url}Activities(${checkOut.clgCode})');
      final response = await http.patch(
        Uri.parse('${URL.url}Activities(${checkOut.clgCode})'),
        headers: {
          'content-type': 'application/json',
          'cookie': 'B1SESSION=${GetValues.sessionID}',
        },
        body: json.encode({
          'Notes': '${checkOut.notes}', //visit discussion
          'Closed': '${checkOut.closed}',
          'CloseDate': '${checkOut.closedate}',
          'EndTime': '${checkOut.endTime}',
          'Duration': '${checkOut.duration}',
          'U_OrdProsValue': '${checkOut.uOrdProsValue}',
          'U_PymntVal': '${checkOut.uPymntVal}',
          'U_Complaints': '${checkOut.uComplaints}',
          'U_Remarks1': '${checkOut.uRemarks1}',
          'U_Remarks2': '${checkOut.uRemarks2}',
          'U_COLatitude': '${checkOut.uCOLatitude}',
          'U_COLongitude': '${checkOut.uCOLongitude}',
          'U_Link1': '${checkOut.uLink1}',
          'U_Link2': '${checkOut.uLink2}',
          'U_Link3': '${checkOut.uLink3}',
          'U_Link4': '${checkOut.uLink4}',
          'U_Products': '${checkOut.uProducts}',
          'U_BrandContr': '${checkOut.uBrandContr}',
          'U_PPComp': '${checkOut.uPPComp}',
          'U_BrandinPromo': '${checkOut.uBrandinPromo}',
          'U_CheckedIn': '${checkOut.uCheckedIn}',
          'U_Advertise': '${checkOut.uAdvertise}',
          'U_AdvFormt': '${checkOut.uAdvFormt}',
          'U_NxtFollowup': '${checkOut.uNxtFollowup}',
          'U_Status': '${checkOut.ustatus}',
          'U_Project': '${checkOut.uProject}',
          'U_Customer': '${checkOut.uCustomer}',
          'U_Consultant': '${checkOut.uConsultant}',
          'U_Subgroup': '${checkOut.uSubgroup}',
          'U_CheckOutAdd': '${checkOut.uCheckOutAdd}',
        }),
      );

      log(
        'CheckOutPatchAPi::${json.encode({
              "Notes": "${checkOut.notes}", //visit discussion
              "Closed": "${checkOut.closed}",
              "CloseDate": "${checkOut.closedate}",
              "EndTime": "${checkOut.endTime}",
              "Duration": "${checkOut.duration}",
              // "durationType": ""${checkOut}",
              "U_OrdProsValue": "${checkOut.uOrdProsValue}",
              "U_PymntVal": "${checkOut.uPymntVal}",
              "U_Complaints": "${checkOut.uComplaints}",
              "U_Remarks1": "${checkOut.uRemarks1}",
              "U_Remarks2": "${checkOut.uRemarks2}",
              "U_COLatitude": "${checkOut.uCOLatitude}",
              "U_COLongitude": "${checkOut.uCOLongitude}",
              "U_Link1": "${checkOut.uLink1}",
              "U_Link2": "${checkOut.uLink2}",
              "U_Link3": "${checkOut.uLink3}",
              "U_Link4": "${checkOut.uLink4}",
              "U_Products": "${checkOut.uProducts}",
              "U_BrandContr": "${checkOut.uBrandContr}",
              "U_PPComp": "${checkOut.uPPComp}",
              "U_BrandinPromo": "${checkOut.uBrandinPromo}",
              "U_CheckedIn": "${checkOut.uCheckedIn}",
              "U_Advertise": "${checkOut.uAdvertise}",
              "U_AdvFormt": "${checkOut.uAdvFormt}",
              "U_NxtFollowup": "${checkOut.uNxtFollowup}",
              "U_Status": "${checkOut.ustatus}",
              "U_Project": "${checkOut.uProject}",
              "U_Customer": "${checkOut.uCustomer}",
              "U_Consultant": "${checkOut.uConsultant}",
              "U_Subgroup": "${checkOut.uSubgroup}",
              "U_CheckOutAdd": "${checkOut.uCheckOutAdd}",
            })}',
      );
      log('check out res: ${response.body}');
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
  String? notes;
  String? closed;
  String? closedate;
  String? endTime; //changed
  double? duration;
  String? durationType;
  double? uOrdProsValue;
  double? uPymntVal;
  String? uComplaints;
  String? uRemarks1;
  String? uRemarks2;
  String? uCOLatitude;
  String? uCOLongitude;
  String? uLink1;
  String? uLink2;
  String? uLink3;
  String? uLink4;
  String? uProducts;
  String? uBrandContr;
  String? uPPComp;
  String? uBrandinPromo;
  String? uCheckedIn;
  String? uAdvertise;
  String? uAdvFormt;
  String? uNxtFollowup;
  String? ustatus;
  String? uProject;
  String? uCustomer;
  String? uConsultant;
  String? uSubgroup;
  String? uCheckOutAdd;

  CheckOutModel({
    this.uCheckOutAdd,
    this.clgCode,
    this.closed,
    this.duration,
    this.notes,
    this.closedate,
    this.durationType,
    this.endTime,
    this.uAdvFormt,
    this.uAdvertise,
    this.uBrandContr,
    this.uBrandinPromo,
    this.uCOLatitude,
    this.uCOLongitude,
    this.uCheckedIn,
    this.uComplaints,
    this.uLink1,
    this.uLink2,
    this.uLink3,
    this.uLink4,
    this.uNxtFollowup,
    this.uOrdProsValue,
    this.uPPComp,
    this.uProducts,
    this.uPymntVal,
    this.uRemarks1,
    this.uRemarks2,
    this.ustatus,
    this.uConsultant,
    this.uCustomer,
    this.uProject,
    this.uSubgroup,
  });

  Map<String, Object?> toMap() => {
        PostCheckOut.U_CheckOutAdd: uCheckOutAdd,
        PostCheckOut.CloseDate: closedate,
        PostCheckOut.Closed: closed,
        PostCheckOut.Duration: duration,
        PostCheckOut.EndTime: endTime,
        PostCheckOut.Notes: notes,
        PostCheckOut.UAdvFormt: uAdvFormt,
        PostCheckOut.UAdvertise: uAdvertise,
        PostCheckOut.UStatus: ustatus,
        PostCheckOut.U_BrandContr: uBrandContr,
        PostCheckOut.U_BrandinPromo: uBrandinPromo,
        PostCheckOut.U_COLatitude: uCOLatitude,
        PostCheckOut.U_COLongitude: uCOLongitude,
        PostCheckOut.U_Complaints: uComplaints,
        PostCheckOut.U_NxtFollowup: uNxtFollowup,
        PostCheckOut.U_OrdProsValue: uOrdProsValue,
        PostCheckOut.U_PPComp: uPPComp,
        PostCheckOut.U_Products: uProducts,
        PostCheckOut.U_PymntVal: uPymntVal,
        PostCheckOut.U_Remarks1: uRemarks1,
        PostCheckOut.U_Remarks2: uRemarks2,
        PostCheckOut.clgCode: clgCode,
        PostCheckOut.U_Project: uProject,
        PostCheckOut.U_Consultant: uConsultant,
        PostCheckOut.U_Customer: uCustomer,
        PostCheckOut.U_Subgroup: uSubgroup,
      };
}
