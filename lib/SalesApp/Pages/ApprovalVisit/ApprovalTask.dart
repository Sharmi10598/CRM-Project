// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_lambdas, prefer_single_quotes, unawaited_futures, avoid_unnecessary_containers, require_trailing_commas, prefer_if_elements_to_conditional_expressions, unused_local_variable, prefer_final_locals, omit_local_variable_types, unnecessary_new

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_bundle/SalesApp/Api/GetActiviesApi/GetActivitiesApi.dart';
import 'package:ultimate_bundle/SalesApp/Api/GetSaleEmpApi/GetSaleEmpApi.dart';
import 'package:ultimate_bundle/SalesApp/Api/UpdateVisit/ApproveVisit.dart';
import 'package:ultimate_bundle/SalesApp/Api/UpdateVisit/RejectVisit.dart';
import 'package:ultimate_bundle/SalesApp/Model/GetActivities/GetActivitieModel.dart';
import 'package:ultimate_bundle/SalesApp/Model/GetSaleEmpModel/GetSaleEmpModel.dart';
import 'package:ultimate_bundle/SalesApp/Pages/ApprovalVisit/Widget/ApprovalDialog.dart';
import 'package:ultimate_bundle/SalesApp/Pages/ApprovalVisit/Widget/RejectDialog.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/uikit_model.dart';
import 'package:ultimate_bundle/src/furney/src/Api/Notification/NotificationApi.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/SalesAppBar.dart';

