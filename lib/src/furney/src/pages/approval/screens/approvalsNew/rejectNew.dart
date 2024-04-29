// ignore_for_file: avoid_unnecessary_containers, prefer_single_quotes, prefer_interpolation_to_compose_strings, prefer_is_empty, unrelated_type_equality_checks, omit_local_variable_types, unnecessary_const, file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/approvals_api/approvals_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/approvals_api/approvals_details_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/approvals_api/approvals_patch_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/approvals_api/rejectApi.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/approvals_modal/approvals_details.modal.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/approvals_modal/approvals_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/approvals_info.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class Rejected extends StatefulWidget {
  const Rejected({Key? key}) : super(key: key);
  // final String title;  this.title
  @override
  RejectedState createState() => RejectedState();
}

class RejectedState extends State<Rejected> {
  List<ApprovalsValue> approvalsvalues = [];
  List<ApprovalsValue> filtervalue = [];
  static bool backBtnreload = false;
  List<DocumentApprovalValue> documentApprovalValue = [];
  ScrollController scrollController = ScrollController();
  int lenthofList = 0;
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  @override
  void initState() {
    super.initState();
    RejectAPi.getGlobalData().then((value) {
      // print("url: "+ApprovalsAPi.url);
      if (value.approvalsvalue != null) {
        if (value.approvalsvalue!.length > 0) {
          setState(() {
            isapprovalslengthNull = false;
            print("approvalsvalue: " +
                value.approvalsvalue![0].ObjType.toString());
            // value.Customervalue![0].salesPersonCode!.toStringAsFixed(0);
            //print(value.nextLink);
            // valuesReturn(value.approvalsvalue![0].ObjType.toString());
            approvalsvalues = value.approvalsvalue!;
            filtervalue = approvalsvalues;
            ApprovalsAPi.nextUrl = value.nextLink;
            lenthofList = filtervalue.length;
          });
        } else if (value.error != null) {
          setState(() {
            isapprovalslengthNull = false;
          });
          final snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              '${value.error}!!..',
              style: const TextStyle(color: Colors.white),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //    Future.delayed(const Duration(seconds: 5),(){
          //    Navigator.pop(context);
          // });
        } else if (value.approvalsvalue!.length == 0) {
          setState(() {
            isapprovalslengthNull = false;
          });
          const snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'No Approvals!!..',
              style: const TextStyle(color: Colors.white),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //   Future.delayed(const Duration(seconds: 5),(){
          //    Navigator.pop(context);
          // });
        }
      }
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (mycontroller[0].text.isEmpty) {
          getmoredata();
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  bool swipeLoad = false;
  bool isapprovalslengthNull = true;
  void getmoredata() {
    ApprovalsAPi.callNextLink().then((val) {
      setState(() {
        swipeLoad = true;
        if (val.approvalsvalue!.length > 0) {
          // deliveryValue = val.deliveryModaleValue!;
          // deliveryValueFilter = deliveryValue;
          for (int i = 0; i < lenthofList; i++) {
            filtervalue.add(
              ApprovalsValue(
                cardName: val.approvalsvalue![i].cardName,
                DraftEntry: val.approvalsvalue![i].DraftEntry,
                FromUser: val.approvalsvalue![i].FromUser,
                ObjType: val.approvalsvalue![i].ObjType,
                WddCode: val.approvalsvalue![i].WddCode,
                WtmCode: val.approvalsvalue![i].WtmCode,
                cardCode: val.approvalsvalue![i].cardCode,
                createDate: val.approvalsvalue![i].createDate,
                createTime: val.approvalsvalue![i].createTime,
                CurrStep: val.approvalsvalue![i].CurrStep,
                DocDate: val.approvalsvalue![i].DocDate,
                DocNum: val.approvalsvalue![i].DocNum,
              ),
            );
          }
          swipeLoad = false;
          print("lenthofList: " + lenthofList.toString());
          print("lennList: " + filtervalue.length.toString());
          print(val.nextLink);
        }
      });
    });
  }

  String? resuestValue;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    final DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("are you sure");
      if (backBtnreload == true) {
        Get.offAllNamed<dynamic>(FurneyRoutes.home);
        return Future.value(true);
      }
      return Future.value(true);
    }
    if (backBtnreload == true) {
      Get.offAllNamed<dynamic>(FurneyRoutes.home);
      return Future.value(true);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
        key: _scaffoldKey,
        // appBar: appBar(context, _scaffoldKey, widget.title),
        drawer: drawer(context),
        body: isapprovalslengthNull == true
            ? Center(
                child: SpinKitThreeBounce(
                  size: Screens.heigth(context) * 0.06,
                  color: theme.primaryColor,
                ),
              )
            : SafeArea(
                child: Column(
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
                            filtervalue = approvalsvalues
                                .where(
                                  (e) =>
                                      e.cardName!
                                          .toLowerCase()
                                          .contains(v.toLowerCase()) ||
                                      e.cardCode!
                                          .toLowerCase()
                                          .contains(v.toLowerCase()) ||
                                      e.DraftEntry!
                                          .toString()
                                          .contains(v.toLowerCase()),
                                )
                                .toList();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search for reject',
                          hintStyle: TextStyles.bodytextBlack1(context),
                          // AppLocalizations.of(context)!
                          //     .search_sales_quot,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              final FocusScopeNode focus =
                                  FocusScope.of(context);
                              if (!focus.hasPrimaryFocus) {
                                focus.unfocus();
                              }
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
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: filtervalue.length,
                        itemBuilder: (context, i) {
                          //       if (i == filtervalue.length - 1) {
                          //   if (mycontroller[0].text.isEmpty) {
                          //     print("1111111");
                          //     return SpinKitThreeBounce(
                          //       size: Screens.width(context) * 0.06,
                          //       color: theme.primaryColor,
                          //     );
                          //   }
                          // }
                          return Card(
                            elevation: 8,
                            child: InkWell(
                              onTap: () {
                                backBtnreload = false;
                                //  showbottomsheet(context ,i);
                                ApprovalsInfoState.iscomeFromRejectORApproved =
                                    true;
                                ApprovalsDetailsAPi.draftEntry =
                                    filtervalue[i].DraftEntry.toString();
                                ApprovalsPatchAPi.approvalID =
                                    filtervalue[i].WddCode.toString();
                                ApprovalsInfoState.docTypeName = filtervalue[i]
                                        .ObjType
                                        .toString()
                                        .contains('13')
                                    ? 'A/R Invoice'
                                    : filtervalue[i]
                                            .ObjType
                                            .toString()
                                            .contains('23')
                                        ? 'Sales Quotation'
                                        : filtervalue[i]
                                                .ObjType
                                                .toString()
                                                .contains('17')
                                            ? 'Sales Order'
                                            : filtervalue[i]
                                                    .ObjType
                                                    .toString()
                                                    .contains('14')
                                                ? 'Sales Return'
                                                : filtervalue[i]
                                                        .ObjType
                                                        .toString()
                                                        .contains('15')
                                                    ? 'Deliveries'
                                                    : '';
                                Get.toNamed<dynamic>(
                                    FurneyRoutes.approvalsInfo);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: Screens.heigth(context) * 0.005,
                                  // bottom: Screens.heigth(context) * 0.005,
                                  left: Screens.width(context) * 0.02,
                                  right: Screens.width(context) * 0.04,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Center(
                                    //   child:

                                    SizedBox(
                                        height: Screens.heigth(context) * 0.02),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Icon(
                                        //   Icons.mail_outline,
                                        //   color: theme.primaryColor,
                                        //   size: Screens.width(context) * 0.07,
                                        // ),
                                        // SizedBox(width: Screens.width(context) * 0.05),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width:
                                                  Screens.width(context) * 0.7,
                                              //color: Colors.red,
                                              child: Text(
                                                filtervalue[i]
                                                        .ObjType
                                                        .toString()
                                                        .contains('13')
                                                    ? 'A/R Invoice'
                                                    : filtervalue[i]
                                                            .ObjType
                                                            .toString()
                                                            .contains('23')
                                                        ? 'Sales Quotation'
                                                        : filtervalue[i]
                                                                .ObjType
                                                                .toString()
                                                                .contains('17')
                                                            ? 'Sales Order'
                                                            : filtervalue[i]
                                                                    .ObjType
                                                                    .toString()
                                                                    .contains(
                                                                        '14')
                                                                ? 'Sales Return'
                                                                : filtervalue[i]
                                                                        .ObjType
                                                                        .toString()
                                                                        .contains(
                                                                            '15')
                                                                    ? 'Deliveries'
                                                                    : '',
                                                //"Request for "+filtervalue![i].ObjType .toString(),
                                                style:
                                                    TextStyles.boldPC1(context),
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  Screens.width(context) * 0.7,
                                              // color: Colors.red,
                                              child: Text(
                                                "From: ${filtervalue[i].FromUser}",
                                                style:
                                                    TextStyles.bodytextBlack1(
                                                        context),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: Screens.width(context) * 0.06,
                                          //color: Colors.red,

                                          child: Icon(
                                            Icons.chevron_right_outlined,
                                            size: Screens.width(context) * 0.1,
                                            color: theme.primaryColor,
                                          ),
                                        )
                                        //   SizedBox(width: Screens.width(context) * 0.05),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: Screens.width(context) * 0.6,
                                          // color: Colors.red,
                                          child: Text(
                                            "${filtervalue[i].cardName}",
                                            style: TextStyles.bodytextBlack1(
                                                context),
                                          ),
                                        ),
                                        // SizedBox(width: Screens.width(context) * 0.1),
                                        Container(
                                          child: Text(
                                            "${filtervalue[i].createDate}",
                                            style: TextStyles.bodytextBlack1(
                                                context),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
