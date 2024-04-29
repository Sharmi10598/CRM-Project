// ignore_for_file: require_trailing_commas, unnecessary_parenthesis

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/SalesChart_modal/SalesChart_modal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class GetSalesChartApi {
  static String? slpCode;

  static Future<SalesChartModal> getSalesChartData() async {
    print('GetValues.slpCode ${GetValues.slpCode}');
    try {
      final response = await http.post(Uri.parse(URL.dynamicUrl),
          headers: {
            'content-type': 'application/json',
          },
          body: json.encode({
            'constr':
                'Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=${GetValues.sapPassword};',

            // 'Server=INSIGNIAC03313;Database=InsigniaLimited;User Id=sa; Password=Insignia@2021#;',
            'query':
                "exec SalesTarget_AchSales '${GetValues.slpCode}'", //'${GetValues.slpCode}'
          }));
          log(json.encode({
            'constr':
                'Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=${GetValues.sapPassword};',

            // 'Server=INSIGNIAC03313;Database=InsigniaLimited;User Id=sa; Password=Insignia@2021#;',
            'query':
                "exec SalesTarget_AchSales '${GetValues.slpCode}'", //'${GetValues.slpCode}'
          }));
      log("SalesChart res::${json.decode(response.body)}");
      if (response.statusCode == 200) {
        return SalesChartModal.fromJson(
            (json.decode(response.body) as Map<String, dynamic>),
            response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return SalesChartModal.issue(response.statusCode);
      }
    } catch (e) {
      //  throw Exception("Exception: $e");
      return SalesChartModal.issue(500);
    }
  }
}
