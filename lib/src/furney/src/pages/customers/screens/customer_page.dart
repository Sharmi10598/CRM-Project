// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, unnecessary_const, use_named_constants, require_trailing_commas, omit_local_variable_types, prefer_is_empty, avoid_unnecessary_containers, prefer_single_quotes, avoid_print, prefer_if_elements_to_conditional_expressions, unawaited_futures

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
//import 'package:ultimate_bundle/src/furney/src/Api/customer_bp/customer_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/customer_bp/customer_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/customer_bp/customer_details_api.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/customer_bp/NewCustomerModel2.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/bp_info.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/widget/general.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/widget/logistic_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/screens/create_order.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/creation/content_order_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/creation/header_order_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/creation/logistics_orders_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/screens/create_quot.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/creation/content_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/creation/header_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/header_qut.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  CustomerPageState createState() => CustomerPageState();
}

class CustomerPageState extends State<CustomerPage> {
  static bool isCameFromCreation = false;
  static bool isCameFromCreationOrder = false;
  static bool isCameFromAgeingReport = false;

  List<NewCustomerData> customerData = [];
  List<NewCustomerData> customerDataFilter = [];
  // ScrollController scrollController = ScrollController();
  int lenthofList = 0;
  int minuslength = 0;
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  String? slpcode;
  @override
  void initState() {
    super.initState();
    log('isCameFromCreationOrderisCameFromCreationOrder::$isCameFromCreationOrder');
    callApi();
  }

  Future<void> callApi() async {
    final preff = await SharedPreferences.getInstance();
    setState(() {
      GetCustomerAPi.slpCode = preff.getString('SlpCode');
      print("slpccode222: " + GetCustomerAPi.slpCode.toString());
      print("slpccode222: " + GetValues.sapPassword.toString());
    });
    await GetCustomerAPi.getGlobalData().then((value) {
      if (value.CustomerData != null) {
        if (value.CustomerData!.length > 0) {
          print("Customervalue!.length: " +
              value.CustomerData!.length.toString());
          setState(() {
            //print( "salesPersonCode: "+value.Customervalue![0].salesPersonCode!.toStringAsFixed(0));
            // value.Customervalue![0].salesPersonCode!.toStringAsFixed(0);
            //  print("nextLink: "+value.nextLink.toString());
            customerData = value.CustomerData!;
            customerDataFilter = customerData;
            // GetCustomerAPi.nextUrl = value.nextLink;
            lenthofList = customerDataFilter.length;
            // print("lenthofList: "+lenthofList.toString());
            // print("U_CASHCUST: "+customerData[1].businessPartners!.U_CASHCUST.toString());
            //  print("leng..."+customerData.length.toString());
            //  print("cardcode: "+customerData[0].cardCode.toString());
            //  print("cardname: "+customerData[1].cardCode.toString());
          });
        }
      } else if (value.error != null) {
        final snackBar = SnackBar(
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          content: Text(
            '${value.error}!!..',
            style: const TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.pop(context);
        });
      }

      // scrollController.addListener(() {
      //   if(scrollController.position.pixels ==
      //       scrollController.position.maxScrollExtent) {
      //     if (mycontroller[0].text.isEmpty) {
      //       // getmoredata();
      //     }
      //   }
      //   // else if (scrollController.position.pixels !=
      //   //     scrollController.position.maxScrollExtent) {
      //   //   print("heelllllloo");
      //   // }
      // });
    });
  }

  @override
  void dispose() {
    super.dispose();
    //scrollController.dispose();
  }

  bool swipeLoad = false;
  // void getmoredata() {
  //   GetCustomerAPi.callNextLink().then((val) {
  //     setState(() {
  //       swipeLoad = true;
  //       minuslength = -1;
  //       if (val.Customervalue != null) {
  //         lenthofList = val.Customervalue!.length;
  //         print("lenthofList2: "+lenthofList.toString());
  //         for (int i = 0; i < lenthofList; i++) {
  //           customerDataFilter.add(
  //             CustomerValue(
  //               businessPartners: val.Customervalue![i].businessPartners,
  //           paymentTermsTypes: val.Customervalue![i].paymentTermsTypes,
  //           salesPersons: val.Customervalue![i].salesPersons,));
  //         }
  //         swipeLoad = false;
  //          print("lenthofList3: " + lenthofList.toString());
  //         // print("lennList: " + customerDataFilter.length.toString());
  //         // print(val.nextLink);
  //         minuslength = 0;

