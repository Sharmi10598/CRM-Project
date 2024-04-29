// ignore_for_file: file_names, prefer_single_quotes, require_trailing_commas, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/SchemeQuteModel/SchemeQuteModel.dart';

class SchemeQuteAPi {
  static Future<SchemeQuteModal> getGlobalData(
      List<SalesQuteScheme> salesOderSchene) async {
    try {
      final response =
          await http.post(Uri.parse('${URL.urlLocal}DisCalculation_Quo'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "SCHEMES": salesOderSchene.map((e) => e.toMap()).toList(),
              }));
      log('${URL.urlLocal}DisCalculation_Quo');
      log("SCHEMES Json: " +
          json.encode(
              {"SCHEMES": salesOderSchene.map((e) => e.toMap()).toList()}));

      log("json SCHEMES Res: " + response.body);
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return SchemeQuteModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        print(json.decode(response.body));
        print(json.decode(response.body));
        // throw Exception("Error!!...");
        return SchemeQuteModal.issue(
          response.statusCode,
        );
      }
    } catch (e) {
      //  throw Exception("Exceptionsss: $e");
      return SchemeQuteModal.exception(
          'Restart the app or contact the admin!!..', 500);
    }
  }
}
