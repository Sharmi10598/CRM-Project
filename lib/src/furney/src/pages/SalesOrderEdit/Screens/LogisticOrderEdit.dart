// ignore: file_names
// ignore_for_file: file_names, prefer_single_quotes, require_trailing_commas, unnecessary_new, avoid_void_async, omit_local_variable_types, prefer_is_empty, unnecessary_null_checks, unawaited_futures, avoid_print, prefer_interpolation_to_compose_strings, cascade_invocations, prefer_const_constructors, invariant_booleans, unnecessary_lambdas, unnecessary_parenthesis, prefer_int_literals, unnecessary_string_interpolations, unnecessary_statements, unnecessary_this, prefer_final_locals, non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/SchemeOrderApi/SchemeOrderApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/SOafterApi/SOafterApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/post_order_api/SOLogin/soLoginApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/post_order_api/SOLogin/soPatchApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/post_order_api/checkOrderORDraft/draftSaveApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/post_order_api/checkOrderORDraft/orderordraft.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/post_order_api/getCreaditDays/getBalanceCreditLimit.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/post_order_api/getCreaditDays/getCreaditDaysApi.dart';
import 'package:ultimate_bundle/src/furney/src/DB/DBHelper.dart';
import 'package:ultimate_bundle/src/furney/src/DB/DBModal/CusTomerModal.dart';
import 'package:ultimate_bundle/src/furney/src/DB/DBModal/ItemModal.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/SchemeOrderModel/SchemeOrderModel.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesOrderEdit/Screens/ContentEdit.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesOrderEdit/Screens/EditOrder.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesOrderEdit/Screens/HederEdit.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sign_in/widgets/custom_elevatedBtn.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:uuid/uuid.dart';

class LogisticEditORder extends StatefulWidget {
  const LogisticEditORder(
      {required this.docEntry, required this.isAproved, Key? key})
      : super(key: key);
  final int docEntry;
  final bool isAproved;
  @override
  LogisticEditORderState createState() => LogisticEditORderState();
}

class LogisticEditORderState extends State<LogisticEditORder> {
  @override
  void initState() {
    if (EditORderDetailsState.isCameforapprovalsales == true) {
      setValuesToapproval();
    }
    setboolVal();
  }

  static String? approvedocentry;
  static String? valueSelectedOrder2;
  static String? valueSelectedGPApproval2;
  static String? orderrecTime;
  void setValuesToapproval() {
    setState(() {
      valueSelectedOrder = valueSelectedOrder2;
      valueSelectedGPApproval = valueSelectedGPApproval2;
      mycontroller[0].text = orderrecTime!;
    });
  }

