// ignore_for_file: prefer_interpolation_to_compose_strings, noop_primitive_operations, omit_local_variable_types, unnecessary_new, prefer_const_constructors, require_trailing_commas, avoid_print, prefer_single_quotes, prefer_if_elements_to_conditional_expressions

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ultimate_bundle/SalesApp/Pages/Planning/UnplannedVisit.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/streamDataApi/streamDataapi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/approvals_api/approvals_details_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/rejectedApi/rejectedApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/salesOrder_details_api.dart';
//import 'package:ultimate_bundle/src/furney/src/Api/sales_order/sales_order_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/sales_order_api.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_oder/approvals_order_modal/approvals_order_modal.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_oder/sales_order_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/delivery/widgets/delivery_appbar.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/screens/sales_order_details.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/creation/content_order_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/creation/header_order_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/creation/logistics_orders_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/showDetails/approvalsDetailsOrders.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

import 'package:ultimate_bundle/src/furney/src/pages/sales_order/screens/create_order.dart';

import '../../../../../../SalesApp/Pages/Planning/UpdatePlan.dart';

class SalesOrder extends StatefulWidget {
  const SalesOrder({
    Key? key,
  }) : super(key: key);
  //final String title;
  @override
  _SalesQuotState createState() => _SalesQuotState();
}

