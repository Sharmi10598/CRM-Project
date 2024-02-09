// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, avoid_print, file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_oder/GetDiscountModel/GetDiscountModel.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';


class DiscountAPi{

  static Future<Discountdata> getGlobalData(String cardcode,String itemcode, String qty, String date) async {
  print(json.encode({
        //  "{
"ItemPriceParams": {
"CardCode": cardcode,
"ItemCode": itemcode,
"UoMQuantity": qty,
"Date":date
}
//}"
         }),);
    try {
    final response = await http.post(
        Uri.parse(
     URL.url+"CompanyService_GetItemPrice",//CompanyService_GetItemPrice
    
      ),
        headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+ GetValues.sessionID.toString(),
        },

        body: json.encode({
        //  "{
"ItemPriceParams": {
"CardCode": cardcode,
"ItemCode": itemcode,
"UoMQuantity": qty,
"Date":date
}
//}"
         }),
      );
      if (response.statusCode == 200) {
         print("res od: "+json.decode(response.body).toString());
         print("res stcode: "+response.statusCode.toString());
        return Discountdata.fromJson(json.decode(response.body)as Map<String,dynamic>);
      } else {
         print('res od: '+json.decode(response.body).toString());
         print("res stcode: "+response.statusCode.toString());
      //  throw Exception('Restart the app or contact the admin!!..');
    return Discountdata.error(json.decode(response.body)as Map<String,dynamic>);
      }
    } catch (e) {
     // throw Exception(e);
     return Discountdata.exception('$e');
    }
  }
}