  static String billto = '';
  static String shipto = '';
  static String cusID = '';
  static double currentACbalance = 0.0;
  static double ordersBal = 0.0;
  static List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());

  Uuid uuid = Uuid();
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[200],
      body:
          // Padding(
          //  padding: EdgeInsets.only(top:Screens.heigth(context)*0.01,),//left: Screens.width(context)*0.01,right: Screens.width(context)*0.01,
          // child:
          Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Screens.width(context) * 0.02),
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
                                        "$billto",
                                        style:
                                            TextStyles.headlineBlack1(context),
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
                                Icon(
                                  Icons.navigate_next_outlined,
                                  color: theme.primaryColor,
                                  size: Screens.heigth(context) * 0.06,
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
                                        "$shipto",
                                        style:
                                            TextStyles.headlineBlack1(context),
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
                                Icon(
                                  Icons.navigate_next_outlined,
                                  color: theme.primaryColor,
                                  size: Screens.heigth(context) * 0.06,
                                )
                              ],
                            ),
                            Divider(
                              thickness: 1.5,
                            ),
                            SizedBox(
                              height: Screens.heigth(context) * 0.01,
                            ),
                            Text(
                              "Select Order Type",
                              style: TextStyles.boldPC1(context),
                            ),
                            SizedBox(
                              height: Screens.heigth(context) * 0.01,
                            ),
                            Container(
                              width: Screens.width(context),
                              padding:
                                  EdgeInsets.only(top: 1, left: 10, right: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButton(
                                dropdownColor: Colors.white,
                                hint: Text(
                                  "Select Order Type: ",
                                  style: TextStyles.headlineBlack1(context),
                                ),
                                value: valueSelectedOrder,
                                //dropdownColor:Colors.green,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                isExpanded: true,
                                onChanged: (val) {
                                  setState(() {
                                    valueSelectedOrder = val.toString();
                                    print("valll: " + val.toString());
                                  });
                                },
                                items: salesOrderType.map((e) {
                                  return DropdownMenuItem(
                                      value: e["value"],
                                      child: Text(
                                        e["name"].toString(),
                                        style:
                                            TextStyles.headlineBlack1(context),
                                      ));
                                }).toList(),
                              ),
                            ),
                            SizedBox(
                              height: Screens.heigth(context) * 0.02,
                            ),
                            Text(
                              "GP Approval Required?",
                              style: TextStyles.boldPC1(context),
                            ),
                            SizedBox(
                              height: Screens.heigth(context) * 0.01,
                            ),
                            Container(
                              width: Screens.width(context),
                              padding:
                                  EdgeInsets.only(top: 1, left: 10, right: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButton(
                                dropdownColor: Colors.white,
                                hint: Text(
                                  "GP Approval Required?",
                                  style: TextStyles.headlineBlack1(context),
                                ),
                                value: valueSelectedGPApproval,
                                //dropdownColor:Colors.green,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                isExpanded: true,
                                onChanged: (val) {
                                  setState(() {
                                    valueSelectedGPApproval = val.toString();
                                    print("valll: " + val.toString());
                                  });
                                },
                                items: grpApprovalRequired.map((e) {
                                  return DropdownMenuItem(
                                      value: e["value"],
                                      child: Text(
                                        e["name"].toString(),
                                        style:
                                            TextStyles.headlineBlack1(context),
                                      ));
                                }).toList(),
                              ),
                            ),
                            SizedBox(
                              height: Screens.heigth(context) * 0.02,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // AppLocalizations.of(context)!.docNo,
                                  "Order Received Time",
                                  style: TextStyles.boldPC1(context),
                                ),
                                SizedBox(
                                  height: Screens.heigth(context) * 0.005,
                                ),
                                Stack(
                                  children: [
                                    SizedBox(
                                      //   height: 50,
                                      child: TextFormField(
                                        readOnly: true,
                                        onTap: () {
                                          selecTime(context);
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Enter Order Received Time";
                                          }
                                          return null;
                                        },
                                        controller: mycontroller[0],
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 10),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide:
                                                BorderSide(color: Colors.green),
                                          ),
                                        ),
                                        cursorColor: theme.primaryColor,
                                      ),
                                    ),
                                    Positioned(
                                        top: Screens.heigth(context) * 0.007,
                                        left: Screens.width(context) * 0.86,
                                        child: InkWell(
                                          onTap: () {
                                            selecTime(context);
                                          },
                                          child: Icon(Icons.access_time,
                                              color: theme.primaryColor,
                                              size: Screens.width(context) *
                                                  0.095),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Screens.heigth(context) * 0.02,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // AppLocalizations.of(context)!.docNo,
                                  "Order Received Date",
                                  style: TextStyles.boldPC1(context),
                                ),
                                SizedBox(
                                  height: Screens.heigth(context) * 0.005,
                                ),
                                Stack(
                                  children: [
                                    SizedBox(
                                      //   height: 50,

                                      child: TextFormField(
                                        onTap: () {
                                          showDate(context);
                                        },
                                        readOnly: true,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Enter Order Received Date";
                                          }

                                          return null;
                                        },
                                        controller: mycontroller[1],
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 10),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide:
                                                BorderSide(color: Colors.green),
                                          ),
                                        ),
                                        cursorColor: theme.primaryColor,
                                      ),
                                    ),
                                    Positioned(
                                        top: Screens.heigth(context) * 0.01,
                                        left: Screens.width(context) * 0.86,
                                        child: InkWell(
                                          onTap: () {
                                            showDate(context);
                                          },
                                          child: Icon(
                                              Icons.calendar_today_outlined,
                                              color: theme.primaryColor,
                                              size: Screens.width(context) *
                                                  0.08),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Screens.heigth(context) * 0.02,
                            ),
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

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomSpinkitdButton(
                          onTap: schmDisableBtn == false
                              ? null
                              : () async {
                                  ifSchemeOnlyClicked = true;
                                  await callSchemeOrderApi();
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
                            });
                            if (schmDisableBtn == true) {
                              await callSchemeOrderApi().then((valueb) {
                                if (valueb == true) {
                                  setState(() {
                                    schemeApiLoad = true;
                                    isLoading = true;
                                  });

                                  validateAndCallApi();
                                } else {
                                  showSnack('Something went wrong try again');
                                }
                              });
                            } else {
                              validateAndCallApi();
                            }

                            // if(schemeApiCalled == true){
                            //   validateAndCallApi();
                            // }else{
                            //}
                            //callServiceLayerApi();
                            //  checkORderORDraft();
                          },
                          isLoading: isLoading,
                          //  labelLoading: AppLocalizations.of(context)!.signing,
                          label: 'Save',
                        ),
                      ),
                      SizedBox(
                        height: Screens.heigth(context) * 0.02,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomSpinkitdButton(
                          onTap: () async {
                            setAllValuesToDB();
                            //  print(cusID);
                          },
                          // isLoading: isLoading,
                          //  labelLoading: AppLocalizations.of(context)!.signing,
                          label: 'Save as Draft',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Screens.heigth(context) * 0.05,
                ),
              ],
            ),
          ),
        ],
      ),
      // ),
    );
  }

  bool ifSchemeOnlyClicked = false;
  void showSnack(String msg) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 5),
      backgroundColor: Colors.red,
      content: Text(
        msg,
        style: TextStyle(color: Colors.white),
      ),
    );
    ScaffoldMessenger.of(this.context).showSnackBar(snackBar);
  }

  bool schemeApiLoad = false;
  bool alreadySchemeApiCalled = false;
  // List<SOafterdetails> SOafterdata = [];
  List<SchemeOrderModalData>? saleOrderdata = [];
  int Count = 0;
  Future<bool> callSchemeOrderApi() async {
    Count = 0;
    saleOrderdata!.clear();
    setState(() {
      if (ifSchemeOnlyClicked == true) {
        schemeApiLoad = true;
        isLoading = true;
      }
    });
    bool returnbool = false;
    List<SalesOrderScheme> salesOderSchene = [];

// int totalbalance=(int.parse(currentACbalance)+int.parse(ordersBal)).toString();
    for (int i = 0; i < ContentOrderEditState.itemsDetails.length; i++) {
      salesOderSchene.add(SalesOrderScheme(
          ItemCode: ContentOrderEditState.itemsDetails[i].itemCode,
          PriceBefDi:
              ContentOrderEditState.itemsDetails[i].price!.toStringAsFixed(2),
          Quantity: ContentOrderEditState.itemsDetails[i].qty.toString(),
          UCartons: ContentOrderEditState.itemsDetails[i].carton!.toString(),
          lineno: (i + 1).toString(),
          balance: (currentACbalance + ordersBal).toString(),
          customer: HeaderEditOrderPageState.bpCode));
      ContentOrderEditState.itemsDetails[i].discounpercent = 0;
      ContentOrderEditState.itemsDetails[i].lineNo = i + 1;
    }
    await SchemeOrderAPi.getGlobalData(salesOderSchene).then((value) {
      if (value.statuscode >= 200 && value.statuscode <= 210) {
//  SalesOrderAfterAPi.baseType = value.saleOrder[0].;

        if (value.saleOrder != null) {
          alreadySchemeApiCalled = true;

          for (int i = 0; i < value.saleOrder!.length; i++) {
            saleOrderdata = value.saleOrder;

            // print("SO After List :" + SOafterdata[i].toString());
            if (value.saleOrder![i].discPer != 0) {
              Count = 1;

              SalesOrderAfterAPi.baseLineTo =
                  value.saleOrder![i].lineNum.toString();
              SalesOrderAfterAPi.disValue =
                  value.saleOrder![i].discVal.toString();
              SalesOrderAfterAPi.discper =
                  value.saleOrder![i].discPer.toString();
              SalesOrderAfterAPi.schemeEntry = value.saleOrder![i].schemeEntry;
              //
              for (int k = 0;
                  k < ContentOrderEditState.itemsDetails.length;
                  k++) {
                if (ContentOrderEditState.itemsDetails[k].lineNo ==
                    value.saleOrder![i].lineNum) {
                  //
                  ContentOrderEditState.itemsDetails[k].discounpercent =
                      ContentOrderEditState.itemsDetails[k].discounpercent! +
                          value.saleOrder![i].discPer;
                  ContentOrderEditState.itemsDetails[k].discount =
                      ((ContentOrderEditState.itemsDetails[k].price! *
                              ContentOrderEditState.itemsDetails[k].qty!) *
                          ContentOrderEditState
                              .itemsDetails[k].discounpercent! /
                          100);
                  //double discount = (price * qty) * discountper / 100;
                  ContentOrderEditState.itemsDetails[k].valueAFdisc =
                      ((ContentOrderEditState.itemsDetails[k].price! *
                              ContentOrderEditState.itemsDetails[k].qty!) -
                          ContentOrderEditState.itemsDetails[k].discount!);
                  ContentOrderEditState.itemsDetails[k].total =
                      (ContentOrderEditState.itemsDetails[k].valueAFdisc! *
                          (1 +
                              ContentOrderEditState.itemsDetails[k].taxPer! /
                                  100));
                  ContentOrderEditState.itemsDetails[k].tax =
                      (ContentOrderEditState.itemsDetails[k].total! -
                          ContentOrderEditState.itemsDetails[k].valueAFdisc!);
                }
              }
            } else if (value.saleOrder![i].discVal != 0) {
              ContentOrderEditState.itemsDetails[i].discount =
                  value.saleOrder![i].discVal;
              SalesOrderAfterAPi.baseLineTo =
                  value.saleOrder![i].lineNum.toString();
              SalesOrderAfterAPi.disValue =
                  value.saleOrder![i].discVal.toString();
              SalesOrderAfterAPi.discper =
                  value.saleOrder![i].discPer.toString();
              SalesOrderAfterAPi.schemeEntry = value.saleOrder![i].schemeEntry;
            }
          }

          calculateScheme();
          setState(() {});
          returnbool = true;
          setState(() {
            if (ifSchemeOnlyClicked == true) {
              schemeApiLoad = false;
              isLoading = false;
              ifSchemeOnlyClicked = false;
            }
          });
        } else if (value.saleOrder == null) {
          alreadySchemeApiCalled = true;
          setState(() {
            if (ifSchemeOnlyClicked == true) {
              schemeApiLoad = false;
              isLoading = false;
              ifSchemeOnlyClicked = false;
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
        ScaffoldMessenger.of(this.context).showSnackBar(snackBar);
        returnbool = false;
        setState(() {
          if (ifSchemeOnlyClicked == true) {
            schemeApiLoad = false;
            isLoading = false;
            ifSchemeOnlyClicked = false;
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
        ScaffoldMessenger.of(this.context).showSnackBar(snackBar);
        returnbool = false;
        setState(() {
          if (ifSchemeOnlyClicked == true) {
            schemeApiLoad = false;
            isLoading = false;
            ifSchemeOnlyClicked = false;
          }
        });
      }
    });
    return returnbool;
  }

  void calculateScheme() {
    double basictotal = 0.00;
    double discount = 0.00;
    double totalbefordisc = 0.00;

    double tax = 0.00;
    double grandtotal = 0.00;

    setState(() {
      if (ContentOrderEditState.itemsDetails.isNotEmpty) {
        for (int i = 0; i < ContentOrderEditState.itemsDetails.length; i++) {
          basictotal =
              basictotal + ContentOrderEditState.itemsDetails[i].total!;
          totalbefordisc = ContentOrderEditState.itemsDetails[i].price! *
              ContentOrderEditState.itemsDetails[i].qty!.toDouble();
          discount = discount + ContentOrderEditState.itemsDetails[i].discount!;
          tax = tax +
              (ContentOrderEditState.itemsDetails[i].total! -
                  ContentOrderEditState.itemsDetails[i].valueAFdisc!);
        }
        // print("basictotal: " + basictotal.toString());
        // print("discount: " + discount.toString());
        setState(() {
          HeaderEditOrderPageState.discount = discount;
          HeaderEditOrderPageState.tax = tax;
          HeaderEditOrderPageState.total = basictotal;
          //  - discount + tax;
          HeaderEditOrderPageState.totalBeforeDiscount = totalbefordisc;
        });
      } else {
        setState(() {
          discount = 0.00;
          grandtotal = 0.00;
          tax = 0.00;
          HeaderEditOrderPageState.total = grandtotal;
          HeaderEditOrderPageState.discount = discount;
          HeaderEditOrderPageState.tax = tax;
          HeaderEditOrderPageState.totalBeforeDiscount = grandtotal;
        });
      }
    });
  }

  List<Documents> cusDoc = [];
  List<ItemDocuments> itemDoc = [];
  void setAllValuesToDB() {
    var vals = Documents(
        billTo: billto,
        bPCode: HeaderEditOrderPageState.bpCode,
        bPName: HeaderEditOrderPageState.bpName,
        currency: GetValues.currency.toString(),
        cusRefNo: HeaderEditOrderPageState.mycontroller[0].text,
        docDate: HeaderEditOrderPageState.currentDateTime!,
        status: HeaderEditOrderPageState.status,
        gPApprovalReq: valueSelectedGPApproval!,
        orderRecDate: mycontroller[1].text,
        orderRecTime: mycontroller[0].text,
        postDate: HeaderEditOrderPageState.currentDateTime!,
        remarks: HeaderEditOrderPageState.mycontroller[1].text,
        salesEmp: HeaderEditOrderPageState.salesEmp!,
        selectOrderType: valueSelectedOrder!,
        shipTo: shipto,
        validUntil: HeaderEditOrderPageState.currentDateTime!);
    // print("vals: ${vals.billTo}");
    DataBaseHelper.insertData(vals, 'CustomerDetails').then((value) {
      print("inserted value: $value");
      saveItemsToDB(value.toString());
    });
  }

  void saveItemsToDB(String cusId) {
    print("lenlen: " + ContentOrderEditState.itemsDetails.length.toString());
    for (int i = 0; i < ContentOrderEditState.itemsDetails.length; i++) {
      // itemDoc.add(
      var val = ItemDocuments(
          deliveryDate: '',
          cusID: cusId,
          discount: ContentOrderEditState.itemsDetails[i].discount!
              .toStringAsFixed(2),
          itemCode: ContentOrderEditState.itemsDetails[i].itemCode,
          itemName: ContentOrderEditState.itemsDetails[i].itemName,
          price:
              ContentOrderEditState.itemsDetails[i].price!.toStringAsFixed(2),
          qty: ContentOrderEditState.itemsDetails[i].qty.toString(),
          tax: ContentOrderEditState.itemsDetails[i].tax!.toStringAsFixed(2),
          total:
              ContentOrderEditState.itemsDetails[i].total!.toStringAsFixed(2),
          wareHouseCose:
              ContentOrderEditState.itemsDetails[i].wareHouseCode.toString(),
          discounpercent: ContentOrderEditState.itemsDetails[i].discounpercent!
              .toStringAsFixed(2),
          taxCode: ContentOrderEditState.itemsDetails[i].taxCode.toString(),
          taxCodeName: ContentOrderEditState.itemsDetails[i].taxName.toString(),
          carton: ContentOrderEditState.itemsDetails[i].carton.toString(),
          valueAFDisc: ContentOrderEditState.itemsDetails[i].valueAFdisc);
      //  );
      //  print("items: "+ val.itemName);
      DataBaseHelper.insertItemData(val, 'ItemDetails').then((value) {
        showDetailBox('Order Successfully Saved as Draft!!..');
      });
    }
  }

  void deleteValueINDB(String cusID) {
    DataBaseHelper.deleteData('$cusID', 'CustomerDetails', 'ItemDetails');
  }

  static String? valueSelectedOrder;
  static String? valueSelectedGPApproval;
  List<Map<String, String>> salesOrderType = [
    {"name": "Select", "value": '0'},
    {"name": "Normal", "value": '1'},
    {"name": "Depot transfer", "value": "2"},
    {"name": "Root Sale", "value": "3"},
    {"name": "Project sale", "value": "4"},
    {"name": "Special Order", "value": "5"},
  ];
  List<Map<String, String>> grpApprovalRequired = [
    {"name": "NO", "value": '0'},
    {"name": "YES", "value": '1'},
  ];
  bool isLoading = false;

// FOR PATCH API

  void validateAndCallApi() async {
    // print(ContentOrderEditState.itemsDetails[i].valueAFdisc)
    if (HeaderEditOrderPageState.bpCode == '') {
      setState(() {
        isLoading = false;
        schemeApiLoad = false;
      });
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Please Choose Business Partner!!...',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(this.context).showSnackBar(snackBar);
    } else if (ContentOrderEditState.itemsDetails.length < 1) {
      setState(() {
        isLoading = false;
        schemeApiLoad = false;
      });
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Please Add Items!!...',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(this.context).showSnackBar(snackBar);
    } else if (HeaderEditOrderPageState.mycontroller[0].text.isEmpty) {
      setState(() {
        isLoading = false;
        schemeApiLoad = false;
      });
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Please Fill Customer Ref.No!!...',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(this.context).showSnackBar(snackBar);
    } else if (valueSelectedOrder == null) {
      setState(() {
        isLoading = false;
        schemeApiLoad = false;
      });
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Please Choose Select Order Type!!...',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(this.context).showSnackBar(snackBar);
    } else if (valueSelectedGPApproval == null) {
      setState(() {
        isLoading = false;
        schemeApiLoad = false;
      });
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Please choose GP Approval !!...',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(this.context).showSnackBar(snackBar);
    } else if (mycontroller[0].text.isEmpty) {
      setState(() {
        isLoading = false;
        schemeApiLoad = false;
      });
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Please Fill Order Received Time !!...',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(this.context).showSnackBar(snackBar);
    } else if (mycontroller[1].text.isEmpty) {
      setState(() {
        isLoading = false;
        schemeApiLoad = false;
      });
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Please Fill Order Received Date!!...',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(this.context).showSnackBar(snackBar);
    } else {
      SalesOrderPatchAPi.cardCodePost = HeaderEditOrderPageState.bpCode;
      SalesOrderPatchAPi.cardNamePost = HeaderEditOrderPageState.bpName;
      SalesOrderPatchAPi.docLineQout = ContentOrderEditState.itemsDetails;
      SalesOrderPatchAPi.docDate =
          HeaderEditOrderPageState.currentDateTime.toString();
      SalesOrderPatchAPi.dueDate =
          HeaderEditOrderPageState.currentDateTime.toString();
      SalesOrderPatchAPi.remarks =
          HeaderEditOrderPageState.mycontroller[1].text;
      SalesOrderPatchAPi.orderDate = mycontroller[1].text;
      SalesOrderPatchAPi.orderType = valueSelectedOrder;
      SalesOrderPatchAPi.gpApproval = valueSelectedGPApproval;
      SalesOrderPatchAPi.orderTime = mycontroller[0].text;
      SalesOrderPatchAPi.custREfNo =
          HeaderEditOrderPageState.mycontroller[0].text;
      SalesOrderPatchAPi.deviceTransID = uuid.v1();
      SalesOrderPatchAPi.deviceCode = GetValues.deviceID;
      CheckOrderORDraftAPi.deviceTransID = SalesOrderPatchAPi.deviceTransID;
      CheckOrderORDraftAPi.deviceCode = SalesOrderPatchAPi.deviceCode;
      DraftSaveAPi.deviceCode = GetValues.deviceID;
      DraftSaveAPi.deviceTransID = SalesOrderPatchAPi.deviceTransID;
      SalesOrderPatchAPi.slpCode = GetValues.slpCode;
      currentDate();
      double getcreditLimit;
      GettCreditDaysAPi.cardCode = HeaderEditOrderPageState.bpCode;
      GettCreditDaysAPi.date = currentDateTime;
      GetBalanceCreditAPi.cardCode = HeaderEditOrderPageState.bpCode;
      for (int i = 0; i < ContentOrderEditState.itemsDetails.length; i++) {
        ContentOrderEditState.itemsDetails[i].lineNo = i;
      }
      if (HeaderEditOrderPageState.paymentTerms.toLowerCase() == "cash") {
        SalesOrderPatchAPi.sessionID = GetValues.sessionID!;
        await callPostApi();
      } else {
        await GetBalanceCreditAPi.getGlobalData().then((value) {
          if (value.balanceCreaditValue!.isNotEmpty) {
            getcreditLimit = value.balanceCreaditValue![0].CreditLimit!;
            callSaveApi(getcreditLimit);
          } else if (value.balanceCreaditValue!.isEmpty) {
            callSaveApi(0.00);
          }
        });
      }
    }
    HeaderEditOrderPageState.mycontroller[0].text = '';
  }

  void callSaveApi(double getCredit) async {
    await GettCreditDaysAPi.getGlobalData().then((value) async {
      if (value.creaditDaysValueValue!.isNotEmpty) {
        if (value.creaditDaysValueValue![0].CreditDays == 0) {
          // print("getCredit3333 : " + getCredit.toString());
          await GetBalanceCreditAPi.getGlobalData().then((value) async {
            if (value.balanceCreaditValue!.isNotEmpty) {
              double? balance = value.balanceCreaditValue![0].Balance;
              double? creditLimit = value.balanceCreaditValue![0].CreditLimit;
              double? ordersBal = value.balanceCreaditValue![0].OrdersBal;

              double ans = creditLimit! -
                  balance! -
                  ordersBal! -
                  HeaderEditOrderPageState.total;
              if (ans < 0) {
                SOLoginAPi.username = 'solimitapp';
                await SOLoginAPi.getGlobalData().then((valuel) {
                  if (valuel.sessionId!.isNotEmpty) {
                    soLimit = true;
                    SalesOrderPatchAPi.sessionID = valuel.sessionId!;
                    callPostApi();
                  } else {
                    setState(() {
                      isLoading = false;
                      schemeApiLoad = false;
                    });
                    showDetailBox('Server Issue Please Try Again !!..');
                  }
                });
                // });
              } else {
                SalesOrderPatchAPi.sessionID = GetValues.sessionID;
                callPostApi();
              }
            } else {
              SalesOrderPatchAPi.sessionID = GetValues.sessionID;
              callPostApi();
            }
          });
        } else if (value.creaditDaysValueValue![0].CreditDays! > 0) {
          // PostMaxCommitAPi.cardCodePost = HeaderEditOrderPageState.bpCode;
          // PostMaxCommitAPi.value = "${50.00 + getCredit}";
          // PostMaxCommitAPi.getGlobalData().then((value) {
          // print(" PostMaxCommitAPi callPostApi: ");
          SOLoginAPi.username = 'sodaysapp';
          await SOLoginAPi.getGlobalData().then((valuel) {
            if (valuel.sessionId != null) {
              soDats = true;
              SalesOrderPatchAPi.sessionID = valuel.sessionId!;
              callPostApi();
            } else if (valuel.sessionId == null) {
              setState(() {
                isLoading = false;
                schemeApiLoad = false;
              });
              showDetailBox('Server Issue Please Try Again !!..');
            }
          });

          //  });
        } else {
          SalesOrderPatchAPi.sessionID = GetValues.sessionID;
          callPostApi();
        }
      }
    });
  }

  static bool soLimit = false;
  static bool soDats = false;

  Future<void> callPostApi() async {
    await SalesOrderPatchAPi.getGlobalData(
      EditORderDetailsState.latitude!,
      EditORderDetailsState.longitude!,
      widget.docEntry,
    ) //
        .then((value) {
      //  log("Doccccccd" + value.docEntry.toString());
      if (value.statusCode! >= 200 && value.statusCode! <= 204) {
        SalesOrderAfterAPi.baseEntry = value.docEntry.toString();

        ///   setState(() => isLoading = false);
        //  print(value.statusCode);
        // const snackBar = SnackBar(
        //   duration: Duration(seconds: 5),
        //   backgroundColor: Colors.green,
        //   content: Text(
        //     'Orders Created Successfully!!...',
        //     style: TextStyle(color: Colors.white),
        //   ),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // nullallValues();
        checkORderORDraft();
        deleteValueINDB(cusID);
        //Get.offAllNamed<dynamic>(FurneyRoutes.newSalesOrders);
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        setState(() {
          isLoading = false;
          schemeApiLoad = false;
        });
        // print(value.statusCode);
        final snackBar = SnackBar(
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
          content: Text(
            '${value.error!.message!.value}!!..', //
            style: TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(this.context).showSnackBar(snackBar);
      } else {
        setState(() {
          isLoading = false;
          schemeApiLoad = false;
        });
        // print(value.statusCode);
        final snackBar = SnackBar(
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
          content: Text(
            '${value.error!.message!.value}!!..', //
            style: TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(this.context).showSnackBar(snackBar);
      }
    });
    if (schmDisableBtn == true) {
      SalesOrderAfterAPi.sessionID = GetValues.sessionID;
      SalesOrderAfterAPi.baseType = "17";
      // SalesOrderAfterAPi.baseEntry = "12345";
      // print("SO basetype: " + SalesOrderAfterAPi.baseType.toString());
      // print("SO discper:" + SalesOrderAfterAPi.baseLineTo.toString());
      // print("SO discper:" + SalesOrderAfterAPi.disValue.toString());
      // print("SO discper:" + SalesOrderAfterAPi.discper.toString());
      // print("SO schemeEntry:" + SalesOrderAfterAPi.schemeEntry.toString());
      for (int i = 0; i < saleOrderdata!.length; i++) {
        SalesOrderAfterAPi.baseLineTo = saleOrderdata![i].lineNum.toString();
        SalesOrderAfterAPi.disValue = saleOrderdata![i].discVal.toString();
        SalesOrderAfterAPi.discper = saleOrderdata![i].discPer.toString();
        SalesOrderAfterAPi.schemeEntry = saleOrderdata![i].schemeEntry;
        await SalesOrderAfterAPi.getData(SalesOrderPatchAPi.deviceTransID!)
            .then((value) async {
          if (value.statusCode! >= 200 && value.statusCode! <= 210) {}
        });
      }
    }
  }

  void deleteValueToDB() {}

  void checkORderORDraft() {
    CheckOrderORDraftAPi.urlss();
    CheckOrderORDraftAPi.getGlobalData().then((value) {
      // log("CheckOrderORDraftAPi: "+ value.orderORDraftValue![0].cardName .toString());
      if (value.orderORDraftValue!.length > 0) {
        setState(() {
          isLoading = false;
          schemeApiLoad = false;
        });
        ContentOrderEditState.isCalculated = true;
        showDetailBox(soDats == true
            ? 'Document needs credit days approval hence saved as draft'
            : soLimit == true
                ? 'Document needs credit limit approval hence saved as draft'
                : 'Order Created Successfully !!..');
      } else if (value.orderORDraftValue!.length < 1) {
        callDraftApi();
      }
    });
  }

  void callDraftApi() {
    DraftSaveAPi.urlss();
    DraftSaveAPi.getGlobalData().then((value) {
      if (value.orderORDraftValue!.length > 0) {
        setState(() {
          isLoading = false;
          schemeApiLoad = false;
        });
        ContentOrderEditState.isCalculated = true;
        showDetailBox(soDats == true
            ? 'Document needs credit days approval hence saved as draft'
            : soLimit == true
                ? 'Document needs credit limit approval hence saved as draft'
                : 'Orders needs approval hence saved as draft !!..');
      } else {
        setState(() {
          isLoading = false;
          schemeApiLoad = false;
        });
        showDetailBox('Order Not Successfull Please Try Again !!..');
      }
    });
  }

  void showDetailBox(String msg) {
    //print("object");
    showDialog<dynamic>(
      context: context,
      builder: (context) {
        // String contentText = "Content of Dialog";
        return StatefulBuilder(
          builder: (context, setState) {
            Theme.of(context);
            return AlertDialog(
              //    title: Text("Title of Dialog"),
              content: SizedBox(
                //  color: Colors.black12,
                // height: Screens.heigth(context) * 0.4,
                width: Screens.width(context) * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "$msg",
                      style: TextStyles.headlineBlack1(context),
                    ),
                    SizedBox(
                      height: Screens.heigth(context) * 0.02,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() => isLoading = false);
                          Get.offAllNamed<dynamic>(FurneyRoutes.newSalesOrders);
                          //  Navigator.pop(context);
                        },
                        child: Text(
                          'OK',
                          style: TextStyles.whiteText(context),
                        ))
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String? currentDateTime;
  void currentDate() {
    DateTime now = DateTime.now();
    setState(() {
      String val =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
      currentDateTime = val;
      print(currentDateTime);
    });
  }

  final TimeOfDay _selectTime = TimeOfDay.now();
  String? installTime;
  void selecTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectTime,
      //  builder: (BuildContext context, Widget? child){
      //     return MediaQuery(
      //       data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
      //       child: child!);
    );
    MaterialLocalizations localizations = MaterialLocalizations.of(context);

    if (picked != null) {
      String format = localizations.formatTimeOfDay(picked);
      setState(() {
        mycontroller[0].text = format;
        //  hour = _selectTime.hour.toString();
        String time, postTime, postTime2;
        time = picked.toString();
        postTime = time.replaceAll("TimeOfDay", "");
        postTime2 = postTime.replaceAll("(", "");
        installTime = postTime2.replaceAll(")", "");
        mycontroller[0].clear();
        mycontroller[0].text = installTime!;
        print(installTime);
      });
    }
  }

  void showDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        mycontroller[1].text = value.toString();
        var date = DateTime.parse(mycontroller[1].text);
        mycontroller[1].text = "";
        mycontroller[1].text =
            "${date.year.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
        print("date: " + mycontroller[1].text);
      });
    });
  }
}

class SelectUserType {
  String name;
  String type;
  SelectUserType({required this.name, required this.type});

  static List<SelectUserType> selectUserType = [
    new SelectUserType(name: 'Select', type: '0'),
    new SelectUserType(name: 'Normal', type: '1'),
    new SelectUserType(name: 'Depot transfer', type: '2'),
    new SelectUserType(name: 'Select', type: '3'),
    new SelectUserType(name: 'Select', type: '0'),
  ];
}
