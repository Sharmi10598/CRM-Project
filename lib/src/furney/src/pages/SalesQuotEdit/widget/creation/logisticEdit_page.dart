// ignore: file_names
// ignore_for_file: file_names, unused_local_variable, prefer_final_locals, omit_local_variable_types, prefer_const_constructors, prefer_single_quotes, unnecessary_parenthesis, unnecessary_lambdas, prefer_interpolation_to_compose_strings, unawaited_futures

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/SchemeQuteApi/SchemeQuteApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/SOafterApi/SOafterApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_quotations_api/EditApi/PostPut_sales_quot.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/SchemeQuteModel/SchemeQuteModel.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesQuotEdit/widget/creation/contentEdit_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesQuotEdit/widget/creation/headerEdit_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sign_in/widgets/custom_elevatedBtn.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:uuid/uuid.dart';

import '../../../../Api/service_layer_api/sales_quotations_api/EditApi/PostPatch_quot_api.dart';
import '../../../../Modal/service_layer_modal/approvals_modal/approvals_details.modal.dart';
import '../../../../Modal/service_layer_modal/sales_quot/QuotPutModel.dart';
import '../../../sales_quot/screens/SalesQutDetails.dart';

class LogisticEditPage extends StatefulWidget {
  LogisticEditPage({Key? key, required this.docentry}) : super(key: key);
  int docentry;
  @override
  LogisticEditPageState createState() => LogisticEditPageState();
}

class LogisticEditPageState extends State<LogisticEditPage> {
  static String billto = '';
  static String shipto = '';
  static String cardcode = '';
  static double currentACbalance = 0;
  static double ordersBal = 0;

  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  bool schmDisableBtn = false;

