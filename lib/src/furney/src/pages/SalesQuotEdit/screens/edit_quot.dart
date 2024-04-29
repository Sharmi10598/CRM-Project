// ignore_for_file: require_trailing_commas, prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_parenthesis

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/approvals_modal/approvals_details.modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesQuotEdit/widget/creation/contentEdit_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesQuotEdit/widget/creation/headerEdit_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesQuotEdit/widget/creation/logisticEdit_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/delivery/widgets/delivery_appbar.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/creation/header_creation.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class EditDetails extends StatefulWidget {
  EditDetails(
      {required this.getdocumentApprovalValue,
      required this.docentry,
      required this.title,
      Key? key})
      : super(key: key);
  final String title;
  int docentry;
  List<DocumentApprovalValue> getdocumentApprovalValue = [];

  @override
  EditDetailsState createState() => EditDetailsState();
}

class EditDetailsState extends State<EditDetails> {
  static bool contentAddItems = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void currentDate() {
    final now = DateTime.now();
    setState(() {
      HeaderCreationState.currentDateTime =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
      print('date: ${HeaderCreationState.currentDateTime}');
    });
  }

  @override
  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    final now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print('are you sure');
      //  Get.offAllNamed<dynamic>(FurneyRoutes.salesQuotes);
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Are you want to exit press again!!..',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Future.value(false);
    }
    Get.offAllNamed<dynamic>(FurneyRoutes.newSalesQuot);
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return Future.value(true);
  }

  String isTaxApplied(double total, double tax) {
    double res = 0;
    String isaval = '0';
    res = tax / total * 100;
    isaval = (res == 18 ? "O1" : "null");

    return isaval;
  }

  calucultaeDocVal() async {
    double basictotal = 0;
    double discVal = 0;
    double taxVal = 0;
    double tax = 0;

    double taxable = 0;
    double netvalue = 0;
    HeaderEditCreationState.totalBeforeDiscount = 0;
    HeaderEditCreationState.discount = 0;
    HeaderEditCreationState.tax = 0;
    HeaderEditCreationState.total = 0;
    String? taxCode;

    for (int ik = 0; ik < widget.getdocumentApprovalValue.length; ik++) {
      double ttaxTotal = 0;
      ttaxTotal = widget.getdocumentApprovalValue[ik].taxTotal != null
          ? widget.getdocumentApprovalValue[ik].taxTotal!
          : 0;
      taxVal = (taxVal + ttaxTotal);
      if (widget.getdocumentApprovalValue[ik].taxCode != null) {
        taxCode = widget.getdocumentApprovalValue[ik].taxCode == 'null' ||
                widget.getdocumentApprovalValue[ik].taxCode == null ||
                widget.getdocumentApprovalValue[ik].taxCode == 0
            ? isTaxApplied(
                widget.getdocumentApprovalValue[ik].lineTotal!, ttaxTotal
                // widget.getdocumentApprovalValue[ik].taxTotal!
                )
            : widget.getdocumentApprovalValue[ik].taxCode!;
      }
      await getTaxRate(taxCode!);

      basictotal = basictotal +
          (widget.getdocumentApprovalValue[ik].quantity! *
              widget.getdocumentApprovalValue[ik].unitPrice!);
      if (widget.getdocumentApprovalValue[ik].discountPercent != null) {
        discVal = discVal +
            ((widget.getdocumentApprovalValue[ik].unitPrice! *
                    widget.getdocumentApprovalValue[ik].quantity!) -
                (widget.getdocumentApprovalValue[ik].lineTotal!));

        tax = tax + ttaxTotal;
        // netvalue = netvalue + widget.getdocumentApprovalValue[ik].total!;
        // discVal =

        // discVal +
        //     (basictotal *
        //         widget.getdocumentApprovalValue[ik].discountPercent! /
        //         100);
      }
      // taxable = basictotal - discVal;
      // double xxxx = taxSelected;

      // taxVal = taxVal +
      //     (taxable *
      //         xxxx
      //         // double.parse(widget.getdocumentApprovalValue[ik].TaxCode!)
      //         /
      //         100);

      netvalue = (basictotal - discVal) + tax;
      ContentEditCreationState.discountper =
          widget.getdocumentApprovalValue[ik].discountPercent != null
              ? widget.getdocumentApprovalValue[ik].discountPercent!
              : 0;
    }

    HeaderEditCreationState.totalBeforeDiscount = basictotal;
    // HeaderEditCreationState.totalBeforeDiscount + basictotal;
    HeaderEditCreationState.discount = discVal;
    // HeaderEditCreationState.discount + discVal;
    HeaderEditCreationState.tax = taxVal;
    // HeaderEditCreationState.tax + taxVal;
    HeaderEditCreationState.total = netvalue;
    // HeaderEditCreationState.total + netvalue;
  }

  getTaxRate(String taxCode) {
    String? valueChosedReason;
    double taxSelected = 0;
    String? valueChossed;

    if (GetValues.countryCode!.toLowerCase() == 'tanzania') {
      if (taxCode == 'O0') {
        // print("" + widget.getdocumentApprovalValue[ik].taxCode.toString());
        valueChossed = 'O0 - 0 % Output VAT';
        valueChosedReason = '0';
        taxCode = 'O0';
        taxSelected = 0.00;
        taxSelected = double.parse(valueChosedReason);
      } else if (taxCode == 'O1') {
        valueChossed = 'O1 - 18 % Output VAT';
        valueChosedReason = '18';
        taxCode = 'O1';
        taxSelected = 0.00;
        taxSelected = double.parse(valueChosedReason);
      } else if (taxCode == '01') {
        //01
        valueChossed = 'O1 - 18 % Output VAT';
        valueChosedReason = '18';
        taxCode = 'O1';
        taxSelected = 0.00;
        taxSelected = double.parse(valueChosedReason);
      } else if (taxCode == 'O3') {
        valueChossed = 'O3 - Exempted Output VAT';
        taxCode = 'O3';
        valueChosedReason = '0';
        taxSelected = 0.00;
        taxSelected = double.parse(valueChosedReason);
      } else if (taxCode == 'X0') {
        valueChossed = 'X0 - Exempt Output';
        valueChosedReason = '0';
        taxCode = 'X0';
        taxSelected = 0.00;
        taxSelected = double.parse(valueChosedReason);
      }
    } else {
      if (taxCode == 'O0') {
        // print("" + widget.getdocumentApprovalValue[ik].taxCode.toString());
        valueChossed = 'O0 - 0 % Output VAT';
        valueChosedReason = '0';
        taxCode = 'O0';
        taxSelected = 0.00;
        taxSelected = double.parse(valueChosedReason);
      } else if (taxCode == 'O1') {
        valueChossed = 'O1 - 16 % Output VAT';
        valueChosedReason = '16';
        taxCode = 'O1';
        taxSelected = 0.00;
        taxSelected = double.parse(valueChosedReason);
      } else if (taxCode == '01') {
        //01
        valueChossed = 'O1 - 16 % Output VAT';
        valueChosedReason = '16';
        taxCode = 'O1';
        taxSelected = 0.00;
        taxSelected = double.parse(valueChosedReason);
      } else if (taxCode == 'O3') {
        valueChossed = 'O3 - Exempted Output VAT';
        taxCode = 'O3';
        valueChosedReason = '0';
        taxSelected = 0.00;
        taxSelected = double.parse(valueChosedReason);
      } else if (taxCode == 'X0') {
        valueChossed = 'X0 - Exempt Output';
        valueChosedReason = '0';
        taxCode = 'X0';
        taxSelected = 0.00;
        taxSelected = double.parse(valueChosedReason);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    currentDate();
    calucultaeDocVal();
  }

  static TabController? tabController;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 3,
      child:
          // WillPopScope(
          //   onWillPop: onbackpress,
          //   child:
          Scaffold(
              resizeToAvoidBottomInset: false,
              key: _scaffoldKey,
              backgroundColor: Colors.grey[200],
              appBar: deliveryAppBar(context, _scaffoldKey, widget.title),
              drawer: drawer(context),
              body: Padding(
                padding: EdgeInsets.only(
                  top: Screens.heigth(context) * 0.01,
                ), //left: Screens.width(context)*0.02,right: Screens.width(context)*0.02,bottom: Screens.heigth(context)*0.01
                child: TabBarView(
                    //controller: tabController,
                    // physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const HeaderEditCreation(),
                      ContentEditCreation(
                        getdocumentApprovalValue:
                            widget.getdocumentApprovalValue,
                      ),
                      LogisticEditPage(
                        docentry: widget.docentry,
                      ),
                    ]),
              )),
      // ),
    );
  }
  // static void changepage(BuildContext context){
  //   DefaultTabController.of(context)!.animateTo(1);
  // }
}