class _SalesQuotState extends State<SalesOrder> {
  List<SalesOrderValue> salesOrderDetails = [];
  List<SalesOrderValue> salesOrderFilter = [];
  ScrollController scrollController = ScrollController();
  int lenthofList = 0;
  int minuslength = 0;
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());

  //rejected

  List<ApprovalsOrdersValue> approvalsOrdersValues = [];
  List<ApprovalsOrdersValue> filterapprovals = [];
  @override
  void initState() {
    super.initState();
    log("lennList: " + salesOrderFilter.length.toString());
    log("getvalues password: " + GetValues.sapPassword.toString());
    log("getvalues username: " + GetValues.sapUserName.toString());

    //  GetValues.isAtive[0]=false;
    //   GetValues.isAtive[1]=true;
    // SalesOderAPi.getGlobalData().then((val) {
    //   if(val.salesOrderValue!=null){
    //       print(val.salesOrderValue![0].cardName);
    //           print(val.salesOrderValue!.length.toString());
    //       setState(() {
    //         salesOrderDetails = val.salesOrderValue!;
    //         salesOrderFilter =salesOrderDetails;
    //          lenthofList = salesOrderFilter.length;
    //          SalesOderAPi.nextUrl = val.nextLink;
    //       });
    //   }else if(val.error !=null){
    //        final snackBar = SnackBar(
    //         duration: const Duration(seconds: 5),
    //         backgroundColor: Colors.red,
    //         content: Text(
    //           '${val.error}!!..',
    //           style: const TextStyle(color: Colors.white),
    //         ),
    //       );
    //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //     }
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (nextLink != null) {
          log("object222");
          getmoredata();
        }
      }
    });
    log("lenthofList :::${salesOrderFilter.length}");
    log("nextLinknextLink::$nextLink");
    // });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  bool swipeLoad = false;
  void getmoredata() {
    log("nextLinknextLink::$nextLink");

    SalesOderAPi.callNextLink().then((val) {
      setState(() {
        swipeLoad = true;
        minuslength = -1;
        if (val.salesOrderValue != null) {
          for (int i = 0; i < lenthofList; i++) {
            salesOrderFilter.add(SalesOrderValue(
                DocDate: val.salesOrderValue![i].DocDate,
                cardCode: val.salesOrderValue![i].cardCode,
                cardName: val.salesOrderValue![i].cardName,
                docEntry: val.salesOrderValue![i].docEntry,
                DocNum: val.salesOrderValue![i].DocNum,
                cancelStatus: val.salesOrderValue![i].cancelStatus,
                documentStatus: val.salesOrderValue![i].documentStatus));
          }
          swipeLoad = false;

          log("lenthofList: " + lenthofList.toString());
          log("lennList: " + salesOrderFilter.length.toString());
          log(val.nextLink.toString());
          minuslength = 0;
        }
      });
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    final DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      log("are you sure");
      Get.offAllNamed<dynamic>(FurneyRoutes.home);
      return Future.value(true);
    }
    Get.offAllNamed<dynamic>(FurneyRoutes.home);
    return Future.value(true);
  }

  bool searchLoading = false;
  bool spin = false;
  String? nextLink;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didpop) {
        if (didpop) return;
        log("bbbbbbbb");
        onbackpress();
      },
      child: Scaffold(
        // key:_scaffoldKey,
        //   drawer:
        // GetValues.userRoll == '3' ? drawer2(context) : drawer(context),
        // appBar: appBar(context, _scaffoldKey, widget.title),
        //  ),

        body:
            //  salesOrderDetails.isEmpty? Center(
            //   child:  SpinKitThreeBounce(
            //                 size: Screens.heigth(context)*0.06,
            //                 color:theme.primaryColor,
            //               ),
            // ):
            SafeArea(
                child: Padding(
          padding: EdgeInsets.only(
              left: Screens.width(context) * 0.02,
              right: Screens.width(context) * 0.02,
              top: Screens.heigth(context) * 0.01,
              bottom: Screens.width(context) * 0.01),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
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
                        salesOrderFilter = salesOrderDetails
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
                      hintText: 'Search for Orders',
                      hintStyle: TextStyles.bodytextBlack1(context),
                      // AppLocalizations.of(context)!
                      //     .search_sales_quot,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          log(' get password:::${GetValues.sapPassword}');
                          mycontroller[1].text = "";
                          mycontroller[2].text = "";
                          mycontroller[3].text = "";
                          statusChossed = null;
                          statusBorderRed = false;
                          showSheetSearch(theme, context);
                          // SalesOderAPi.searchValue = mycontroller[0].text;
                          // setState(() {
                          //   salesOrderDetails.clear();
                          //   salesOrderFilter.clear();
                          //   });

                          //   SalesOderAPi.searchData().then((value) {
                          //         if(value.salesOrderValue!=null){
                          //           setState(() {
                          //             print(value.salesOrderValue![0].docEntry);
                          //             salesOrderDetails = value.salesOrderValue!;
                          //             salesOrderFilter =salesOrderDetails;
                          //           });
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
                Positioned(
                    left: Screens.width(context) * 0.8,
                    child: IconButton(
                        onPressed: () {
                          //print("object");
                          setAllNull();
                          Get.toNamed<dynamic>(
                              FurneyRoutes.creationOrderDetails);
                        },
                        icon: Icon(
                          Icons.add,
                          color: theme.primaryColor,
                          size: Screens.width(context) * 0.08,
                        )))
              ]),
              searchLoading == true // salesOrderDetails.isEmpty &&
                  ? SizedBox(
                      //color: Colors.amber,
                      width: Screens.width(context),
                      height: Screens.heigth(context) * 0.72,
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
                  : openClosedList(theme),
            ],
          ),
        )),
      ),
    );
  }

  bool isPartOne = true;

  Expanded openClosedList(ThemeData theme) {
    log('salesOrderFilterXXX:::${salesOrderFilter.length}');
    return Expanded(
      child: isPartOne == true
          ? ListView.builder(
              controller: scrollController,
              itemCount: salesOrderFilter.length, //dataSocialMedia.length,
              itemBuilder: (context, i) {
                // if(i ==salesOrderFilter.length-1 ){
                //   if(mycontroller[0].text.isEmpty){
                //     print("1111111");
                //             return SpinKitThreeBounce(
                //           size: Screens.width(context)*0.06,
                //           color:theme.primaryColor,
                //         );
                //   }
                //         }
                return Card(
                    elevation: 8,
                    child: InkWell(
                      onTap: () {
                        SalesOderDetailsAPi.docEntry =
                            salesOrderFilter[i].docEntry.toString();
                        StreamDataAPi.docEntry =
                            salesOrderFilter[i].docEntry.toString();
                        StreamDataAPi.docNO =
                            salesOrderFilter[i].DocNum.toString();
                        SalesOrderDetailsState.status = salesOrderFilter[i]
                                        .cancelStatus ==
                                    'csNo' &&
                                salesOrderFilter[i].documentStatus ==
                                    'bost_Open'
                            ? 'Open'
                            : salesOrderFilter[i].cancelStatus == 'csYes' &&
                                    salesOrderFilter[i].documentStatus ==
                                        'bost_Close'
                                ? 'Cancelled'
                                : salesOrderFilter[i].cancelStatus == 'csNo' &&
                                        salesOrderFilter[i].documentStatus ==
                                            'bost_Close'
                                    ? 'Closed'
                                    : '';
                        print(" StreamDataAPi.docEntry " +
                            StreamDataAPi.docEntry.toString());
                        print("DocNum: " + StreamDataAPi.docNO.toString());

                        Get.toNamed<dynamic>(FurneyRoutes.salesorderdetails);
                      },
                      child: Container(
                        height: Screens.heigth(context) * 0.075,
                        width: Screens.width(context),
                        decoration: const BoxDecoration(
                            // color:Colors.green,
                            // borderRadius: BorderRadius.circular(Const.radius),
                            // border: Border.all(color: Colors.black)
                            ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              //row 1
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: Screens.width(context) * 0.02,
                                  height: double.infinity,
                                  color: theme.primaryColor,
                                ),
                                SizedBox(
                                  width: Screens.width(context) * 0.01,
                                ),
                                SizedBox(
                                  //   color: Colors.greenAccent,
                                  width: Screens.width(context) * 0.2,
                                  child: Text(
                                    '${salesOrderFilter[i].DocNum}',
                                    style: TextStyles.bodytextBlack1(context),
                                  ),
                                ),
                                SizedBox(
                                  width: Screens.width(context) * 0.01,
                                ),
                                SizedBox(
                                  //   color: Colors.blue,
                                  width: Screens.width(context) * 0.4,
                                  child: Text(
                                    '${salesOrderFilter[i].cardName}',
                                    style: TextStyles.bodytextBlack1(context),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: Screens.width(context) * 0.02),
                              child: Row(
                                children: [
                                  Container(
                                    alignment: Alignment.centerRight,
                                    //    color: Colors.red,
                                    width: Screens.width(context) * 0.22,
                                    child: Column(
                                      children: [
                                        Text(
                                          salesOrderFilter[i].cancelStatus ==
                                                      'csNo' &&
                                                  salesOrderFilter[i]
                                                          .documentStatus ==
                                                      'bost_Open'
                                              ? 'Open'
                                              : salesOrderFilter[i]
                                                              .cancelStatus ==
                                                          'csYes' &&
                                                      salesOrderFilter[i]
                                                              .documentStatus ==
                                                          'bost_Close'
                                                  ? 'Cancelled'
                                                  : salesOrderFilter[i]
                                                                  .cancelStatus ==
                                                              'csNo' &&
                                                          salesOrderFilter[i]
                                                                  .documentStatus ==
                                                              'bost_Close'
                                                      ? 'Closed'
                                                      : '',
                                          style: TextStyles.bodytextBlack1(
                                              context),
                                        ),
                                        Text(
                                          config.alignDate(salesOrderFilter[i]
                                              .DocDate
                                              .toString()),
                                          style: TextStyles.bodytextBlack1(
                                              context),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: theme.primaryColor,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
              })
          : ListView.builder(
              itemCount: filterapprovals.length,
              itemBuilder: (c, i) {
                return InkWell(
                  onTap: () {
                    ApprovalsDetailsOrdersState.docTypeName = filterapprovals[i]
                            .ObjType
                            .toString()
                            .contains('13')
                        ? 'A/R Invoice'
                        : filterapprovals[i].ObjType.toString().contains('23')
                            ? 'Sales Quotation'
                            : filterapprovals[i]
                                    .ObjType
                                    .toString()
                                    .contains('17')
                                ? 'Sales Order'
                                : filterapprovals[i]
                                        .ObjType
                                        .toString()
                                        .contains('14')
                                    ? 'Sales Return'
                                    : filterapprovals[i]
                                            .ObjType
                                            .toString()
                                            .contains('15')
                                        ? 'Deliveries'
                                        : '';
                    ApprovalsDetailsAPi.draftEntry =
                        filterapprovals[i].docEntry.toString();
                    ApprovalsDetailsOrdersState.isCameFormSalesORder = true;
                    Get.toNamed<dynamic>(
                        FurneyRoutes.approvalsDetailsSalesOrders);
                  },
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Screens.width(context) * 0.01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            //row 1
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                ///  color: Colors.greenAccent,
                                width: Screens.width(context) * 0.2,
                                child: Text(
                                  '${filterapprovals[i].cardCode}',
                                  style: TextStyles.bodytextBlack1(context),
                                ),
                              ),
                              SizedBox(
                                width: Screens.width(context) * 0.01,
                              ),
                              SizedBox(
                                //   color: Colors.blue,
                                width: Screens.width(context) * 0.4,
                                child: Text(
                                  '${filterapprovals[i].cardName}',
                                  style: TextStyles.bodytextBlack1(context),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: Screens.width(context) * 0.02),
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.centerRight,
                                  //    color: Colors.red,
                                  width: Screens.width(context) * 0.22,
                                  child: Column(
                                    children: [
                                      Text(
                                        '${filterapprovals[i].docEntry}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                      Text(
                                        '${filterapprovals[i].DocDate}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: theme.primaryColor,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }

  Future<void> setAllNull() async {
    final preff = await SharedPreferences.getInstance();
    setState(() {
      HeaderOrderCreationState.isTextFiledEnabled = false;
      HeaderOrderCreationState.bpName = '';
      HeaderOrderCreationState.bpCode = '';
      HeaderOrderCreationState.contactPerson = '';
      HeaderOrderCreationState.isHaveAdvance = '';
      HeaderOrderCreationState.mycontroller[2].clear();
      // HeaderCreationState.docNo='';
      HeaderOrderCreationState.salesEmp =
          preff.getString('sapUserName').toString();
      // HeaderCreationState.currency='';
      HeaderOrderCreationState.status = 'open';
      HeaderOrderCreationState.total = 0.00;
      HeaderOrderCreationState.tax = 0.00;
      HeaderOrderCreationState.discount = 0.00;
      HeaderOrderCreationState.totalBeforeDiscount = 0.00;
      HeaderOrderCreationState.mycontroller[0].clear();
      HeaderOrderCreationState.mycontroller[1].clear();
      //content creation
      ContentOrderCreationState.itemsDetails.clear();
      ContentOrderCreationState.carcode = null;
      //
      LogisticOrderState.valueSelectedGPApproval = null;
      LogisticOrderState.valueSelectedOrder = null;
      LogisticOrderState.mycontroller[0].clear();
      LogisticOrderState.mycontroller[1].clear();
      LogisticOrderState.soDats = false;
      LogisticOrderState.soLimit = false;
      SwitchBtn.siwtchTrue = true;
      CreateOrderDetailsState.isCameFromqutation = false;
    });
  }

  List<GlobalKey<FormState>> formkey =
      List.generate(3, (i) => GlobalKey<FormState>());
  void showSheetSearch(ThemeData theme, BuildContext context) {
    //nznznz
    showModalBottomSheet<dynamic>(
        isDismissible: false,
        isScrollControlled: true,
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Form(
                    key: formkey[0],
                    child: Container(
                      child: Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Stack(
                              children: [
                                SizedBox(
                                  child: new TextFormField(
                                    onTap: () {
                                      showDate(context);
                                    },
                                    readOnly: true,
                                    controller: mycontroller[1],
                                    onChanged: (val) {},
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "ENTER FROM DATE";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(fontSize: 15),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      labelText: "Choose from date",
                                      labelStyle:
                                          TextStyles.bodytextBlack1(context),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: Screens.heigth(context) * 0.01,
                                    left: Screens.width(context) * 0.8,
                                    child: InkWell(
                                      onTap: () {
                                        showDate(context);
                                      },
                                      child: Icon(Icons.calendar_today_outlined,
                                          color: theme.primaryColor,
                                          size: Screens.width(context) * 0.08),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),

                            Stack(
                              children: [
                                SizedBox(
                                  child: new TextFormField(
                                    onTap: () {
                                      showToDate(context);
                                    },
                                    readOnly: true,
                                    controller: mycontroller[2],
                                    onChanged: (val) {},
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "ENTER TO DATE";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(fontSize: 15),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      labelText: "Choose to date",
                                      labelStyle:
                                          TextStyles.bodytextBlack1(context),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: Screens.heigth(context) * 0.01,
                                    left: Screens.width(context) * 0.8,
                                    child: InkWell(
                                      onTap: () {
                                        showToDate(context);
                                      },
                                      child: Icon(Icons.calendar_today_outlined,
                                          color: theme.primaryColor,
                                          size: Screens.width(context) * 0.08),
                                    )),
                              ],
                            ),
                            //  ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              child: new TextFormField(
                                controller: mycontroller[3],
                                onChanged: (val) {},
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "ENTER DISCOUNT";
                                //   }else if(value.isNotEmpty){
                                //       double dis =double.parse(value);
                                //       if(dis>100){
                                //         return "DISCOUNT MORE THAN 100";
                                //       }
                                //   }
                                //   return null;
                                // },
                                // keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  labelText: "Customer name",
                                  labelStyle:
                                      TextStyles.bodytextBlack1(context),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: Screens.width(context),
                              padding:
                                  EdgeInsets.only(top: 1, left: 10, right: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: statusBorderRed == false
                                          ? Colors.grey
                                          : Colors.red),
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButton(
                                dropdownColor: Colors.white,

                                hint: Text(
                                  "Select Status: ",
                                  style: TextStyles.bodytextBlack1(context),
                                ),
                                value: statusChossed,
                                //dropdownColor:Colors.green,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                isExpanded: true,
                                onChanged: (val) {
                                  setState(() {
                                    statusChossed = val.toString();
                                    statusBorderRed = false;
                                    if (statusChossed == 'Rejected' ||
                                        statusChossed == 'Pending') {
                                      isPartOne = false;
                                    } else {
                                      isPartOne = true;
                                    }
                                  });
                                },
                                items: statusData.map((e) {
                                  return DropdownMenuItem(
                                      value: "${e['name']}",
                                      child: Text(
                                        e['name'].toString(),
                                        style:
                                            TextStyles.headlineBlack1(context),
                                      ));
                                }).toList(),
                              ),
                            ),
                            Visibility(
                              visible: statusBorderRed,
                              child: Text(
                                "CHOOSE STATUS",
                                style: GoogleFonts.poppins(
                                    color: Colors.red[700],
                                    fontSize: Screens.width(context) * 0.03),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    backgroundColor: theme.primaryColor,
                                  ),
                                  child: Text(
                                    "Cancel",
                                    style: TextStyles.whiteText(context),
                                  ),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: theme.primaryColor,
                                    ),
                                    onPressed: () {
                                      if (statusChossed == null) {
                                        setState(() {
                                          statusBorderRed = true;
                                        });
                                        return;
                                      }
                                      log("mycontroller333${mycontroller[3].text}");
                                      validateSearch();
                                    },
                                    child: Text(
                                      "Search",
                                      style: TextStyles.whiteText(context),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ));
  }

  List<Map<String, String>> statusData = [
    {"name": 'Open', "value": "Open"},
    {"name": 'Closed', "value": "Closed"},
    {"name": 'Pending', "value": "Pending"},
    {"name": 'Rejected', "value": "Rejected"},
  ];
  String? statusChossed;
  bool statusBorderRed = false;
  Future<void> validateSearch() async {
    if (formkey[0].currentState!.validate()) {
      Navigator.pop(context);
      if (isPartOne == true) {
        setState(() {
          salesOrderFilter.clear();
          salesOrderDetails.clear();
          searchLoading = true;
          spin = true;
        });
        //         SalesOderAPi.fromDate = mycontroller[1].text;
        // SalesOderAPi.toDate = mycontroller[2].text;
        SalesOderAPi.searchValue = mycontroller[3].text;
        SalesOderAPi.callWhichApi = statusChossed!;
        print("callwhich api: " + SalesOderAPi.callWhichApi);
        await SalesOderAPi.meth(mycontroller[1].text, mycontroller[2].text);
        await SalesOderAPi.getGlobalData(
                mycontroller[1].text, mycontroller[2].text)
            .then((value) {
          if (value.salesOrderValue!.isNotEmpty) {
            setState(() {
              salesOrderDetails = value.salesOrderValue!;
              salesOrderFilter = salesOrderDetails;
              log("quotDataFilter: " + salesOrderFilter.length.toString());
              lenthofList = salesOrderFilter.length;
              // if (value.nextLink != 'null') {
              //   nextLink = value.nextLink;
              //   SalesOderAPi.nextUrl = value.nextLink;
              //   log("nextLink:: " + value.nextLink.toString());
              // }
              searchLoading = false;
              spin = false;
            });
          } else if (value.salesOrderValue!.isEmpty) {
            setState(() {
              searchLoading = false;
              spin = false;
            });
            final snackBar = SnackBar(
              duration: const Duration(seconds: 5),
              backgroundColor: Colors.red,
              content: Text(
                'No $statusChossed Orders!!..',
                style: const TextStyle(color: Colors.white),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        });
      } else {
        if (statusChossed == 'Rejected' || statusChossed == 'Pending') {
          if (mycontroller[3].text.isEmpty) {
            print("1212121212121212121");
            const snackBar = SnackBar(
              duration: Duration(seconds: 5),
              backgroundColor: Colors.red,
              content: Text(
                'Please select customer name!!..',
                style: TextStyle(color: Colors.white),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            return;
          }
        }
        print("D4344, CardName: AGNES MWITA CHACHA,");

        setState(() {
          approvalsOrdersValues.clear();
          filterapprovals.clear();
          searchLoading = true;
          spin = true;
        });
        await RejectedORPendingAPi.getGlobalData(
                GetValues.slpCode!,
                mycontroller[3].text,
                mycontroller[1].text,
                mycontroller[2].text,
                statusChossed!)
            .then((value) {
          if (value.approvalsOrdersValue!.isNotEmpty) {
            setState(() {
              approvalsOrdersValues = value.approvalsOrdersValue!;
              filterapprovals = approvalsOrdersValues;
              searchLoading = false;
              spin = false;
            });
          } else {
            setState(() {
              searchLoading = false;
              spin = false;
            });
            final snackBar = SnackBar(
              duration: const Duration(seconds: 5),
              backgroundColor: Colors.red,
              content: Text(
                'No $statusChossed found!!..',
                style: const TextStyle(color: Colors.white),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        });
      }
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
        final date = DateTime.parse(mycontroller[1].text);
        mycontroller[1].text = "";
        mycontroller[1].text =
            "${date.year.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
        // String apidate =
        //     "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
        // GetFollowupApi.fromDate = apidate;
        print(mycontroller[1].text);
      });
    });
  }

  void showToDate(BuildContext context) {
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
        mycontroller[2].text = value.toString();
        final date = DateTime.parse(mycontroller[2].text);
        mycontroller[2].text = "";
        mycontroller[2].text =
            "${date.year.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
        // String apidate =
        //     "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
        // GetFollowupApi.fromDate = apidate;
        print(mycontroller[2].text);
      });
    });
  }
}
