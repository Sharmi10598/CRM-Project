import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/customer_bp/SeriesModel.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class GetSeriesApiAPi {
  static Future<SeriesModel> getGlobalData() async {
    try {
      final response = await http.post(
        Uri.parse(URL.dynamicUrl),
        headers: {
          'content-type': 'application/json',
        },
        body: json.encode({
          'constr':
              'Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=${GetValues.sapPassword};',
          'query':
              "Select Series, SeriesName From nnm1 Where ObjectCode = '2' And DocSubType = 'C'",
        }),
      );

      // print('B1SESSION='+ GetValues.sessionID.toString());
      // print('odata.maxpagesize=${GetValues.maximumfetchValue}');
      // log("SERIES API: " + json.decode(response.body).toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        return SeriesModel.fromJson(response.body, response.statusCode);
      } else {
        print('Exception: Error');
        return SeriesModel.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      print('Exception: $e');
      //  throw Exception("Exception: $e");
      return SeriesModel.fromJson(e.toString(), 500);
    }
  }
}
