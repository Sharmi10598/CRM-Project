// ignore_for_file: noop_primitive_operations, omit_local_variable_types, prefer_interpolation_to_compose_strings, require_trailing_commas, prefer_single_quotes, prefer_const_constructors, duplicate_ignore, unnecessary_new, sized_box_for_whitespace, prefer_if_elements_to_conditional_expressions, prefer_const_literals_to_create_immutables, unnecessary_lambdas, unawaited_futures, unnecessary_string_interpolations

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/helpers/uikit_model.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/SalesQutApiNew/GetAllSalesQutApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/SalesQutApiNew/GetAllSalesQutApi2.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_quotations_api/salesQuot_details_api.dart';
//import 'package:ultimate_bundle/src/furney/src/Api/sales_quotations_api/sales_quot_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_quotations_api/sales_quot_api.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_quot/sales_quot_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/delivery/widgets/delivery_appbar.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/screens/SalesQutDetails.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/screens/sales_quot_details.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/creation/content_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/creation/header_creation.dart';

class SalesQuot extends StatefulWidget {
  //required this.title
  const SalesQuot({
    Key? key,
  }) : super(key: key);
  //final String title;
  @override
  _SalesQuotState createState() => _SalesQuotState();
}

class _SalesQuotState extends State<SalesQuot> {
  List<SalesQuotValue> quotData = [];
  List<SalesQuotValue> quotDataFilter = [];
  List<SalesQuotValue> quotDataFilter2 = [];

  ScrollController scrollController = ScrollController();
  int lenthofList = 0;
  int minuslength = 0;
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());

  // new chnages

  List<ValueData> values = [];
  List<ValueData> filtervalues = [];
  bool nodata = false;

  @override
  void initState() {
    super.initState();
    mycontroller[0].text = '';

    // callApi();

    //   SalesQuotAPi.getGlobalData().then((val) {
    //      if(val.salesQuotValue!=null){
    //        print("cardCode: "+val.salesQuotValue![1].cardCode .toString());
    //       print("documentStatus: "+val.salesQuotValue![25].documentStatus.toString());
    //       print('cancelStatus: '+val.salesQuotValue![25].cancelStatus.toString());
    //           print(val.salesQuotValue!.length.toString());

    //       setState(() {
    //         quotData = val.salesQuotValue!;
    //         quotDataFilter =quotData;
    //          lenthofList = quotDataFilter.length;
    //          SalesQuotAPi.nextUrl = val.nextLink;
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
    //   });

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // if(mycontroller[0].text.isEmpty){
        print("object");
        if (nextLink != null) {
          print("object222");
          getmoredata();
        }
        //}
      }
    });
  }

