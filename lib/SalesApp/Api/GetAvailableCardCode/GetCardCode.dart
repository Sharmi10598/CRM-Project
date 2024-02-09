// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, require_trailing_commas

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/SalesApp/Model/GetAvailCardCode/GetAvailCardCode.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class GetAvaCardCodeAPi {
  static Future<GetAvalCardCodeModel> getGlobalData() async {
    try {
      final response = await http.post(
        Uri.parse(URL.dynamicUrl),
        headers: {
          'content-type': 'application/json',
          },
         body: json.encode({
              "constr": "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
              "query": "select 'L' + Replicate('0',4-Len(max(LastCardCode)+1)) + convert(varchar,max(LastCardcode)+1) as lastcardcode from (select Case when Left(Cardcode,1) = 'L' then convert(int,Right(cardcode,len(CardCode)-1)) else  (convert(int,cardcode)) End lastcardcode from ocrd where CardType  = 'L') t",//'${GetValues.slpCode}'
          })
      );

      log("DataL "+json.encode({
              "constr": "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
              "query": "select 'L' + Replicate('0',4-Len(max(LastCardCode)+1)) + convert(varchar,max(LastCardcode)+1) as lastcardcode from (select Case when Left(Cardcode,1) = 'L' then convert(int,Right(cardcode,len(CardCode)-1)) else  (convert(int,cardcode)) End lastcardcode from ocrd where CardType  = 'L') t"
          }));
     
      // print('B1SESSION='+ GetValues.sessionID.toString());
      // print('odata.maxpagesize=${GetValues.maximumfetchValue}');
      print("customer code numbr: " + json.decode(response.body).toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        return GetAvalCardCodeModel.fromJson( response.body,response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return GetAvalCardCodeModel.fromJson( response.body,response.statusCode);
      }
    } catch (e) {
      //  throw Exception("Exception: $e");
      return GetAvalCardCodeModel.fromJson(e.toString(),500);
    }
  }
}
