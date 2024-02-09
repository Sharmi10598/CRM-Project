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
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_quotations_api/post_api/post_sales_quot.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/SchemeQuteModel/SchemeQuteModel.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/creation/content_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/creation/header_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sign_in/widgets/custom_elevatedBtn.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:uuid/uuid.dart';

class LogisticPage extends StatefulWidget {
  const LogisticPage({Key? key}) : super(key: key);

  @override
  LogisticPageState createState() => LogisticPageState();
}

class LogisticPageState extends State<LogisticPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setboolVal();
  }

  static String billto = '';
  static String shipto = '';
  static String cardcode = '';
  static double currentACbalance = 0;
  static double ordersBal = 0;
  setboolVal() async {
    final pref2 = await pref;

    setState(() {
      if (pref2.getBool('schemeReq') != null) {
        schmDisableBtn = pref2.getBool('schemeReq')!;
      }
      log("SchmDisableBtnSchmDisableBtn:::$schmDisableBtn");
    });
  }

  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  bool schmDisableBtn = false;
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

    for (int i = 0; i < ContentCreationState.itemsDetails.length; i++) {
      salesQuteScheme.add(
        SalesQuteScheme(
          ItemCode: ContentCreationState.itemsDetails[i].itemCode,
          PriceBefDi:
              ContentCreationState.itemsDetails[i].price!.toStringAsFixed(2),
          Quantity: ContentCreationState.itemsDetails[i].qty.toString(),
          UCartons: ContentCreationState.itemsDetails[i].carton!.toString(),
          lineno: (i + 1).toString(),
          balance: (currentACbalance + ordersBal).toString(),
          customer: HeaderCreationState.bpCode,
        ),
      );
      ContentCreationState.itemsDetails[i].discounpercent = 0;
      ContentCreationState.itemsDetails[i].lineNo = i + 1;
    }

    await SchemeQuteAPi.getGlobalData(salesQuteScheme).then((value) {
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        if (value.saleOrder != null) {
          saleOrderdata = value.saleOrder!;

          alreadySchemeApiCalled = true;
          for (int i = 0; i < value.saleOrder!.length; i++) {
            if (value.saleOrder![i].discPer != 0) {
              for (int k = 0;
                  k < ContentCreationState.itemsDetails.length;
                  k++) {
                if (ContentCreationState.itemsDetails[k].lineNo ==
                    value.saleOrder![i].lineNum) {
                  ContentCreationState.itemsDetails[k].discounpercent =
                      ContentCreationState.itemsDetails[k].discounpercent! +
                          value.saleOrder![i].discPer;

                  ContentCreationState.itemsDetails[k].discount =
                      ((ContentCreationState.itemsDetails[k].price! *
                              ContentCreationState.itemsDetails[k].qty!) *
                          ContentCreationState.itemsDetails[k].discounpercent! /
                          100);
                  ContentCreationState.itemsDetails[k].valueAF =
                      ((ContentCreationState.itemsDetails[k].price! *
                              ContentCreationState.itemsDetails[k].qty!) -
                          ContentCreationState.itemsDetails[k].discount!);

                  ContentCreationState
                      .itemsDetails[k].total = (ContentCreationState
                          .itemsDetails[k].valueAF! *
                      (1 + ContentCreationState.itemsDetails[k].taxPer! / 100));
                  ContentCreationState.itemsDetails[k].tax =
                      (ContentCreationState.itemsDetails[k].total! -
                          ContentCreationState.itemsDetails[k].valueAF!);
                  log(
                    "tax:::" +
                        ContentCreationState.itemsDetails[k].tax!.toString(),
                  );
                  //  ContentCreationState.itemsDetails[k].total=value.saleOrder[i].;
                }
              }
            } else if (value.saleOrder![i].discVal != 0) {
              ContentCreationState.itemsDetails[i].discount =
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

    setState(() {
      if (ContentCreationState.itemsDetails.isNotEmpty) {
        for (int i = 0; i < ContentCreationState.itemsDetails.length; i++) {
          basictotal = basictotal +
              (ContentCreationState.itemsDetails[i].qty!.toDouble() *
                  ContentCreationState.itemsDetails[i].price!.toDouble());
          //  basictotal + ContentCreationState.itemsDetails[i].total!;
          // ContentCreationState.itemsDetails[i].qty!.toDouble()*ContentCreationState.itemsDetails[i].price!.toDouble();
          totalbefordisc = totalbefordisc +
              ContentCreationState.itemsDetails[i].price! *
                  ContentCreationState.itemsDetails[i].qty!.toDouble();

          discount = discount + ContentCreationState.itemsDetails[i].discount!;
          tax = tax +
              (ContentCreationState.itemsDetails[i].total! -
                  ContentCreationState.itemsDetails[i].valueAF!);

          grandtotal = (basictotal - discount) + tax;
        }
        print("grandtotal: " + basictotal.toString());
        //total over
        HeaderCreationState.discount = discount;
        HeaderCreationState.tax = tax;
        HeaderCreationState.total = grandtotal;
        // basictotal;
        // - discount + tax;
        HeaderCreationState.totalBeforeDiscount = totalbefordisc;
      } else {
        setState(() {
          discount = 0.00;
          grandtotal = 0.00;
          tax = 0.00;
          HeaderCreationState.total = grandtotal;
          HeaderCreationState.discount = discount;
          HeaderCreationState.tax = tax;
          HeaderCreationState.totalBeforeDiscount = grandtotal;
        });
      }
    });
  }

  bool isLoading = false;
  Future<void> validateAndCallApi() async {
    if (HeaderCreationState.bpCode == '') {
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
    } else if (ContentCreationState.itemsDetails.isEmpty) {
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
      SalesQuotPostAPi.cardCodePost = HeaderCreationState.bpCode;
      SalesQuotPostAPi.docLineQout = ContentCreationState.itemsDetails;
      SalesQuotPostAPi.docDate = HeaderCreationState.currentDateTime.toString();
      SalesQuotPostAPi.dueDate = HeaderCreationState.currentDateTime.toString();
      SalesQuotPostAPi.remarks = HeaderCreationState.mycontroller[1].text;
      var uuid = Uuid();
      String? uuidg = uuid.v1();
      SalesQuotPostAPi.method(uuidg);
      await SalesQuotPostAPi.getGlobalData(uuidg).then((value) {
        SalesOrderAfterAPi.baseEntry = value.docEntry.toString();
        log("object:" + value.statusCode.toString());
        log("docEntry:" + value.docEntry.toString());
        if (value.statusCode == null) {
          return;
        }
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
              'Quotation Created Successfully!!...',
              style: TextStyle(color: Colors.white),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Get.offAllNamed<dynamic>(FurneyRoutes.newSalesQuot);
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