//String method = "Quotations?\$filter=SalesPersonCode eq ${GetValues.slpCode} &\$select=DocEntry,DocNum,DocDate,CardCode,CardName,DocumentStatus&\$orderby=DocDate desc";
  Future<void> callApi() async {
    //  log("sales qqqq: "+ method);
    await GetAllSalesQuaAPi.getGlobalData().then((result) {
      // log("value value ${result.activitiesData.toString()}");
      if (result.statusCode! >= 200 && result.statusCode! <= 210) {
        if (result.activitiesData != null) {
          // log("value value ${result.activitiesData![0].CardName}");

          setState(() {
            values = result.activitiesData!;
            filtervalues = values;
            log("filtervaluesfiltervaluesfiltervalues:::${filtervalues.length}");
            //  method = result.nextLink.toString();
          });
        } else {
          nodata = true;
          setState(() {});
          //    Get.defaultDialog<void>(
          //   title: 'Alert',
          //   middleText: '${result.error}'
          // );
        }
      } else if (result.statusCode! >= 400 && result.statusCode! <= 410) {
        Get.defaultDialog<void>(middleText: '${result.error}');
      } else {
        Get.defaultDialog<void>(middleText: '${result.error}');
      }
    });
  }

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

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  bool swipeLoad = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void getmoredata() {
    SalesQuotAPi.callNextLink().then((val) {
      setState(() {
        swipeLoad = true;
        minuslength = -1;
        if (val.salesQuotValue != null) {
          int isv = 0;
          for (int i = 0; i < lenthofList; i++) {
            quotDataFilter.add(SalesQuotValue(
                DocDate: val.salesQuotValue![i].DocDate,
                cardCode: val.salesQuotValue![i].cardCode,
                cardName: val.salesQuotValue![i].cardName,
                docEntry: val.salesQuotValue![i].docEntry,
                DocNum: val.salesQuotValue![i].DocNum,
                cancelStatus: val.salesQuotValue![i].cancelStatus,
                documentStatus: val.salesQuotValue![i].documentStatus));
            isv = isv + i;
          }
          if (isv == lenthofList - 1) {
            swipeLoad = false;
          }
          print('lenthofList: ' + lenthofList.toString());
          print('lennList: ' + quotDataFilter.length.toString());
          print(val.nextLink);
          minuslength = 0;
        } else if (val.salesQuotValue!.isEmpty) {
          setState(() {
            searchLoading = false;
            spin = false;
          });
          final snackBar = SnackBar(
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.red,
            content: Text(
              'No Open quotations!!..',
              style: const TextStyle(color: Colors.white),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    });
  }

  //  DateTime? currentBackPressTime;
  // Future<bool> onbackpress() {
  //   DateTime now = DateTime.now();
  //   if (currentBackPressTime == null ||
  //       now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
  //     currentBackPressTime = now;
  //      print("are you sure");
  //    Get.offAllNamed<dynamic>(FurneyRoutes.home);
  //     return Future.value(true);
  //   }
  //    Get.offAllNamed<dynamic>(FurneyRoutes.home);
  //     return Future.value(true);
  // }
  bool searchLoading = false;
  bool spin = false;
  String? nextLink;

  //
  bool swipeLoad2 = false;
  String nextSqLink = '';

  Future<void> getmoredataFWH() async {
    if (nextSqLink.isNotEmpty && nextSqLink.toString() != 'null') {
      swipeLoad = true;
      setState(() => swipeLoad);
      callApi();
    }
  }

  Config config = new Config();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
        // backgroundColor: Colors.grey[200],
        // key: _scaffoldKey,
        // drawer: drawer(context),
        // appBar: appBar(context, _scaffoldKey, widget.title),
        //  ),

        body:
            // quotData.isEmpty? Center(
            //   child:  SpinKitThreeBounce(
            //                 size: Screens.heigth(context)*0.06,
            //                 color:theme.primaryColor,
            //               ),
            // ):
            SafeArea(
                child: Container(
          // color: Colors.red,
          padding: EdgeInsets.only(
              left: Screens.width(context) * 0.02,
              right: Screens.width(context) * 0.02,
              top: Screens.heigth(context) * 0.01,
              bottom: Screens.width(context) * 0.01),
          child:
              // values.isEmpty && nodata == false
              //     ? Center(child: CircularProgressIndicator())
              //     :
              Column(
                /// mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: Screens.heigth(context) * 0.06,
                    decoration: BoxDecoration(
                      color: theme.hintColor.withOpacity(.05),
                      borderRadius: BorderRadius.circular(Const.radius),
                    ),
                    child: TextFormField(
                      controller: mycontroller[0],
                      autocorrect: false,
                      style: theme.textTheme.bodyMedium,
                      onChanged: (v) {
                        setState(() {
                          quotDataFilter = quotData
                              // filtervalues = values
                              .where((e) =>
                                  e.cardCode!
                                      .toLowerCase()
                                      .contains(v.toLowerCase()) ||
                                  e.cardName!
                                      .toLowerCase()
                                      .contains(v.toLowerCase()) ||
                                  e.DocNum.toString()
                                      .toLowerCase()
                                      .contains(v.toLowerCase()) ||
                                  e.documentStatus
                                      .toString()
                                      .toLowerCase()
                                      .contains(v.toLowerCase()))
                              .toList();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search for Quotations',
                        hintStyle: TextStyles.bodytextBlack1(context),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            mycontroller[1].text = "";
                            mycontroller[2].text = "";
                            mycontroller[3].text = "";
                            statusBorderRed = false;
                            statusChossed = null;
                            showSheetSearch(theme, context);
                          }, //
                          color: theme.primaryColor,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              setAllNull();
                              Get.toNamed<dynamic>(FurneyRoutes.creationDetails);
                            });
                          }, //
                          color: theme.primaryColor,
                        ),
                        //   Positioned(
                        //           left: Screens.width(context)*0.8,
                        //           child: IconButton(onPressed: (){
                        //             //print("object");
                        //             setAllNull();
                        //              Get.toNamed<dynamic>(FurneyRoutes.creationDetails);
                        //           }, icon: Icon(Icons.add,
                        //           color: theme.primaryColor,
                        //           size: Screens.width(context)*0.08,
                        //           )))
                        //       ]
                        //     ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 5,
                        ),
                      ),
                    ),
                  ),
              
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
              
                  // Expanded(
                  //     child: LazyLoadScrollView(
                  //       isLoading: swipeLoad2,
                  //       onEndOfPage: () => getmoredataFWH(),
                  //       child: Scrollbar(
                  //         thickness: 5,
                  //         child: ListView.builder(
                  //           itemCount: swipeLoad2 == true
                  //               ? 1
                  //               : filtervalues.length,
                  //           itemBuilder:
                  //               (BuildContext context, int index) {
                  //             if (swipeLoad2 == true) {
                  //               return Container(
                  //                   width: Screens.width(context),
                  //                   height: Screens.heigth(context) * 0.8,
                  //                   child: Center(
                  //                       child:
                  //                           CircularProgressIndicator()));
                  //             }
                  //             return InkWell(
                  //               child: Card(
                  //                   child: GestureDetector(
                  //                 onTap: () {
                  //                   if (filtervalues[index].docStatus ==
                  //                       "bost_Close") {
                  //                     SalesDetailsQuotState
                  //                         .isclosedocument = true;
                  //                     log("IsClose::" +
                  //                         filtervalues[index]
                  //                             .docStatus
                  //                             .toString());
                  //                   } else {
                  //                     SalesDetailsQuotState
                  //                         .isclosedocument = false;
                  //                   }
              
                  //                   if (filtervalues[index].docStatus ==
                  //                       "C") {
                  //                     SalesDetailsQuotState
                  //                         .isclosedocument2 = true;
                  //                     log("IsC::" +
                  //                         filtervalues[index]
                  //                             .docStatus
                  //                             .toString());
                  //                   } else {
                  //                     SalesDetailsQuotState
                  //                         .isclosedocument2 = false;
                  //                   }
                  //                   log("filtervalues[index].docStatus:bost_Close::" +
                  //                       filtervalues[index]
                  //                           .docStatus
                  //                           .toString());
                  //                   //  widget.DTCon. selectedFWH(index,context);
                  //                   // ApprovalsDetailsQuotState.docTypeName =  filtervalues[index].ObjType.toString().contains('13')?'A/R Invoice':
                  //                   //                                  filtervalues[index].ObjType.toString().contains('23')?'Sales Quotation':
                  //                   //                                   filtervalues[index].ObjType.toString().contains('17')?'Sales Order':
                  //                   //                                    filtervalues[index].ObjType.toString().contains('14')?'Sales Return':
                  //                   //                                    filtervalues[index].ObjType.toString().contains('15')?'Deliveries':'';
                  //                   filtervalues[index]
                  //                       .docEntry
                  //                       .toString();
                  //                   log("filtervalues[index].docEntry:::::::::::" +
                  //                       filtervalues[index]
                  //                           .docEntry
                  //                           .toString());
                  //                   SalesDetailsQuotState.docEntryforSO =
                  //                       filtervalues[index]
                  //                           .docEntry
                  //                           .toString();
                  //                   Get.to<void>(SalesDetailsQuot(
                  //                     title: 'Sales Quot',
                  //                     docentry: filtervalues[index]
                  //                         .docEntry
                  //                         .toString(),
                  //                   ));
                  //                 },
                  //                 child: Container(
                  //                     decoration: BoxDecoration(
                  //                       color: Colors.white,
                  //                       boxShadow: [
                  //                         BoxShadow(
                  //                           color: Colors.grey
                  //                               .withOpacity(0.5),
                  //                           spreadRadius: 1,
                  //                           blurRadius: 2,
                  //                           offset: Offset(0, 3),
                  //                         ),
                  //                       ],
                  //                       borderRadius:
                  //                           BorderRadius.circular(4),
                  //                     ),
                  //                     padding: EdgeInsets.all(
                  //                         Screens.heigth(context) * 0.01),
                  //                     child: Column(
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.start,
                  //                       children: [
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment
                  //                                   .spaceBetween,
                  //                           children: [
                  //                             Container(
                  //                               child: Text(
                  //                                   '${filtervalues[index].CardCode}',
                  //                                   style: theme.textTheme
                  //                                       .bodyLarge),
                  //                             ),
                  //                             Container(
                  //                               child: Text(
                  //                                   '${filtervalues[index].docnum}',
                  //                                   style: theme.textTheme
                  //                                       .bodyLarge),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                         Container(
                  //                           child: Text(
                  //                               '${filtervalues[index].CardName}',
                  //                               style: theme
                  //                                   .textTheme.bodyLarge),
                  //                         ),
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment
                  //                                   .spaceBetween,
                  //                           children: [
                  // Container(
                  //   child: Text(
                  //       '${filtervalues[index].docStatus}',
                  //       style: theme.textTheme
                  //           .bodyLarge),
                  // ),
                  //                             Container(
                  //                               child: Text(
                  // config.alignDate2(
                  //                                       filtervalues[
                  //                                               index]
                  //                                           .docDate),
                  //                                   style: theme.textTheme
                  //                                       .bodyLarge),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ],
                  //                     )),
                  //               )),
                  //             );
                  //           },
                  //         ),
                  //       ),
                  //     ),
                  //   )
                  // sharmi commented
              
                  //     Stack(
                  //       children:[
                  //         Container(
                  //         height: Screens.heigth(context) * 0.06,
                  //         decoration: BoxDecoration(
                  //           color: theme.hintColor.withOpacity(.05),
                  //           borderRadius: BorderRadius.circular(Const.radius),
                  //         ),
                  //         child: TextField(
                  //          controller: mycontroller[0],
                  //           autocorrect: false,
                  //           style: theme.textTheme.bodyText2,
                  //           onChanged: (v) {
                  //             setState(() {
                  //               quotDataFilter = quotData
                  //                   .where((e) =>
                  //                       (e)
                  //                           .cardName!
                  //                           .toLowerCase()
                  //                           .contains(v.toLowerCase()) ||
                  //                       (e)
                  //                           .cardCode!
                  //                           .toLowerCase()
                  //                           .contains(v.toLowerCase()))
                  //                   .toList();
                  //             });
                  //           },
                  //           decoration: InputDecoration(
                  //             hintText: 'Search for Quotations',
                  //             hintStyle: TextStyles.bodytextBlack1(context),
                  //             // AppLocalizations.of(context)!
                  //             //     .search_sales_quot,
                  //             enabledBorder: InputBorder.none,
                  //             focusedBorder: InputBorder.none,
                  //             prefixIcon: IconButton(
                  //               icon: const Icon(Icons.search),
                  //               onPressed: () {
                  //                  mycontroller[1].text="";
                  //               mycontroller[2].text="";
                  //               mycontroller[3].text="";
                  //               statusBorderRed = false;
                  //               statusChossed = null;
                  //                 showSheetSearch(theme,context);
                  //               //    SalesQuotAPi.searchValue = mycontroller[0].text;
                  //               // setState(() {
                  //               //   quotData.clear();
                  //               //   quotDataFilter.clear();
                  //               //   });
              
                  //               //   SalesQuotAPi.searchData().then((value) {
                  //               //         if(value.salesQuotValue!=null){
                  //               //           if(value.salesQuotValue!.length>0){
                  //               //               setState(() {
                  //               //             print(value.salesQuotValue![0].docEntry);
                  //               //             quotData = value.salesQuotValue!;
                  //               //             quotDataFilter =quotData;
                  //               //           });
                  //               //           }else{
              
                  //               //           }
                  //               //         }
                  //               //   });
                  //               }, //
                  //               color: theme.primaryColor,
                  //             ),
                  //             contentPadding: const EdgeInsets.symmetric(
                  //               vertical: 15,
                  //               horizontal: 5,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //        Positioned(
                  //           left: Screens.width(context)*0.8,
                  //           child: IconButton(onPressed: (){
                  //             //print("object");
                  //             setAllNull();
                  //              Get.toNamed<dynamic>(FurneyRoutes.creationDetails);
                  //           }, icon: Icon(Icons.add,
                  //           color: theme.primaryColor,
                  //           size: Screens.width(context)*0.08,
                  //           )))
                  //       ]
                  //     ),
                  //      searchLoading == true //quotData.length == 0 &&
                  // ? Container(
                  //   //color: Colors.amber,
                  //   width: Screens.width(context),
                  //   height: Screens.heigth(context)*0.72,
                  //   child: Center(
                  //       child: Visibility(
                  //         visible: spin,
                  //         child: SpinKitThreeBounce(
                  //           size: Screens.heigth(context) * 0.06,
                  //           color: theme.primaryColor,
                  //         ),
                  //       ),
                  //     ),
                  // )
                  // :statusChossed == 'Open' || statusChossed =='Closed'? openClosedList(theme)
              
                  // :Container(
                  //   width: Screens.width(context),
                  //   height: Screens.heigth(context)*0.735,
                  //   color: Colors.white,
                  // child: Column(
                  //       children: [
                  //         Expanded(
                  //           child: ListView.builder(
                  //             itemCount:22,// filterapprovals.length,
                  //             itemBuilder: (c,i){
                  //             return InkWell(
                  //               onTap:(){
                  //                 // ApprovalsDetailsQuotState.docTypeName =  filterapprovals[i].ObjType.toString().contains('13')?'A/R Invoice':
                  //                 //                        filterapprovals[i].ObjType.toString().contains('23')?'Sales Quotation':
                  //                 //                         filterapprovals[i].ObjType.toString().contains('17')?'Sales Order':
                  //                 //                          filterapprovals[i].ObjType.toString().contains('14')?'Sales Return':
                  //                 //                          filterapprovals[i].ObjType.toString().contains('15')?'Deliveries':'';
                  //                 // ApprovalsDetailsAPi.draftEntry = filterapprovals[i].docEntry.toString();
                  //                 Get.toNamed<dynamic>(FurneyRoutes.approvalsDetailsSalesQuot);
                  //               },
                  //               child: Card(
                  //                 child: Container(
                  //                    padding: EdgeInsets.symmetric(horizontal: Screens.width(context)*0.01),
                  //                       child:  Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //                 Row(//row 1
                  //                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     // Container(
                  //                     //   width: Screens.width(context)*0.01,
                  //                     //  height: double.infinity,
                  //                     //   color: Colors.blue,
                  //                     // ),
                  //                     //SizedBox(width: Screens.width(context)*0.01,),
                  //                     Container(
                  //                    ///  color: Colors.greenAccent,
                  //                         width: Screens.width(context)*0.2,
                  //                       child: Text('data',//'${filterapprovals[i].cardCode}',
                  //                       style: TextStyles.bodytextBlack1(context),),
                  //                     ),
                  //                      SizedBox(width: Screens.width(context)*0.01,),
                  //                     Container(
                  //                     //   color: Colors.blue,
                  //                         width: Screens.width(context)*0.4,
                  //                       child: Text('data',//'${filterapprovals[i].cardName}',
                  //                       style: TextStyles.bodytextBlack1(context),),
                  //                     )
                  //                   ],
                  //                 ),
              
                  //                 Padding(
                  //                   padding:  EdgeInsets.only(top:Screens.width(context)*0.02),
                  //                   child: Row(
                  //                     children: [
                  //                       Container(
                  //                         alignment: Alignment.centerRight,
                  //                      //    color: Colors.red,
                  //                         width: Screens.width(context)*0.22,
                  //                         child: Column(
                  //                           children: [
                  //                             Text(
                  //                         'data',//   '${filterapprovals[i].docEntry}' ,
                  //                            style:TextStyles.bodytextBlack1(context),),
                  //                             Text(
                  //                               'data',//'${filterapprovals[i].DocDate}' ,
                  //                               style: TextStyles.bodytextBlack1(context),),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       Icon(Icons.chevron_right,
                  //                       color:  theme.primaryColor,)
                  //                     ],
                  //                   ),
                  //                 )
                  //           ],
                  //         ),
                  //                 ),
                  //               ),
                  //             );
                  //           }),
                  //         ),
                  //       ],
                  //     ),
                  // ),
                ],
              ),
        )),
      ),
    );
  }

  bool isPartOne = true;

  Expanded openClosedList(ThemeData theme) {
    return Expanded(
      child: ListView.builder(
          controller: scrollController,
          itemCount: quotDataFilter.length, //dataSocialMedia.length,
          itemBuilder: (context, i) {
            // if(swipeLoad == true ){
            //   // if(mycontroller[0].text.isEmpty){
            //     print("1111111");
            //             return SpinKitThreeBounce(
            //           size: Screens.width(context)*0.06,
            //           color:theme.primaryColor,
            //         );
            //   //}
            //         }
            return Card(
                elevation: 8,
                child: InkWell(
                  onTap: () {
                    if (quotDataFilter[i].documentStatus == "bost_Close") {
                      SalesDetailsQuotState.isclosedocument = true;
                      log("IsClose::" +
                          quotDataFilter[i].documentStatus.toString());
                    } else {
                      SalesDetailsQuotState.isclosedocument = false;
                    }

                    if (quotDataFilter[i].documentStatus == "C") {
                      SalesDetailsQuotState.isclosedocument2 = true;
                      log("IsC::" +
                          quotDataFilter[i].documentStatus.toString());
                    } else {
                      SalesDetailsQuotState.isclosedocument2 = false;
                    }
                    log("filtervalues[index].docStatus:bost_Close::" +
                        quotDataFilter[i].documentStatus.toString());
                    quotDataFilter[i].docEntry.toString();
                    log("filtervalues[index].docEntry:::::::::::" +
                        quotDataFilter[i].docEntry.toString());
                    SalesDetailsQuotState.docEntryforSO =
                        quotDataFilter[i].docEntry.toString();
                    SalesDetailsQuotState.basedocentry =
                        quotDataFilter[i].docEntry.toString();
                    // Get.to<void>(SalesDetailsQuot(
                    //   // title: 'Sales Quot',
                    //   // docentry: quotDataFilter[i].docEntry.toString(),
                    // ));
                    Get.toNamed<dynamic>(FurneyRoutes.salesQtDetailss);

                    SalesOuotDetailsAPi.docEntry =
                        quotDataFilter[i].docEntry.toString();
                    // print(SalesOuotDetailsAPi.docEntry);
                    // SalesQtDetailsState
                    //     .status = quotDataFilter[i].cancelStatus == 'csNo' &&
                    //         quotDataFilter[i].documentStatus == 'bost_Open'
                    //     ? 'Open'
                    //     : quotDataFilter[i].cancelStatus == 'csYes' &&
                    //             quotDataFilter[i].documentStatus == 'bost_Close'
                    //         ? 'Cancelled'
                    //         : quotDataFilter[i].cancelStatus == 'csNo' &&
                    //                 quotDataFilter[i].documentStatus ==
                    //                     'bost_Close'
                    //             ? 'Closed'
                    //             : '';
                  },
                  child: Container(
                    height: Screens.heigth(context) * 0.09,
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
                            Container(
                              //   color: Colors.greenAccent,
                              width: Screens.width(context) * 0.2,
                              child: Text(
                                '${quotDataFilter[i].DocNum}',
                                style: TextStyles.bodytextBlack1(context),
                              ),
                            ),
                            SizedBox(
                              width: Screens.width(context) * 0.01,
                            ),
                            Container(
                              //   color: Colors.blue,
                              width: Screens.width(context) * 0.4,
                              child: Text(
                                '${quotDataFilter[i].cardName}',
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
                                    // Text(
                                    //   quotDataFilter[i].cancelStatus ==
                                    //               'csNo' &&
                                    //           quotDataFilter[i]
                                    //                   .documentStatus ==
                                    //               'bost_Open'
                                    //       ? 'Open'
                                    //       : quotDataFilter[i].cancelStatus ==
                                    //                   'csYes' &&
                                    //               quotDataFilter[i]
                                    //                       .documentStatus ==
                                    //                   'bost_Close'
                                    //           ? 'Cancelled'
                                    //           : quotDataFilter[i]
                                    //                           .cancelStatus ==
                                    //                       'csNo' &&
                                    //                   quotDataFilter[i]
                                    //                           .documentStatus ==
                                    //                       'bost_Close'
                                    //               ? 'Closed'
                                    //               : '',
                                    //   style: TextStyles.bodytextBlack1(context),
                                    // ),
                                    Text('${quotDataFilter[i].documentStatus}',
                                        style: theme.textTheme.bodyLarge),
                                    Text(
                                      '${config.alignDate2(quotDataFilter[i].DocDate.toString())}',
                                      style: TextStyles.bodytextBlack1(context),
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
          }),
    );
  }

  Future<void> setAllNull() async {
    final preff = await SharedPreferences.getInstance();
    HeaderCreationState.bpName = '';
    HeaderCreationState.bpCode = '';
    HeaderCreationState.contactPerson = '';
    // HeaderCreationState.docNo='';
    HeaderCreationState.salesEmp = preff.getString('sapUserName').toString();
    // HeaderCreationState.currency='';
    HeaderCreationState.status = '';
    HeaderCreationState.discount = 0.00;
    HeaderCreationState.totalBeforeDiscount = 0.00;
    HeaderCreationState.total = 0.00;
    HeaderCreationState.tax = 0.00;
    //content creation
    ContentCreationState.itemsDetails.clear();
    ContentCreationState.carcode = null;

    SwitchBtn.siwtchTrue = true;
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
                        child: SingleChildScrollView(
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
                                        child: Icon(
                                            Icons.calendar_today_outlined,
                                            color: theme.primaryColor,
                                            size:
                                                Screens.width(context) * 0.08),
                                      ))
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
                                        child: Icon(
                                            Icons.calendar_today_outlined,
                                            color: theme.primaryColor,
                                            size:
                                                Screens.width(context) * 0.08),
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

                                  style: TextStyle(fontSize: 15),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        // ignore: prefer_const_constructors
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
                              // Container(
                              //   width: Screens.width(context),
                              //   padding:
                              //       EdgeInsets.only(top: 1, left: 10, right: 10),
                              //   decoration: BoxDecoration(
                              //       border: Border.all(
                              //           color: statusBorderRed == false
                              //               ? Colors.grey
                              //               : Colors.red),
                              //       borderRadius: BorderRadius.circular(5)),
                              //   child: DropdownButton(
                              //     hint: Text(
                              //       "Select Status: ",
                              //       style: TextStyles.bodytextBlack1(context),
                              //     ),
                              //     value: statusChossed,
                              //     //dropdownColor:Colors.green,
                              //     icon: Icon(Icons.arrow_drop_down),
                              //     iconSize: 30,
                              //     style: TextStyle(
                              //         color: Colors.black, fontSize: 16),
                              //     isExpanded: true,
                              //     onChanged: (val) {
                              //       setState(() {
                              //         statusChossed = val.toString();
                              //         statusBorderRed = false;
                              //       });
                              //     },
                              //     items: statusData.map((e) {
                              //       return DropdownMenuItem(
                              //           value: "${e['name']}",
                              //           child: Text(
                              //             e['name'].toString(),
                              //             style:
                              //                 TextStyles.headlineBlack1(context),
                              //           ));
                              //     }).toList(),
                              //   ),
                              // ),
                              // Visibility(
                              //   visible: statusBorderRed,
                              //   child: Text(
                              //     "CHOOSE STATUS",
                              //     style: GoogleFonts.poppins(
                              //         color: Colors.red[700],
                              //         fontSize: Screens.width(context) * 0.03),
                              //   ),
                              // ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
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
                                        // if (statusChossed == null) {
                                        //   setState(() {
                                        // statusBorderRed = true;
                                        //   });
                                        //   return;
                                        // }
                                        setState(() {
                                          validateSearch();
                                        });
                                      },
                                      child: Text(
                                        "Search",
                                        style: TextStyles.whiteText(context),
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            ));
  }

  List<Map<String, String>> statusData = [
    {"name": 'Open', "value": "Open"},
    {"name": 'Closed', "value": "Closed"},
    // {"name": 'Pending',"value":"Pending"},
    // {"name": 'Rejected',"value":"Rejected"},
  ];
  bool statusBorderRed = false;
  String? statusChossed;
  Future<void> validateSearch() async {
    if (formkey[0].currentState!.validate()) {
      Navigator.pop(context);
      setState(() {
        quotData.clear();
        searchLoading = true;
        spin = true;
      });
      if (statusChossed == "Rejected" || statusChossed == "Pending") {
        print("Pending Pending Pending");
      } else {
        // SalesQuotAPi.fromDate = mycontroller[1].text;
        //     SalesQuotAPi.toDate = mycontroller[2].text;
        //     SalesQuotAPi.searchValue = mycontroller[3].text;
        //     SalesQuotAPi.callWhichApi = statusChossed!;
        SalesQuotAPi.getGlobalData(mycontroller[1].text, mycontroller[2].text)
            .then((value) {
          // quotDataFilter = [];
          // quotData = [];
          if (value.salesQuotValue!.isNotEmpty) {
            setState(() {
              quotData = value.salesQuotValue!;
              quotDataFilter = quotData;
              quotDataFilter2 = quotData;
              log("quotDataFilter: " + quotDataFilter.length.toString());
              log("quotDataFilter[i].DocNum:::${quotDataFilter[0].DocNum}");
              lenthofList = quotDataFilter.length;
              // if (value.nextLink != 'null') {
              //   nextLink = value.nextLink;
              //   SalesQuotAPi.nextUrl = value.nextLink;
              //   log("nextLink:: " + value.nextLink.toString());
              // }
              searchLoading = false;
              spin = false;
            });
          } else if (value.salesQuotValue!.isEmpty) {
            setState(() {
              searchLoading = false;
              spin = false;
            });
            final snackBar = SnackBar(
              duration: const Duration(seconds: 5),
              backgroundColor: Colors.red,
              content: Text(
                'No sales quotations!!..',
                style: const TextStyle(color: Colors.white),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            setState(() {
              searchLoading = false;
              spin = false;
            });
            final snackBar = SnackBar(
              duration: const Duration(seconds: 5),
              backgroundColor: Colors.red,
              content: Text(
                'Something Went Wrong!!..',
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
