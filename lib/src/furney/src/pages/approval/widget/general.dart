// ignore_for_file: prefer_const_constructors, unawaited_futures

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/AgingReportAPI/AgeingExcelReport.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/AgingReportAPI/AgeingPdfAPI.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/ApprovalReqReportAPi/ApprovalReqExcelApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/ApprovalReqReportAPi/ApprovalRequestPdfApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/CustomerStatementApi/customerStatementApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/SubGruopSalesYTD/SubGroupYTDPdf.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/SubGruopSalesYTD/SubGruopYTDExcel.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/customer_bp/new_customer_modal.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/salesperson_modal/salesPerson_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sign_in/widgets/custom_elevatedBtn.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class General extends StatefulWidget {
  const General({
    Key? key,
  }) : super(key: key);

  @override
  GeneralState createState() => GeneralState();
}

class GeneralState extends State<General> {
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  static CustomerDetailsValue? customerDetailsValue;
  static List<SalesPersonValue>? salesPersonModal = [];
  static int index = 0;
  static String? acntBalance;
  static String? slpName;
  static String? paymentTerms;
  static String? cardCode;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Screens.width(context) * 0.02),
      width: Screens.width(context),
      height: Screens.heigth(context) * 0.3,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Screens.heigth(context) * 0.01,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //    AppLocalizations.of(context)!.docNo,
                      'Acct Balance',
                      style: TextStyles.boldPC1(context),
                    ),
                    SizedBox(
                      width: Screens.width(context) * 0.83,
                      // color: Colors.blue,
                      child: Text(
                        // '$acntBalance',// "4,789,949.15 \$",
                        TextStyles.splitValues('$acntBalance'),
                        style: TextStyles.headlineBlack1(context),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Screens.heigth(context) * 0.01,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //    AppLocalizations.of(context)!.docNo,
                      'Credit Limit',
                      style: TextStyles.boldPC1(context),
                    ),
                    SizedBox(
                      width: Screens.width(context) * 0.83,
                      // color: Colors.blue,
                      child: Text(
                        // '${customerDetailsValue!.creditLimit}',//  "0.00 \$",
                        TextStyles.splitValues(
                          '${customerDetailsValue!.creditLimit}',
                        ),
                        style: TextStyles.headlineBlack1(context),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Screens.heigth(context) * 0.01,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //    AppLocalizations.of(context)!.docNo,
                      'Sales Employee',
                      style: TextStyles.boldPC1(context),
                    ),
                    SizedBox(
                      width: Screens.width(context) * 0.83,
                      // color: Colors.blue,
                      child: Text(
                        '$slpName',
                        style: TextStyles.headlineBlack1(context),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Screens.heigth(context) * 0.01,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //    AppLocalizations.of(context)!.docNo,
                      'Payment Terms',
                      style: TextStyles.boldPC1(context),
                    ),
                    SizedBox(
                      width: Screens.width(context) * 0.83,
                      // color: Colors.blue,
                      child: Text(
                        '$paymentTerms',
                        style: TextStyles.headlineBlack1(context),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Screens.heigth(context) * 0.01,
                ),
                GestureDetector(
                  onTap: () {
                    // Get.toNamed<dynamic>(FurneyRoutes.regularSalesPrice);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price List',
                        style: TextStyles.boldPC1(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              customerDetailsValue!.priceListNum
                                  .toString(), // "Regular Sales Price",
                              style: TextStyles.headlineBlack1(context),
                            ),
                          ),
                          Icon(
                            Icons.navigate_next_outlined,
                            color: theme.primaryColor,
                            size: Screens.heigth(context) * 0.06,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Screens.heigth(context) * 0.01,
                ),
                GestureDetector(
                  onTap: () {
                    if (customerDetailsValue!.phone1 == '') {
                      const snackBar = SnackBar(
                        duration: Duration(seconds: 5),
                        backgroundColor: Colors.red,
                        content: Text(
                          'There is no phone number to call !!..',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      makecall('${customerDetailsValue!.phone1}');
                    }
                    //  makecall('${customerDetailsValue!.phone1}');
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Telephone',
                        style: TextStyles.boldPC1(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              '${customerDetailsValue!.phone1}', // customerDetailsValue[index].cardCode.toString(),
                              style: TextStyles.headlineBlack1(context),
                            ),
                          ),
                          Icon(
                            Icons.navigate_next_outlined,
                            color: theme.primaryColor,
                            size: Screens.heigth(context) * 0.06,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Screens.heigth(context) * 0.01,
                ),
                GestureDetector(
                  onTap: () {
                    mailto(
                      'https://mail.google.com/mail/u/0/#inbox?compose=new',
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyles.boldPC1(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              '${customerDetailsValue!.emailAddress}', // "info@maxi-teq.sap.com",
                              style: TextStyles.headlineBlack1(context),
                            ),
                          ),
                          Icon(
                            Icons.navigate_next_outlined,
                            color: theme.primaryColor,
                            size: Screens.heigth(context) * 0.06,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Screens.heigth(context) * 0.01,
                ),
                GestureDetector(
                  onTap: () {
                    //  launchInWebViewWithJavaScript("https://mail.google.com");
                    launchInBrowser('https://google.com');
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Web Site',
                        style: TextStyles.boldPC1(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              '${customerDetailsValue!.website}', //    "WWW.maxi-teq.sap.com",
                              style: TextStyles.headlineBlack1(context),
                            ),
                          ),
                          Icon(
                            Icons.navigate_next_outlined,
                            color: theme.primaryColor,
                            size: Screens.heigth(context) * 0.06,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Screens.heigth(context) * 0.01,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //    AppLocalizations.of(context)!.docNo,
                      'Remarks',
                      style: TextStyles.boldPC1(context),
                    ),
                    SizedBox(
                      width: Screens.width(context) * 0.83,
                      // color: Colors.blue,
                      child: Text(
                        customerDetailsValue!.notes.toString(),
                        style: TextStyles.headlineBlack1(context),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Screens.heigth(context) * 0.02,
                ),
                CustomSpinkitdButton(
                  onTap: () async {
                    mycontroller[7].text = '';
                    mycontroller[8].text = '';
                    nowCurrentDate();
                    customerSaleslogbottomsheet('YTDGrowthSLP');
                  },
                  isLoading: isLoading,
                  label: 'Sub-Group Wise Sales YTD Growth SLP',
                ),
                SizedBox(
                  height: Screens.heigth(context) * 0.01,
                ),
                CustomSpinkitdButton(
                  onTap: () {
                    setState(approvalRequstBottomSheet);
                  },
                  isLoading: isLoading,
                  label: 'Approval Request Report',
                ),
                // SizedBox(
                //   height: Screens.heigth(context) * 0.01,
                // ),
                // CustomSpinkitdButton(
                //   onTap: () async {
                //     mycontroller[5].text = '';
                //     mycontroller[6].text = cardCode!;
                //     apiCustCode = cardCode!;

                //     setState(() {
                //       ageingBottomSheet(theme);
                //     });
                //   },
                //   isLoading: isLoading,
                //   label: 'Aging Report',
                // ),
                SizedBox(
                  height: Screens.heigth(context) * 0.01,
                ),
                CustomSpinkitdButton(
                  onTap: () async {
                    mycontroller[1].clear();
                    mycontroller[2].clear();
                    bottomSheet(theme);
                  },
                  isLoading: isLoading,
                  //  labelLoading: AppLocalizations.of(context)!.signing,
                  label: 'View Customer Statement',
                ),
                SizedBox(
                  height: Screens.heigth(context) * 0.03,
                ),
              ],
            ),
            Visibility(
              visible: isScreenLoad,
              child: Container(
                width: Screens.width(context),
                height: Screens.heigth(context),
                color: Colors.white60,
                child: Center(
                  child: SpinKitThreeBounce(
                    size: Screens.heigth(context) * 0.07,
                    color: theme.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isLoading = false;
  bool isScreenLoad = false;
  List<GlobalKey<FormState>> formkey =
      List.generate(10, (i) => GlobalKey<FormState>());
  void bottomSheet(ThemeData theme) {
    //nznznz
    showModalBottomSheet<dynamic>(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Form(
            key: formkey[0],
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
                              vertical: 10,
                              horizontal: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            labelText: 'Choose from date',
                            labelStyle: TextStyles.bodytextBlack1(context),
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
                            size: Screens.width(context) * 0.08,
                          ),
                        ),
                      ),
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
                              vertical: 10,
                              horizontal: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            labelText: 'Choose to date',
                            labelStyle: TextStyles.bodytextBlack1(context),
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
                            size: Screens.width(context) * 0.08,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: theme.primaryColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        callApi();
                      },
                      child: Text(
                        'Search',
                        style: TextStyles.whiteText(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> callApi() async {
    if (formkey[0].currentState!.validate()) {
      setState(() {
        isScreenLoad = true;
        //  isLoading = true;
      });

      await CustomerStatementApi.getGlobalData(cardCode, apiFromDate, apiToDate)
          .then((value) {
        isScreenLoad = false;

        if (value == 200) {
          setState(() {
            isScreenLoad = false;
            //isLoading = false;
          });
        } else {
          setState(() {
            isScreenLoad = false;
            //  isLoading = false;
          });
          showSnackBar('Try again!!..');
        }
      });
      Navigator.pop(context);
    }
  }

  String apiFromDate = '';
  String apiToDate = '';

  void showSnackBar(String msg) {
    final sn = SnackBar(
      content: Text(
        msg,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.maybeOf(context)!.showSnackBar(sn);
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
        final date = DateTime.parse(mycontroller[2].text);
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

  Future<void> makecall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'exception $url';
    }
  }

  Future<void> launchInWebViewWithJavaScript(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> mailto(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'exception $url';
    }
  }

  Future<void> openMap(double latitude, double longitude) async {
    final googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  // String salesApiFromVDate = '';
  String salesApiToVDate = '';
  nowCurrentDate() {
    final date = DateTime.parse(DateTime.now().toString());
    salesApiToVDate =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    log('salesApiToVDatesalesApiToVDate::$salesApiToVDate');
  }

  // findFirstDateOfTheYear2(DateTime dateTime) {
  //   DateTime dateTimeWithOffset = dateTime;

  //   log('dateTimeWithOffset Firstyear::$dateTimeWithOffset');
  //   return DateTime(dateTimeWithOffset.year, 1, 1);
  // }

  DateTime findPreviousYear2(DateTime dateTime) {
    var dateTimeWithOffset = dateTime;

    log('dateTimeWithOffset Firstyear::$dateTimeWithOffset');
    return DateTime(dateTimeWithOffset.year - 1, 1);
  }

  void customerSaleslogbottomsheet(String methodName) {
    showModalBottomSheet<dynamic>(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          height: 200,
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Column(
            // mainAxisAlignment: Ma,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Do you want to open in? ',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);

                      if (methodName == 'YTDGrowthSLP') {
                        callSubGroupSalesPafApi(methodName);
                      } else {
                        // callCustomerSalesApi("$methodName");
                      }
                    },
                    child: Text(
                      'PDF',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      if (methodName == 'YTDGrowthSLP') {
                        callSubGroupSalesExcelApi(methodName);
                      } else {
                        // callCustomerSalesExcelApi(methodName);
                      }
                    },
                    child: Text(
                      'Excel',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void approvalRequstBottomSheet() {
    showModalBottomSheet<dynamic>(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          height: 200,
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Column(
            // mainAxisAlignment: Ma,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Do you want to open in? ',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      setState(
                        () {
                          callApprovalReqPdfApi();
                        },
                      );
                    },
                    child: Text(
                      'PDF',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      setState(
                        () {
                          callApprovalReqExcelApi();
                        },
                      );
                    },
                    child: Text(
                      'Excel',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> callSubGroupSalesPafApi(String methodname) async {
    setState(() {
      isScreenLoad = true;
    });
    log('methodnamemethodname::${findPreviousYear2(DateTime.now()).toString().replaceAll('00:00:00.000', '')}:::$cardCode:::$methodname');
    SubGroupSalesPdfReportAPi.fromDate = findPreviousYear2(DateTime.now())
        .toString()
        .replaceAll(' 00:00:00.000', '')
        .trim();

    SubGroupSalesPdfReportAPi.toDate = salesApiToVDate;
    SubGroupSalesPdfReportAPi.slpCode = GetValues.slpCode;
    SubGroupSalesPdfReportAPi.methodName = methodname;
    SubGroupSalesPdfReportAPi.cardCode = cardCode;

    await SubGroupSalesPdfReportAPi.getGlobalData().then((value) {
      isScreenLoad = false;

      if (value == 200) {
        setState(() {
          isScreenLoad = false;
        });
      } else {
        setState(() {
          isScreenLoad = false;
        });
        showSnackBar('Try again!!..');
      }
    });
    // Navigator.pop(context);
    setState(() {
      isScreenLoad = false;
    });
  }

  Future<void> callApprovalReqPdfApi() async {
    setState(() {
      isScreenLoad = true;
    });
    log('methodnamemethodname::$cardCode');

    // ApprovalReqApi.cardCode = cardCode;

    await ApprovalReqApi.getGlobalData(cardCode).then((value) {
      isScreenLoad = false;

      if (value == 200) {
        setState(() {
          isScreenLoad = false;
        });
      } else {
        setState(() {
          isScreenLoad = false;
        });
        showSnackBar('Try again!!..');
      }
    });
    // Navigator.pop(context);
    setState(() {
      isScreenLoad = false;
    });
  }

  Future<void> callApprovalReqExcelApi() async {
    log('methodnamemethodname::$cardCode');
    setState(() {
      isScreenLoad = true;
    });
    await ApprovalReqExcelAPi.getGlobalData(cardCode.toString()).then((value) {
      isScreenLoad = false;

      if (value == 200) {
        setState(() {
          isScreenLoad = false;
        });
      } else {
        setState(() {
          isScreenLoad = false;
        });
        showSnackBar('Try again!!..');
      }
    });
    // Navigator.pop(context);
    setState(() {
      isScreenLoad = false;
    });
  }

  Future<void> callSubGroupSalesExcelApi(String methodname) async {
    setState(() {
      isScreenLoad = true;
    });
    log('methodnamemethodname::$methodname');
    SubGroupsSaleExcelReportAPi.fromDate = findPreviousYear2(DateTime.now())
        .toString()
        .replaceAll(' 00:00:00.000', '')
        .trim();
    SubGroupsSaleExcelReportAPi.toDate = salesApiToVDate;
    SubGroupsSaleExcelReportAPi.slpCode = GetValues.slpCode;
    SubGroupsSaleExcelReportAPi.cardCode = cardCode;
    SubGroupsSaleExcelReportAPi.reportName = '${methodname}Excel';

    await SubGroupsSaleExcelReportAPi.getGlobalData().then((value) {
      isScreenLoad = false;

      if (value == 200) {
        setState(() {
          isScreenLoad = false;
        });
      } else {
        setState(() {
          isScreenLoad = false;
        });
        showSnackBar('Try again!!..');
      }
    });
    // Navigator.pop(context);
    setState(() {
      isScreenLoad = false;
    });
  }

  void showAgeingDate(BuildContext context) {
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
        mycontroller[5].text = value.toString();
        var date = DateTime.parse(mycontroller[5].text);
        mycontroller[5].text = '';
        mycontroller[5].text =
            "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().padLeft(2, '0')}";
        apiAgeingDate =
            "${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}";
        log('apiAgeingDate:$apiAgeingDate');
      });
    });
  }

  void ageingBottomSheet(ThemeData theme) {
    //nznznz
    showModalBottomSheet<dynamic>(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Form(
            key: formkey[1],
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
                        child: Column(
                          children: [
                            TextFormField(
                              onTap: () {
                                apiAgeingDate = '';
                                showAgeingDate(context);
                              },
                              readOnly: true,
                              controller: mycontroller[5],
                              onChanged: (val) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Date';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 15),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                labelText: 'Choose Date',
                                labelStyle: TextStyles.bodytextBlack1(context),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              // onTap: () {
                              //   mycontroller[6].text = '';
                              //   apiCustCode = '';
                              //   setState(() {
                              //     // Get.toNamed<void>(
                              //     //   FurneyRoutes.selectionCustomer,
                              //     // )!
                              //     //     .then((value) {
                              //     //   apiCustCode =
                              //     //       '${SelectedCustModel.CustomerCode ?? ''}';
                              //     //   mycontroller[6].text =
                              //     //       '${SelectedCustModel.CustomerCode ?? ''}'; //\n${SelectedCustModel.shipAddress}
                              //     // });
                              //   });
                              // },
                              readOnly: true,
                              controller: mycontroller[6],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Customer Code';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 15),
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.navigate_next_outlined,
                                  color: theme.primaryColor,
                                  size: Screens.heigth(context) * 0.06,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                labelText: 'Choose Customer Code',
                                labelStyle: TextStyles.bodytextBlack1(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: Screens.heigth(context) * 0.01,
                        left: Screens.width(context) * 0.8,
                        child: InkWell(
                          onTap: () {
                            apiAgeingDate = '';
                            showAgeingDate(context);
                          },
                          child: Icon(
                            Icons.calendar_today_outlined,
                            color: theme.primaryColor,
                            size: Screens.width(context) * 0.08,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: theme.primaryColor,
                      ),
                      onPressed: ageingBottomSheetViewer,
                      child: Text(
                        'Search',
                        style: TextStyles.whiteText(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void ageingBottomSheetViewer() {
    showModalBottomSheet<dynamic>(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          height: 200,
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Column(
            // mainAxisAlignment: Ma,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Do you want to open in? ',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      callAgeingApi();
                    },
                    child: Text(
                      'PDF',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      callAgeingExcelApi();
                    },
                    child: Text(
                      'Excel',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String apiAgeingDate = '';
  String apiCustCode = '';
  Future<void> callAgeingApi() async {
    if (formkey[1].currentState!.validate()) {
      setState(() {
        isScreenLoad = true;
      });
      log('AgeingAPi.date::$apiAgeingDate');
      AgeingAPi.date = apiAgeingDate;
      AgeingAPi.custCode = apiCustCode;
      AgeingAPi.slpCode = GetValues.slpCode;

      AgeingAPi.getGlobalData().then((value) {
        if (value == 200) {
          setState(() {
            isScreenLoad = false;
          });
        } else {
          setState(() {
            isScreenLoad = false;
          });
          showSnackBar('Try again!!..');
        }
      });
      Navigator.pop(context);
      setState(() {
        isScreenLoad = false;
      });
    }
  }

  Future<void> callAgeingExcelApi() async {
    if (formkey[1].currentState!.validate()) {
      setState(() {
        isScreenLoad = true;
      });
      AgeingExcelAPi.date = apiAgeingDate;
      AgeingExcelAPi.slpCode = GetValues.slpCode;
      AgeingExcelAPi.custCode = apiCustCode;
      // print("SalesOnDayAPi.slpCode: " + AgeingExcelAPi.slpCode.toString());
      // isFromSalesinDay = false;
      AgeingExcelAPi.getGlobalData().then((value) {
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