  //       }
  //     });
  //   });
  // }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer:
          //  GetValues.userRoll == '3' ? drawer2(context) :
          drawer(context),
      appBar: appBar(context, _scaffoldKey, widget.title),
      body: customerData.isEmpty && searchLoading == false
          ? Center(
              child: SpinKitThreeBounce(
                size: Screens.heigth(context) * 0.06,
                color: theme.primaryColor,
              ),
            )
          : Column(
              children: [
                Container(
                  height: Screens.heigth(context) * 0.06,
                  decoration: BoxDecoration(
                    color: theme.hintColor.withOpacity(.05),
                    borderRadius: BorderRadius.circular(Const.radius),
                  ),
                  child: TextField(
                    controller: mycontroller[0],
                    autocorrect: false,
                    style: theme.textTheme.bodyMedium,
                    onChanged: (v) {
                      setState(() {
                        customerDataFilter = customerData
                            .where((e) =>
                                e.cardName!
                                    .toLowerCase()
                                    .contains(v.toLowerCase()) ||
                                e.cardCode!
                                    .toLowerCase()
                                    .contains(v.toLowerCase()))
                            .toList();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for Customer',
                      hintStyle: TextStyles.bodytextBlack1(context),
                      // AppLocalizations.of(context)!
                      //     .search_sales_quot,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          final FocusScopeNode focus = FocusScope.of(context);
                          if (!focus.hasPrimaryFocus) {
                            focus.unfocus();
                          }
                          GetCustomerAPi.searchValue = mycontroller[0].text;
                          //  setState(() {
                          //    spin=true;
                          //     searchLoading =true;
                          //             customerData.clear();
                          //             customerDataFilter.clear();
                          //           //  print("customerDataFilter: "+customerDataFilter.length.toString());
                          //             });
                          //   GetCustomerAPi.searchData().then((value) {
                          //         if(value.Customervalue!.length>0){
                          //           setState(() {
                          //                 spin=false;
                          //         //    print(value.Customervalue![0].);
                          //             customerData = value.Customervalue!;
                          //             customerDataFilter =customerData;
                          //           });
                          //         }else if(value.Customervalue!.length==0){
                          //             const snackBar = SnackBar(
                          //           duration:  Duration(seconds: 5),
                          //           backgroundColor: Colors.red,
                          //           content: Text(
                          //             'There is no data to show!!..',
                          //             style:  TextStyle(color: Colors.white),
                          //           ),
                          //         );
                          //         setState(() {
                          //             spin=false;
                          //         });
                          //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          //         }
                          //   });
                        }, //
                        color: theme.primaryColor,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 5,
                      ),
                    ),
                  ),
                ),
                customerData.length == 0 && searchLoading == true
                    ? SizedBox(
                        // color: Colors.amber,
                        width: Screens.width(context),
                        height: Screens.heigth(context) * 0.8,
                        child: Center(
                          child: Visibility(
                            visible: spin,
                            child: SpinKitThreeBounce(
                              size: Screens.heigth(context) * 0.06,
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          //controller: scrollController,
                          itemCount: customerDataFilter.length,
                          itemBuilder: (BuildContext context, int i) {
                            // if (i == customerDataFilter.length - 1) {
                            //   if (mycontroller[0].text.isEmpty) {
                            //     print("1111111");
                            //     return SpinKitThreeBounce(
                            //       size: Screens.width(context) * 0.06,
                            //       color: theme.primaryColor,
                            //     );
                            //   }
                            // }
                            return
                                //  Card(
                                //    elevation: 8,
                                //   child:
                                InkWell(
                              onTap: () {
                                final FocusScopeNode focus =
                                    FocusScope.of(context);
                                if (!focus.hasPrimaryFocus) {
                                  focus.unfocus();
                                }
                                LogisticPageState.billto = '';
                                LogisticPageState.shipto = '';
                                if (isCameFromCreation == true) {
                                  setState(() {
                                    HeaderCreationState.bpName =
                                        customerDataFilter[i]
                                            .cardName
                                            .toString();
                                    HeaderCreationState.bpCode =
                                        customerDataFilter[i]
                                            .cardCode
                                            .toString();
                                    HeaderCreationState.currentACbalance =
                                        customerDataFilter[i]
                                            .currentAccountBalance
                                            .toString();
                                    HeaderCreationState.ordersBal =
                                        customerDataFilter[i]
                                            .currentOrderBalance
                                            .toString();
                                    customerDataFilter[i].U_CASHCUST == 'YES'
                                        ? HeaderCreationState
                                            .isTextFiledEnabled = true
                                        : HeaderCreationState
                                            .isTextFiledEnabled = false;
                                    HeaderOrderCreationState.bpName =
                                        customerDataFilter[i]
                                            .cardName
                                            .toString();
                                    log("billll111:" +
                                        customerDataFilter[i]
                                            .U_CASHCUST
                                            .toString());
                                    LogisticPageState.billto =
                                        customerDataFilter[i]
                                            .BilltoDefault
                                            .toString();
                                    LogisticPageState.shipto =
                                        customerDataFilter[i]
                                            .ShipToDefault
                                            .toString();
                                    ContentCreationState.carcode =
                                        customerDataFilter[i]
                                            .cardCode
                                            .toString();
                                    LogisticPageState.currentACbalance =
                                        customerDataFilter[i]
                                            .currentAccountBalance!;
                                    LogisticPageState.ordersBal =
                                        customerDataFilter[i]
                                            .currentOrderBalance!;
                                    isCameFromCreation = false;
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CreateDetails(
                                                  title: 'Quotation Creation'),
                                        ));
                                    // Get.toNamed<dynamic>(
                                    //     FurneyRoutes.creationDetails);
                                  });
                                } else if (isCameFromCreationOrder == true) {
                                  log('bpNamexx =' +
                                      customerDataFilter[i]
                                          .cardName
                                          .toString());
                                  setState(() {
                                    log(customerDataFilter[i]
                                        .currentOrderBalance
                                        .toString());
                                    log(customerDataFilter[i]
                                        .currentAccountBalance
                                        .toString());
                                    customerDataFilter[i].U_CASHCUST == 'YES'
                                        ? HeaderOrderCreationState
                                            .isTextFiledEnabled = true
                                        : HeaderOrderCreationState
                                            .isTextFiledEnabled = false;

                                    log('customerDataFilter[i].U_CASHCUST::${customerDataFilter[i].U_CASHCUST}');

                                    HeaderOrderCreationState.bpName =
                                        customerDataFilter[i]
                                            .cardName
                                            .toString();
                                    HeaderOrderCreationState.bpCode =
                                        customerDataFilter[i]
                                            .cardCode
                                            .toString();
                                    HeaderOrderCreationState.bpName =
                                        HeaderOrderCreationState
                                                .currentACbalance =
                                            customerDataFilter[i].cardName!;

                                    customerDataFilter[i]
                                        .currentAccountBalance
                                        .toString();
                                    HeaderOrderCreationState.ordersBal =
                                        customerDataFilter[i]
                                            .currentOrderBalance
                                            .toString();
                                    HeaderOrderCreationState.paymentTerms =
                                        customerDataFilter[i]
                                            .pymntGroup
                                            .toString();
                                    HeaderOrderCreationState.isHaveAdvance =
                                        customerDataFilter[i]
                                            .cardName
                                            .toString();
                                    print("billll:" +
                                        customerDataFilter[i]
                                            .BilltoDefault
                                            .toString());
                                    LogisticOrderState.billto =
                                        customerDataFilter[i]
                                            .BilltoDefault
                                            .toString();
                                    LogisticOrderState.shipto =
                                        customerDataFilter[i]
                                            .ShipToDefault
                                            .toString();
                                    ContentOrderCreationState.carcode =
                                        customerDataFilter[i]
                                            .cardCode
                                            .toString();
                                    LogisticOrderState.ordersBal =
                                        customerDataFilter[i]
                                            .currentOrderBalance!;
                                    LogisticOrderState.currentACbalance =
                                        customerDataFilter[i]
                                            .currentAccountBalance!;
                                    isCameFromCreationOrder = false;
                                    Navigator.pop(context);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CreateOrderDetails(
                                                  title: 'Order Creation'),
                                        ));
                                    // Get.toNamed<dynamic>(
                                    //     FurneyRoutes.creationOrderDetails);
                                  });
                                }
                                // static bool isCameFromCreationOrder = false;
                                else {
                                  BPInfoState.cardName =
                                      customerDataFilter[i].cardName;
                                  BPInfoState.cardCode =
                                      customerDataFilter[i].cardCode;
                                  BPInfoState.curentBalance =
                                      customerDataFilter[i]
                                          .currentAccountBalance!
                                          .toStringAsFixed(2);
                                  BPInfoState.slpName =
                                      customerDataFilter[i].slpname;
                                  BPInfoState.paymentTerms =
                                      customerDataFilter[i].pymntGroup;
                                  print(BPInfoState.cardCode);
                                  CustomerDetailsAPi.cardCode =
                                      customerDataFilter[i].cardCode.toString();

                                  Get.toNamed<dynamic>(FurneyRoutes.bpinfo);
                                  // print("iiii: "+i.toString());
                                  GeneralState.index = i;
                                  BPInfoState.index = i;
                                }
                              },
                              child: Container(
                                  // height: Screens.heigth(context)*0.1,
                                  width: Screens.width(context),
                                  padding: const EdgeInsets.only(
                                      // top: Screens.heigth(context) * 0.005,
                                      // bottom: Screens.heigth(context) * 0.005,
                                      // left: Screens.width(context) * 0.02,
                                      // right: Screens.width(context) * 0.02,
                                      ),
                                  decoration: const BoxDecoration(
                                      // color:Colors.green,
                                      // borderRadius: BorderRadius.circular(Const.radius),
                                      //    border: Border( bottom: BorderSide(color: Colors.grey),)
                                      ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: Screens.width(context) * 0.2,
                                            //color: Colors.redAccent,
                                            decoration: const BoxDecoration(),
                                            child: Icon(
                                              Icons.account_box_outlined,
                                              color: theme.primaryColor,
                                              size:
                                                  Screens.width(context) * 0.1,
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                //width: Screens.width(context)*0.55,
                                                //  color: Colors.greenAccent,
                                                child: Text(
                                                  customerDataFilter[i]
                                                      .cardCode
                                                      .toString(),
                                                  style: TextStyles.boldPC1(
                                                      context),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        Screens.width(context) *
                                                            0.52,
                                                    //  color: Colors.greenAccent,
                                                    child: Text(
                                                      customerDataFilter[i]
                                                          .cardName
                                                          .toString(),
                                                      style: TextStyles
                                                          .headlineBlack1(
                                                              context),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width: Screens.width(
                                                              context) *
                                                          0.05),
                                                  Container(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    width:
                                                        Screens.width(context) *
                                                            0.2,
                                                    //   color: Colors.redAccent,
                                                    child: Text(
                                                      // customerDataFilter[i].businessPartners!
                                                      //     .currentAccountBalance
                                                      //     .toString(),
                                                      TextStyles.splitValues(
                                                          '${customerDataFilter[i].currentAccountBalance}'),
                                                      style: TextStyles
                                                          .headlineBlack1(
                                                              context),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          // top: Screens.heigth(context) * 0.005,
                                          // bottom: Screens.heigth(context) * 0.005,
                                          left: Screens.width(context) * 0.06,
                                          right: Screens.width(context) * 0.06,
                                        ),
                                        // ignore: prefer_const_constructors
                                        child: Divider(
                                          thickness: 1.5,
                                        ),
                                      )
                                    ],
                                  )),
                              //  ),
                            );
                          },
                        ),
                      )
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Get.toNamed<void>(FurneyRoutes.createCustomer);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  bool spin = true;
  bool searchLoading = false;
}
