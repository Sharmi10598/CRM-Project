// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/customer_bp/NewCustomerModel2.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/customer_bp/customer_modal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class GetCustomerAPi {
  static String? searchValue;
  static String? nextUrl;
  static String? sessionID;
  static String? slpCode;

  // static Future<CustomerModal> getGlobalData() async {
  //   print("GetValues.slpCode "+GetValues.slpCode .toString());
  //   try {
  //   final response = await http.get(
  //       Uri.parse(
  //      URL.url+"/\$crossjoin(BusinessPartners,SalesPersons,PaymentTermsTypes)?\$expand=SalesPersons(\$select=SalesEmployeeName),PaymentTermsTypes(\$select=PaymentTermsGroupName),BusinessPartners(\$select=CardCode,CardName,ShipToDefault,BilltoDefault,CurrentAccountBalance,U_CASHCUST)&\$filter=BusinessPartners/PayTermsGrpCode eq PaymentTermsTypes/GroupNumber and BusinessPartners/SalesPersonCode eq SalesPersons/SalesEmployeeCode and BusinessPartners/CardType eq 'cCustomer' and (BusinessPartners/SalesPersonCode eq ${GetValues.slpCode} or BusinessPartners/U_CASHCUST eq 'Yes')"
  //   //  /\$crossjoin(BusinessPartners,SalesPersons,PaymentTermsTypes)?\$expand=SalesPersons(\$select=SalesEmployeeName),PaymentTermsTypes(\$select=PaymentTermsGroupName),BusinessPartners(\$select=CardCode,CardName,ShipToDefault,BilltoDefault,CurrentAccountBalance,U_CASHCUST)&\$filter=BusinessPartners/PayTermsGrpCode eq PaymentTermsTypes/GroupNumber and BusinessPartners/SalesPersonCode eq SalesPersons/SalesEmployeeCode and BusinessPartners/CardType eq 'cCustomer' and BusinessPartners/SalesPersonCode eq ${GetValues.slpCode}"
  //     ),
  //       headers: {
  //       'content-type': 'application/json',
  //       'cookie': 'B1SESSION='+ GetValues.sessionID.toString(),//'B1SESSION=cd7eff02-46e1-11ec-8000-000c29e6775e',
  //       'Prefer':'odata.maxpagesize=${GetValues.maximumfetchValue}'
  //       },

  //     );
  //     // print('B1SESSION='+ GetValues.sessionID.toString());
  //     // print('odata.maxpagesize=${GetValues.maximumfetchValue}');
  //     print("customer details: "+json.decode(response.body).toString());
  //      print(response.statusCode);
  //     if (response.statusCode == 200) {
  //    //   print(json.decode(response.body));
  //       return CustomerModal.fromJson(json.decode(response.body)as Map<String,dynamic>);
  //     } else {
  //       // throw Exception("Error!!...");
  //     return CustomerModal.issue('Error!!..');
  //     }
  //   } catch (e) {
  //    //  throw Exception("Exception: $e");
  //     return CustomerModal.issue("Restart the app or contact the admin!!..");
  //   }
  // }
  static Future<NewCustomerModal2> getGlobalData() async {
    // print("GetValues.slpCode " + GetValues.slpCode.toString());
    log("GetCustomerAPi::" + URL.dynamicUrl);
    log(
      "Post Det::" +
          json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
            "query": "exec BZ_CRM_GET_CUST_SLPCODE '${GetValues.slpCode}'",
          }),
    );
    try {
      final response = await http.post(
        Uri.parse(URL.dynamicUrl),
        headers: {
          'content-type': 'application/json',
        },
        body: json.encode({
          "constr":
              "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
          "query":
              "exec BZ_CRM_GET_CUST_SLPCODE '${GetValues.slpCode}'", //'${GetValues.slpCode}'
        }),
      );

      // print('B1SESSION='+ GetValues.sessionID.toString());
      // print('odata.maxpagesize=${GetValues.maximumfetchValue}');
      print("customer details: " + json.decode(response.body).toString());
      // print(response.statusCode);
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return NewCustomerModal2.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      } else {
        // throw Exception("Error!!...");
        return NewCustomerModal2.issue('Error!!..');
      }
    } catch (e) {
      //  throw Exception("Exception: $e");
      return NewCustomerModal2.issue(
          "Restart the app or contact the admin!!..");
    }
  }

  static Future<CustomerModal> callNextLink() async {
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
        return CustomerModal.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      } else {
        throw Exception('Restart the app or contact the admin!!..');
        //  return SalesOrderModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      throw Exception('$e');
      //  return SalesOrderModal.issue('Restart the app or contact the admin!!..');
    }
  }

  static Future<CustomerModal> searchData() async {
    //  print( URL.url+"\$crossjoin(BusinessPartners,SalesPersons,PaymentTermsTypes)?\$expand=SalesPersons(\$select=SalesEmployeeName),PaymentTermsTypes(\$select=PaymentTermsGroupName),BusinessPartners(\$select=CardCode,CardName,ShipToDefault,BilltoDefault,CurrentAccountBalance,U_CASHCUST)&\$filter=BusinessPartners/PayTermsGrpCode eq PaymentTermsTypes/GroupNumber and BusinessPartners/SalesPersonCode eq SalesPersons/SalesEmployeeCode and (contains(BusinessPartners/CardCode,'$searchValue') or contains(BusinessPartners/CardName,'$searchValue')) and BusinessPartners/CardType eq 'cCustomer' and (BusinessPartners/SalesPersonCode eq ${GetValues.slpCode} or BusinessPartners/U_CASHCUST eq 'Yes')");
    try {
      final response = await http.get(
        Uri.parse(
          //http://102.69.164.12:50001/b1s/v1/DeliveryNotes(10)

          URL.url +
              "\$crossjoin(BusinessPartners,SalesPersons,PaymentTermsTypes)?\$expand=SalesPersons(\$select=SalesEmployeeName),PaymentTermsTypes(\$select=PaymentTermsGroupName),BusinessPartners(\$select=CardCode,CardName,ShipToDefault,BilltoDefault,CurrentAccountBalance,U_CASHCUST)&\$filter=BusinessPartners/PayTermsGrpCode eq PaymentTermsTypes/GroupNumber and BusinessPartners/SalesPersonCode eq SalesPersons/SalesEmployeeCode and (contains(BusinessPartners/CardCode,'$searchValue') or contains(BusinessPartners/CardName,'$searchValue')) and BusinessPartners/CardType eq 'cCustomer' and (BusinessPartners/SalesPersonCode eq ${GetValues.slpCode} or BusinessPartners/U_CASHCUST eq 'Yes')", // and DocumentStatus eq 'bost_Open'
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + GetValues.sessionID.toString(),
          'Prefer': 'odata.maxpagesize=${GetValues.maximumfetchValue}'
        },
      );
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return CustomerModal.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      } else {
        print(json.decode(response.body));
        print(json.decode(response.statusCode.toString()));
        throw Exception('Restart the app or contact the admin!!..');
        // return CustomerModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      throw Exception(e);
      // return CustomerModal.issue('Restart the app or contact the admin!!..');
    }
  }
}
