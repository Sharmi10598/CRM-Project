// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, require_trailing_commas

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/SalesApp/Model/VistListModel/VisitListModel.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class GetVisitListAPi {
  static Future<VistListModel> getGlobalData(String date) async {
    try {
      final response = await http.post(
        Uri.parse(URL.dynamicUrl),
        headers: {
          'content-type': 'application/json',
          },
         body: json.encode({
              "constr": "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
              "query": "select ClgCode ,T1.CardCode , CardName , T2.Name  ,T0.Details , U_Status,CntctSbjct,U_PlanDate,U_PlanTime,(Select Max(CntctDate) From OCLG A Where CardCOde = T0.CardCode and SlpCode = T0.SlpCode And A.U_Latitude is Not Null ) LastVisit,Case When U_COLatitude is Not NULL Then 'Completed' Else Case When U_PlanDate > Getdate() And T0.U_Latitude is Null Then 'Up Coming' Else Case When DateDiff(d,U_PlanDate,Getdate()) < 30 Then 'Not Visited' End End End VisitStatus from OCLG T0 Inner join OCRD T1 on T0.CardCode  = T1.CardCode inner join OCLS T2 on T2.Code = T0.CntctSbjct where U_PlanDate = '$date' and U_status !='H' and T0.slpcode = '${GetValues.slpCode}'", //'${GetValues.slpCode}'
          })
      );
     
      log(json.encode({
              "constr": "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
          "query": "select ClgCode ,T1.CardCode , CardName , T2.Name  ,T0.Details , U_Status,CntctSbjct,U_PlanDate,U_PlanTime,(Select Max(CntctDate) From OCLG A Where CardCOde = T0.CardCode and SlpCode = T0.SlpCode And A.U_Latitude is Not Null ) LastVisit,Case When U_COLatitude is Not NULL Then 'Completed' Else Case When U_PlanDate > Getdate() And T0.U_Latitude is Null Then 'Up Coming' Else Case When DateDiff(d,U_PlanDate,Getdate()) < 30 Then 'Not Visited' End End End VisitStatus from OCLG T0 Inner join OCRD T1 on T0.CardCode  = T1.CardCode inner join OCLS T2 on T2.Code = T0.CntctSbjct where U_PlanDate = '$date'and U_status !='H' and T0.slpcode = '${GetValues.slpCode}'"
   }));
      // print('B1SESSION='+ GetValues.sessionID.toString());
      // print('odata.maxpagesize=${GetValues.maximumfetchValue}');
      // print("customer details: " + json.decode(response.body).toString());
      // print(response.statusCode);
        return VistListModel.fromJson( response.body,response.statusCode);
  
        // throw Exception("Error!!...");
    } catch (e) {
      //  throw Exception("Exception: $e");
      return VistListModel.fromJson(e.toString(),500);
    }
  }
}
