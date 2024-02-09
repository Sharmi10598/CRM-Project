// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, unnecessary_const, prefer_is_empty, omit_local_variable_types, require_trailing_commas, prefer_const_constructors, unawaited_futures, prefer_single_quotes, unnecessary_string_interpolations, prefer_final_locals, prefer_if_elements_to_conditional_expressions

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ultimate_bundle/SalesApp/Api/GetSaleEmpIDApi/SalesEmpIDApi.dart';
import 'package:ultimate_bundle/SalesApp/Model/GetSaleEmpIDModel/GetSalesEmpIDModel.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/Reportapi/ReportApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/Reportapi/reportExcelApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/netPendingOrderApi/NetPendingExcel.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/netPendingOrderApi/NetPendingOrder.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/salesInDayApi/salesInDayApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/salesInDayApi/salesinDayExcelapi.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/item_modal/mainsubModal/mainModal.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/item_modal/mainsubModal/subModal.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/stock_item_modal.dart/stock_item_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class Reports extends StatefulWidget {
  const Reports({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  SReportsState createState() => SReportsState();
}

class SReportsState extends State<Reports> {
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  List<StockValue> stock = [];
  List<StockValue> stockFilter = [];
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    callSaleEmp();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    // setState(() {
      isLoading = false;
    // });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  List<GetSalesEmpData> purposeData = [];
  Future<void> callSaleEmp() async {
    setState(() {});
    GetSaleEmpIDAPi.getGlobalData().then((value) {
      // loadinapi = false;
      setState(() {});
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.purposeData != null) {
          setState(() {
            purposeData = value.purposeData!;
          });

          log("DATTA::" + purposeData.length.toString());
        } else {
          // apiError = value.message!;
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        // apiError = value.error!;
      } else {
        // apiError = value.error!;
      }
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      drawer: drawer(context),
      key: _scaffoldKey,
      appBar: appBar(context, _scaffoldKey, widget.title),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: Screens.width(context),
                  decoration: const BoxDecoration(),
                  padding: EdgeInsets.only(
                    top: Screens.heigth(context) * 0.005,
                    bottom: Screens.heigth(context) * 0.005,
                    left: Screens.width(context) * 0.04,
                    right: Screens.width(context) * 0.04,
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          isFromSalesinDay = true;
                          mycontroller[1].clear();
                          mycontroller[2].clear();
                          bottomSheet(theme);
                        },
                        child: Card(
                          child: Container(
                            alignment: Alignment.center,
                            height: Screens.heigth(context) * 0.1,
                            width: Screens.width(context) * 0.9,
                            // color: Colors.greenAccent,
                            child: Text(
                              'Sales in day', //stockFilter[i].itemCode .toString(),
                              style: TextStyles.boldPC1(context),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          mycontroller[1].clear();
                          mycontroller[2].clear();
                          bottomSheet(theme);
                        },
                        child: Card(
                          child: Container(
                            alignment: Alignment.center,
                            height: Screens.heigth(context) * 0.1,
                            width: Screens.width(context) * 0.9,
                            //    color: Colors.greenAccent,
                            child: Text(
                              'Net Pending Order', //stockFilter[i].itemCode .toString(),
                              style: TextStyles.boldPC1(context),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          mycontroller[3].clear();
                          mycontroller[4].clear();
                          valueChosedStatusWon = null;
                          valuechose = false;
                          bottomVisitSheet(theme, 'visit');
                        },
                        child: Card(
                          child: Container(
                            alignment: Alignment.center,
                            height: Screens.heigth(context) * 0.1,
                            width: Screens.width(context) * 0.9,
                            //    color: Colors.greenAccent,
                            child: Text(
                              'Visit Log Report', //stockFilter[i].itemCode .toString(),
                              style: TextStyles.boldPC1(context),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          mycontroller[3].clear();
                          mycontroller[4].clear();
                          valueChosedStatusWon = null;
                          valuechose = false;
                          bottomVisitSheet(theme, 'sc');
                        },
                        child: Card(
                          child: Container(
                            alignment: Alignment.center,
                            height: Screens.heigth(context) * 0.1,
                            width: Screens.width(context) * 0.9,
                            //    color: Colors.greenAccent,
                            child: Text(
                              'Schedule Report', //stockFilter[i].itemCode .toString(),
                              style: TextStyles.boldPC1(context),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          mycontroller[3].clear();
                          mycontroller[4].clear();
                          valueChosedStatusWon = null;
                          valuechose = false;
                          bottomVisitSheet(theme, 'AdheranceOld');
                        },
                        child: Card(
                          child: Container(
                            alignment: Alignment.center,
                            height: Screens.heigth(context) * 0.1,
                            width: Screens.width(context) * 0.9,
                            //    color: Colors.greenAccent,
                            child: Text(
                              'Adherence Report', //stockFilter[i].itemCode .toString(),
                              style: TextStyles.boldPC1(context),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          mycontroller[3].clear();
                          mycontroller[4].clear();
                          valueChosedStatusWon = null;
                          valuechose = false;
                          bottomVisitSheet(theme, 'Adherance');
                        },
                        child: Card(
                          child: Container(
                            alignment: Alignment.center,
                            height: Screens.heigth(context) * 0.1,
                            width: Screens.width(context) * 0.9,
                            //    color: Colors.greenAccent,
                            child: Text(
                              'Adherence Report Emp-wise', //stockFilter[i].itemCode .toString(),
                              style: TextStyles.boldPC1(context),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          mycontroller[3].clear();
                          mycontroller[4].clear();
                          valueChosedStatusWon = null;
                          valuechose = false;
                          bottomVisitSheet(theme, 'Activity');
                        },
                        child: Card(
                          child: Container(
                            alignment: Alignment.center,
                            height: Screens.heigth(context) * 0.1,
                            width: Screens.width(context) * 0.9,
                            child: Text(
                              'Activity Report',
                              style: TextStyles.boldPC1(context),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          mycontroller[3].clear();
                          mycontroller[4].clear();
                          valueChosedStatusWon = null;
                          valuechose = false;
                          bottomVisitSheet(theme, 'Corporate');
                        },
                        child: Card(
                          child: Container(
                            alignment: Alignment.center,
                            height: Screens.heigth(context) * 0.1,
                            width: Screens.width(context) * 0.9,
                            child: Text(
                              'Corporate Report',
                              style: TextStyles.boldPC1(context),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          mycontroller[3].clear();
                          mycontroller[4].clear();
                          valueChosedStatusWon = null;
                          valuechose = false;
                          bottomVisitSheet(theme, 'VisitCount');
                        },
                        child: Card(
                          child: Container(
                            alignment: Alignment.center,
                            height: Screens.heigth(context) * 0.1,
                            width: Screens.width(context) * 0.9,
                            child: Text(
                              'Visit Count Report',
                              style: TextStyles.boldPC1(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: isLoading,
            child: Container(
              width: Screens.width(context),
              height: Screens.heigth(context),
              color: Colors.white60,
              child: Center(
                child: SpinKitThreeBounce(
                  size: Screens.heigth(context) * 0.06,
                  color: theme.primaryColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  static bool isLoading = false;
  bool isFromSalesinDay = false;
  List<GlobalKey<FormState>> formkey =
      List.generate(3, (i) => GlobalKey<FormState>());
  List<MainModalValue> mainValueValue = [];
  List<SubModalValue> subValueValue = [];

  void bottomSheet(ThemeData theme) {
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Stack(
                              children: [
                                SizedBox(
                                  child: TextFormField(
                                    onTap: () {
                                      showDate(context);
                                    },
                                    readOnly: true,
                                    controller: mycontroller[1],
                                    onChanged: (val) {},
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'ENTER FROM DATE';
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
                                      labelText: 'Choose from date',
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
                                  child: TextFormField(
                                    onTap: () {
                                      showToDate(context);
                                    },
                                    readOnly: true,
                                    controller: mycontroller[2],
                                    onChanged: (val) {},
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'ENTER TO DATE';
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
                                          // ignore: prefer_const_constructors
                                          Radius.circular(10),
                                        ),
                                      ),
                                      labelText: 'Choose to date',
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
                            SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    backgroundColor: theme.primaryColor,
                                  ),
                                  onPressed: showbottomsheetviewer,
                                  child: Text(
                                    "Search",
                                    style: TextStyles.whiteText(context),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ));
  }

  bool error = false;
  void errorMsg() {
    setState(() {
      error = true;
    });
  }

//visit log Report
  void visitlogbottomsheet(String methodName) {
    showModalBottomSheet<dynamic>(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (context, setState) => Container(
                height: 200,
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Column(
                  // mainAxisAlignment: Ma,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Do you want to open in? ",
                        style: TextStyle(fontSize: 20)),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              callVisitApi(methodName);
                            },
                            child: Text("PDF",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue))),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              callVisitExcelApi(methodName);
                            },
                            child: Text("Excel",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue)))
                      ],
                    )
                  ],
                ),
              )),
    );
  }

  void showbottomsheetviewer() {
    showModalBottomSheet<dynamic>(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (context, setState) => Container(
                height: 200,
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Column(
                  // mainAxisAlignment: Ma,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Do you want to open in? ",
                        style: TextStyle(fontSize: 20)),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              callApi();
                            },
                            child: Text("PDF",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue))),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              callexcelApi();
                            },
                            child: Text("Excel",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue)))
                      ],
                    )
                  ],
                ),
              )),
    );
  }

  Future<void> callexcelApi() async {
    if (formkey[0].currentState!.validate()) {
      if (isFromSalesinDay == true) {
        SalesOnDayExcelAPi.fromDate = apiFromDate;
        SalesOnDayExcelAPi.toDate = apiToDate;
        SalesOnDayExcelAPi.slpCode = GetValues.slpCode;
        // print("SalesOnDayAPi.slpCode: " + SalesOnDayExcelAPi.slpCode.toString());
        isFromSalesinDay = false;
        SalesOnDayExcelAPi.getGlobalData().then((value) {
          if (value == 200) {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
            showSnackBar('Try again!!..');
          }
        });
        Navigator.pop(context);
        setState(() {
          isLoading = true;
        });
      } else {
        NetPendingOrderExcelAPi.fromDate = apiFromDate;
        NetPendingOrderExcelAPi.toDate = apiToDate;
        NetPendingOrderExcelAPi.slpCode = GetValues.slpCode;
        print("SalesOnDayAPi.slpCode22: " +
            NetPendingOrderExcelAPi.slpCode.toString());
        NetPendingOrderExcelAPi.getGlobalData().then((value) {
          if (value == 200) {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
            showSnackBar('Try again!!..');
          }
        });
        Navigator.pop(context);
        setState(() {
          isLoading = true;
        });
      }
    }
  }

  Future<void> callApi() async {
    if (formkey[0].currentState!.validate()) {
      if (isFromSalesinDay == true) {
        SalesOnDayAPi.fromDate = apiFromDate;
        SalesOnDayAPi.toDate = apiToDate;
        SalesOnDayAPi.slpCode = GetValues.slpCode;
        print("SalesOnDayAPi.slpCode: " + SalesOnDayAPi.slpCode.toString());
        isFromSalesinDay = false;
        SalesOnDayAPi.getGlobalData().then((value) {
          if (value == 200) {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
            showSnackBar('Try again!!..');
          }
        });
        Navigator.pop(context);
        setState(() {
          isLoading = true;
        });
      } else {
        NetPendingOrderAPi.fromDate = apiFromDate;
        NetPendingOrderAPi.toDate = apiToDate;
        NetPendingOrderAPi.slpCode = GetValues.slpCode;
        print("SalesOnDayAPi.slpCode22: " +
            NetPendingOrderAPi.slpCode.toString());
        NetPendingOrderAPi.getGlobalData().then((value) {
          if (value == 200) {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
            showSnackBar('Try again!!..');
          }
        });
        Navigator.pop(context);
        setState(() {
          isLoading = true;
        });
      }
    }
  }

  void showSnackBar(String msg) {
    final sn = SnackBar(
      content: Text(
        "$msg",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.maybeOf(context)!.showSnackBar(sn);
  }

  String apiFromDate = '';
  String apiToDate = '';

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
        mycontroller[1].text = '';
        mycontroller[1].text =
            "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().padLeft(2, '0')}";
        apiFromDate =
            "${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}";
        // SalesOnDayAPi.fromDate = apidate;
        // print(SalesOnDayAPi.fromDate);
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
        var date = DateTime.parse(mycontroller[2].text);
        mycontroller[2].text = '';
        mycontroller[2].text =
            "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().padLeft(2, '0')}";
        apiToDate =
            "${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}";
        // GetFollowupApi.fromDate = apidate;
        //  print(mycontroller[2].text);
      });
    });
  }

  /// visit
  String apiFromVDate = '';
  String apiToVDate = '';
  String? valueChosedStatusWon;
  bool? valuechose = false;
  choosedStatus(String val) {
    setState(() {
      valueChosedStatusWon = val;
    });
  }

  void bottomVisitSheet(ThemeData theme, String methodName) {
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
                    key: formkey[1],
                    child: Container(
                      child: Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Stack(
                              children: [
                                SizedBox(
                                  child: TextFormField(
                                    onTap: () {
                                      showFromVDate(context);
                                    },
                                    readOnly: true,
                                    controller: mycontroller[3],
                                    onChanged: (val) {},
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'ENTER FROM DATE';
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
                                      labelText: 'Choose from date',
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
                                        showFromVDate(context);
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
                                  child: TextFormField(
                                    onTap: () {
                                      showToVDate(context);
                                    },
                                    readOnly: true,
                                    controller: mycontroller[4],
                                    onChanged: (val) {},
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'ENTER TO DATE';
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
                                          // ignore: prefer_const_constructors
                                          Radius.circular(10),
                                        ),
                                      ),
                                      labelText: 'Choose to date',
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
                                        showToVDate(context);
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
                            methodName == "Adherance"
                                ? Container(
                                    width: Screens.width(context) * 0.6,
                                    child: DropdownButton(
                                      hint: Text(
                                        valuechose == true
                                            ? "Select Slpcode:*"
                                            : "Select Slpcode:",
                                        style:
                                            theme.textTheme.bodyText2?.copyWith(
                                          fontFamily: 'Segoe',
                                          color: valuechose == true
                                              ? Colors.red
                                              : Colors.black,
                                          fontSize:
                                              Screens.width(context) * 0.035,
                                        ),
                                      ),
                                      value: valueChosedStatusWon,
                                      //dropdownColor:Colors.green,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 30,
                                      itemHeight: 48,

                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      isExpanded: true,
                                      onChanged: (val) {
                                        setState(() {
                                          choosedStatus(val.toString());
                                        });
                                      },
                                      items: purposeData.map((e) {
                                        return DropdownMenuItem(
                                            // ignore: unnecessary_brace_in_string_interps
                                            value: "${e.slpcode}",
                                            child: Text(e.slpname.toString()));
                                      }).toList(),
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    backgroundColor: theme.primaryColor,
                                  ),
                                  onPressed: () {
                                    if (formkey[1].currentState!.validate()) {
                                      if (methodName == "Adherance") {
                                        if (valueChosedStatusWon == null ||
                                            valueChosedStatusWon!.isEmpty) {
                                          setState(() {
                                            valuechose = true;
                                          });
                                        } else {
                                          visitlogbottomsheet(methodName);
                                        }
                                      } else {
                                        visitlogbottomsheet(methodName);
                                      }
                                    }

                                    //
                                    // callVisitApi(methodName);
                                  },
                                  child: Text(
                                    "Search",
                                    style: TextStyles.whiteText(context),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ));
  }

  void showFromVDate(BuildContext context) {
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
        mycontroller[3].text = value.toString();
        var date = DateTime.parse(mycontroller[3].text);
        mycontroller[3].text = '';
        mycontroller[3].text =
            "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().padLeft(2, '0')}";
        apiFromVDate =
            "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      });
    });
  }

  void showToVDate(BuildContext context) {
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
        mycontroller[4].text = value.toString();
        var date = DateTime.parse(mycontroller[4].text);
        mycontroller[4].text = '';
        mycontroller[4].text =
            "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().padLeft(2, '0')}";
        apiToVDate =
            "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      });
    });
  }

  Future<void> callVisitExcelApi(String methodName) async {
    // if (formkey[1].currentState!.validate()) {
    Navigator.pop(context);
    setState(() {
      isLoading = true;
    });
    String fileName = '$methodName';
    log("Anbbb::${GetValues.slpCode}");
    String Slpcode =
        valueChosedStatusWon != null && valueChosedStatusWon!.isNotEmpty
            ? "$valueChosedStatusWon"
            : '${GetValues.slpCode}';
    log("Slpcode::" + Slpcode.toString());
    String content = '${methodName}Excel/${Slpcode},$apiFromVDate,$apiToVDate';
    await ReportExcelApi.getGlobalData(content, fileName).then((value) {
      apiFromVDate = '';
      apiToVDate = '';
      valueChosedStatusWon = null;
      setState(() {
        valuechose = false;
      });

      if (value == 200) {
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        showSnackBar('Try again!!..');
      }
    });
    // }
  }

  Future<void> callVisitApi(String methodName) async {
    // if (formkey[1].currentState!.validate()) {
    Navigator.pop(context);
    setState(() {
      isLoading = true;
    });
    String fileName = '$methodName';
    log("methodNamemethodName::$methodName");
    String Slpcode =
        valueChosedStatusWon != null && valueChosedStatusWon!.isNotEmpty
            ? "$valueChosedStatusWon"
            : '${GetValues.slpCode}';
    log("Slpcode::" + Slpcode.toString());
    String content = '$methodName/${Slpcode},$apiFromVDate,$apiToVDate';

//      http://localhost:22621/api/Adherance/139,2024-01-01,2024-02-01
// http://localhost:22621/api/AdheranceExcel/139,2024-01-01,2024-02-01
log("contentcontent::${content}");
    await ReportApi.getGlobalData(content, fileName).then((value) {
      apiFromVDate = '';
      apiToVDate = '';
      valueChosedStatusWon = null;
      setState(() {
        valuechose = false;
      });
      if (value == 200) {
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        showSnackBar('Try again!!..');
      }
    });
    // }
  }
}
