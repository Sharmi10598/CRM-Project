// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/notes_modal/notes_modal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class NotesAPi{

  static Future<NotesModal> getGlobalData() async {
    try {
    final response = await http.get(
        Uri.parse(
      '${URL.urlLocal}GetMsg/${GetValues.crmUserID}',
      ),
        headers: {
        'content-type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        print('data123:${json.decode(response.body)}');
        return NotesModal.fromJson(json.decode(response.body)as Map<String,dynamic>);
      } else {
       //  print(json.decode(response.body));
        // print(json.decode(response.statusCode.toString()));
        // throw Exception("Error!!...");
      return NotesModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
       print(e);
      // throw Exception("Exceptionsss: $e");
      return NotesModal.exception('Restart the app or contact the admin!!..');
    }
  }
 
}
