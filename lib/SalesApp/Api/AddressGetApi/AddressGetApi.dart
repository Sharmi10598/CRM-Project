import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/SalesApp/Model/AddressApiModel/AddressMoasterModel.dart';

class AddressMasterApi {
  static Future<AddressrModel> getData(String lan, String long) async {

    try {
      log('addapi::'
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lan,$long&key=AIzaSyA5hgVuwQMn60iwC7jh098QjJOT5T8Vwe0');
      // await config.getSetup();
      final response = await http.get(
        Uri.parse(
            'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lan,$long&key=AIzaSyA5hgVuwQMn60iwC7jh098QjJOT5T8Vwe0',),
        headers: {
          'content-type': 'application/json',
        },
      );
      // log("ADDRESS:::${response.body}");
      // log("sk_Address_master_data${json.decode(response.body)}");
      if (response.statusCode == 200) {
        // Map data = json.decode(response.body);
        return AddressrModel.fromJson(
          json.decode(response.body),
          response.statusCode,
        );
      } else {
        log('Error: ${json.decode(response.body)}');
        throw Exception('Error');
        // return AddressrModel.error('Error', resCode);
      }
    } catch (e) {
      log('Exception:$e' );
      throw Exception(e.toString());
      // return AddressrModel.error(e.toString(), resCode);
    }
  }
}
