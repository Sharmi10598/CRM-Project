// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, unnecessary_string_interpolations, unused_local_variable, prefer_final_locals, omit_local_variable_types

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/customer_bp/CreateCustPostModel.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class PostCustCreateAPi {
  static Future<CreateCustPostModel> getGlobalData(
      NewCutomerModel newCutomerModel,) async {
    try {
      log(URL.url + "BusinessPartners");
      final response = await http.post(Uri.parse(URL.url + "BusinessPartners"),
          headers: {
            'content-type': 'application/json',
            "cookie": 'B1SESSION=' + GetValues.sessionID.toString(),
          },
          body: 
          newCutomerModel.cardCode== null?
           json.encode({
        "CardName": "${newCutomerModel.cardName}",
        "CardType": "cCustomer",
        "GroupCode": newCutomerModel.grupCode,
        "FederalTaxID": newCutomerModel.FederalTaxID,
        "AdditionalID": newCutomerModel.AdditionalID,
        "Territory": newCutomerModel.Territory,
        "Cellular": newCutomerModel.Cellular,
        "SalesPersonCode": newCutomerModel.SalesPersonCode,
        "ContactPerson": newCutomerModel.ContactPerson,
        "CreditLimit": newCutomerModel.CreditLimit,
        "Notes": newCutomerModel.Notes,
        "PayTermsGrpCode": newCutomerModel.PayTermsGrpCod,
        "Valid": "tNO",
        "Frozen": "tYES",
        "Series": newCutomerModel.Series,
        "U_TinCer":newCutomerModel.tincer,
        "U_VatCer":newCutomerModel.vatcer,
        "BPAddresses": newCutomerModel.newModel!.map((e) => 
        e.tojson(),).toList(),
        "ContactEmployees":newCutomerModel.contEmp!.map((e) => e.tojson()).toList(),
      }) 
          :
          json.encode({
        "CardCode": "${newCutomerModel.cardCode}",
        "CardName": "${newCutomerModel.cardName}",
        "CardType": "cCustomer",
        "GroupCode": newCutomerModel.grupCode,
        "FederalTaxID": newCutomerModel.FederalTaxID,
        "AdditionalID": newCutomerModel.AdditionalID,
        "Territory": newCutomerModel.Territory,
        "Cellular": newCutomerModel.Cellular,
        "SalesPersonCode": newCutomerModel.SalesPersonCode,
        "ContactPerson": newCutomerModel.ContactPerson,
        "CreditLimit": newCutomerModel.CreditLimit,
        "Notes": newCutomerModel.Notes,
        "PayTermsGrpCode": newCutomerModel.PayTermsGrpCod,
        "Valid": "tNO",
        "Frozen": "tYES",
        "Series": newCutomerModel.Series,
        "U_TinCer":newCutomerModel.tincer,
        "U_VatCer":newCutomerModel.vatcer,
        "BPAddresses": newCutomerModel.newModel!.map((e) => 
        e.tojson(),).toList(),
        "ContactEmployees":newCutomerModel.contEmp!.map((e) => e.tojson()).toList(),
      }),);

      log( newCutomerModel.cardCode== null?
           json.encode({
        "CardName": "${newCutomerModel.cardName}",
        "CardType": "cCustomer",
        "GroupCode": newCutomerModel.grupCode,
        "FederalTaxID": newCutomerModel.FederalTaxID,
        "AdditionalID": newCutomerModel.AdditionalID,
        "Territory": newCutomerModel.Territory,
        "Cellular": newCutomerModel.Cellular,
        "SalesPersonCode": newCutomerModel.SalesPersonCode,
        "ContactPerson": newCutomerModel.ContactPerson,
        "CreditLimit": newCutomerModel.CreditLimit,
        "Notes": newCutomerModel.Notes,
        "PayTermsGrpCode": newCutomerModel.PayTermsGrpCod,
        "Valid": "tNO",
        "Frozen": "tYES",
        "Series": newCutomerModel.Series,
        "U_TinCer":newCutomerModel.tincer,
        "U_VatCer":newCutomerModel.vatcer,
         "BPAddresses": newCutomerModel.newModel!.map((e) => 
        e.tojson(),).toList(),
        "ContactEmployees":newCutomerModel.contEmp!.map((e) => e.tojson()).toList(),
      }) 
          :
          json.encode({
        "CardCode": "${newCutomerModel.cardCode}",
        "CardName": "${newCutomerModel.cardName}",
        "CardType": "cCustomer",
        "GroupCode": newCutomerModel.grupCode,
        "FederalTaxID": newCutomerModel.FederalTaxID,
        "AdditionalID": newCutomerModel.AdditionalID,
        "Territory": newCutomerModel.Territory,
        "Cellular": newCutomerModel.Cellular,
        "SalesPersonCode": newCutomerModel.SalesPersonCode,
        "ContactPerson": newCutomerModel.ContactPerson,
        "CreditLimit": newCutomerModel.CreditLimit,
        "Notes": newCutomerModel.Notes,
        "PayTermsGrpCode": newCutomerModel.PayTermsGrpCod,
        "Valid": "tNO",
        "Frozen": "tYES",
        "Series": newCutomerModel.Series,
         "BPAddresses": newCutomerModel.newModel!.map((e) => 
        e.tojson(),).toList(),
        "ContactEmployees":newCutomerModel.contEmp!.map((e) => e.tojson()).toList(),
      }),);
      // print('B1SESSION='+ GetValues.sessionID.toString());
      // print('odata.maxpagesize=${GetValues.maximumfetchValue}');
      log("customer creation: " + json.decode(response.body).toString());
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return CreateCustPostModel.fromJson(response.body, response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return CreateCustPostModel.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      //  throw Exception("Exception: $e");
      return CreateCustPostModel.fromJson(e.toString(), 500);
    }
  }
}

class NewCutomerModel {
   String? tincer;
  String? vatcer;
  String? cardCode;
  String? cardName;
  int? grupCode;
  String? FederalTaxID;
  String? AdditionalID;
  int? Territory;
  String? Cellular;
   int? SalesPersonCode;
   String?  ContactPerson;
     int ? CreditLimit;
    String? Notes;
   int? PayTermsGrpCod;
   String? Valid ;
   int? Series;
  List<NewCutomeAdrsModel>? newModel;
  List<ContactEmployees>?contEmp;
  NewCutomerModel({
    this.cardName,
    this.grupCode,
    this.cardCode,
    this.newModel,
    this.AdditionalID,
    this.Cellular,
    this.ContactPerson,
    this.CreditLimit,
    this.FederalTaxID,
    this.Notes,
    this.PayTermsGrpCod,
    this.SalesPersonCode,
    this.Series,
    this.Territory,
    this.Valid,
    this.contEmp,
    this.tincer,
    this.vatcer,
  });
}

class NewCutomeAdrsModel {
  String? AddressName;
  String? Street;
  String? ZipCode;
  String? City;
  String? Country;
  String? State;
  String? AddressType;
  String? AddressName2;
  String? AddressName3;

  NewCutomeAdrsModel({
    this.AddressName,
    this.AddressName2,
    this.AddressName3,
    this.AddressType,
    this.City,
    this.Country,
    this.State,
    this.Street,
    this.ZipCode,
  });

  Map<String, dynamic> tojson() {
    Map<String, dynamic> data = <String, dynamic>{
      "AddressName": AddressName,
      "Street": Street,
      "ZipCode": ZipCode,
      "City": City,
      "Country": Country,
      "State": State,
      "AddressType": AddressType,
      "AddressName2": AddressName2,
      "AddressName3": AddressName3,
    };
    return data;
  }


}

class ContactEmployees{
  String? name;
  ContactEmployees({
    required this.name,
  });

    Map<String, dynamic> tojson() {
    Map<String, dynamic> data = <String, dynamic>{
      "Name": name,
    };
    return data;
  }
}
