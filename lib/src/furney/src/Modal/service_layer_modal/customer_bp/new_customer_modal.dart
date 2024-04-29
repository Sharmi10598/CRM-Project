// ignore_for_file: omit_local_variable_types, prefer_final_locals, avoid_redundant_argument_values, prefer_single_quotes

import 'dart:developer';

class NewCustomerModal {
  String? odatametadata;
  List<CustomerDetailsValue>? value;
  String? error;
  String? nextLink;
  NewCustomerModal({
    required this.odatametadata,
    this.value,
    this.error,
    this.nextLink,
  });
  factory NewCustomerModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['value'] != null) {
      var list = jsons['value'] as List; //jsonDecode
      // print(list);
      List<CustomerDetailsValue> dataList = list
          .map((dynamic enquiries) => CustomerDetailsValue.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return NewCustomerModal(
        value: dataList,
        odatametadata: jsons['odata.metadata'].toString(),
        nextLink: jsons['odata.nextLink'].toString(),
      );
    } else {
      return NewCustomerModal(
        odatametadata: null,
        value: null,
      );
    }
  }

  factory NewCustomerModal.issue(String e) {
    return NewCustomerModal(
      odatametadata: null,
      value: null,
      error: e,
    );
  }
}

class CustomerDetailsValue {
//int groupCode;
// String? cardCode;
// String ?cardName;
  String? cardType;
  String? phone1;
  String? phone2;
  double currentAccountBalance;
//double openDeliveryNotesBalance;
  dynamic creditLimit;
  List<BpAddress> bpaddress;
  List<ContactEmployees>? contactEmployees;
//List<BPFiscalTaxIDCollection>? bpFiscalTaxIDCollection;
  dynamic priceListNum;
  String? emailAddress;
  String? website;
  String? contactPerson;
  String? billTodefault;
  String? shipTodefault;
  String? notes;
  CustomerDetailsValue({
    // this.cardName,
    required this.phone1,
    required this.phone2,
    required this.currentAccountBalance,
    required this.bpaddress, // required this.openDeliveryNotesBalance,
    // this.bpFiscalTaxIDCollection,
    required this.creditLimit,
    required this.priceListNum,
    required this.emailAddress,
    required this.website,
    required this.contactPerson,
    required this.billTodefault,
    required this.shipTodefault, // required this.groupCode,
    // this.cardCode,
    this.cardType,
    this.notes,
    this.contactEmployees,
  });

  factory CustomerDetailsValue.fromJson(dynamic jsons) {
    var list = jsons['BPAddresses'] as List;
    var list2 = jsons['ContactEmployees'] as List;
    log('customer bp info list::$list2');
    List<BpAddress> dataList =
        list.map((dynamic enquiries) => BpAddress.fromJson(enquiries)).toList();
    List<ContactEmployees> dataList2 = list2
        .map((dynamic enquiries) => ContactEmployees.fromJson(enquiries))
        .toList();
    return CustomerDetailsValue(
      //  groupCode: jsons['GroupCode'] as int,
      //   cardCode: jsons['CardCode'].toString(),
      //     cardName: jsons['CardName'].toString(),
      cardType: jsons['CardType'].toString(),
      phone1: jsons['phone1'] == null ? '' : jsons['phone1'].toString(),
      phone2: jsons['phone2'].toString(),
      currentAccountBalance: jsons['CurrentAccountBalance'] as double,
      //   openDeliveryNotesBalance:  jsons['OpenDeliveryNotesBalance'] as double,
      creditLimit: jsons['CreditLimit'],
      bpaddress: dataList,
      contactEmployees: dataList2,
      priceListNum: jsons["PriceListNum"],
      emailAddress:
          jsons['EmailAddress'] == null ? '' : jsons['EmailAddress'].toString(),
      website: jsons["Website"] == null ? '' : jsons['Website'].toString(),
      contactPerson: jsons["ContactPerson"] == null
          ? ''
          : jsons['ContactPerson'].toString(),
      billTodefault: jsons["BillToState"].toString(),
      shipTodefault: jsons["ShipToState"].toString(),
      notes: jsons['Notes'].toString(),
    );
  }
}

class BpAddress {
  String? addressName;
  String? street;
  String? block;
  String? county;
  String? zipCode;
  String? city;
  String? country2;
  String? state;

//List<BpAddress> bpaddress;
  BpAddress({
    required this.addressName,
    required this.zipCode,
    required this.city,
    required this.country2, //required this.bpaddress,
    required this.state,
    this.street,
    this.county,
    this.block,
  });

  factory BpAddress.fromJson(dynamic jsons) {
    // var list =  jsons['BPAddresses'] as List;
    //  List<BpAddress> dataList = list
    //       .map((dynamic enquiries) => BpAddress.fromJson(enquiries))
    //       .toList();
    return BpAddress(
      addressName:
          jsons['AddressName'] == null ? '' : jsons['AddressName'].toString(),
      street: jsons['Street'] == null ? '' : jsons['Street'].toString(),
      block: jsons['Block'] == null ? '' : jsons['Block'].toString(),
      zipCode: jsons['ZipCode'] == null ? '' : jsons['ZipCode'].toString(),
      city: jsons['City'] == null ? '' : jsons['City'].toString(),
      county: jsons['County'] == null ? '' : jsons['County'].toString(),
      country2: jsons['Country'] == null ? '' : jsons['Country'].toString(),
      state: jsons['State'] == null ? '' : jsons['State'].toString(),

      /// bpaddress:  dataList
    );
  }
}

class BPFiscalTaxIDCollection {
  String? address;
  String? bpCode;
  String? addrType;
  String? taxId0;
  BPFiscalTaxIDCollection({
    required this.address,
    this.bpCode,
    this.addrType,
    this.taxId0,
  });

  factory BPFiscalTaxIDCollection.fromJson(dynamic jsons) {
    // var list =  jsons['BPAddresses'] as List;
    //  List<BpAddress> dataList = list
    //       .map((dynamic enquiries) => BpAddress.fromJson(enquiries))
    //       .toList();
    return BPFiscalTaxIDCollection(
      address: jsons['Address'].toString(),
      bpCode: jsons['BPCode'].toString(),
      addrType: jsons['AddrType'].toString(),
      taxId0: jsons['TaxId0'].toString(),

      /// bpaddress:  dataList
    );
  }
}

class ContactEmployees {
  String? cardCode;
  String? name;
  String? phone1;
//String ?taxId0;
  ContactEmployees({
    required this.cardCode,
    this.name,
    this.phone1,
    // this.taxId0,
  });

  factory ContactEmployees.fromJson(dynamic jsons) {
    return ContactEmployees(
      cardCode: jsons['CardCode'] == null ? '' : jsons['CardCode'].toString(),
      name: jsons['Name'] == null ? '' : jsons['Name'].toString(),
      phone1: jsons['Phone1'] == null ? '' : jsons['Phone1'].toString(),
      //  taxId0:  jsons['TaxId0'].toString(),
      /// bpaddress:  dataList
    );
  }
}