  setboolVal() async {
    final pref2 = await pref;

    setState(() {
      if (pref2.getBool('schemeReq') != null) {
        schmDisableBtn = pref2.getBool('schemeReq')!;
      }
      log("SchmDisableBtnSchmDisableBtn:::$schmDisableBtn");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setboolVal();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body:
          // Padding(
          //  padding: EdgeInsets.only(top:Screens.heigth(context)*0.01,),//left: Screens.width(context)*0.01,right: Screens.width(context)*0.01,
          // child:
          // Stack(
          //   children: [
          // SingleChildScrollView(
          // child:
          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: Screens.width(context) * 0.02),
            color: Colors.white,
            width: Screens.width(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Screens.heigth(context) * 0.01,
                ),
                GestureDetector(
                  onTap: () {
                    //  Get.toNamed<dynamic>(FurneyRoutes.draftDetails);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bill To",
                        style: TextStyles.boldPC1(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                width: Screens.width(context) * 0.83,
                                // color: Colors.blue,
                                child: Text(
                                  billto,
                                  style: TextStyles.headlineBlack1(context),
                                ),
                              ),
                              //      Container(
                              //   width: Screens.width(context) * 0.83,
                              //   // color: Colors.blue,
                              //   child: Text(
                              //     "Irvine CA 92612 USA",
                              //     style: GoogleFonts.poppins(
                              //         fontSize: Screens.heigth(context) * 0.02,
                              //         color: Colors.black),
                              //   ),
                              // ),
                            ],
                          ),
                          Container(
                            child: Icon(
                              Icons.navigate_next_outlined,
                              color: theme.primaryColor,
                              size: Screens.heigth(context) * 0.06,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.5,
                ),
                GestureDetector(
                  onTap: () {
                    //  Get.toNamed<dynamic>(FurneyRoutes.draftDetails);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ship To",
                        style: TextStyles.boldPC1(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                width: Screens.width(context) * 0.83,
                                // color: Colors.blue,
                                child: Text(
                                  shipto,
                                  style: TextStyles.headlineBlack1(context),
                                ),
                              ),
                              //      Container(
                              //   width: Screens.width(context) * 0.83,
                              //   // color: Colors.blue,
                              //   child: Text(
                              //     "Irvine CA 92612 USA",
                              //     style: GoogleFonts.poppins(
                              //         fontSize: Screens.heigth(context) * 0.02,
                              //         color: Colors.black),
                              //   ),
                              // ),
                            ],
                          ),
                          Container(
                            child: Icon(
                              Icons.navigate_next_outlined,
                              color: theme.primaryColor,
                              size: Screens.heigth(context) * 0.06,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),

                // SizedBox(height: Screens.heigth(context) * 0.01, ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //            "Shipping Type",
                //             style: GoogleFonts.poppins(
                //                 fontSize: Screens.heigth(context) * 0.018,
                //                 color: theme.primaryColor),
                //           ),
                //           Container(
                //             width: Screens.width(context) * 0.83,
                //             // color: Colors.blue,
                //             child: Text(
                //               "Motor Express",
                //               style: GoogleFonts.poppins(
                //                   fontSize: Screens.heigth(context) * 0.02,
                //                   color: Colors.black),
                //             ),
                //           ),
                //         ],
                //       ),
              ],
            ),
          ),
          SizedBox(
            height: Screens.heigth(context) * 0.01,
          ),

          ///
          Column(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomSpinkitdButton(
                  onTap: schmDisableBtn == false
                      ? null
                      : () async {
                          schemeOnlyClicked = true;
                          await callSchemeQuteApi();
                        },
                  isLoading: schemeApiLoad,
                  label: 'Apply Schemes',
                ),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomSpinkitdButton(
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                      schemeApiLoad = true;
                      schemeOnlyClicked = false;
                    });
                    if (schmDisableBtn == true) {
                      await callSchemeQuteApi().then((valq) {
                        if (valq == true) {
                          validateAndCallApi();
                        } else {
                          showSnack('Something went wrong try again');
                        }
                      });
                    } else {
                      validateAndCallApi();
                    }
                  },
                  isLoading: isLoading,
                  label: 'Save',
                ),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.01,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showSnack(String msg) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 5),
      backgroundColor: Colors.red,
      content: Text(
        msg,
        style: TextStyle(color: Colors.white),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool schemeApiLoad = false;
  bool alreadySchemeApiCalled = false;
  List<SchemeQuteModalData> saleOrderdata = [];
  bool schemeOnlyClicked = false;
  Future<bool> callSchemeQuteApi() async {
    saleOrderdata.clear();

    setState(() {
      if (schemeOnlyClicked == true) {
        isLoading = true;
        schemeApiLoad = true;
      }
    });
    bool returnbool = false;
    List<SalesQuteScheme> salesQuteScheme = [];

    for (int i = 0;
        i < ContentEditCreationState.contentitemsDetails.length;
        i++) {
      salesQuteScheme.add(
        SalesQuteScheme(
          ItemCode: ContentEditCreationState.contentitemsDetails[i].itemCode!,
          PriceBefDi: ContentEditCreationState.contentitemsDetails[i].price!
              .toStringAsFixed(2),
          Quantity:
              ContentEditCreationState.contentitemsDetails[i].qty.toString(),
          UCartons: ContentEditCreationState.contentitemsDetails[i].carton!
              .toString(),
          lineno: (i + 1).toString(),
          balance: (currentACbalance + ordersBal).toString(),
          customer: HeaderEditCreationState.bpCode,
        ),
      );
      ContentEditCreationState.contentitemsDetails[i].discounpercent = 0;
      ContentEditCreationState.contentitemsDetails[i].lineNoo = i + 1;
    }

    await SchemeQuteAPi.getGlobalData(salesQuteScheme).then((value) {
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        if (value.saleOrder != null) {
          saleOrderdata = value.saleOrder!;

          alreadySchemeApiCalled = true;
          for (int i = 0; i < value.saleOrder!.length; i++) {
            if (value.saleOrder![i].discPer != 0) {
              for (int k = 0;
                  k < ContentEditCreationState.contentitemsDetails.length;
                  k++) {
                if (ContentEditCreationState.contentitemsDetails[k].lineNoo ==
                    value.saleOrder![i].lineNum) {
                  ContentEditCreationState.contentitemsDetails[k]
                      .discounpercent = ContentEditCreationState
                          .contentitemsDetails[k].discounpercent! +
                      value.saleOrder![i].discPer;

                  ContentEditCreationState.contentitemsDetails[k].discount =
                      ((ContentEditCreationState.contentitemsDetails[k].price! *
                              ContentEditCreationState
                                  .contentitemsDetails[k].qty!) *
                          ContentEditCreationState
                              .contentitemsDetails[k].discounpercent! /
                          100);
                  log('itemsDetails[k].discount::${ContentEditCreationState.contentitemsDetails[k].discount} ');
                  ContentEditCreationState.contentitemsDetails[k].valueAF =
                      ((ContentEditCreationState.contentitemsDetails[k].price! *
                              ContentEditCreationState
                                  .contentitemsDetails[k].qty!) -
                          ContentEditCreationState
                              .contentitemsDetails[k].discount!);

                  ContentEditCreationState.contentitemsDetails[k].total =
                      (ContentEditCreationState
                              .contentitemsDetails[k].valueAF! *
                          (1 +
                              ContentEditCreationState
                                      .contentitemsDetails[k].taxPer! /
                                  100));
                  ContentEditCreationState.contentitemsDetails[k].tax =
                      (ContentEditCreationState.contentitemsDetails[k].total! -
                          ContentEditCreationState
                              .contentitemsDetails[k].valueAF!);
                  log(
                    "tax:::" +
                        ContentEditCreationState.contentitemsDetails[k].tax!
                            .toString(),
                  );
                  //  ContentEditCreationState.contentitemsDetails[k].total=value.saleOrder[i].;
                }
              }
            } else if (value.saleOrder![i].discVal != 0) {
              ContentEditCreationState.contentitemsDetails[i].discount =
                  value.saleOrder![i].discVal;
            }
          }
          setState(() {});
          sumofTotal();
          returnbool = true;
          setState(() {
            if (schemeOnlyClicked == true) {
              isLoading = false;
              schemeApiLoad = false;
              schemeOnlyClicked = false;
            }
          });
        } else if (value.saleOrder == null) {
          alreadySchemeApiCalled = true;
          setState(() {
            if (schemeOnlyClicked == true) {
              isLoading = false;
              schemeApiLoad = false;
              schemeOnlyClicked = false;
            }
          });
          returnbool = true;
        }
      } else if (value.statuscode >= 400 && value.statuscode <= 410) {
        final snackBar = SnackBar(
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
          content: Text(
            'Something went wrong try again..!!',
            style: TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        returnbool = false;
        setState(() {
          if (schemeOnlyClicked == true) {
            isLoading = false;
            schemeApiLoad = false;
            schemeOnlyClicked = false;
          }
        });
      } else {
        const snackBar = SnackBar(
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
          content: Text(
            'Something went wrong try again..!!',
            style: TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        returnbool = false;
        setState(() {
          if (schemeOnlyClicked == true) {
            isLoading = false;
            schemeApiLoad = false;
            schemeOnlyClicked = false;
          }
        });
      }
    });
    return returnbool;
  }

  void sumofTotal() {
    double basictotal = 0;
    double discount = 0;
    double tax = 0;
    double grandtotal = 0;
    double totalbefordisc = 0;
    HeaderEditCreationState.tax = 0;
    setState(() {
      if (ContentEditCreationState.contentitemsDetails.isNotEmpty) {
        for (int i = 0;
            i < ContentEditCreationState.contentitemsDetails.length;
            i++) {
          basictotal = basictotal +
              ContentEditCreationState.contentitemsDetails[i].total!;
          // ContentEditCreationState.contentitemsDetails[i].qty!.toDouble()*ContentEditCreationState.contentitemsDetails[i].price!.toDouble();
          totalbefordisc = totalbefordisc +
              (ContentEditCreationState.contentitemsDetails[i].price! *
                  ContentEditCreationState.contentitemsDetails[i].qty!
                      .toDouble());
          log("ContentEditCreationState.contentitemsDetails[i].discount::${ContentEditCreationState.contentitemsDetails[i].discount}");
          discount = discount +
              ContentEditCreationState.contentitemsDetails[i].discount!;

          log("discount::${discount}");

          tax = tax +
              (ContentEditCreationState.contentitemsDetails[i].total! -
                  ContentEditCreationState.contentitemsDetails[i].valueAF!);
        }
        print("grandtotal: " + basictotal.toString());
        //total over
        HeaderEditCreationState.discount = discount;
        HeaderEditCreationState.tax = tax;
        HeaderEditCreationState.total = basictotal;
        // - discount + tax;
        HeaderEditCreationState.totalBeforeDiscount = totalbefordisc;
      } else {
        setState(() {
          discount = 0.00;
          grandtotal = 0.00;
          tax = 0.00;
          HeaderEditCreationState.total = grandtotal;
          HeaderEditCreationState.discount = discount;
          HeaderEditCreationState.tax = tax;
          HeaderEditCreationState.totalBeforeDiscount = grandtotal;
        });
      }
    });
  }

  List<DocumentLineData> itemsDetailsData = [];
  static QuotPutModel? quotputdataval;
  static ApprovalDetailsValue? quotputdataval55;
  List<AddItem2> contentitemsDetails55 = [];
  List<DocumentApprovalValue> getdocitemsDetailsData = [];

  delputHeaderValues() {
    contentitemsDetails55 = [];
    quotputdataval55 = null;
    itemsDetailsData = [];
    contentitemsDetails55 = ContentEditCreationState.contentitemsDetails;
    quotputdataval55 = SalesDetailsQuotState.approvalDetailsValue;
    quotputdataval = QuotPutModel(
      odataMetadata: quotputdataval55!.odataMetadata == null ||
              quotputdataval55!.odataMetadata == "null"
          ? null
          : quotputdataval55!.odataMetadata,
      odataEtag: quotputdataval55!.odataEtag == null ||
              quotputdataval55!.odataEtag == "null"
          ? null
          : quotputdataval55!.odataEtag,
      docEntry: quotputdataval55!.docEntry == null ||
              quotputdataval55!.docEntry == "null"
          ? null
          : quotputdataval55!.docEntry,
      docNum:
          quotputdataval55!.docNum == null || quotputdataval55!.docNum == "null"
              ? null
              : quotputdataval55!.docNum,
      docType: quotputdataval55!.docType == null ||
              quotputdataval55!.docType == "null"
          ? null
          : quotputdataval55!.docType,
      handWritten: quotputdataval55!.handWritten == null ||
              quotputdataval55!.handWritten == "null"
          ? null
          : quotputdataval55!.handWritten,
      printed: quotputdataval55!.printed == null ||
              quotputdataval55!.printed == "null"
          ? null
          : quotputdataval55!.printed,
      docDate: quotputdataval55!.docDate == null ||
              quotputdataval55!.docDate == "null"
          ? null
          : quotputdataval55!.docDate,
      docDueDate: quotputdataval55!.docDueDate == null ||
              quotputdataval55!.docDueDate == "null"
          ? null
          : quotputdataval55!.docDueDate,
      cardCode: quotputdataval55!.cardCode == null ||
              quotputdataval55!.cardCode == "null"
          ? null
          : quotputdataval55!.cardCode,
      cardName: quotputdataval55!.cardName == null ||
              quotputdataval55!.cardName == "null"
          ? null
          : quotputdataval55!.cardName,
      address: quotputdataval55!.address == null ||
              quotputdataval55!.address == "null"
          ? null
          : quotputdataval55!.address,
      numAtCard: quotputdataval55!.numAtCard == null ||
              quotputdataval55!.numAtCard == "null"
          ? null
          : quotputdataval55!.numAtCard,
      docTotal: quotputdataval55!.docTotal == null ||
              quotputdataval55!.docTotal == "null"
          ? null
          : quotputdataval55!.docTotal,
      attachmentEntry: quotputdataval55!.attachmentEntry == null ||
              quotputdataval55!.attachmentEntry == "null"
          ? null
          : quotputdataval55!.attachmentEntry,
      docCurrency: quotputdataval55!.docCurrency == null ||
              quotputdataval55!.docCurrency == "null"
          ? null
          : quotputdataval55!.docCurrency,
      docRate: quotputdataval55!.docRate == null ||
              quotputdataval55!.docRate == "null"
          ? null
          : quotputdataval55!.docRate,
      reference1: quotputdataval55!.reference1 == null ||
              quotputdataval55!.reference1 == "null"
          ? null
          : quotputdataval55!.reference1,
      reference2: quotputdataval55!.reference2 == null ||
              quotputdataval55!.reference2 == "null"
          ? null
          : quotputdataval55!.reference2,
      comments: quotputdataval55!.comments == null ||
              quotputdataval55!.comments == "null"
          ? null
          : quotputdataval55!.comments,
      journalMemo: quotputdataval55!.journalMemo == null ||
              quotputdataval55!.journalMemo == "null"
          ? null
          : quotputdataval55!.journalMemo,
      paymentGroupCode: quotputdataval55!.paymentGroupCode == null ||
              quotputdataval55!.paymentGroupCode == "null"
          ? null
          : quotputdataval55!.paymentGroupCode,
      docTime: quotputdataval55!.docTime == null ||
              quotputdataval55!.docTime == "null"
          ? null
          : quotputdataval55!.docTime,
      salesPersonCode: quotputdataval55!.salesPersonCode == null ||
              quotputdataval55!.salesPersonCode == "null"
          ? null
          : quotputdataval55!.salesPersonCode,
      transportationCode: quotputdataval55!.transportationCode == null ||
              quotputdataval55!.transportationCode == "null"
          ? null
          : quotputdataval55!.transportationCode,
      confirmed: quotputdataval55!.confirmed == null ||
              quotputdataval55!.confirmed == "null"
          ? null
          : quotputdataval55!.confirmed,
      importFileNum: quotputdataval55!.importFileNum == null ||
              quotputdataval55!.importFileNum == "null"
          ? null
          : quotputdataval55!.importFileNum!,
      summeryType: quotputdataval55!.summeryType == null ||
              quotputdataval55!.summeryType == "null"
          ? null
          : quotputdataval55!.summeryType,
      contactPersonCode: quotputdataval55!.contactPersonCode == null ||
              quotputdataval55!.contactPersonCode == "null"
          ? null
          : quotputdataval55!.contactPersonCode,
      showScn: quotputdataval55!.showScn == null ||
              quotputdataval55!.showScn == "null"
          ? null
          : quotputdataval55!.showScn,
      series:
          quotputdataval55!.series == null || quotputdataval55!.series == "null"
              ? null
              : quotputdataval55!.series,
      taxDate: quotputdataval55!.taxDate == null ||
              quotputdataval55!.taxDate == "null"
          ? null
          : quotputdataval55!.taxDate,
      partialSupply: quotputdataval55!.partialSupply == null ||
              quotputdataval55!.partialSupply == "null"
          ? null
          : quotputdataval55!.partialSupply,
      docObjectCode: quotputdataval55!.docObjectCode == null ||
              quotputdataval55!.docObjectCode == "null"
          ? null
          : quotputdataval55!.docObjectCode,
      shipToCode: quotputdataval55!.shipToCode == null ||
              quotputdataval55!.shipToCode == "null"
          ? null
          : quotputdataval55!.shipToCode,
      indicator: quotputdataval55!.indicator == null ||
              quotputdataval55!.indicator == "null"
          ? null
          : quotputdataval55!.indicator,
      federalTaxId: quotputdataval55!.federalTaxId == null ||
              quotputdataval55!.federalTaxId == "null"
          ? null
          : quotputdataval55!.federalTaxId,
      discountPercent: quotputdataval55!.discountPercent == null ||
              quotputdataval55!.discountPercent == "null"
          ? null
          : quotputdataval55!.discountPercent,
      paymentReference: quotputdataval55!.paymentReference == null ||
              quotputdataval55!.paymentReference == "null"
          ? null
          : quotputdataval55!.paymentReference,
      creationDate: quotputdataval55!.creationDate == null ||
              quotputdataval55!.creationDate == "null"
          ? null
          : quotputdataval55!.creationDate,
      updateDate: quotputdataval55!.updateDate == null ||
              quotputdataval55!.updateDate == "null"
          ? null
          : quotputdataval55!.updateDate,
      financialPeriod: quotputdataval55!.financialPeriod == null ||
              quotputdataval55!.financialPeriod == "null"
          ? null
          : quotputdataval55!.financialPeriod,
      userSign: quotputdataval55!.userSign == null ||
              quotputdataval55!.userSign == "null"
          ? null
          : quotputdataval55!.userSign,
      transNum: quotputdataval55!.transNum == null ||
              quotputdataval55!.transNum == "null"
          ? null
          : quotputdataval55!.transNum,
      vatSum:
          quotputdataval55!.vatSum == null || quotputdataval55!.vatSum == "null"
              ? null
              : quotputdataval55!.vatSum,
      vatSumSys: quotputdataval55!.vatSumSys == null ||
              quotputdataval55!.vatSumSys == "null"
          ? null
          : quotputdataval55!.vatSumSys,
      vatSumFc: quotputdataval55!.vatSumFc == null ||
              quotputdataval55!.vatSumFc == "null"
          ? null
          : quotputdataval55!.vatSumFc,
      netProcedure: quotputdataval55!.netProcedure == null ||
              quotputdataval55!.netProcedure == "null"
          ? null
          : quotputdataval55!.netProcedure,
      docTotalFc: quotputdataval55!.docTotalFc == null ||
              quotputdataval55!.docTotalFc == "null"
          ? null
          : quotputdataval55!.docTotalFc,
      docTotalSys: quotputdataval55!.docTotalSys == null ||
              quotputdataval55!.docTotalSys == "null"
          ? null
          : quotputdataval55!.docTotalSys,
      form1099: quotputdataval55!.form1099 == null ||
              quotputdataval55!.form1099 == "null"
          ? null
          : quotputdataval55!.form1099,
      box1099: quotputdataval55!.box1099 == null ||
              quotputdataval55!.box1099 == "null"
          ? null
          : quotputdataval55!.box1099,
      revisionPo: quotputdataval55!.revisionPo == null ||
              quotputdataval55!.revisionPo == "null"
          ? null
          : quotputdataval55!.revisionPo,
      requriedDate: quotputdataval55!.requriedDate == null ||
              quotputdataval55!.requriedDate == "null"
          ? null
          : quotputdataval55!.requriedDate,
      cancelDate: quotputdataval55!.cancelDate == null ||
              quotputdataval55!.cancelDate == "null"
          ? null
          : quotputdataval55!.cancelDate,
      blockDunning: quotputdataval55!.blockDunning == null ||
              quotputdataval55!.blockDunning == "null"
          ? null
          : quotputdataval55!.blockDunning,
      submitted: quotputdataval55!.submitted == null ||
              quotputdataval55!.submitted == "null"
          ? null
          : quotputdataval55!.submitted,
      segment: quotputdataval55!.segment == null ||
              quotputdataval55!.segment == "null"
          ? null
          : quotputdataval55!.segment,
      pickStatus: quotputdataval55!.pickStatus == null ||
              quotputdataval55!.pickStatus == "null"
          ? null
          : quotputdataval55!.pickStatus,
      pick: quotputdataval55!.pick == null || quotputdataval55!.pick == "null"
          ? null
          : quotputdataval55!.pick,
      paymentMethod: quotputdataval55!.paymentMethod == null ||
              quotputdataval55!.paymentMethod == "null"
          ? null
          : quotputdataval55!.paymentMethod,
      paymentBlock: quotputdataval55!.paymentBlock == null ||
              quotputdataval55!.paymentBlock == "null"
          ? null
          : quotputdataval55!.paymentBlock,
      paymentBlockEntry: quotputdataval55!.paymentBlockEntry == null ||
              quotputdataval55!.paymentBlockEntry == "null"
          ? null
          : quotputdataval55!.paymentBlockEntry,
      centralBankIndicator: quotputdataval55!.centralBankIndicator == null ||
              quotputdataval55!.centralBankIndicator == "null"
          ? null
          : quotputdataval55!.centralBankIndicator,
      maximumCashDiscount: quotputdataval55!.maximumCashDiscount == null ||
              quotputdataval55!.maximumCashDiscount == "null"
          ? null
          : quotputdataval55!.maximumCashDiscount,
      reserve: quotputdataval55!.reserve == null ||
              quotputdataval55!.reserve == "null"
          ? null
          : quotputdataval55!.reserve,
      project: quotputdataval55!.project == null ||
              quotputdataval55!.project == "null"
          ? null
          : quotputdataval55!.project,
      exemptionValidityDateFrom:
          quotputdataval55!.exemptionValidityDateFrom == null ||
                  quotputdataval55!.exemptionValidityDateFrom == "null"
              ? null
              : quotputdataval55!.exemptionValidityDateFrom,
      exemptionValidityDateTo:
          quotputdataval55!.exemptionValidityDateTo == null ||
                  quotputdataval55!.exemptionValidityDateTo == "null"
              ? null
              : quotputdataval55!.exemptionValidityDateTo,
      wareHouseUpdateType: quotputdataval55!.wareHouseUpdateType == null ||
              quotputdataval55!.wareHouseUpdateType == "null"
          ? null
          : quotputdataval55!.wareHouseUpdateType,
      rounding: quotputdataval55!.rounding == null ||
              quotputdataval55!.rounding == "null"
          ? null
          : quotputdataval55!.rounding,
      externalCorrectedDocNum:
          quotputdataval55!.externalCorrectedDocNum == null ||
                  quotputdataval55!.externalCorrectedDocNum == "null"
              ? null
              : quotputdataval55!.externalCorrectedDocNum,
      internalCorrectedDocNum:
          quotputdataval55!.internalCorrectedDocNum == null ||
                  quotputdataval55!.internalCorrectedDocNum == "null"
              ? null
              : quotputdataval55!.internalCorrectedDocNum,
      nextCorrectingDocument:
          quotputdataval55!.nextCorrectingDocument == null ||
                  quotputdataval55!.nextCorrectingDocument == "null"
              ? null
              : quotputdataval55!.nextCorrectingDocument,
      deferredTax: quotputdataval55!.deferredTax == null ||
              quotputdataval55!.deferredTax == "null"
          ? null
          : quotputdataval55!.deferredTax,
      taxExemptionLetterNum: quotputdataval55!.taxExemptionLetterNum == null ||
              quotputdataval55!.taxExemptionLetterNum == "null"
          ? null
          : quotputdataval55!.taxExemptionLetterNum,
      wtApplied: quotputdataval55!.wtApplied == null ||
              quotputdataval55!.wtApplied == "null"
          ? null
          : quotputdataval55!.wtApplied,
      wtAppliedFc: quotputdataval55!.wtAppliedFc == null ||
              quotputdataval55!.wtAppliedFc == "null"
          ? null
          : quotputdataval55!.wtAppliedFc,
      billOfExchangeReserved:
          quotputdataval55!.billOfExchangeReserved == null ||
                  quotputdataval55!.billOfExchangeReserved == "null"
              ? null
              : quotputdataval55!.billOfExchangeReserved,
      agentCode: quotputdataval55!.agentCode == null ||
              quotputdataval55!.agentCode == "null"
          ? null
          : quotputdataval55!.agentCode,
      wtAppliedSc: quotputdataval55!.wtAppliedSc == null ||
              quotputdataval55!.wtAppliedSc == "null"
          ? null
          : quotputdataval55!.wtAppliedSc,
      totalEqualizationTax: quotputdataval55!.totalEqualizationTax == null ||
              quotputdataval55!.totalEqualizationTax == "null"
          ? null
          : quotputdataval55!.totalEqualizationTax,
      totalEqualizationTaxFc:
          quotputdataval55!.totalEqualizationTaxFc == null ||
                  quotputdataval55!.totalEqualizationTaxFc == "null"
              ? null
              : quotputdataval55!.totalEqualizationTaxFc,
      totalEqualizationTaxSc:
          quotputdataval55!.totalEqualizationTaxSc == null ||
                  quotputdataval55!.totalEqualizationTaxSc == "null"
              ? null
              : quotputdataval55!.totalEqualizationTaxSc,
      numberOfInstallments: quotputdataval55!.numberOfInstallments == null ||
              quotputdataval55!.numberOfInstallments == "null"
          ? null
          : quotputdataval55!.numberOfInstallments,
      applyTaxOnFirstInstallment:
          quotputdataval55!.applyTaxOnFirstInstallment == null ||
                  quotputdataval55!.applyTaxOnFirstInstallment == "null"
              ? null
              : quotputdataval55!.applyTaxOnFirstInstallment,
      wtNonSubjectAmount: quotputdataval55!.wtNonSubjectAmount == null ||
              quotputdataval55!.wtNonSubjectAmount == "null"
          ? null
          : quotputdataval55!.wtNonSubjectAmount,
      wtNonSubjectAmountSc: quotputdataval55!.wtNonSubjectAmountSc == null ||
              quotputdataval55!.wtNonSubjectAmountSc == "null"
          ? null
          : quotputdataval55!.wtNonSubjectAmountSc,
      wtNonSubjectAmountFc: quotputdataval55!.wtNonSubjectAmountFc == null ||
              quotputdataval55!.wtNonSubjectAmountFc == "null"
          ? null
          : quotputdataval55!.wtNonSubjectAmountFc,
      wtExemptedAmount: quotputdataval55!.wtExemptedAmount == null ||
              quotputdataval55!.wtExemptedAmount == "null"
          ? null
          : quotputdataval55!.wtExemptedAmount,
      wtExemptedAmountSc: quotputdataval55!.wtExemptedAmountSc == null ||
              quotputdataval55!.wtExemptedAmountSc == "null"
          ? null
          : quotputdataval55!.wtExemptedAmountSc,
      wtExemptedAmountFc: quotputdataval55!.wtExemptedAmountFc == null ||
              quotputdataval55!.wtExemptedAmountFc == "null"
          ? null
          : quotputdataval55!.wtExemptedAmountFc,
      baseAmount: quotputdataval55!.baseAmount == null ||
              quotputdataval55!.baseAmount == "null"
          ? null
          : quotputdataval55!.baseAmount,
      baseAmountSc: quotputdataval55!.baseAmountSc == null ||
              quotputdataval55!.baseAmountSc == "null"
          ? null
          : quotputdataval55!.baseAmountSc,
      baseAmountFc: quotputdataval55!.baseAmountFc == null ||
              quotputdataval55!.baseAmountFc == "null"
          ? null
          : quotputdataval55!.baseAmountFc,
      wtAmount: quotputdataval55!.wtAmount == null ||
              quotputdataval55!.wtAmount == "null"
          ? null
          : quotputdataval55!.wtAmount,
      wtAmountSc: quotputdataval55!.wtAmountSc == null ||
              quotputdataval55!.wtAmountSc == "null"
          ? null
          : quotputdataval55!.wtAmountSc,
      wtAmountFc: quotputdataval55!.wtAmountFc == null ||
              quotputdataval55!.wtAmountFc == "null"
          ? null
          : quotputdataval55!.wtAmountFc,
      vatDate: quotputdataval55!.vatDate == null ||
              quotputdataval55!.vatDate == "null"
          ? null
          : quotputdataval55!.vatDate,
      documentsOwner: quotputdataval55!.documentsOwner == null ||
              quotputdataval55!.documentsOwner == "null"
          ? null
          : quotputdataval55!.documentsOwner,
      folioPrefixString: quotputdataval55!.folioPrefixString == null ||
              quotputdataval55!.folioPrefixString == "null"
          ? null
          : quotputdataval55!.folioPrefixString,
      folioNumber: quotputdataval55!.folioNumber == null ||
              quotputdataval55!.folioNumber == "null"
          ? null
          : quotputdataval55!.folioNumber,
      documentSubType: quotputdataval55!.documentSubType == null ||
              quotputdataval55!.documentSubType == "null"
          ? null
          : quotputdataval55!.documentSubType,
      bpChannelCode: quotputdataval55!.bpChannelCode == null ||
              quotputdataval55!.bpChannelCode == "null"
          ? null
          : quotputdataval55!.bpChannelCode,
      bpChannelContact: quotputdataval55!.bpChannelContact == null ||
              quotputdataval55!.bpChannelContact == "null"
          ? null
          : quotputdataval55!.bpChannelContact,
      address2: quotputdataval55!.address2 == null ||
              quotputdataval55!.address2 == "null"
          ? null
          : quotputdataval55!.address2,
      documentStatus: quotputdataval55!.documentStatus == null ||
              quotputdataval55!.documentStatus == "null"
          ? null
          : quotputdataval55!.documentStatus,
      periodIndicator: quotputdataval55!.periodIndicator == null ||
              quotputdataval55!.periodIndicator == "null"
          ? null
          : quotputdataval55!.periodIndicator,
      payToCode: quotputdataval55!.payToCode == null ||
              quotputdataval55!.payToCode == "null"
          ? null
          : quotputdataval55!.payToCode,
      manualNumber: quotputdataval55!.manualNumber == null ||
              quotputdataval55!.manualNumber == "null"
          ? null
          : quotputdataval55!.manualNumber,
      useShpdGoodsAct: quotputdataval55!.useShpdGoodsAct == null ||
              quotputdataval55!.useShpdGoodsAct == "null"
          ? null
          : quotputdataval55!.useShpdGoodsAct,
      isPayToBank: quotputdataval55!.isPayToBank == null ||
              quotputdataval55!.isPayToBank == "null"
          ? null
          : quotputdataval55!.isPayToBank,
      payToBankCountry: quotputdataval55!.payToBankCountry == null ||
              quotputdataval55!.payToBankCountry == "null"
          ? null
          : quotputdataval55!.payToBankCountry,
      payToBankCode: quotputdataval55!.payToBankCode == null ||
              quotputdataval55!.payToBankCode == "null"
          ? null
          : quotputdataval55!.payToBankCode,
      payToBankAccountNo: quotputdataval55!.payToBankAccountNo == null ||
              quotputdataval55!.payToBankAccountNo == "null"
          ? null
          : quotputdataval55!.payToBankAccountNo,
      payToBankBranch: quotputdataval55!.payToBankBranch == null ||
              quotputdataval55!.payToBankBranch == "null"
          ? null
          : quotputdataval55!.payToBankBranch,
      bplIdAssignedToInvoice:
          quotputdataval55!.bplIdAssignedToInvoice == null ||
                  quotputdataval55!.bplIdAssignedToInvoice == "null"
              ? null
              : quotputdataval55!.bplIdAssignedToInvoice,
      downPayment: quotputdataval55!.downPayment == null ||
              quotputdataval55!.downPayment == "null"
          ? null
          : quotputdataval55!.downPayment,
      reserveInvoice: quotputdataval55!.reserveInvoice == null ||
              quotputdataval55!.reserveInvoice == "null"
          ? null
          : quotputdataval55!.reserveInvoice,
      languageCode: quotputdataval55!.languageCode == null ||
              quotputdataval55!.languageCode == "null"
          ? null
          : quotputdataval55!.languageCode,
      trackingNumber: quotputdataval55!.trackingNumber == null ||
              quotputdataval55!.trackingNumber == "null"
          ? null
          : quotputdataval55!.trackingNumber,
      pickRemark: quotputdataval55!.pickRemark == null ||
              quotputdataval55!.pickRemark == "null"
          ? null
          : quotputdataval55!.pickRemark,
      closingDate: quotputdataval55!.closingDate == null ||
              quotputdataval55!.closingDate == "null"
          ? null
          : quotputdataval55!.closingDate,
      sequenceCode: quotputdataval55!.sequenceCode == null ||
              quotputdataval55!.sequenceCode == "null"
          ? null
          : quotputdataval55!.sequenceCode,
      sequenceSerial: quotputdataval55!.sequenceSerial == null ||
              quotputdataval55!.sequenceSerial == "null"
          ? null
          : quotputdataval55!.sequenceSerial,
      seriesString: quotputdataval55!.seriesString == null ||
              quotputdataval55!.seriesString == "null"
          ? null
          : quotputdataval55!.seriesString,
      subSeriesString: quotputdataval55!.subSeriesString == null ||
              quotputdataval55!.subSeriesString == "null"
          ? null
          : quotputdataval55!.subSeriesString,
      sequenceModel: quotputdataval55!.sequenceModel == null ||
              quotputdataval55!.sequenceModel == "null"
          ? null
          : quotputdataval55!.sequenceModel,
      useCorrectionVatGroup: quotputdataval55!.useCorrectionVatGroup == null ||
              quotputdataval55!.useCorrectionVatGroup == "null"
          ? null
          : quotputdataval55!.useCorrectionVatGroup,
      totalDiscount: quotputdataval55!.totalDiscount == null ||
              quotputdataval55!.totalDiscount == "null"
          ? null
          : quotputdataval55!.totalDiscount,
      downPaymentAmount: quotputdataval55!.downPaymentAmount == null ||
              quotputdataval55!.downPaymentAmount == "null"
          ? null
          : quotputdataval55!.downPaymentAmount,
      downPaymentPercentage: quotputdataval55!.downPaymentPercentage == null ||
              quotputdataval55!.downPaymentPercentage == "null"
          ? null
          : quotputdataval55!.downPaymentPercentage,
      downPaymentType: quotputdataval55!.downPaymentType == null ||
              quotputdataval55!.downPaymentType == "null"
          ? null
          : quotputdataval55!.downPaymentType,
      downPaymentAmountSc: quotputdataval55!.downPaymentAmountSc == null ||
              quotputdataval55!.downPaymentAmountSc == "null"
          ? null
          : quotputdataval55!.downPaymentAmountSc,
      downPaymentAmountFc: quotputdataval55!.downPaymentAmountFc == null ||
              quotputdataval55!.downPaymentAmountFc == "null"
          ? null
          : quotputdataval55!.downPaymentAmountFc,
      vatPercent: quotputdataval55!.vatPercent == null ||
              quotputdataval55!.vatPercent == "null"
          ? null
          : quotputdataval55!.vatPercent,
      serviceGrossProfitPercent:
          quotputdataval55!.serviceGrossProfitPercent == null ||
                  quotputdataval55!.serviceGrossProfitPercent == "null"
              ? null
              : quotputdataval55!.serviceGrossProfitPercent,
      openingRemarks: quotputdataval55!.openingRemarks == null ||
              quotputdataval55!.openingRemarks == "null"
          ? null
          : quotputdataval55!.openingRemarks,
      closingRemarks: quotputdataval55!.closingRemarks == null ||
              quotputdataval55!.closingRemarks == "null"
          ? null
          : quotputdataval55!.closingRemarks,
      roundingDiffAmount: quotputdataval55!.roundingDiffAmount == null ||
              quotputdataval55!.roundingDiffAmount == "null"
          ? null
          : quotputdataval55!.roundingDiffAmount,
      roundingDiffAmountFc: quotputdataval55!.roundingDiffAmountFc == null ||
              quotputdataval55!.roundingDiffAmountFc == "null"
          ? null
          : quotputdataval55!.roundingDiffAmountFc,
      roundingDiffAmountSc: quotputdataval55!.roundingDiffAmountSc == null ||
              quotputdataval55!.roundingDiffAmountSc == "null"
          ? null
          : quotputdataval55!.roundingDiffAmountSc,
      cancelled: quotputdataval55!.cancelled == null ||
              quotputdataval55!.cancelled == "null"
          ? null
          : quotputdataval55!.cancelled,
      signatureInputMessage: quotputdataval55!.signatureInputMessage == null ||
              quotputdataval55!.signatureInputMessage == "null"
          ? null
          : quotputdataval55!.signatureInputMessage,
      signatureDigest: quotputdataval55!.signatureDigest == null ||
              quotputdataval55!.signatureDigest == "null"
          ? null
          : quotputdataval55!.signatureDigest,
      certificationNumber: quotputdataval55!.certificationNumber == null ||
              quotputdataval55!.certificationNumber == "null"
          ? null
          : quotputdataval55!.certificationNumber,
      privateKeyVersion: quotputdataval55!.privateKeyVersion == null ||
              quotputdataval55!.privateKeyVersion == "null"
          ? null
          : quotputdataval55!.privateKeyVersion,
      controlAccount: quotputdataval55!.controlAccount == null ||
              quotputdataval55!.controlAccount == "null"
          ? null
          : quotputdataval55!.controlAccount,
      insuranceOperation347: quotputdataval55!.insuranceOperation347 == null ||
              quotputdataval55!.insuranceOperation347 == "null"
          ? null
          : quotputdataval55!.insuranceOperation347,
      archiveNonremovableSalesQuotation:
          quotputdataval55!.archiveNonremovableSalesQuotation == null ||
                  quotputdataval55!.archiveNonremovableSalesQuotation == "null"
              ? null
              : quotputdataval55!.archiveNonremovableSalesQuotation,
      gtsChecker: quotputdataval55!.gtsChecker == null ||
              quotputdataval55!.gtsChecker == "null"
          ? null
          : quotputdataval55!.gtsChecker,
      gtsPayee: quotputdataval55!.gtsPayee == null ||
              quotputdataval55!.gtsPayee == "null"
          ? null
          : quotputdataval55!.gtsPayee,
      extraMonth: quotputdataval55!.extraMonth == null ||
              quotputdataval55!.extraMonth == "null"
          ? null
          : quotputdataval55!.extraMonth,
      extraDays: quotputdataval55!.extraDays == null ||
              quotputdataval55!.extraDays == "null"
          ? null
          : quotputdataval55!.extraDays,
      cashDiscountDateOffset:
          quotputdataval55!.cashDiscountDateOffset == null ||
                  quotputdataval55!.cashDiscountDateOffset == "null"
              ? null
              : quotputdataval55!.cashDiscountDateOffset,
      startFrom: quotputdataval55!.startFrom == null ||
              quotputdataval55!.startFrom == "null"
          ? null
          : quotputdataval55!.startFrom,
      ntsApproved: quotputdataval55!.ntsApproved == null ||
              quotputdataval55!.ntsApproved == "null"
          ? null
          : quotputdataval55!.ntsApproved,
      eTaxWebSite: quotputdataval55!.eTaxWebSite == null ||
              quotputdataval55!.eTaxWebSite == "null"
          ? null
          : quotputdataval55!.eTaxWebSite,
      eTaxNumber: quotputdataval55!.eTaxNumber == null ||
              quotputdataval55!.eTaxNumber == "null"
          ? null
          : quotputdataval55!.eTaxNumber,
      ntsApprovedNumber: quotputdataval55!.ntsApprovedNumber == null ||
              quotputdataval55!.ntsApprovedNumber == "null"
          ? null
          : quotputdataval55!.ntsApprovedNumber,
      eDocGenerationType: quotputdataval55!.eDocGenerationType == null ||
              quotputdataval55!.eDocGenerationType == "null"
          ? null
          : quotputdataval55!.eDocGenerationType,
      eDocSeries: quotputdataval55!.eDocSeries == null ||
              quotputdataval55!.eDocSeries == "null"
          ? null
          : quotputdataval55!.eDocSeries,
      eDocNum: quotputdataval55!.eDocNum == null ||
              quotputdataval55!.eDocNum == "null"
          ? null
          : quotputdataval55!.eDocNum,
      eDocExportFormat: quotputdataval55!.eDocExportFormat == null ||
              quotputdataval55!.eDocExportFormat == "null"
          ? null
          : quotputdataval55!.eDocExportFormat,
      eDocStatus: quotputdataval55!.eDocStatus == null ||
              quotputdataval55!.eDocStatus == "null"
          ? null
          : quotputdataval55!.eDocStatus,
      eDocErrorCode: quotputdataval55!.eDocErrorCode == null ||
              quotputdataval55!.eDocErrorCode == "null"
          ? null
          : quotputdataval55!.eDocErrorCode,
      eDocErrorMessage: quotputdataval55!.eDocErrorMessage == null ||
              quotputdataval55!.eDocErrorMessage == "null"
          ? null
          : quotputdataval55!.eDocErrorMessage,
      downPaymentStatus: quotputdataval55!.downPaymentStatus == null ||
              quotputdataval55!.downPaymentStatus == "null"
          ? null
          : quotputdataval55!.downPaymentStatus,
      groupSeries: quotputdataval55!.groupSeries == null ||
              quotputdataval55!.groupSeries == "null"
          ? null
          : quotputdataval55!.groupSeries,
      groupNumber: quotputdataval55!.groupNumber == null ||
              quotputdataval55!.groupNumber == "null"
          ? null
          : quotputdataval55!.groupNumber,
      groupHandWritten: quotputdataval55!.groupHandWritten == null ||
              quotputdataval55!.groupHandWritten == "null"
          ? null
          : quotputdataval55!.groupHandWritten,
      reopenOriginalDocument:
          quotputdataval55!.reopenOriginalDocument == null ||
                  quotputdataval55!.reopenOriginalDocument == "null"
              ? null
              : quotputdataval55!.reopenOriginalDocument,
      reopenManuallyClosedOrCanceledDocument:
          quotputdataval55!.reopenManuallyClosedOrCanceledDocument == null ||
                  quotputdataval55!.reopenManuallyClosedOrCanceledDocument ==
                      "null"
              ? null
              : quotputdataval55!.reopenManuallyClosedOrCanceledDocument,
      createOnlineQuotation: quotputdataval55!.createOnlineQuotation == null ||
              quotputdataval55!.createOnlineQuotation == "null"
          ? null
          : quotputdataval55!.createOnlineQuotation,
      posEquipmentNumber: quotputdataval55!.posEquipmentNumber == null ||
              quotputdataval55!.posEquipmentNumber == "null"
          ? null
          : quotputdataval55!.posEquipmentNumber,
      posManufacturerSerialNumber:
          quotputdataval55!.posManufacturerSerialNumber == null ||
                  quotputdataval55!.posManufacturerSerialNumber == "null"
              ? null
              : quotputdataval55!.posManufacturerSerialNumber,
      posCashierNumber: quotputdataval55!.posCashierNumber == null ||
              quotputdataval55!.posCashierNumber == "null"
          ? null
          : quotputdataval55!.posCashierNumber,
      applyCurrentVatRatesForDownPaymentsToDraw:
          quotputdataval55!.applyCurrentVatRatesForDownPaymentsToDraw == null ||
                  quotputdataval55!.applyCurrentVatRatesForDownPaymentsToDraw ==
                      "null"
              ? null
              : quotputdataval55!.applyCurrentVatRatesForDownPaymentsToDraw,
      closingOption: quotputdataval55!.closingOption == null ||
              quotputdataval55!.closingOption == "null"
          ? null
          : quotputdataval55!.closingOption,
      specifiedClosingDate: quotputdataval55!.specifiedClosingDate == null ||
              quotputdataval55!.specifiedClosingDate == "null"
          ? null
          : quotputdataval55!.specifiedClosingDate,
      openForLandedCosts: quotputdataval55!.openForLandedCosts == null ||
              quotputdataval55!.openForLandedCosts == "null"
          ? null
          : quotputdataval55!.openForLandedCosts,
      authorizationStatus: quotputdataval55!.authorizationStatus == null ||
              quotputdataval55!.authorizationStatus == "null"
          ? null
          : quotputdataval55!.authorizationStatus,
      totalDiscountFc: quotputdataval55!.totalDiscountFc == null ||
              quotputdataval55!.totalDiscountFc == "null"
          ? null
          : quotputdataval55!.totalDiscountFc,
      totalDiscountSc: quotputdataval55!.totalDiscountSc == null ||
              quotputdataval55!.totalDiscountSc == "null"
          ? null
          : quotputdataval55!.totalDiscountSc,
      relevantToGts: quotputdataval55!.relevantToGts == null ||
              quotputdataval55!.relevantToGts == "null"
          ? null
          : quotputdataval55!.relevantToGts,
      bplName: quotputdataval55!.bplName == null ||
              quotputdataval55!.bplName == "null"
          ? null
          : quotputdataval55!.bplName,
      vatRegNum: quotputdataval55!.vatRegNum == null ||
              quotputdataval55!.vatRegNum == "null"
          ? null
          : quotputdataval55!.vatRegNum,
      annualInvoiceDeclarationReference:
          quotputdataval55!.annualInvoiceDeclarationReference == null ||
                  quotputdataval55!.annualInvoiceDeclarationReference == "null"
              ? null
              : quotputdataval55!.annualInvoiceDeclarationReference,
      supplier: quotputdataval55!.supplier == null ||
              quotputdataval55!.supplier == "null"
          ? null
          : quotputdataval55!.supplier,
      releaser: quotputdataval55!.releaser == null ||
              quotputdataval55!.releaser == "null"
          ? null
          : quotputdataval55!.releaser,
      receiver: quotputdataval55!.receiver == null ||
              quotputdataval55!.receiver == "null"
          ? null
          : quotputdataval55!.receiver,
      blanketAgreementNumber:
          quotputdataval55!.blanketAgreementNumber == null ||
                  quotputdataval55!.blanketAgreementNumber == "null"
              ? null
              : quotputdataval55!.blanketAgreementNumber,
      isAlteration: quotputdataval55!.isAlteration == null ||
              quotputdataval55!.isAlteration == "null"
          ? null
          : quotputdataval55!.isAlteration,
      cancelStatus: quotputdataval55!.cancelStatus == null ||
              quotputdataval55!.cancelStatus == "null"
          ? null
          : quotputdataval55!.cancelStatus,
      assetValueDate: quotputdataval55!.assetValueDate == null ||
              quotputdataval55!.assetValueDate == "null"
          ? null
          : quotputdataval55!.assetValueDate,
      documentDelivery: quotputdataval55!.documentDelivery == null ||
              quotputdataval55!.documentDelivery == "null"
          ? null
          : quotputdataval55!.documentDelivery,
      authorizationCode: quotputdataval55!.authorizationCode == null ||
              quotputdataval55!.authorizationCode == "null"
          ? null
          : quotputdataval55!.authorizationCode,
      startDeliveryDate: quotputdataval55!.startDeliveryDate == null ||
              quotputdataval55!.startDeliveryDate == "null"
          ? null
          : quotputdataval55!.startDeliveryDate,
      startDeliveryTime: quotputdataval55!.startDeliveryTime == null ||
              quotputdataval55!.startDeliveryTime == "null"
          ? null
          : quotputdataval55!.startDeliveryTime,
      endDeliveryDate: quotputdataval55!.endDeliveryDate == null ||
              quotputdataval55!.endDeliveryDate == "null"
          ? null
          : quotputdataval55!.endDeliveryDate,
      endDeliveryTime: quotputdataval55!.endDeliveryTime == null ||
              quotputdataval55!.endDeliveryTime == "null"
          ? null
          : quotputdataval55!.endDeliveryTime,
      vehiclePlate: quotputdataval55!.vehiclePlate == null ||
              quotputdataval55!.vehiclePlate == "null"
          ? null
          : quotputdataval55!.vehiclePlate,
      atDocumentType: quotputdataval55!.atDocumentType == null ||
              quotputdataval55!.atDocumentType == "null"
          ? null
          : quotputdataval55!.atDocumentType,
      elecCommStatus: quotputdataval55!.elecCommStatus == null ||
              quotputdataval55!.elecCommStatus == "null"
          ? null
          : quotputdataval55!.elecCommStatus,
      elecCommMessage: quotputdataval55!.elecCommMessage == null ||
              quotputdataval55!.elecCommMessage == "null"
          ? null
          : quotputdataval55!.elecCommMessage,
      reuseDocumentNum: quotputdataval55!.reuseDocumentNum == null ||
              quotputdataval55!.reuseDocumentNum == "null"
          ? null
          : quotputdataval55!.reuseDocumentNum,
      reuseNotaFiscalNum: quotputdataval55!.reuseNotaFiscalNum == null ||
              quotputdataval55!.reuseNotaFiscalNum == "null"
          ? null
          : quotputdataval55!.reuseNotaFiscalNum,
      printSepaDirect: quotputdataval55!.printSepaDirect == null ||
              quotputdataval55!.printSepaDirect == "null"
          ? null
          : quotputdataval55!.printSepaDirect,
      fiscalDocNum: quotputdataval55!.fiscalDocNum == null ||
              quotputdataval55!.fiscalDocNum == "null"
          ? null
          : quotputdataval55!.fiscalDocNum,
      posDailySummaryNo: quotputdataval55!.posDailySummaryNo == null ||
              quotputdataval55!.posDailySummaryNo == "null"
          ? null
          : quotputdataval55!.posDailySummaryNo,
      posReceiptNo: quotputdataval55!.posReceiptNo == null ||
              quotputdataval55!.posReceiptNo == "null"
          ? null
          : quotputdataval55!.posReceiptNo,
      pointOfIssueCode: quotputdataval55!.pointOfIssueCode == null ||
              quotputdataval55!.pointOfIssueCode == "null"
          ? null
          : quotputdataval55!.pointOfIssueCode,
      letter:
          quotputdataval55!.letter == null || quotputdataval55!.letter == "null"
              ? null
              : quotputdataval55!.letter,
      folioNumberFrom: quotputdataval55!.folioNumberFrom == null ||
              quotputdataval55!.folioNumberFrom == "null"
          ? null
          : quotputdataval55!.folioNumberFrom,
      folioNumberTo: quotputdataval55!.folioNumberTo == null ||
              quotputdataval55!.folioNumberTo == "null"
          ? null
          : quotputdataval55!.folioNumberTo,
      interimType: quotputdataval55!.interimType == null ||
              quotputdataval55!.interimType == "null"
          ? null
          : quotputdataval55!.interimType,
      relatedType: quotputdataval55!.relatedType == null ||
              quotputdataval55!.relatedType == "null"
          ? null
          : quotputdataval55!.relatedType,
      relatedEntry: quotputdataval55!.relatedEntry == null ||
              quotputdataval55!.relatedEntry == "null"
          ? null
          : quotputdataval55!.relatedEntry,
      sapPassport: quotputdataval55!.sapPassport == null ||
              quotputdataval55!.sapPassport == "null"
          ? null
          : quotputdataval55!.sapPassport,
      documentTaxId: quotputdataval55!.documentTaxId == null ||
              quotputdataval55!.documentTaxId == "null"
          ? null
          : quotputdataval55!.documentTaxId,
      dateOfReportingControlStatementVat:
          quotputdataval55!.dateOfReportingControlStatementVat == null ||
                  quotputdataval55!.dateOfReportingControlStatementVat == "null"
              ? null
              : quotputdataval55!.dateOfReportingControlStatementVat,
      reportingSectionControlStatementVat:
          quotputdataval55!.reportingSectionControlStatementVat == null ||
                  quotputdataval55!.reportingSectionControlStatementVat ==
                      "null"
              ? null
              : quotputdataval55!.reportingSectionControlStatementVat,
      excludeFromTaxReportControlStatementVat:
          quotputdataval55!.excludeFromTaxReportControlStatementVat == null ||
                  quotputdataval55!.excludeFromTaxReportControlStatementVat ==
                      "null"
              ? null
              : quotputdataval55!.excludeFromTaxReportControlStatementVat,
      posCashRegister: quotputdataval55!.posCashRegister == null ||
              quotputdataval55!.posCashRegister == "null"
          ? null
          : quotputdataval55!.posCashRegister,
      updateTime: quotputdataval55!.updateTime == null ||
              quotputdataval55!.updateTime == "null"
          ? null
          : quotputdataval55!.updateTime,
      createQrCodeFrom: quotputdataval55!.createQrCodeFrom == null ||
              quotputdataval55!.createQrCodeFrom == "null"
          ? null
          : quotputdataval55!.createQrCodeFrom,
      priceMode: quotputdataval55!.priceMode == null ||
              quotputdataval55!.priceMode == "null"
          ? null
          : quotputdataval55!.priceMode,
      shipFrom: quotputdataval55!.shipFrom == null ||
              quotputdataval55!.shipFrom == "null"
          ? null
          : quotputdataval55!.shipFrom,
      commissionTrade: quotputdataval55!.commissionTrade == null ||
              quotputdataval55!.commissionTrade == "null"
          ? null
          : quotputdataval55!.commissionTrade,
      commissionTradeReturn: quotputdataval55!.commissionTradeReturn == null ||
              quotputdataval55!.commissionTradeReturn == "null"
          ? null
          : quotputdataval55!.commissionTradeReturn,
      useBillToAddrToDetermineTax:
          quotputdataval55!.useBillToAddrToDetermineTax == null ||
                  quotputdataval55!.useBillToAddrToDetermineTax == "null"
              ? null
              : quotputdataval55!.useBillToAddrToDetermineTax,
      cig: quotputdataval55!.cig == null || quotputdataval55!.cig == "null"
          ? null
          : quotputdataval55!.cig,
      cup: quotputdataval55!.cup == null || quotputdataval55!.cup == "null"
          ? null
          : quotputdataval55!.cup,
      fatherCard: quotputdataval55!.fatherCard == null ||
              quotputdataval55!.fatherCard == "null"
          ? null
          : quotputdataval55!.fatherCard,
      fatherType: quotputdataval55!.fatherType == null ||
              quotputdataval55!.fatherType == "null"
          ? null
          : quotputdataval55!.fatherType,
      shipState: quotputdataval55!.shipState == null ||
              quotputdataval55!.shipState == "null"
          ? null
          : quotputdataval55!.shipState,
      shipPlace: quotputdataval55!.shipPlace == null ||
              quotputdataval55!.shipPlace == "null"
          ? null
          : quotputdataval55!.shipPlace,
      custOffice: quotputdataval55!.custOffice == null ||
              quotputdataval55!.custOffice == "null"
          ? null
          : quotputdataval55!.custOffice,
      fci: quotputdataval55!.fci == null || quotputdataval55!.fci == "null"
          ? null
          : quotputdataval55!.fci,
      addLegIn: quotputdataval55!.addLegIn == null ||
              quotputdataval55!.addLegIn == "null"
          ? null
          : quotputdataval55!.addLegIn,
      legTextF: quotputdataval55!.legTextF == null ||
              quotputdataval55!.legTextF == "null"
          ? null
          : quotputdataval55!.legTextF,
      danfeLgTxt: quotputdataval55!.danfeLgTxt == null ||
              quotputdataval55!.danfeLgTxt == "null"
          ? null
          : quotputdataval55!.danfeLgTxt,
      indFinal: quotputdataval55!.indFinal == null ||
              quotputdataval55!.indFinal == "null"
          ? null
          : quotputdataval55!.indFinal,
      dataVersion: quotputdataval55!.dataVersion == null ||
              quotputdataval55!.dataVersion == "null"
          ? null
          : quotputdataval55!.dataVersion,
      uPurchaseType: quotputdataval55!.uPurchaseType == null ||
              quotputdataval55!.uPurchaseType == "null"
          ? null
          : quotputdataval55!.uPurchaseType,
      uApApprove: quotputdataval55!.uApApprove == null ||
              quotputdataval55!.uApApprove == "null"
          ? null
          : quotputdataval55!.uApApprove,
      uFinalDel: quotputdataval55!.uFinalDel == null ||
              quotputdataval55!.uFinalDel == "null"
          ? null
          : quotputdataval55!.uFinalDel,
      uIncoTerms: quotputdataval55!.uIncoTerms == null ||
              quotputdataval55!.uIncoTerms == "null"
          ? null
          : quotputdataval55!.uIncoTerms,
      uSourceDest: quotputdataval55!.uSourceDest == null ||
              quotputdataval55!.uSourceDest == "null"
          ? null
          : quotputdataval55!.uSourceDest,
      uTransNo: quotputdataval55!.uTransNo == null ||
              quotputdataval55!.uTransNo == "null"
          ? null
          : quotputdataval55!.uTransNo,
      uVehicleNo: quotputdataval55!.uVehicleNo == null ||
              quotputdataval55!.uVehicleNo == "null"
          ? null
          : quotputdataval55!.uVehicleNo,
      uSupplierDt: quotputdataval55!.uSupplierDt == null ||
              quotputdataval55!.uSupplierDt == "null"
          ? null
          : quotputdataval55!.uSupplierDt,
      uQuotNo: quotputdataval55!.uQuotNo == null ||
              quotputdataval55!.uQuotNo == "null"
          ? null
          : quotputdataval55!.uQuotNo,
      uQuotDate: quotputdataval55!.uQuotDate == null ||
              quotputdataval55!.uQuotDate == "null"
          ? null
          : quotputdataval55!.uQuotDate,
      uGovPermit: quotputdataval55!.uGovPermit == null ||
              quotputdataval55!.uGovPermit == "null"
          ? null
          : quotputdataval55!.uGovPermit,
      uGovPermitdt: quotputdataval55!.uGovPermitdt == null ||
              quotputdataval55!.uGovPermitdt == "null"
          ? null
          : quotputdataval55!.uGovPermitdt,
      uCheckNo: quotputdataval55!.uCheckNo == null ||
              quotputdataval55!.uCheckNo == "null"
          ? null
          : quotputdataval55!.uCheckNo,
      uCheckDate: quotputdataval55!.uCheckDate == null ||
              quotputdataval55!.uCheckDate == "null"
          ? null
          : quotputdataval55!.uCheckDate,
      uApprovalDate: quotputdataval55!.uApprovalDate == null ||
              quotputdataval55!.uApprovalDate == "null"
          ? null
          : quotputdataval55!.uApprovalDate,
      uOrderNoRecd: quotputdataval55!.uOrderNoRecd == null ||
              quotputdataval55!.uOrderNoRecd == "null"
          ? null
          : quotputdataval55!.uOrderNoRecd,
      uOrderDate: quotputdataval55!.uOrderDate == null ||
              quotputdataval55!.uOrderDate == "null"
          ? null
          : quotputdataval55!.uOrderDate,
      uClearingAgent: quotputdataval55!.uClearingAgent == null ||
              quotputdataval55!.uClearingAgent == "null"
          ? null
          : quotputdataval55!.uClearingAgent,
      uDateSubAgent: quotputdataval55!.uDateSubAgent == null ||
              quotputdataval55!.uDateSubAgent == "null"
          ? null
          : quotputdataval55!.uDateSubAgent,
      uIdfno:
          quotputdataval55!.uIdfno == null || quotputdataval55!.uIdfno == "null"
              ? null
              : quotputdataval55!.uIdfno,
      uIdfDate: quotputdataval55!.uIdfDate == null ||
              quotputdataval55!.uIdfDate == "null"
          ? null
          : quotputdataval55!.uIdfDate,
      uInspectionNo: quotputdataval55!.uInspectionNo == null ||
              quotputdataval55!.uInspectionNo == "null"
          ? null
          : quotputdataval55!.uInspectionNo,
      uEta: quotputdataval55!.uEta == null || quotputdataval55!.uEta == "null"
          ? null
          : quotputdataval55!.uEta,
      uAirwayBillNo: quotputdataval55!.uAirwayBillNo == null ||
              quotputdataval55!.uAirwayBillNo == "null"
          ? null
          : quotputdataval55!.uAirwayBillNo,
      uBol: quotputdataval55!.uBol == null || quotputdataval55!.uBol == "null"
          ? null
          : quotputdataval55!.uBol,
      uCotecna: quotputdataval55!.uCotecna == null ||
              quotputdataval55!.uCotecna == "null"
          ? null
          : quotputdataval55!.uCotecna,
      uArrivalDate: quotputdataval55!.uArrivalDate == null ||
              quotputdataval55!.uArrivalDate == "null"
          ? null
          : quotputdataval55!.uArrivalDate,
      uDahacoAgentFees: quotputdataval55!.uDahacoAgentFees == null ||
              quotputdataval55!.uDahacoAgentFees == "null"
          ? null
          : quotputdataval55!.uDahacoAgentFees,
      uPortCharges: quotputdataval55!.uPortCharges == null ||
              quotputdataval55!.uPortCharges == "null"
          ? null
          : quotputdataval55!.uPortCharges,
      uOtherExp: quotputdataval55!.uOtherExp == null ||
              quotputdataval55!.uOtherExp == "null"
          ? null
          : quotputdataval55!.uOtherExp,
      uClearCharges: quotputdataval55!.uClearCharges == null ||
              quotputdataval55!.uClearCharges == "null"
          ? null
          : quotputdataval55!.uClearCharges,
      uHiddenChrges: quotputdataval55!.uHiddenChrges == null ||
              quotputdataval55!.uHiddenChrges == "null"
          ? null
          : quotputdataval55!.uHiddenChrges,
      uGoodsInspBy: quotputdataval55!.uGoodsInspBy == null ||
              quotputdataval55!.uGoodsInspBy == "null"
          ? null
          : quotputdataval55!.uGoodsInspBy,
      uGoodsReport: quotputdataval55!.uGoodsReport == null ||
              quotputdataval55!.uGoodsReport == "null"
          ? null
          : quotputdataval55!.uGoodsReport,
      uPymtStatus: quotputdataval55!.uPymtStatus == null ||
              quotputdataval55!.uPymtStatus == "null"
          ? null
          : quotputdataval55!.uPymtStatus,
      uPymtType: quotputdataval55!.uPymtType == null ||
              quotputdataval55!.uPymtType == "null"
          ? null
          : quotputdataval55!.uPymtType,
      uTtCopyImage: quotputdataval55!.uTtCopyImage == null ||
              quotputdataval55!.uTtCopyImage == "null"
          ? null
          : quotputdataval55!.uTtCopyImage,
      uPfiImage: quotputdataval55!.uPfiImage == null ||
              quotputdataval55!.uPfiImage == "null"
          ? null
          : quotputdataval55!.uPfiImage,
      uSupplierImage: quotputdataval55!.uSupplierImage == null ||
              quotputdataval55!.uSupplierImage == "null"
          ? null
          : quotputdataval55!.uSupplierImage,
      uBolImage: quotputdataval55!.uBolImage == null ||
              quotputdataval55!.uBolImage == "null"
          ? null
          : quotputdataval55!.uBolImage,
      uOrderType: quotputdataval55!.uOrderType == null ||
              quotputdataval55!.uOrderType == "null"
          ? null
          : quotputdataval55!.uOrderType,
      uTruckInternal: quotputdataval55!.uTruckInternal == null ||
              quotputdataval55!.uTruckInternal == "null"
          ? null
          : quotputdataval55!.uTruckInternal,
      uGpApproval: quotputdataval55!.uGpApproval == null ||
              quotputdataval55!.uGpApproval == "null"
          ? null
          : quotputdataval55!.uGpApproval,
      uSupplierName: quotputdataval55!.uSupplierName == null ||
              quotputdataval55!.uSupplierName == "null"
          ? null
          : quotputdataval55!.uSupplierName,
      uVatNumber: quotputdataval55!.uVatNumber == null ||
              quotputdataval55!.uVatNumber == "null"
          ? null
          : quotputdataval55!.uVatNumber,
      uTransferType: quotputdataval55!.uTransferType == null ||
              quotputdataval55!.uTransferType == "null"
          ? null
          : quotputdataval55!.uTransferType,
      uSalesOrder: quotputdataval55!.uSalesOrder == null ||
              quotputdataval55!.uSalesOrder == "null"
          ? null
          : quotputdataval55!.uSalesOrder,
      uReceived: quotputdataval55!.uReceived == null ||
              quotputdataval55!.uReceived == "null"
          ? null
          : quotputdataval55!.uReceived,
      uDriverName: quotputdataval55!.uDriverName == null ||
              quotputdataval55!.uDriverName == "null"
          ? null
          : quotputdataval55!.uDriverName,
      uReserveInvoice: quotputdataval55!.uReserveInvoice == null ||
              quotputdataval55!.uReserveInvoice == "null"
          ? null
          : quotputdataval55!.uReserveInvoice,
      uRefSeries: quotputdataval55!.uRefSeries == null ||
              quotputdataval55!.uRefSeries == "null"
          ? null
          : quotputdataval55!.uRefSeries,
      uReceivedTime: quotputdataval55!.uReceivedTime == null ||
              quotputdataval55!.uReceivedTime == "null"
          ? null
          : quotputdataval55!.uReceivedTime,
      uSkuBatchNo: quotputdataval55!.uSkuBatchNo == null ||
              quotputdataval55!.uSkuBatchNo == "null"
          ? null
          : quotputdataval55!.uSkuBatchNo,
      uInwardNo: quotputdataval55!.uInwardNo == null ||
              quotputdataval55!.uInwardNo == "null"
          ? null
          : quotputdataval55!.uInwardNo,
      uDispatchTime: quotputdataval55!.uDispatchTime == null ||
              quotputdataval55!.uDispatchTime == "null"
          ? null
          : quotputdataval55!.uDispatchTime,
      uReceivedDate: quotputdataval55!.uReceivedDate == null ||
              quotputdataval55!.uReceivedDate == "null"
          ? null
          : quotputdataval55!.uReceivedDate,
      uExpiryDate: quotputdataval55!.uExpiryDate == null ||
              quotputdataval55!.uExpiryDate == "null"
          ? null
          : quotputdataval55!.uExpiryDate,
      uCnType: quotputdataval55!.uCnType == null ||
              quotputdataval55!.uCnType == "null"
          ? null
          : quotputdataval55!.uCnType,
      uTinNo:
          quotputdataval55!.uTinNo == null || quotputdataval55!.uTinNo == "null"
              ? null
              : quotputdataval55!.uTinNo,
      uLpoNo:
          quotputdataval55!.uLpoNo == null || quotputdataval55!.uLpoNo == "null"
              ? null
              : quotputdataval55!.uLpoNo,
      uOrderQty: quotputdataval55!.uOrderQty == null ||
              quotputdataval55!.uOrderQty == "null"
          ? null
          : quotputdataval55!.uOrderQty,
      uDispatchDate: quotputdataval55!.uDispatchDate == null ||
              quotputdataval55!.uDispatchDate == "null"
          ? null
          : quotputdataval55!.uDispatchDate,
      uBranch: quotputdataval55!.uBranch == null ||
              quotputdataval55!.uBranch == "null"
          ? null
          : quotputdataval55!.uBranch,
      uSalAppEntry: quotputdataval55!.uSalAppEntry == null ||
              quotputdataval55!.uSalAppEntry == "null"
          ? null
          : quotputdataval55!.uSalAppEntry,
      uDocType: quotputdataval55!.uDocType == null ||
              quotputdataval55!.uDocType == "null"
          ? null
          : quotputdataval55!.uDocType,
      uIntKey: quotputdataval55!.uIntKey == null ||
              quotputdataval55!.uIntKey == "null"
          ? null
          : quotputdataval55!.uIntKey,
      uQrFileLoc: quotputdataval55!.uQrFileLoc == null ||
              quotputdataval55!.uQrFileLoc == "null"
          ? null
          : quotputdataval55!.uQrFileLoc,
      uRctCde: quotputdataval55!.uRctCde == null ||
              quotputdataval55!.uRctCde == "null"
          ? null
          : quotputdataval55!.uRctCde,
      uZno: quotputdataval55!.uZno == null || quotputdataval55!.uZno == "null"
          ? null
          : quotputdataval55!.uZno,
      uVfdIn:
          quotputdataval55!.uVfdIn == null || quotputdataval55!.uVfdIn == "null"
              ? null
              : quotputdataval55!.uVfdIn,
      uQrPath: quotputdataval55!.uQrPath == null ||
              quotputdataval55!.uQrPath == "null"
          ? null
          : quotputdataval55!.uQrPath,
      uQrValue: quotputdataval55!.uQrValue == null ||
              quotputdataval55!.uQrValue == "null"
          ? null
          : quotputdataval55!.uQrValue,
      uIdate:
          quotputdataval55!.uIdate == null || quotputdataval55!.uIdate == "null"
              ? null
              : quotputdataval55!.uIdate,
      uItime:
          quotputdataval55!.uItime == null || quotputdataval55!.uItime == "null"
              ? null
              : quotputdataval55!.uItime,
      uDeviceCode: quotputdataval55!.uDeviceCode == null ||
              quotputdataval55!.uDeviceCode == "null"
          ? null
          : quotputdataval55!.uDeviceCode,
      uDeviceTransId: quotputdataval55!.uDeviceTransId == null ||
              quotputdataval55!.uDeviceTransId == "null"
          ? null
          : quotputdataval55!.uDeviceTransId,
      uRvc: quotputdataval55!.uRvc == null || quotputdataval55!.uRvc == "null"
          ? null
          : quotputdataval55!.uRvc,
      uVrn: quotputdataval55!.uVrn == null || quotputdataval55!.uVrn == "null"
          ? null
          : quotputdataval55!.uVrn,
      uLongitude: quotputdataval55!.uLongitude == null ||
              quotputdataval55!.uLongitude == "null"
          ? null
          : quotputdataval55!.uLongitude,
      uLatitude: quotputdataval55!.uLatitude == null ||
              quotputdataval55!.uLatitude == "null"
          ? null
          : quotputdataval55!.uLatitude,
      uAuditJobGroup: quotputdataval55!.uAuditJobGroup == null ||
              quotputdataval55!.uAuditJobGroup == "null"
          ? null
          : quotputdataval55!.uAuditJobGroup,
      uAuditName: quotputdataval55!.uAuditName == null ||
              quotputdataval55!.uAuditName == "null"
          ? null
          : quotputdataval55!.uAuditName,
      uRequest: quotputdataval55!.uRequest == null ||
              quotputdataval55!.uRequest == "null"
          ? null
          : quotputdataval55!.uRequest,
      uPosDocNo: quotputdataval55!.uPosDocNo == null ||
              quotputdataval55!.uPosDocNo == "null"
          ? null
          : quotputdataval55!.uPosDocNo,
      documentLines: [],
      documentReferences: quotputdataval55!.documentReferences!.isNotEmpty
          ? quotputdataval55!.documentReferences
          : [],
      taxExtension: quotputdataval55!.taxExtension == null
          ? null
          : quotputdataval55!.taxExtension,
      addressExtension: quotputdataval55!.addressExtension == null
          ? null
          : quotputdataval55!.addressExtension,
    );

    getdocitemsDetailsData = quotputdataval55!.documentLines!;
  }

  putcheckitem() async {
    itemsDetailsData = [];
    log("getdocitemsDetailsData::::${getdocitemsDetailsData.length}");
    // for (int i = 0; i < getdocitemsDetailsData.length; i++) {
    await dputItemListData();
    // }
  }

  dputItemListData() {
    for (int ij = 0; ij < contentitemsDetails55.length; ij++) {
      // log("DDDD::${getdocitemsDetailsData[i].itemCode! + ":::" + contentitemsDetails55[ij].itemCode.toString()}");
      // if (getdocitemsDetailsData[i].itemCode ==
      //     contentitemsDetails55[ij].itemCode) {
      log("contentitemsDetails55[ij].lineNo::${contentitemsDetails55[ij].lineNumm}");
      // log("message:::");
      if (contentitemsDetails55[ij].lineNumm != null) {
        itemsDetailsData.add(DocumentLineData(
          lineNum: contentitemsDetails55[ij].lineNumm,
          // contentitemsDetails55[ij].lineNum,
          itemCode: contentitemsDetails55[ij].itemCode,
          itemDescription: contentitemsDetails55[ij].itemName,
          quantity: contentitemsDetails55[ij].qty,
          shipDate: contentitemsDetails55[ij].shipDate,
          price: contentitemsDetails55[ij].price,
          priceAfterVat: contentitemsDetails55[ij].priceAfterVat,
          currency: GetValues.currency,
          rate: contentitemsDetails55[ij].rate,
          discountPercent: contentitemsDetails55[ij].discounpercent,
          vendorNum: contentitemsDetails55[ij].vendorNum,
          serialNum: contentitemsDetails55[ij].serialNum,
          warehouseCode: contentitemsDetails55[ij].warehouse,
          salesPersonCode: contentitemsDetails55[ij].salesPersonCode,
          commisionPercent: contentitemsDetails55[ij].commisionPercent,
          treeType: contentitemsDetails55[ij].treeType,
          accountCode: contentitemsDetails55[ij].accountCode,
          useBaseUnits: contentitemsDetails55[ij].useBaseUnits,
          supplierCatNum: contentitemsDetails55[ij].supplierCatNum,
          costingCode: contentitemsDetails55[ij].costingCode,
          projectCode: contentitemsDetails55[ij].projectCode == null ||
                  contentitemsDetails55[ij].projectCode == "null"
              ? null
              : contentitemsDetails55[ij].projectCode,
          // contentitemsDetails55[ij].projectCode,
          barCode: contentitemsDetails55[ij].barCode == null ||
                  contentitemsDetails55[ij].barCode == "null"
              ? null
              : contentitemsDetails55[ij].barCode,
          vatGroup: contentitemsDetails55[ij].vatGroup,
          height1: contentitemsDetails55[ij].height1,
          hight1Unit: contentitemsDetails55[ij].hight1Unit == null ||
                  contentitemsDetails55[ij].hight1Unit == "null"
              ? null
              : contentitemsDetails55[ij].hight1Unit,
          height2: contentitemsDetails55[ij].height2,
          height2Unit: contentitemsDetails55[ij].height2Unit == null ||
                  contentitemsDetails55[ij].height2Unit == "null"
              ? null
              : contentitemsDetails55[ij].height2Unit,
          lengh1: contentitemsDetails55[ij].lengh1,
          lengh1Unit: contentitemsDetails55[ij].lengh1Unit == null ||
                  contentitemsDetails55[ij].lengh1Unit == "null"
              ? null
              : contentitemsDetails55[ij].lengh1Unit,
          lengh2: contentitemsDetails55[ij].lengh2,
          lengh2Unit: contentitemsDetails55[ij].lengh2Unit == null ||
                  contentitemsDetails55[ij].lengh2Unit == "null"
              ? null
              : contentitemsDetails55[ij].lengh2Unit,
          weight1: contentitemsDetails55[ij].weight1,
          weight1Unit: contentitemsDetails55[ij].weight1Unit,
          weight2: contentitemsDetails55[ij].weight2,
          weight2Unit: contentitemsDetails55[ij].weight2Unit,
          factor1: contentitemsDetails55[ij].factor1,
          factor2: contentitemsDetails55[ij].factor2,
          factor3: contentitemsDetails55[ij].factor3,
          factor4: contentitemsDetails55[ij].factor4,
          baseType: contentitemsDetails55[ij].baseType,
          baseEntry: contentitemsDetails55[ij].baseEntry,
          baseLine: contentitemsDetails55[ij].baseLine,
          volume: contentitemsDetails55[ij].volume,
          volumeUnit: contentitemsDetails55[ij].volumeUnit,
          width1: contentitemsDetails55[ij].weight1,
          width1Unit: contentitemsDetails55[ij].width1Unit,
          width2: contentitemsDetails55[ij].weight2,
          width2Unit: contentitemsDetails55[ij].width2Unit,
          address: contentitemsDetails55[ij].address,
          taxCode: contentitemsDetails55[ij].taxCode,
          taxType: contentitemsDetails55[ij].taxType,
          taxLiable: contentitemsDetails55[ij].taxLiable,
          pickStatus: contentitemsDetails55[ij].pickStatus,
          pickQuantity: contentitemsDetails55[ij].pickQuantity,
          pickListIdNumber: contentitemsDetails55[ij].pickListIdNumber,
          originalItem: contentitemsDetails55[ij].originalItem,
          backOrder: contentitemsDetails55[ij].backOrder,
          freeText: contentitemsDetails55[ij].freeText,
          shippingMethod: contentitemsDetails55[ij].shippingMethod,
          poTargetNum: contentitemsDetails55[ij].poTargetNum == null ||
                  contentitemsDetails55[ij].poTargetNum == "null"
              ? null
              : contentitemsDetails55[ij].poTargetNum,
          poTargetEntry: contentitemsDetails55[ij].poTargetEntry,
          poTargetRowNum: contentitemsDetails55[ij].poTargetRowNum,
          correctionInvoiceItem:
              contentitemsDetails55[ij].correctionInvoiceItem,
          corrInvAmountToStock: contentitemsDetails55[ij].corrInvAmountToStock,
          corrInvAmountToDiffAcct:
              contentitemsDetails55[ij].corrInvAmountToDiffAcct,
          appliedTax: contentitemsDetails55[ij].appliedTax,
          appliedTaxFc: contentitemsDetails55[ij].appliedTaxFc,
          appliedTaxSc: contentitemsDetails55[ij].appliedTaxSc,
          wtLiable: contentitemsDetails55[ij].wtLiable,
          deferredTax: contentitemsDetails55[ij].deferredTax,
          equalizationTaxPercent:
              contentitemsDetails55[ij].equalizationTaxPercent,
          totalEqualizationTax: contentitemsDetails55[ij].totalEqualizationTax,
          totalEqualizationTaxFc:
              contentitemsDetails55[ij].totalEqualizationTaxFc,
          totalEqualizationTaxSc:
              contentitemsDetails55[ij].totalEqualizationTaxSc,
          netTaxAmount: contentitemsDetails55[ij].netTaxAmount,
          netTaxAmountFc: contentitemsDetails55[ij].netTaxAmountFc,
          netTaxAmountSc: contentitemsDetails55[ij].netTaxAmountSc,
          measureUnit: contentitemsDetails55[ij].measureUnit,
          unitsOfMeasurment: contentitemsDetails55[ij].unitsOfMeasurment,
          lineTotal: contentitemsDetails55[ij].lineTotal,
          taxPercentagePerRow: contentitemsDetails55[ij].taxPercentagePerRow,
          taxTotal: contentitemsDetails55[ij].taxTotal,
          consumerSalesForecast:
              contentitemsDetails55[ij].consumerSalesForecast,
          exciseAmount: contentitemsDetails55[ij].exciseAmount,
          taxPerUnit: contentitemsDetails55[ij].taxPerUnit,
          totalInclTax: contentitemsDetails55[ij].totalInclTax,
          countryOrg: contentitemsDetails55[ij].countryOrg,
          sww: contentitemsDetails55[ij].sww,
          transactionType: contentitemsDetails55[ij].transactionType == null ||
                  contentitemsDetails55[ij].transactionType == "null"
              ? null
              : contentitemsDetails55[ij].transactionType,
          distributeExpense: contentitemsDetails55[ij].distributeExpense,
          rowTotalFc: contentitemsDetails55[ij].rowTotalFc,
          rowTotalSc: contentitemsDetails55[ij].rowTotalSc,
          lastBuyInmPrice: contentitemsDetails55[ij].lastBuyInmPrice,
          lastBuyDistributeSumFc:
              contentitemsDetails55[ij].lastBuyDistributeSumFc,
          lastBuyDistributeSumSc:
              contentitemsDetails55[ij].lastBuyDistributeSumSc,
          lastBuyDistributeSum: contentitemsDetails55[ij].lastBuyDistributeSum,
          stockDistributesumForeign:
              contentitemsDetails55[ij].stockDistributesumForeign,
          stockDistributesumSystem:
              contentitemsDetails55[ij].stockDistributesumSystem,
          stockDistributesum: contentitemsDetails55[ij].stockDistributesum,
          stockInmPrice: contentitemsDetails55[ij].stockInmPrice,
          pickStatusEx: contentitemsDetails55[ij].pickStatusEx,
          taxBeforeDpm: contentitemsDetails55[ij].taxBeforeDpm,
          taxBeforeDpmfc: contentitemsDetails55[ij].taxBeforeDpmfc,
          taxBeforeDpmsc: contentitemsDetails55[ij].taxBeforeDpmsc,
          cfopCode: contentitemsDetails55[ij].cfopCode,
          cstCode: contentitemsDetails55[ij].cstCode,
          usage: contentitemsDetails55[ij].usage,
          taxOnly: contentitemsDetails55[ij].taxOnly,
          visualOrder: contentitemsDetails55[ij].visualOrder,
          baseOpenQuantity: contentitemsDetails55[ij].baseOpenQuantity,
          unitPrice: double.parse(contentitemsDetails55[ij].price.toString()),
          lineStatus: contentitemsDetails55[ij].lineStatus,
          packageQuantity: contentitemsDetails55[ij].packageQuantity,
          text: contentitemsDetails55[ij].text,
          lineType: contentitemsDetails55[ij].lineType,
          cogsCostingCode: contentitemsDetails55[ij].cogsCostingCode,
          cogsAccountCode: contentitemsDetails55[ij].cogsAccountCode,
          changeAssemlyBoMWarehouse:
              contentitemsDetails55[ij].changeAssemlyBoMWarehouse,
          grossBuyPrice: contentitemsDetails55[ij].grossBuyPrice,
          grossBase: contentitemsDetails55[ij].grossBase,
          grossProfitTotalBasePrice:
              contentitemsDetails55[ij].grossProfitTotalBasePrice,
          costingCode2: contentitemsDetails55[ij].costingCode2,
          costingCode3: contentitemsDetails55[ij].costingCode3,
          costingCode4: contentitemsDetails55[ij].costingCode5,
          costingCode5: contentitemsDetails55[ij].costingCode5,
          itemDetails: contentitemsDetails55[ij].itemDetails,
          locationCode: contentitemsDetails55[ij].locationCode,
          actualDeliveryDate: contentitemsDetails55[ij].actualDeliveryDate,
          remainingOpenQuantity: 0,
          openAmount: 0,
          openAmountFc: 0,
          openAmountSc: 0,
          exLineNo: contentitemsDetails55[ij].exLineNo,
          Date: contentitemsDetails55[ij].Date,
          Quantity: contentitemsDetails55[ij].Quantity,
          cogsCostingCode2: contentitemsDetails55[ij].cogsCostingCode2,
          cogsCostingCode3: contentitemsDetails55[ij].cogsCostingCode3,
          cogsCostingCode4: contentitemsDetails55[ij].cogsCostingCode4,
          cogsCostingCode5: contentitemsDetails55[ij].cogsCostingCode5,
          csTforIpi: contentitemsDetails55[ij].csTforIpi,
          csTforPis: contentitemsDetails55[ij].csTforPis,
          csTforCofins: contentitemsDetails55[ij].csTforCofins,
          creditOriginCode: contentitemsDetails55[ij].creditOriginCode,
          withoutInventoryMovement:
              contentitemsDetails55[ij].withoutInventoryMovement,
          agreementNo: contentitemsDetails55[ij].agreementNo,
          agreementRowNumber: contentitemsDetails55[ij].agreementRowNumber,
          actualBaseEntry: contentitemsDetails55[ij].actualBaseEntry,
          actualBaseLine: contentitemsDetails55[ij].actualBaseLine,
          docEntry: contentitemsDetails55[ij].docEntry,
          surpluses: contentitemsDetails55[ij].surpluses,
          defectAndBreakup: contentitemsDetails55[ij].defectAndBreakup,
          shortages: contentitemsDetails55[ij].shortages,
          considerQuantity: contentitemsDetails55[ij].considerQuantity,
          partialRetirement: contentitemsDetails55[ij].partialRetirement,
          retirementQuantity: contentitemsDetails55[ij].retirementQuantity,
          retirementApc: contentitemsDetails55[ij].retirementApc,
          thirdParty: contentitemsDetails55[ij].thirdParty,
          poNum: contentitemsDetails55[ij].poNum,
          poItmNum: contentitemsDetails55[ij].poItmNum,
          expenseType: contentitemsDetails55[ij].expenseType,
          receiptNumber: contentitemsDetails55[ij].receiptNumber,
          expenseOperationType: contentitemsDetails55[ij].expenseOperationType,
          federalTaxId: contentitemsDetails55[ij].federalTaxId == null ||
                  contentitemsDetails55[ij].federalTaxId == "null"
              ? null
              : quotputdataval55!.federalTaxId,
          //  contentitemsDetails55[ij].federalTaxId,
          grossProfit: contentitemsDetails55[ij].grossProfit,
          grossProfitFc: contentitemsDetails55[ij].grossProfitFc,
          grossProfitSc: contentitemsDetails55[ij].grossProfitSc,
          priceSource: contentitemsDetails55[ij].priceSource,
          stgSeqNum: contentitemsDetails55[ij].stgSeqNum,
          stgEntry: contentitemsDetails55[ij].stgEntry,
          stgDesc: contentitemsDetails55[ij].stgDesc,
          uoMEntry: contentitemsDetails55[ij].uoMEntry,
          uoMCode: contentitemsDetails55[ij].uoMCode,
          inventoryQuantity: contentitemsDetails55[ij].inventoryQuantity,
          remainingOpenInventoryQuantity:
              contentitemsDetails55[ij].remainingOpenInventoryQuantity,
          parentLineNum: contentitemsDetails55[ij].parentLineNum == null ||
                  contentitemsDetails55[ij].parentLineNum == "null"
              ? null
              : contentitemsDetails55[ij].parentLineNum,
          incoterms: contentitemsDetails55[ij].incoterms,
          transportMode: contentitemsDetails55[ij].transportMode,
          natureOfTransaction: contentitemsDetails55[ij].natureOfTransaction,
          destinationCountryForImport:
              contentitemsDetails55[ij].destinationCountryForImport,
          destinationRegionForImport:
              contentitemsDetails55[ij].destinationRegionForImport,
          originCountryForExport:
              contentitemsDetails55[ij].originCountryForExport,
          originRegionForExport:
              contentitemsDetails55[ij].originRegionForExport,
          itemType: 'dit_Item',
          changeInventoryQuantityIndependently:
              contentitemsDetails55[ij].changeInventoryQuantityIndependently,
          freeOfChargeBp: contentitemsDetails55[ij].freeOfChargeBp,
          sacEntry: contentitemsDetails55[ij].sacEntry,
          hsnEntry: contentitemsDetails55[ij].hsnEntry,
          grossPrice: contentitemsDetails55[ij].grossPrice,
          grossTotal: contentitemsDetails55[ij].grossTotal,
          grossTotalFc: contentitemsDetails55[ij].grossTotalFc,
          grossTotalSc: contentitemsDetails55[ij].grossTotalSc,
          ncmCode: contentitemsDetails55[ij].ncmCode,
          nveCode: contentitemsDetails55[ij].nveCode,
          indEscala: "tNO",
          ctrSealQty: contentitemsDetails55[ij].ctrSealQty,
          cnjpMan: contentitemsDetails55[ij].cnjpMan,
          cestCode: contentitemsDetails55[ij].cestCode == null
              ? null
              : contentitemsDetails55[ij].cestCode,
          ufFiscalBenefitCode:
              contentitemsDetails55[ij].ufFiscalBenefitCode == null
                  ? null
                  : contentitemsDetails55[ij].ufFiscalBenefitCode,
          shipToCode: contentitemsDetails55[ij].shipToCode == null ||
                  contentitemsDetails55[ij].shipToCode == "null"
              ? null
              : contentitemsDetails55[ij].shipToCode,
          shipToDescription: contentitemsDetails55[ij].shipToDescription,
          externalCalcTaxRate: contentitemsDetails55[ij].externalCalcTaxRate,
          externalCalcTaxAmount:
              contentitemsDetails55[ij].externalCalcTaxAmount,
          externalCalcTaxAmountFc:
              contentitemsDetails55[ij].externalCalcTaxAmountFc,
          externalCalcTaxAmountSc:
              contentitemsDetails55[ij].externalCalcTaxAmountSc,
          standardItemIdentification:
              contentitemsDetails55[ij].standardItemIdentification,
          commodityClassification:
              contentitemsDetails55[ij].commodityClassification,
          unencumberedReason: contentitemsDetails55[ij].unencumberedReason,
          cuSplit: "tNO",
          uQtyOrdered: contentitemsDetails55[ij].uQtyOrdered,
          uOpenQty: contentitemsDetails55[ij].uOpenQty,
          uTonnage: contentitemsDetails55[ij].uTonnage,
          uPackSize: contentitemsDetails55[ij].U_Pack_Size,
          uProfitCentre: contentitemsDetails55[ij].uProfitCentre,
          uNumberDrums: contentitemsDetails55[ij].uNumberDrums,
          uDrumSize: contentitemsDetails55[ij].uDrumSize,
          uPails: contentitemsDetails55[ij].uPails,
          uCartons: contentitemsDetails55[ij].uCartons ?? null,
          uLooseTins: contentitemsDetails55[ij].uLooseTins,
          uNettWt: contentitemsDetails55[ij].uNettWt,
          uGrossWt: contentitemsDetails55[ij].uGrossWt,
          uAppLinId: contentitemsDetails55[ij].uAppLinId,
          uMuQty: contentitemsDetails55[ij].uMuQty,
          uRvc: contentitemsDetails55[ij].uRvc,
          uVrn: contentitemsDetails55[ij].uVrn,
          uIdentifier: contentitemsDetails55[ij].uIdentifier,
        ));
      }
    }
    log("itemsDetailsData::${itemsDetailsData.length}");
  }
  //  quotputdataval55!.documentLines!

  List<AddItem2> contentdocitemsDetails = [];
  List<AddItem3> edititemsDetails = [];
  Future<int?> patchhcheckitem() async {
    edititemsDetails = [];
    contentdocitemsDetails = [];
    log("getdocitemsDetailsData::::${getdocitemsDetailsData.length}");
    // for (int i = 0; i < getdocitemsDetailsData.length; i++) {
    addEditList();
    // }
  }

  addEditList() {
    contentdocitemsDetails = ContentEditCreationState.contentitemsDetails;
    log(" ContentEditCreationState.contentitemsDetails:::${ContentEditCreationState.contentitemsDetails.length}");
    for (int im = 0; im < contentdocitemsDetails.length; im++) {
      // log(" getdocitemsDetailsData[i].itemCode::${getdocitemsDetailsData[i].itemCode}");
      log("contentdocitemsDetails[im].itemCode::${contentdocitemsDetails[im].price}");

      // if (contentdocitemsDetails[im].itemCode ==
      //     getdocitemsDetailsData[i].itemCode) {
      log("IMIMIM:::${contentdocitemsDetails[im].lineNumm}");
      edititemsDetails.add(AddItem3(
        lineNo: contentdocitemsDetails[im].lineNumm,
        itemCode: contentdocitemsDetails[im].itemCode!,
        itemName: contentdocitemsDetails[im].itemName!,
        price: contentdocitemsDetails[im].price,
        discount: contentdocitemsDetails[im].discount,
        qty: double.parse(contentdocitemsDetails[im].qty!.toStringAsFixed(0)),
        total: contentdocitemsDetails[im].lineTotal,
        tax: contentdocitemsDetails[im].taxTotal,
        valuechoosed: contentdocitemsDetails[im].taxCode.toString(),
        discounpercent: contentdocitemsDetails[im].discounpercent,
        taxCode: contentdocitemsDetails[im].taxCode.toString(),
        // contentdocitemsDetails[im].taxCode.toString() == "null" ||
        //         contentdocitemsDetails[im].taxCode == ""
        //     ? contentdocitemsDetails(
        //         contentdocitemsDetails[im].lineTotal!, contentdocitemsDetails[im].taxTotal!)
        //     : contentdocitemsDetails[im].taxCode!.toString(),
        taxPer: contentdocitemsDetails[im].taxPer,
        // caluclateTaxpercent(
        //     contentdocitemsDetails[im].lineTotal!, contentdocitemsDetails[im].taxTotal!),
      ));
    }
    //     else {
    //         if (contentdocitemsDetails[im].itemCode != null) {
    //       edititemsDetails.add(AddItem3(
    //         itemCode: contentdocitemsDetails[im].itemCode!,
    //         itemName: contentdocitemsDetails[im].itemName!,
    //         price: contentdocitemsDetails[im].price,
    //         discount: contentdocitemsDetails[im].discount,
    //         qty: double.parse(
    //             contentdocitemsDetails[im].qty!.toStringAsFixed(0)),
    //         total: contentdocitemsDetails[im].lineTotal,
    //         tax: contentdocitemsDetails[im].taxTotal,
    //         valuechoosed: contentdocitemsDetails[im].taxCode.toString(),
    //         discounpercent: contentdocitemsDetails[im].discounpercent,
    //         taxCode: contentdocitemsDetails[im].taxCode.toString(),
    //         // contentdocitemsDetails[im].taxCode.toString() == "null" ||
    //         //         contentdocitemsDetails[im].taxCode == ""
    //         //     ? contentdocitemsDetails(
    //         //         contentdocitemsDetails[im].lineTotal!, contentdocitemsDetails[im].taxTotal!)
    //         //     : contentdocitemsDetails[im].taxCode!.toString(),
    //         taxPer: contentdocitemsDetails[im].taxPer,
    //         // caluclateTaxpercent(
    //         //     contentdocitemsDetails[im].lineTotal!, contentdocitemsDetails[im].taxTotal!),
    //       ));
    //     }
    //   }
    // }
    log("edititemsDetails length:::${edititemsDetails.length}");
  }

  bool isLoading = false;

  Future<void> validateAndCallApi() async {
    if (HeaderEditCreationState.bpCode == '') {
      setState(() {
        isLoading = false;
        schemeApiLoad = false;
        schemeOnlyClicked = false;
      });
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Please Choose Business Partner!!...',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (ContentEditCreationState.contentitemsDetails.isEmpty) {
      setState(() {
        isLoading = false;
        schemeApiLoad = false;
        schemeOnlyClicked = false;
      });
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Please Add Items!!...',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    // print("sucesssssssssssssssssssss");
    else {
      await delputHeaderValues();
      await putcheckitem();
      await patchhcheckitem();
      // addEditList();
      log("itemsDetailsDataitemsDetailsData:::${itemsDetailsData.length}");
      SalesQuotPutAPi.quotputaval = quotputdataval;
      SalesQuotPutAPi.cardCodePost = HeaderEditCreationState.bpCode;
      SalesQuotPutAPi.docLineQout = itemsDetailsData;
      SalesQuotPutAPi.docDate =
          HeaderEditCreationState.currentDateTime.toString();
      SalesQuotPutAPi.dueDate =
          HeaderEditCreationState.currentDateTime.toString();
      SalesQuotPutAPi.remarks = HeaderEditCreationState.mycontroller[1].text;
      var uuid = Uuid();
      String? uuidg = uuid.v1();
      SalesQuotPutAPi.method(uuidg);

      await SalesQuotPutAPi.getGlobalData(uuidg, widget.docentry)
          .then((value) async {
        SalesOrderAfterAPi.baseEntry = value.docEntry.toString();
        // log("object:" + value.statusCode.toString());
        // log("docEntry:" + value.docEntry.toString());
        // if (value.statusCode == null) {
        //   return;
        // }
        if (value.statusCode! >= 200 && value.statusCode! <= 210) {
          SalesQuotPatchAPi.cardCodePost = quotputdataval!.cardCode;
          SalesQuotPatchAPi.docLineQout = edititemsDetails;
          SalesQuotPatchAPi.docDate = quotputdataval!.docDate;
          // HeaderEditCreationState.currentDateTime.toString();
          SalesQuotPatchAPi.dueDate = quotputdataval!.docDueDate;
          //     HeaderEditCreationState.currentDateTime.toString();
          SalesQuotPatchAPi.remarks =
              HeaderEditCreationState.mycontroller[1].text;
          SalesQuotPatchAPi.method(uuidg);

          await SalesQuotPatchAPi.getGlobalData(uuidg, widget.docentry)
              .then((value) {
            if (value.statusCode! >= 200 && value.statusCode! <= 210) {
              setState(() {
                isLoading = false;
                schemeApiLoad = false;
                schemeOnlyClicked = false;
              });
              const snackBar = SnackBar(
                duration: Duration(seconds: 5),
                backgroundColor: Colors.green,
                content: Text(
                  'Quotation Updated Successfully!!...',
                  style: TextStyle(color: Colors.white),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Get.offAllNamed<dynamic>(FurneyRoutes.newSalesQuot);
            }
          });
        } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
          setState(() {
            isLoading = false;
            schemeApiLoad = false;
            schemeOnlyClicked = false;
          });
          final snackBar = SnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red,
            content: Text(
              '${value.error!.message!.value}!!..',
              style: TextStyle(color: Colors.white),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          setState(() {
            isLoading = false;
            schemeApiLoad = false;
            schemeOnlyClicked = false;
          });
          final snackBar = SnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red,
            content: Text(
              '${value.error!.message!.value}!!..', //
              style: TextStyle(color: Colors.white),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
      if (schmDisableBtn == true) {
        SalesOrderAfterAPi.sessionID = GetValues.sessionID;
        SalesOrderAfterAPi.baseType = "23";
        // SalesOrderAfterAPi.baseEntry = "12345";

        // print("SO basetype: " + SalesOrderAfterAPi.baseType.toString());
        // print("SO discper:" + SalesOrderAfterAPi.baseLineTo.toString());
        // print("SO discper:" + SalesOrderAfterAPi.disValue.toString());
        // print("SO discper:" + SalesOrderAfterAPi.discper.toString());
        // print("SO schemeEntry:" + SalesOrderAfterAPi.schemeEntry.toString());
        for (int i = 0; i < saleOrderdata.length; i++) {
          SalesOrderAfterAPi.baseLineTo = saleOrderdata[i].lineNum.toString();
          SalesOrderAfterAPi.disValue = saleOrderdata[i].discVal.toString();
          SalesOrderAfterAPi.discper = saleOrderdata[i].discPer.toString();
          SalesOrderAfterAPi.schemeEntry = saleOrderdata[i].schemeEntry;
          await SalesOrderAfterAPi.getData(uuidg).then((value) async {
            if (value.statusCode! >= 200 && value.statusCode! <= 210) {
              print("Post Successfully..");
            }
          });
        }
      }
    }
  }
}
