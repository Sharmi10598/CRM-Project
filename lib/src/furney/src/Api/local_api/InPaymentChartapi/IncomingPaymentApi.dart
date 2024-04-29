
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/InPaymentChartModal/InPaymentChartModal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class GetInPaymentChartApi{
  static String? slpCode;

  static Future<InPaymentChartModal> getInPaymentChartData() async {
    print('GetValues.slpCode ${GetValues.slpCode}');
    try {
      final response = await http.post(
        Uri.parse(URL.dynamicUrl),
        headers: {
          'content-type': 'application/json',
          },
         body: json.encode({
              'constr': 
                'Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=${GetValues.sapPassword};',

              // 'Server=INSIGNIAC03313;Database=InsigniaLimited;User Id=sa; Password=Insignia@2021#;',
              'query': "exec SalesTarget_AchCollection '${GetValues.slpCode}'",//'${GetValues.slpCode}'
          }),
      );
          log('PaymentChar::'+json.decode(response.body).toString());
    
     if (response.statusCode == 200) {
        //   print(json.decode(response.body));
        return InPaymentChartModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>,response.statusCode,);
      } else {
        // throw Exception("Error!!...");
        return InPaymentChartModal.issue(response.statusCode);
      }
    } catch (e) {
      //  throw Exception("Exception: $e");
      return InPaymentChartModal.issue(500);
    }
  }

}
