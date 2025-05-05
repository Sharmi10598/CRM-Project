// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_lambdas, prefer_single_quotes, unawaited_futures, avoid_unnecessary_containers, require_trailing_commas, prefer_if_elements_to_conditional_expressions, unused_local_variable, prefer_final_locals, omit_local_variable_types, unnecessary_new

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_bundle/SalesApp/Api/GetSaleEmpApi/GetSaleEmpApi.dart';
import 'package:ultimate_bundle/SalesApp/Api/LocationApi/LocationDetailsAPi.dart';
import 'package:ultimate_bundle/SalesApp/Api/UpdateVisit/ApproveVisit.dart';
import 'package:ultimate_bundle/SalesApp/Api/UpdateVisit/RejectVisit.dart';
import 'package:ultimate_bundle/SalesApp/Model/GetSaleEmpModel/GetSaleEmpModel.dart';
import 'package:ultimate_bundle/SalesApp/Model/LocationModel/LocationModel.dart';
import 'package:ultimate_bundle/SalesApp/Pages/LocationApproval/DetailsDialog.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/uikit_model.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/SalesAppBar.dart';

class LocationApproval extends StatefulWidget {
  const LocationApproval({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  State<LocationApproval> createState() => _LocationApprovalState();
}

class _LocationApprovalState extends State<LocationApproval> {
  @override
  void initState() {
    super.initState();
    callSaleEmp();
  }

  bool loadinapi = true;
  String apiError = '';
  List<GetLocDetData> locationData = [];
  List<GetSalesEmpData> purposeData = [];
  bool loadinapi2 = false;
  String apiError2 = '';

  Future<void> callSaleEmp() async {
    loadinapi = true;
    setState(() {});
    GetSaleEmpAPi.getGlobalData().then((value) {
      loadinapi = false;
      setState(() {});
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.purposeData != null) {
          purposeData = value.purposeData!;
          log("purposeData llll ${purposeData.length}");
        } else {
          apiError = value.message!;
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        apiError = value.error!;
      } else {
        apiError = value.error!;
      }
      setState(() {});
    });
  }

  Future<void> callGetActivities(String slpcode) async {
    log('gggggggggg');
    loadinapi2 = true;
    setState(() {});
    GetLocationDetailsAPi.getGlobalData(slpcode).then((value) {
      loadinapi2 = false;
      setState(() {});
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.purposeData != null) {
          locationData = value.purposeData!;
          log("lenelenlenlenlen: ${locationData.length}");
        } else {
          apiError2 = value.message!;
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        apiError = value.error!;
      } else {
        apiError = value.error!;
      }
      setState(() {});
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? codeValue;

  Future<bool> onbackpress() {
    DateTime now = DateTime.now();
    Get.offAllNamed<dynamic>(FurneyRoutes.home);
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return
        // WillPopScope(
        //   onWillPop: onbackpress,
        //   child:
        Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomInset: false,
            drawer:
                // GetValues.userRoll == '3' ? drawer2(context) :
                drawer(context),
            appBar: salesappBar(context, _scaffoldKey, widget.title),
            body: loadinapi == true && apiError.isEmpty
                ? Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  )
                : loadinapi == true && apiError.isEmpty
                    ? Center(
                        child: Text(apiError),
                      )
                    : Container(
                        width: Screens.width(context),
                        height: Screens.heigth(context),
                        padding: EdgeInsets.symmetric(
                            vertical: Screens.heigth(context) * 0.01,
                            horizontal: Screens.width(context) * 0.02),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              height: Screens.heigth(context) * 0.10,
                              width: Screens.width(context),
                              color: Colors.grey[200],
                              child: SizedBox.expand(
                                child: DropdownButtonFormField<String>(
                                    validator: (value) =>
                                        value == null ? 'field required' : null,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                    icon: Icon(Icons.arrow_drop_down),
                                    value: codeValue,
                                    items: purposeData.map((e) {
                                      return DropdownMenuItem(
                                          // ignore: unnecessary_brace_in_string_interps
                                          value: "${e.slpcode}",
                                          child: Container(
                                              // height: Screens.bodyheight(context)*0.1,
                                              child:
                                                  Text(e.slpname.toString())));
                                    }).toList(),
                                    hint: Text("Select Sales person",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(
                                                color: theme.primaryColor)),
                                    onChanged: (String? value) async {
                                      setState(() {
                                        locationData.clear();
                                        apiError2 = '';
                                        codeValue = value;
                                      });
                                      await callGetActivities(
                                          codeValue.toString());
                                      print("sleect code: $codeValue");
                                      setState(() {});
                                    }),
                              ),
                            ),

                            SizedBox(
                              height: Screens.heigth(context) * 0.01,
                            ),

                            SizedBox(
                              height: Screens.heigth(context) * 0.01,
                            ),
                            (locationData.isEmpty &&
                                    loadinapi2 == true &&
                                    apiError2.isEmpty)
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : (locationData.isEmpty &&
                                        loadinapi2 == false &&
                                        apiError2.isNotEmpty)
                                    ? Center(
                                        child: Text(apiError2),
                                      )
                                    : Expanded(
                                        child: ListView.builder(
                                          itemCount: locationData.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              onTap: () {
                                                showDialog<void>(
                                                    context: context,
                                                    builder: (_) {
                                                      return LocationDialog(
                                                        getLocDetData:
                                                            locationData[index],
                                                      );
                                                    }).then((value) {
                                                  loadinapi2 = false;
                                                  apiError2 = '';
                                                  locationData.clear();
                                                  callGetActivities(codeValue!);
                                                });
                                              },
                                              child: Card(
                                                child: Container(
                                                  width: Screens.width(context),
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: Screens.heigth(
                                                              context) *
                                                          0.01),
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: Screens.heigth(
                                                            context) *
                                                        0.01,
                                                    horizontal:
                                                        Screens.width(context) *
                                                            0.02,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            child: Text(
                                                                '${locationData[index].CardCode}'),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                                '${locationData[index].CardName}'),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                            // locationData.isEmpty?
                            // SizedBox()
                            // :
                            //       Row(
                            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //         children
                            //         :[
                            //           Container(
                            //             width: Screens.width(context)*0.4,
                            //             child:ElevatedButton(onPressed: (){
                            //                   approveAll();
                            //             },
                            //              child: Text('Approve All'))
                            //           ),
                            //           Container(
                            //             width: Screens.width(context)*0.4,
                            //             child:ElevatedButton(onPressed: (){
                            //                shorejectAllDialog();
                            //             },
                            //              child: Text('Reject All'))
                            //           ),
                            //         ]
                            //       )
                          ],
                        ),
                      )
            // ),
            );
  }

