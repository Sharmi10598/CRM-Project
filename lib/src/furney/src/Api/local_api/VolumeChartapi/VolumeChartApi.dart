import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/VolumeChartModal/VolumeChartModal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class GetVolumeChartApi {
  static String? slpCode;

  static Future<VolumeChartModal> getVolumeChartData() async {
    log('GetValues.slpCode ${GetValues.slpCode}');
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
          'query':
              "exec SalesTarget_AchVolume '${GetValues.slpCode}'", //'${GetValues.slpCode}'
        }),
      );
      log('VolumeChartApi::${json.decode(response.body)}');
      // print('B1SESSION='+ GetValues.sessionID.toString());
      // print('odata.maxpagesize=${GetValues.maximumfetchValue}');
      if (response.statusCode == 200) {
        //   print(json.decode(response.body));
        return VolumeChartModal.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
          response.statusCode,
        );
      } else {
        // throw Exception("Error!!...");
        return VolumeChartModal.issue(response.statusCode);
      }
    } catch (e) {
      //  throw Exception("Exception: $e");
      return VolumeChartModal.issue(500);
    }
  }
}
