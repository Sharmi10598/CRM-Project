import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/Login_sap_modal/login_data.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class PostSAPLoginAPi {
  static String? username;
  static String? password;

  static Future<Logindata> getGlobaldData() async {
    log(
      'sapDet:${URL.url}Login::${json.encode({
            'CompanyDB': '${GetValues.sapDB}',
            'UserName': '$username',
            'Password': '$password',
          })}',
    );
    try {
      final response = await http.post(
        Uri.parse(
          '${URL.url}Login',
        ),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'CompanyDB': '${GetValues.sapDB}',
          'UserName': '$username',
          'Password': '$password',
        }),
      );
      log('saplogin sts: ${response.statusCode}');

      log('saplogin: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return Logindata.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
          response.statusCode,
        );
      } else if (response.statusCode >= 200 && response.statusCode <= 210) {
        // print('saplogin: ${json.decode(response.body)}');
        // print(response.statusCode);
        return Logindata.error(
          json.decode(response.body) as Map<String, dynamic>,
          response.statusCode,
        );
      } else {
        return Logindata.error(
          json.decode(response.body) as Map<String, dynamic>,
          response.statusCode,
        );
      }
    } catch (e) {
      log('catch message::$e');
      // throw Exception('Exceptionsss: $e');
      return Logindata.issue('Restart the app or contact the admin!!..', 500);
    }
  }
}