class ApprovalTask extends StatefulWidget {
  const ApprovalTask({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  State<ApprovalTask> createState() => _ApprovalTaskState();
}

class _ApprovalTaskState extends State<ApprovalTask> {
  @override
  void initState() {
    super.initState();
    callSaleEmp();
  }

  bool loadinapi = true;
  String apiError = '';
  List<GetSalesEmpData> purposeData = [];
  bool loadinapi2 = false;
  String apiError2 = '';
  List<GetActivitiesData> activitiesData = [];
  Future<void> callSaleEmp() async {
    loadinapi = true;
    setState(() {});
    GetSaleEmpAPi.getGlobalData().then((value) {
      loadinapi = false;
      setState(() {});
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.purposeData != null) {
          purposeData = value.purposeData!;
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
    loadinapi2 = true;
    setState(() {});
    GetActivitiesAPi.getGlobalData(slpcode).then((value) {
      loadinapi2 = false;
      setState(() {});
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.activitiesData != null) {
          activitiesData = value.activitiesData!;
        } else {
          apiError2 = value.error!;
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        apiError2 = value.error!;
      } else {
        apiError2 = value.error!;
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
        // child:
        Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomInset: false,
            drawer:
                // GetValues.userRoll == '3' ? drawer2(context) :
                drawer(context),
            appBar: salesappBar(context, _scaffoldKey, widget.title),
            body: loadinapi == true && apiError.isEmpty && isallclicked == false
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : loadinapi == true && apiError.isEmpty && isallclicked == false
                    ? Center(
                        child: Text(apiError),
                      )
                    : Container(
                        width: Screens.width(context),
                        height: Screens.heigth(context),
                        padding: EdgeInsets.symmetric(
                            vertical: Screens.heigth(context) * 0.01,
                            horizontal: Screens.width(context) * 0.02),
                        child: Stack(
                          children: [
                            Column(
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
                                        validator: (value) => value == null
                                            ? 'field required'
                                            : null,
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
                                                  child: Text(
                                                      e.slpname.toString())));
                                        }).toList(),
                                        hint: Text("Select Sales person",
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: theme.primaryColor)),
                                        onChanged: (String? value) {
                                          setState(() {
                                            activitiesData.clear();
                                            apiError2 = '';
                                            codeValue = value;
                                            callGetActivities(
                                                codeValue.toString());
                                            print("sleect code: $codeValue");
                                          });
                                        }),
                                  ),
                                ),
                                SizedBox(
                                  height: Screens.heigth(context) * 0.01,
                                ),
                                SizedBox(
                                  height: Screens.heigth(context) * 0.01,
                                ),
                                (activitiesData.isEmpty &&
                                        loadinapi2 == true &&
                                        apiError2.isEmpty)
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : (activitiesData.isEmpty &&
                                            loadinapi2 == false &&
                                            apiError2.isNotEmpty)
                                        ? Center(
                                            child: Text(apiError2),
                                          )
                                        : Expanded(
                                            child: ListView.builder(
                                              itemCount: activitiesData.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return InkWell(
                                                  onTap: () {
                                                    showDialogDeials(
                                                        theme, index);
                                                  },
                                                  child: Card(
                                                    child: Container(
                                                      width: Screens.width(
                                                          context),
                                                      margin: EdgeInsets.symmetric(
                                                          vertical:
                                                              Screens.heigth(
                                                                      context) *
                                                                  0.01),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical:
                                                            Screens.heigth(
                                                                    context) *
                                                                0.01,
                                                        horizontal:
                                                            Screens.width(
                                                                    context) *
                                                                0.02,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            width: Screens.width(
                                                                    context) *
                                                                0.6,
                                                            //color: Colors.red,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  child: Text(
                                                                      '${activitiesData[index].cardCode}'),
                                                                ),
                                                                Container(
                                                                  child: Text(
                                                                      '${activitiesData[index].cardName}'),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              print('datta');
                                                              showDialog<void>(
                                                                  context:
                                                                      context,
                                                                  builder: (_) {
                                                                    return MyApprovalDialog(
                                                                      clgcode: activitiesData[
                                                                              index]
                                                                          .clgCode,
                                                                      activiti:
                                                                          activitiesData[
                                                                              index],
                                                                    );
                                                                  }).then((value) {
                                                                loadinapi2 =
                                                                    false;
                                                                apiError2 = '';
                                                                activitiesData
                                                                    .clear();
                                                                callGetActivities(
                                                                    codeValue!);
                                                              });
                                                              // showDialog(theme);
                                                            },
                                                            child: Container(
                                                                width: Screens.width(
                                                                        context) *
                                                                    0.14,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .green),
                                                                child: Icon(
                                                                  Icons
                                                                      .thumb_up,
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              showDialog<void>(
                                                                  context:
                                                                      context,
                                                                  builder: (_) {
                                                                    return RejectDialog(
                                                                      clgcode: activitiesData[
                                                                              index]
                                                                          .clgCode,
                                                                      activiti:
                                                                          activitiesData[
                                                                              index],
                                                                    );
                                                                  }).then((value) {
                                                                loadinapi2 =
                                                                    false;
                                                                apiError2 = '';
                                                                activitiesData
                                                                    .clear();
                                                                callGetActivities(
                                                                    codeValue!);
                                                              });
                                                            },
                                                            child: Container(
                                                                width: Screens.width(
                                                                        context) *
                                                                    0.14,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .red),
                                                                child: Icon(
                                                                  Icons
                                                                      .thumb_down,
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                activitiesData.isEmpty
                                    ? SizedBox()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                            SizedBox(
                                                width: Screens.width(context) *
                                                    0.4,
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      approveAll();
                                                    },
                                                    child:
                                                        Text('Approve All'))),
                                            SizedBox(
                                                width: Screens.width(context) *
                                                    0.4,
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      shorejectAllDialog();
                                                    },
                                                    child: Text('Reject All'))),
                                          ])
                              ],
                            ),
                            Visibility(
                              visible: isallclicked,
                              child: Container(
                                width: Screens.width(context),
                                height: Screens.heigth(context),
                                color: Colors.white38,
                                child:
                                    Center(child: CircularProgressIndicator()),
                              ),
                            )
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

    for (int i = 0; i < activitiesData.length; i++) {
      ApproveVisitModel aprv = new ApproveVisitModel(
          clgCode: activitiesData[i].clgCode!, status: 'A');
      await ApproveVisitAPi.getGlobalData(aprv).then((value) async {
        if (value.statusCode! >= 200 && value.statusCode! <= 210) {
          PushNotify push = new PushNotify(
              msg: 'Your ${activitiesData[i].cardName} visit Approved..!!',
              title: "Notification From Manager",
              to: activitiesData[i].fcmToken);
          await SendNotifiationAPi.getGlobalData(push).then((valueNot) {
            if (valueNot.statusCode! >= 200 && valueNot.statusCode != 210) {
              setState(() {
                success = success + 1;
              });
            } else {}
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

    if (success == activitiesData.length) {
      setState(() => isallclicked = false);
      config.showDialogSucessDB("Sucessfullly Approved", "Success");
    } else {
      setState(() => isallclicked = false);
      config.showDialogSucessDB("Approved Partially", "Success");
    }
  }

  @override
  void dispose() {
    rejectAllCl.dispose();
    // TODO: implement dispose
    super.dispose();
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
    for (int i = 0; i < activitiesData.length; i++) {
      RejectVisitModel aprv = new RejectVisitModel(
          clgCode: activitiesData[i].clgCode!,
          status: 'R',
          remarks: rejectAllCl.text);
      await RejectVisitAPi.getGlobalData(aprv).then((value) async {
        if (value.statusCode! >= 200 && value.statusCode! <= 210) {
          PushNotify push = new PushNotify(
              msg: 'Your ${activitiesData[i].cardName} visit Rejected..!!',
              title: "Notification From Manager",
              to: activitiesData[i].fcmToken);
          await SendNotifiationAPi.getGlobalData(push).then((valueNot) {
            if (valueNot.statusCode! >= 200 && valueNot.statusCode != 210) {
              setState(() {
                success = success + 1;
              });
            } else {}
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

    if (success == activitiesData.length) {
      setState(() => isallclicked = false);
      config.showDialogSucessDB("Sucessfullly Approved", "Success");
    } else {
      setState(() => isallclicked = false);
      config.showDialogSucessDB("Approved Partially", "Success");
    }
  }
  //

  Configuration config = Configuration();

  void showDialogDeials(ThemeData theme, int ind) {
    Get.defaultDialog<dynamic>(
        // contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
        // insetPadding: EdgeInsets.all(10),
        content: SizedBox(
      width: Screens.width(context),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: Screens.width(context) * 0.35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text(
                          'CardCode',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.black),
                        )),
                        Container(
                            child: Text('${activitiesData[ind].cardCode}')),
                      ],
                    )),
                SizedBox(
                    width: Screens.width(context) * 0.35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                            child: Text(
                          'Date',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.black),
                        )),
                        Container(
                            child: Text(config.alignDate(
                                '${activitiesData[ind].uPlanDate}'))),
                      ],
                    )),
              ],
            ),
          ),
          SizedBox(
            height: Screens.heigth(context) * 0.01,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: Screens.width(context) * 0.35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text(
                          'CardName',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.black),
                        )),
                        Container(
                            child: Text('${activitiesData[ind].cardName}')),
                      ],
                    )),
                SizedBox(
                    width: Screens.width(context) * 0.35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                            child: Text(
                          'Time',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.black),
                        )),
                        Container(
                            child: Text('${activitiesData[ind].uPlanTime}')),
                      ],
                    )),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: Screens.width(context) * 0.35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text(
                          'Purpose',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.black),
                        )),
                        Container(
                            child: Text('${activitiesData[ind].purpose}')),
                      ],
                    )),
                SizedBox(
                    width: Screens.width(context) * 0.35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                            child: Text(
                          'SlpName',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.black),
                        )),
                        Container(
                            child: Text('${activitiesData[ind].slpName}')),
                      ],
                    )),
              ],
            ),
          ),
          SizedBox(
            height: Screens.heigth(context) * 0.01,
          ),
        ],
      ),
    ));
  }
}