  //// for ecreen frezed
  bool isallclicked = false;
  Future<void> approveAll() async {
    setState(() => isallclicked = true);
    int success = 0;
    for (int i = 0; i < locationData.length; i++) {
      ApproveVisitModel aprv =
          new ApproveVisitModel(clgCode: locationData[i].ClgCode!, status: 'A');
      await ApproveVisitAPi.getGlobalData(aprv).then((value) {
        if (value.statusCode! >= 200 && value.statusCode! <= 210) {
          setState(() {
            success = success + 1;
          });
        } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
          setState(() {
            success = success - 1;
          });
        } else {
          setState(() {
            success = success - 1;
          });
        }
      });
    }
    if (success == locationData.length) {
      setState(() => isallclicked = false);
      config.showDialogSucessDB("Sucessfullly Approved", "Success");
    } else {
      setState(() => isallclicked = false);
      config.showDialogSucessDB("Approved Partially", "Success");
    }
  }

  //
  TextEditingController rejectAllCl = new TextEditingController();
  Future<void> shorejectAllDialog() async {
    Get.defaultDialog<void>(
      title: "Reson for Rejection",
      content: Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .primaryColor
                    .withOpacity(0.1), //Colors.grey[200],
                borderRadius:
                    BorderRadius.circular(Screens.width(context) * 0.02),
              ),
              child: TextFormField(
                controller: rejectAllCl,
                maxLines: 3,
                autocorrect: false,
                onChanged: (v) {},
                decoration: InputDecoration(
                  filled: false,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 5,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    rejectAll();
                  },
                  child: Text("Ok"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> rejectAll() async {
    setState(() => isallclicked = true);
    int success = 0;
    for (int i = 0; i < locationData.length; i++) {
      RejectVisitModel aprv = new RejectVisitModel(
          clgCode: locationData[i].ClgCode!,
          status: 'R',
          remarks: rejectAllCl.text);
      await RejectVisitAPi.getGlobalData(aprv).then((value) {
        if (value.statusCode! >= 200 && value.statusCode! <= 210) {
          setState(() {
            success = success + 1;
          });
        } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
          setState(() {
            success = success - 1;
          });
        } else {
          setState(() {
            success = success - 1;
          });
        }
      });
    }

    if (success == locationData.length) {
      setState(() => isallclicked = false);
      config.showDialogSucessDB("Sucessfullly Approved", "Success");
    } else {
      setState(() => isallclicked = false);
      config.showDialogSucessDB("Approved Partially", "Success");
    }
  }
  //

  Configuration config = Configuration();

  // void showDialogDeials(ThemeData theme,int ind) {
  //   Get.defaultDialog<dynamic>(
  //    // contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
  //     // insetPadding: EdgeInsets.all(10),
  //       content: SizedBox(
  //     width: Screens.width(context),
  //     child: Column(
  //       children: [
  //         Container(
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Container(
  //                      width: Screens.width(context)*0.35,
  //                 child:
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Container(child: Text('CardCode',
  //                   style: theme.textTheme.bodyText2?.copyWith(
  //                     color: Colors.black
  //                   ),
  //                   )),
  //                    Container(child: Text('${locationData[ind].CardCode}')),
  //                 ],
  //               )),
  //                Container(
  //                      width: Screens.width(context)*0.35,
  //                 child:
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   Container(child: Text('Date',
  //                   style: theme.textTheme.bodyText2?.copyWith(
  //                     color: Colors.black
  //                   ),)),
  //                    Container(child: Text(config.alignDate('${locationData[ind].U_PlanDate}'))),
  //                 ],
  //               )),
  //             ],
  //           ),
  //         ),
  //         SizedBox(
  //           height: Screens.heigth(context) * 0.01,
  //         ),
  //          Container(
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Container(
  //                      width: Screens.width(context)*0.35,
  //                 child:
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Container(
  //                     child: Text('CardName',
  //                   style: theme.textTheme.bodyText2?.copyWith(
  //                     color: Colors.black
  //                   ),)),
  //                    Container(
  //                     child: Text('${locationData[ind].CardName}')),
  //                 ],
  //               )),
  //               Container(
  //                      width: Screens.width(context)*0.35,
  //                 child:
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   Container(
  //                     child: Text('Time',style: theme.textTheme.bodyText2?.copyWith(
  //                     color: Colors.black
  //                   ),)),
  //                    Container(
  //                     child: Text('${locationData[ind].U_PlanDate}')),
  //                 ],
  //               )),
  //             ],
  //           ),
  //         ),
  //           Container(
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //                Container(
  //                      width: Screens.width(context)*0.35,
  //                 child:
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Container(
  //                     child: Text('Purpose',style: theme.textTheme.bodyText2?.copyWith(
  //                     color: Colors.black
  //                   ),)),
  //                    Container(
  //                     child: Text('${locationData[ind].Purpose}')),
  //                 ],
  //               )),
  //                Container(
  //                     width: Screens.width(context)*0.35,
  //                 child:
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   Container(
  //                     child: Text('SlpName',style: theme.textTheme.bodyText2?.copyWith(
  //                     color: Colors.black
  //                   ),)),
  //                    Container(
  //                     child: Text(
  //                      '', //'${locationData[ind].}'
  //                       )),
  //                 ],
  //               )),
  //             ],
  //           ),
  //         ),
  //         SizedBox(
  //           height: Screens.heigth(context) * 0.01,
  //         ),
  //       ],
  //     ),
  //   ));
  // }
}
