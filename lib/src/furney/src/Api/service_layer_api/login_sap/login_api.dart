// import 'dart:convert';
// import 'dart:developer';
// import '../../../Modal/service_layer_modal/Login_sap_modal/login_data.dart';
// import '../../../widgets/Drawer.dart';
// import '../../url/url.dart';
// import 'package:http/http.dart' as http;

// class PostLoginAPi {
//   static String? username;
//   static String? password;
//   static logMethod() {
//     log(
//       json.encode({
//         'CompanyDB': '${GetValues.sapDB}',
//         'UserName': '$username', //crmapp
//         'Password': '$password' //Tanzania
//       }),
//     );
//   }

//   static Future<Logindata> getGlobalData() async {
//     try {
//       log('SAP Login::' + '${URL.url}Login');
//     final response = await http.post(
//         Uri.parse(
//           '${URL.url}Login',
//         ),
//         // headers: {'Content-Type': 'application/json'},
//         body: json.encode({
          // 'CompanyDB': 'Zambia_UAT',
          // 'UserName': 'manager',
          // 'Password': 'ins@zambia'
//         }),
//       );
//       log('statusCode::${response.statusCode}');
//       print('saplogin: ${response.body}');

//       if (response.statusCode == 200) {
//         // || response.statusCode <= 210
//         // print("saplogin: "+json.decode(response.body).toString());
//         // print(response.statusCode.toString());
//         return Logindata.fromJson(
//             json.decode(response.body) as Map<String, dynamic>,
//             response.statusCode,);
//       } else {
//         print('saplogin: ${json.decode(response.body)}');
//         print(response.statusCode);
//         // throw Exception('Err');
//         return Logindata.error(
//             json.decode(response.body) as Map<String, dynamic>,
//             response.statusCode);
//       }
//     } catch (e) {
//       log('catch message::$e');
//       // throw Exception('Exceptionsss: $e');
//       return Logindata.issue('Restart the app or contact the admin!!..', 500);
//     }
//   }
// }
