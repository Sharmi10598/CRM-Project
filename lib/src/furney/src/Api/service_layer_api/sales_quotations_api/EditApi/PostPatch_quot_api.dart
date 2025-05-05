import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_quot/post_modal/post_quot_modal.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesQuotEdit/widget/creation/contentEdit_creation.dart';
// import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/creation/content_creation.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class SalesQuotPatchAPi {
  static String? sessionID;
  static String? cardCodePost;
  static List<AddQuotEditItem>? docLineQout;
  static String? docDate;
  static String? dueDate;
  static String? remarks;
  static bool isNewList = false;
  static void method(String? deviceTransID) {
    final data = json.encode({
      'CardCode': '$cardCodePost',
      'DocumentStatus': 'bost_Open',
      'DocDate': '$docDate',
      'DocDueDate': '$dueDate',
      'Comments': '$remarks',
      'U_DeviceTransID': deviceTransID,
      'DocumentLines': docLineQout!.map((e) => e.tojson()).toList(),
    });
    log('post q data :$data');
  } //tojson2

  static Future<SalesQuotStatus> getGlobalData(
    String? deviceTransID,
    int docentry,
  ) async {
    try {
      log('${URL.url}Quotations($docentry)');
      final response = await http.patch(
        Uri.parse(
          '${URL.url}Quotations($docentry)',
        ),
        headers: {
          'content-type': 'application/json',
          'cookie': 'B1SESSION=${GetValues.sessionID}',
          //'Prefer':'return-no-content'
        },
        body: json.encode({
          'CardCode': '$cardCodePost',
          'DocumentStatus': 'bost_Open',
          'DocDate': '$docDate',
          'DocDueDate': '$dueDate',
          'U_DeviceTransID': deviceTransID,
          'DocumentLines': docLineQout!.map((e) => e.tojson()).toList(),
        }),
      );

      log(
        'Patch datatatat:${json.encode({
              'CardCode': '$cardCodePost',
              'DocumentStatus': 'bost_Open',
              'DocDate': '$docDate',
              'DocDueDate': '$dueDate',
              'Comments': '$remarks',
              'U_DeviceTransID': deviceTransID,
              'DocumentLines': docLineQout!.map((e) => e.tojson()).toList(),
            })}',
      );
      log('Responce:${response.body}');
      // log('statucCode QUT EDITS:'+response.statusCode.toString());
      // log('Quotations post:'+json.decode(response.body.toString()).toString());
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        return SalesQuotStatus.fromJson(response.statusCode);
      } else {
        return SalesQuotStatus.errorIN(
          json.decode(response.body) as Map<String, dynamic>,
          response.statusCode,
        );
      }
    } catch (e) {
      log(e.toString());
      //  throw Exception(e);
      return SalesQuotStatus.issue(
        'Restart the app or contact the admin!!..\n',
      );
    }
  }
}
