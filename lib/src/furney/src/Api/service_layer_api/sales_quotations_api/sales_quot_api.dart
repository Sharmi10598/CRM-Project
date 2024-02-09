// // ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, omit_local_variable_types

// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
// import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_quot/sales_quot_modal.dart';
// import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, require_trailing_commas, unused_import, always_use_package_imports, duplicate_ignore

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/helpers/uikit_model.dart';
import '../../../../../../SalesApp/Model/GetActivities/GetContApi.dart';
// ignore: always_use_package_imports
import '../../../Modal/SalesQuaModel/AllSalesQuaModel.dart';
import '../../../Modal/service_layer_modal/sales_quot/sales_quot_modal.dart';
import '../../../widgets/Drawer.dart';
import '../../url/url.dart';

class SalesQuotAPi {
  static String? nextUrl;
  static String? searchValue;
  static Future<SalesQuotModal> getGlobalData(
      String fromDate, String toDate) async {
    try {
      log(URL.dynamicUrl);
      final response = await http.post(Uri.parse(URL.dynamicUrl),
          headers: {
            'content-type': 'application/json',
          },
          body: json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
            "query":
                "[BZ_CRM_GET_QUOTATION_BY_SLPCODE] '${GetValues.slpCode}','$fromDate','$toDate'", //'${GetValues.slpCode}'
          }));
      log(json.encode({
        "constr":
            "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
        "query":
            "[BZ_CRM_GET_QUOTATION_BY_SLPCODE] '${GetValues.slpCode}','$fromDate','$toDate'" //'${GetValues.slpCode}'
      }));
      log("response statusCode::" + response.statusCode.toString());
      log("response::" + json.decode(response.body).toString());

      if (response.statusCode == 200) {
        return SalesQuotModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>);
      } else {
        // throw Exception("Error!!...");
        return SalesQuotModal.issue(
            json.decode(response.body) as Map<String, dynamic>
            // return SalesQuotModal.issue(
            //   response.body,
            );
      }
    } catch (e) {
      log(e.toString());
      //  throw Exception("Exception: $e");
      return SalesQuotModal.exception(
        e.toString(),
      );
    }
  }
// }
// class SalesQuotAPi {
//   static String? sessionID;
//   static String? nextUrl;
//   static String? searchValue;
//   // static String? fromDate = '';
//   static String? toDate;
//   static String callWhichApi = '';

//   // static String open =
//   //     "Quotations?\$select=DocEntry,DocNum,DocDate,CardCode,CardName,DocumentStatus,CancelStatus&\$orderby=DocDate desc&\$filter=DocumentStatus eq 'bost_Open' and CancelStatus eq 'csNo'and (contains(CardCode,'$searchValue') or contains(CardName,'$searchValue')) and DocDate ge '$fromDate' and DocDate le '$toDate'";
//   // static String closed =
//   //     "Quotations?\$select=DocEntry,DocNum,DocDate,CardCode,CardName,DocumentStatus,CancelStatus&\$orderby=DocDate desc&\$filter=DocumentStatus eq 'bost_Close' and CancelStatus eq 'csNo'and (contains(CardCode,'$searchValue') or contains(CardName,'$searchValue')) and DocDate ge '$fromDate' and DocDate le '$toDate'";

//   static Future<SalesQuotModal> getGlobalData(String fromDate5) async {
//     log("fromDatefromDatefromDate:::${fromDate5}");

//     print("callWhichApi: " + callWhichApi);
//     final String url = callWhichApi == "Open"
//         ? "Quotations?\$select=DocEntry,DocNum,DocDate,CardCode,CardName,DocumentStatus,CancelStatus&\$orderby=DocDate desc&\$filter=DocumentStatus eq 'bost_Open' and CancelStatus eq 'csNo'and (contains(CardCode,'$searchValue') or contains(CardName,'$searchValue')) and DocDate ge '$fromDate5' and DocDate le '$toDate'"
//         // open
//         : callWhichApi == "Closed"
//             ? "Quotations?\$select=DocEntry,DocNum,DocDate,CardCode,CardName,DocumentStatus,CancelStatus&\$orderby=DocDate desc&\$filter=DocumentStatus eq 'bost_Close' and CancelStatus eq 'csNo'and (contains(CardCode,'$searchValue') or contains(CardName,'$searchValue')) and DocDate ge '$fromDate5' and DocDate le '$toDate'"
//             // closed
//             : '';
//     log(
//       "Quotations url: " + (URL.url + url),
//     );
//     // "Quotations?\$select=DocEntry,DocNum,DocDate,CardCode,CardName,DocumentStatus,CancelStatus&\$orderby=DocDate desc&\$filter=DocumentStatus eq 'bost_Open' and CancelStatus eq 'csNo'and (contains(CardCode,'$searchValue') or contains(CardName,'$searchValue')) and DocDate ge '$fromDate5' and DocDate le '$toDate'"));
//     try {
//       final response = await http.get(
//         Uri.parse(
//           //http://102.69.164.12:50001/b1s/v1/DeliveryNotes(10)
//           URL.url + url,
//         ),
//         headers: {
//           "content-type": "application/json",
//           "cookie": 'B1SESSION=' + GetValues.sessionID.toString(),
//           'Prefer': 'odata.maxpagesize=${GetValues.maximumfetchValue}'
//         },
//       );
  // log("response statusCode::" + response.statusCode.toString());
  // log("response::S" + json.decode(response.body).toString());

//       if (response.statusCode == 200) {
//         return SalesQuotModal.fromJson(
//             json.decode(response.body) as Map<String, dynamic>);
//       } else {
//         //  print(json.decode(response.body));
//         //    print(json.decode(response.statusCode.toString()));
//         // throw Exception('Restart the app or contact the admin!!..');
//         return SalesQuotModal.issue('Restart the app or contact the admin!!..');
//       }
//     } catch (e) {
//       // throw Exception(e);
//       return SalesQuotModal.issue('Restart the app or contact the admin!!..');
//     }
//   }

  static Future<SalesQuotModal> callNextLink() async {
    try {
      final response = await http.get(
        Uri.parse(
          //http://102.69.164.12:50001/b1s/v1/DeliveryNotes(10)
          URL.url + nextUrl.toString(),
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + GetValues.sessionID.toString(),
          'Prefer': 'odata.maxpagesize=${GetValues.maximumfetchValue}'
        },
      );
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return SalesQuotModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>);
      } else {
        // print(response.statusCode);
        throw Exception('Restart the app or contact the admin!!..');
        //  return SalesQuotModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      throw Exception('$e');
      //  return SalesQuotModal.issue('Restart the app or contact the admin!!..');
    }
  }

  static Future<SalesQuotModal> searchData() async {
    try {
      final response = await http.get(
        Uri.parse(
          //http://102.69.164.12:50001/b1s/v1/DeliveryNotes(10)
          URL.url +
              "Quotations?\$select=DocEntry,DocNum,DocDate,CardCode,CardName,DocumentStatus,CancelStatus&\$filter=(contains(CardCode,'$searchValue') or contains(CardName,'$searchValue'))&\$orderby= DocDate desc ", //and DocumentStatus eq 'bost_Open'
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + GetValues.sessionID.toString(),
          'Prefer': 'odata.maxpagesize=${GetValues.maximumfetchValue}'
        },
      );
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return SalesQuotModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>);
      } else {
        //  print(json.decode(response.body));
        //    print(json.decode(response.statusCode.toString()));
        throw Exception('Restart the app or contact the admin!!..');
        // return SalesQuotModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      throw Exception(e);
      // return SalesQuotModal.issue('Restart the app or contact the admin!!..');
    }
  }
}
