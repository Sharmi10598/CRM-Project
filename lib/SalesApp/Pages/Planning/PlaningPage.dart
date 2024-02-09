// ignore_for_file: require_trailing_commas, eol_at_end_of_file, prefer_const_literals_to_create_immutables, prefer_single_quotes, prefer_const_constructors, unawaited_futures, unused_local_variable, prefer_final_locals, omit_local_variable_types, unnecessary_new

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:ultimate_bundle/SalesApp/Api/VistListApi/VisitListApi.dart';
import 'package:ultimate_bundle/SalesApp/Model/VistListModel/VisitListModel.dart';
import 'package:ultimate_bundle/SalesApp/Pages/Planning/CreateVisit.dart';
import 'package:ultimate_bundle/SalesApp/Pages/Planning/UnplannedVisit.dart';
import 'package:ultimate_bundle/SalesApp/Pages/Planning/UpdatePlan.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/uikit_model.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sign_in/widgets/custom_elevatedBtn.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/SalesAppBar.dart';

class PlanningPage extends StatefulWidget {
  const PlanningPage({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  State<PlanningPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<PlanningPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Config config = new Config();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        drawer: drawer(context),
        appBar: salesappBar(context, _scaffoldKey, widget.title),
        body: Container(
          width: Screens.width(context),
          height: Screens.heigth(context),
          padding: EdgeInsets.symmetric(
              vertical: Screens.heigth(context) * 0.01,
              horizontal: Screens.width(context) * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Screens.width(context),
                // height: ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showDate(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Screens.width(context) * 0.01),
                        width: Screens.width(context) * 0.55,
                        //  color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                child: Text(
                              selectedDate.isEmpty
                                  ? 'Select date'
                                  : selectedDate,
                              style: TextStyle(
                                  color: selectedDate.isEmpty
                                      ? Colors.grey
                                      : Colors.black),
                            )),
                            Container(
                                child: Icon(
                              Icons.calendar_month,
                              color: theme.primaryColor,
                            )),
                          ],
                        ),
                      ),
                    ),
                    // Container(
                    //     width: Screens.width(context) * 0.13,
                    //     padding: EdgeInsets.all(5),
                    //     decoration: BoxDecoration(
                    //       color: theme.primaryColor,
                    //       borderRadius: BorderRadius.all(Radius.circular(5)),
                    //     ),
                    //     child: Icon(
                    //       Icons.account_box_outlined,
                    //       color: Colors.white,
                    //     )),
                    // Container(
                    //     width: Screens.width(context) * 0.13,
                    //     child: Icon(Icons.search)),
                    // InkWell(
                    //   onTap: () {
                    //     Get.toNamed<dynamic>(FurneyRoutes.approvalTask);
                    //   },
                    //   child: Container(
                    //       width: Screens.width(context) * 0.13,
                    //       child: Icon(Icons.add)),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.7,
                child: (listLoading == true &&
                        listLoadingMsg.isEmpty &&
                        purposeData!.isEmpty)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : (listLoading == false &&
                            listLoadingMsg.isNotEmpty &&
                            purposeData!.isEmpty)
                        ? Center(child: Text(listLoadingMsg))
                        : SingleChildScrollView(
                            child: Wrap(
                                children: listTimeLine(theme)),
                          ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Screens.width(context)*0.45,
                    child: CustomSpinkitdButton(
                      onTap: () {
                        CreateVisitPageState.date = selectedDate;
                        if (selectedDate.isNotEmpty) {
                          Get.toNamed<void>(FurneyRoutes.createVisitPage)!
                              .then((value) {
                            listLoading = true;
                            listLoadingMsg = '';
                            purposeData!.clear();
                            setState(() {});
                            callVisitListApi(apiDate);
                          });
                        } else {
                          config.showDialog("Choose Date..!!", "Alert");
                        }
                      },
                      label: 'Create Visit Task',
                    ),
                  ),

                    SizedBox(
                       width: Screens.width(context)*0.45,
                    child: CustomSpinkitdButton(
                      onTap: () {
                        UnplannedVisitPageState.date = selectedDate;
                        if (selectedDate.isNotEmpty) {
                          Get.toNamed<void>(FurneyRoutes.unplannedVisit)!
                              .then((value) {
                            listLoading = true;
                            listLoadingMsg = '';
                            purposeData!.clear();
                            setState(() {});
                            callVisitListApi(apiDate);
                          });
                        } else {
                          config.showDialog("Choose Date..!!", "Alert");
                        }
                      },
                      label: 'Unplanned Visit',
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  ///
  ///
  String selectedDate = '';
  String apiDate = '';
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
        selectedDate = value.toString();
        var date = DateTime.parse(selectedDate);
        selectedDate = '';
        selectedDate =
            "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().padLeft(2, '0')}";

        apiDate =
            "${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}";
        callVisitListApi(apiDate);
      });
    });
  }

  bool listLoading = false;
  String listLoadingMsg = '';
  List<GetVisitListData>? purposeData = [];
  Future<void> callVisitListApi(String date) async {
    listLoading = true;
    listLoadingMsg = '';
    purposeData!.clear();
    setState(() {});
    await GetVisitListAPi.getGlobalData(date).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        listLoading = false;
        setState(() {});
        if (value.purposeData != null) {
          listLoadingMsg = '';
          purposeData = value.purposeData;
        } else {
          listLoadingMsg = value.message!;
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        listLoading = false;
        listLoadingMsg = value.error!;
        setState(() {});
      } else {
        listLoading = false;
        listLoadingMsg = value.error!;
        setState(() {});
      }
    });
  }

  // List<Data> timeLine = [
  //   Data(
  //       data1: 'Now Product Discussion',
  //       title: 'BOA VIDA',
  //       data2: 'Molding with manager'),
  //   Data(
  //       data1: 'New Product Discussion on',
  //       title: 'TANZANIA HOMES',
  //       data2: 'Molding with manager'),
  //   Data(
  //       data1: 'Now Product Discussion',
  //       title: 'BOA VIDA',
  //       data2: 'Molding with manager'),
  //   Data(
  //       data1: 'New Product Discussion on',
  //       title: 'TANZANIA HOMES',
  //       data2: 'Molding with manager'),
  //   Data(
  //       data1: 'Now Product Discussion',
  //       title: 'BOA VIDA',
  //       data2: 'Molding with manager'),
  //   Data(
  //       data1: 'New Product Discussion on',
  //       title: 'TANZANIA HOMES',
  //       data2: 'Molding with manager'),
  //   Data(
  //       data1: 'Now Product Discussion',
  //       title: 'BOA VIDA',
  //       data2: 'Molding with manager'),
  //   Data(
  //       data1: 'New Product Discussion on',
  //       title: 'TANZANIA HOMES',
  //       data2: 'Molding with manager'),
  // ];

  List<Widget> listTimeLine(
    ThemeData theme,
  ) {
    return List.generate(purposeData!.length, (index) {
      if (index == 0) {
        //  log("1");
        return Column(
          children: [
            TimelineTile(
              lineXY: 0.2,
              isFirst: true,
              indicatorStyle: IndicatorStyle(
                width: 10,
                color: theme.primaryColor,
                indicatorXY: 0.2,
                padding: EdgeInsets.only(
                  top: 4,
                  left: 4,
                  right: 4,
                ),
                // iconStyle: IconStyle(
                //   color: Colors.white,
                //   iconData:Icons.store,
                // ),
              ),
              beforeLineStyle: const LineStyle(
                thickness: 3,
              ),
              afterLineStyle: const LineStyle(
                thickness: 3,
              ),
              endChild: InkWell(
                onTap: (){
                  log("datatattatabjksdhsjkdhs");
              if (selectedDate.isNotEmpty) {
                 UpdateVisitPageState.clgcode = purposeData![index].ClgCode!;
                UpdateVisitPageState.cardcode = purposeData![index].CardCode!;
                UpdateVisitPageState.cardname = purposeData![index].CardName!;
                UpdateVisitPageState.codeValue = purposeData![index].CntctSbjct!;
                UpdateVisitPageState.date =selectedDate;
                UpdateVisitPageState.time = purposeData![index].plannedTime;
                UpdateVisitPageState.datechosed = purposeData![index].plannedDate!;
                UpdateVisitPageState.details = purposeData![index].Details!;
                      Get.toNamed<void>(FurneyRoutes.updatePlan)!
                          .then((value) {
                        listLoading = true;
                        listLoadingMsg = '';
                        purposeData!.clear();
                        setState(() {});
                        callVisitListApi(apiDate);
                      });
                    } else {
                      config.showDialog("Choose Date..!!", "Alert");
                    }
                },
                child: Container(
                  color: purposeData![index].VisitStatus.toString()
                  .toLowerCase().contains('up')
                      ? Color.fromARGB(255, 255, 212, 118)
                      : purposeData![index].VisitStatus.toString()
                  .toLowerCase().contains('not')
                          ? Colors.pink.shade300
                          : purposeData![index].VisitStatus.toString()
                  .toLowerCase().contains('comple') 
                              ? Colors.green.shade300
                              : Colors.grey[200],
                  alignment: Alignment.centerLeft,
                  width: Screens.width(context) * 0.6,
                  padding: EdgeInsets.symmetric(
                      vertical: Screens.heigth(context) * 0.01,
                      horizontal: Screens.width(context) * 0.02),
                  margin: EdgeInsets.symmetric(
                      vertical: Screens.heigth(context) * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Screens.width(context) * 0.63,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${purposeData![index].CardName} ",
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Screens.heigth(context) * 0.01,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${purposeData![index].Name} ",
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                            SizedBox(
                              height: Screens.heigth(context) * 0.01,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  purposeData![index].LastVisit.toString() == 'null'?'':
                                "${purposeData![index].Details} ",
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                             SizedBox(
                              height: Screens.heigth(context) * 0.01,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                               purposeData![index].LastVisit.toString() == 'null'?'':
                              config.alignDate("${purposeData![index].LastVisit}"),
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Screens.width(context) * 0.2,
                            child: Image.asset("assets/CRM/inltd.jpeg"),
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "Status: ${purposeData![index].U_Status} ",
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              //  startChild:
              //   Container(
              //       padding:EdgeInsets.only
              //   (
              //     left: Screens.width(context)*0.02,
              //     right: Screens.width(context)*0.02
              //   ),
              //    // alignment:Alignment.centerRight,
              //          // color: Colors.blue,
              //           width: Screens.width(context) * 0.25,
              //           child: Column(
              //             children: [
              //               Text(
              //               "dfv",

              //                     textAlign:TextAlign.center,
              //                 style: theme.textTheme.bodyText2,
              //               ),
              //             ],
              //           )),
            ),
          ],
        );
      } else if (index == purposeData!.length - 1) {
        //log("2");
        return Column(
          children: [
            TimelineTile(
              isLast: true,
              lineXY: 0.2,
              indicatorStyle: IndicatorStyle(
                width: 10,
                color: theme.primaryColor,
                // indicatorXY: 0.7,
                padding: EdgeInsets.all(4),
                //    iconStyle: IconStyle(
                //   color: Colors.white,
                //   iconData:Icons.chat,
                // ),
              ),
              beforeLineStyle: const LineStyle(
                thickness: 3,
              ),
              afterLineStyle: const LineStyle(
                thickness: 3,
              ),

              endChild: InkWell(
                onTap: (){
                  log("datatattatabjksdhsjkdhs");
              if (selectedDate.isNotEmpty) {
                 UpdateVisitPageState.clgcode = purposeData![index].ClgCode!;
                 UpdateVisitPageState.cardcode = purposeData![index].CardCode!;
                UpdateVisitPageState.cardname = purposeData![index].CardName!;
                UpdateVisitPageState.codeValue = purposeData![index].CntctSbjct!;
                UpdateVisitPageState.date =selectedDate;
                UpdateVisitPageState.time = purposeData![index].plannedTime;
                UpdateVisitPageState.datechosed = purposeData![index].plannedDate!;
                UpdateVisitPageState.details = purposeData![index].Details!;

                      Get.toNamed<void>(FurneyRoutes.updatePlan)!
                          .then((value) {
                        listLoading = true;
                        listLoadingMsg = '';
                        purposeData!.clear();
                        setState(() {});
                        callVisitListApi(apiDate);
                      });
                    } else {
                      config.showDialog("Choose Date..!!", "Alert");
                    }
                },
                child: Container(
                 color: purposeData![index].VisitStatus.toString()
                  .toLowerCase().contains('up')
                      ? Color.fromARGB(255, 255, 212, 118)
                      : purposeData![index].VisitStatus.toString()
                  .toLowerCase().contains('not')
                          ? Colors.pink.shade300
                          : purposeData![index].VisitStatus.toString()
                  .toLowerCase().contains('comple') 
                              ? Colors.green.shade300
                              : Colors.grey[200],
                  alignment: Alignment.centerLeft,
                  width: Screens.width(context) * 0.6,
                  padding: EdgeInsets.symmetric(
                      vertical: Screens.heigth(context) * 0.01,
                      horizontal: Screens.width(context) * 0.02),
                  margin: EdgeInsets.symmetric(
                      vertical: Screens.heigth(context) * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Screens.width(context) * 0.63,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${purposeData![index].CardName} ",
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Screens.heigth(context) * 0.01,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${purposeData![index].Name} ",
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                            SizedBox(
                              height: Screens.heigth(context) * 0.01,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  purposeData![index].LastVisit.toString() == 'null'?'': 
                                "${purposeData![index].Details} ",
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                              SizedBox(
                              height: Screens.heigth(context) * 0.01,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  purposeData![index].LastVisit.toString() == 'null'?'':
                              config.alignDate("${purposeData![index].LastVisit}"),
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Screens.width(context) * 0.2,
                            child: Image.asset("assets/CRM/inltd.jpeg"),
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "Status: ${purposeData![index].U_Status} ",
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              //  startChild:
              //   Container(
              //       padding:EdgeInsets.only
              //   (
              //     left: Screens.width(context)*0.02,
              //     right: Screens.width(context)*0.02
              //   ),
              //    // alignment:Alignment.centerRight,
              //          // color: Colors.blue,
              //           width: Screens.width(context) * 0.25,
              //           child: Column(
              //             children: [
              //               Text(
              //               "dfv",

              //                     textAlign:TextAlign.center,
              //                 style: theme.textTheme.bodyText2,
              //               ),
              //             ],
              //           )),
            ),
          ],
        );
      } else {
        // log("3");
        return Column(
          children: [
            TimelineTile(
              lineXY: 0.2,
              indicatorStyle: IndicatorStyle(
                width: 10,
                color: theme.primaryColor,
                //   indicatorXY:  0.7,
                padding: EdgeInsets.all(4),
                //   iconStyle: IconStyle(
                //   color: Colors.white,
                //   iconData:Icons.chat,
                // ),
              ),
              beforeLineStyle: const LineStyle(
                thickness: 3,
              ),
              afterLineStyle: const LineStyle(
                thickness: 3,
              ),
              endChild: InkWell(
                onTap: (){
                  log("datatattatabjksdhsjkdhs");
              if (selectedDate.isNotEmpty) {
                UpdateVisitPageState.clgcode = purposeData![index].ClgCode!;
                UpdateVisitPageState.cardcode = purposeData![index].CardCode!;
                UpdateVisitPageState.cardname = purposeData![index].CardName!;
                UpdateVisitPageState.codeValue = purposeData![index].CntctSbjct!;
                UpdateVisitPageState.date =selectedDate;
                UpdateVisitPageState.time = purposeData![index].plannedTime;
                UpdateVisitPageState.datechosed = purposeData![index].plannedDate!;
                UpdateVisitPageState.details = purposeData![index].Details!; 

                      Get.toNamed<void>(FurneyRoutes.updatePlan)!
                          .then((value) {
                        listLoading = true;
                        listLoadingMsg = '';
                        purposeData!.clear();
                        setState(() {});
                        callVisitListApi(apiDate);
                      });
                    } else {
                      config.showDialog("Choose Date..!!", "Alert");
                    }
                },
                child: Container(
                 color: purposeData![index].VisitStatus.toString()
                  .toLowerCase().contains('up')
                      ? Color.fromARGB(255, 255, 212, 118)
                      : purposeData![index].VisitStatus.toString()
                  .toLowerCase().contains('not')
                          ? Colors.pink.shade300
                          : purposeData![index].VisitStatus.toString()
                  .toLowerCase().contains('comple') 
                              ? Colors.green.shade300
                              : Colors.grey[200],
                  alignment: Alignment.centerLeft,
                  width: Screens.width(context) * 0.6,
                  padding: EdgeInsets.symmetric(
                      vertical: Screens.heigth(context) * 0.01,
                      horizontal: Screens.width(context) * 0.02),
                  margin: EdgeInsets.symmetric(
                      vertical: Screens.heigth(context) * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Screens.width(context) * 0.63,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${purposeData![index].CardName} ",
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Screens.heigth(context) * 0.01,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${purposeData![index].Name} ",
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                            SizedBox(
                              height: Screens.heigth(context) * 0.01,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  purposeData![index].LastVisit.toString() == 'null'?'':
                                "${purposeData![index].Details} ",
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                              SizedBox(
                              height: Screens.heigth(context) * 0.01,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  purposeData![index].LastVisit.toString() == 'null'?'':
                              config.alignDate("${purposeData![index].LastVisit}"),
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Screens.width(context) * 0.2,
                            child: Image.asset("assets/CRM/inltd.jpeg"),
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "Status: ${purposeData![index].U_Status} ",
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              //  startChild:
              //   Container(
              //       padding:EdgeInsets.only
              //   (
              //     left: Screens.width(context)*0.02,
              //     right: Screens.width(context)*0.02
              //   ),
              //    // alignment:Alignment.centerRight,
              //          // color: Colors.blue,
              //           width: Screens.width(context) * 0.25,
              //           child: Column(
              //             children: [
              //               Text(
              //               "dfv",

              //                     textAlign:TextAlign.center,
              //                 style: theme.textTheme.bodyText2,
              //               ),
              //             ],
              //           )),
            ),
          ],
        );
      }
    });
  }
}

class Data {
  String title;
  String data1;
  String data2;

  Data({
    required this.title,
    required this.data1,
    required this.data2,
  });
}
