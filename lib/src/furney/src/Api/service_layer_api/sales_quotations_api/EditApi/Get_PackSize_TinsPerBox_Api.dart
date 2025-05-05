import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_quotations_api/EditApi/GetTinsPerbox_PackSize.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class GetPackANDTinsPerBoxApi {
  static Future<GetPackSizeModel> getGlobalData(String? itemcode) async {
    try {
      log('New:::$itemcode:::${URL.dynamicUrl}');
      log("GetPackANDTinsPerBoxApi:::${json.encode(
        {
          "constr":
              "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=${GetValues.sapPassword};",

          // "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
          "query":
              "select U_Pack_Size,U_Tins_Per_Box from oitm where itemcode='$itemcode'"
          // "select U_Pack_Size,U_Tins_Per_Box from oitm where itemcode='5000706C'"
          ,
        },
      )}");

      final response = await http.post(
        Uri.parse(URL.dynamicUrl),
        headers: {
          'content-type': 'application/json',
        },
        body: json.encode(
          {
            'constr':
                'Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=${GetValues.sapPassword};',

            // "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
            'query':
                "select U_Pack_Size,U_Tins_Per_Box from oitm where itemcode='$itemcode'",
            // "select U_Pack_Size,U_Tins_Per_Box from oitm where itemcode='5000706C'"
          },
        ),
      );

      // log('B1SESSION='+ GetValues.sessionID.toString());
      // log('odata.maxpagesize=${GetValues.maximumfetchValue}');
      // log("checkdddd innn: " + json.decode(response.body).toString());
      log('statusCode::${response.statusCode}');
      if (response.statusCode == 200) {
        return GetPackSizeModel.fromJson(response.body, response.statusCode);
      } else {
        log('Exception: Error');
        return GetPackSizeModel.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      log('Exception: $e');
      //  throw Exception("Exception: $e");
      return GetPackSizeModel.fromJson(e.toString(), 500);
    }
  }
}
