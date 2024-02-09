// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, avoid_print, file_names, omit_local_variable_types

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_oder/approvals_order_modal/approvals_order_modal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';


class RejectedORPendingAPi{

  static Future<ApprovalsOrdersModal> getGlobalData(String slpCode1,String searchValue1,String fromDate1,String toDate1,String callWhichApi1) async {
   final String rejectURl = URL.url+"SQLQueries('RejectedList')/List?SlpCode=$slpCode1&CardCode='$searchValue1'&FDate='$fromDate1'&TDate='$toDate1'";
   final String pendingURl = URL.url+"SQLQueries('PendingList')/List?SlpCode=$slpCode1&CardCode='$searchValue1'&FDate='$fromDate1'&TDate='$toDate1'";
    final String callWhichApi = callWhichApi1;
  final String url =   callWhichApi=="Rejected"?rejectURl:callWhichApi=="Pending"?pendingURl:'';
    print(url);
    try {
    final response = await http.get(
        Uri.parse(
      url,
      ),
        headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+ GetValues.sessionID.toString(),
        'Prefer': 'odata.maxpagesize=1000'//${GetValues.maximumfetchValue}
        },
      );
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return ApprovalsOrdersModal.fromJson(json.decode(response.body)as Map<String,dynamic>);
      } else {
        //  print(json.decode(response.body));
        //    print(json.decode(response.statusCode.toString()));
        throw Exception('Restart the app or contact the admin!!..');
   // return ApprovalsOrdersModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      throw Exception(e);
     // return ApprovalsOrdersModal.issue('Restart the app or contact the admin!!..');
    }
  }
}
