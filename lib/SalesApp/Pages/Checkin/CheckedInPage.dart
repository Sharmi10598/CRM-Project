// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_final_locals, prefer_interpolation_to_compose_strings, prefer_single_quotes, prefer_const_constructors, omit_local_variable_types, unnecessary_string_interpolations, unawaited_futures

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_bundle/SalesApp/Api/CheckinApi/CheckInApi.dart';
import 'package:ultimate_bundle/SalesApp/Api/CheckinApi/GerCheckedInApi.dart';
import 'package:ultimate_bundle/SalesApp/Model/GetActivities/GetAprvActivityModel.dart';
import 'package:ultimate_bundle/SalesApp/Model/GetActivities/GetCheckedInModel.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/uikit_model.dart';
import 'package:ultimate_bundle/src/furney/src/DB/DBHelper.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sign_in/widgets/custom_elevatedBtn.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/SalesAppBar.dart';

class CheckedINPage extends StatefulWidget {
  const CheckedINPage({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  State<CheckedINPage> createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckedINPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    checkInternet();
  }

  List<CheckinModel> data = [];
  List<GetActivityApvdData> cust = [];
  Future<void> checkInternet() async {
    bool internet = await config.haveInterNet();
    if (internet) {
      getActivityApi();
    } else {
      getValuesFromDB();
    }
  }

  Future<void> getValuesFromDB() async {
    loading = true;
    msg = '';
    setState(() {});
    data = await DataBaseHelper.getPostCheckinData();
    if (data.isNotEmpty) {
      cust = await DataBaseHelper.getSlctCustData(data[0].clgcode);
      checkedINData.add(
        GetCheckedINData(
          CardCode: cust[0].CardCode,
          CardName: cust[0].CardName,
          VisitReg: cust[0].Name,
          CntctTime: int.parse(data[0].ActivityTime.replaceAll(":", "")),
          CntctDate: data[0].ActivityDate,
          ClgCode: data[0].clgcode,
          Details: cust[0].Details,
          CntctSbjct: 0,
        ),
      );
      if (checkedINData.isNotEmpty) {
        loading = false;
        msg = '';
        setState(() {});
      }
    }
  }

  bool loading = false;
  String msg = '';
  List<GetCheckedINData> checkedINData = [];
  Future<void> getActivityApi() async {
    loading = true;
    msg = '';
    setState(() {});

    await GetCheckedINAPi.getGlobalData(
            GetValues.slpCode!, config.currentDateTimeServer())
        .then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        loading = false;
        msg = '';
        setState(() {});
        if (value.activitiesData != null) {
          checkedINData = value.activitiesData!;
        } else {
          DataBaseHelper.dltAlrchkddata().then((value) {
            Get.back<void>();
          });
          //     loading = false;
          //    msg = 'No data found';
          //  setState(() { });
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        loading = false;
        msg = 'Something went wrong...!!';
        setState(() {});
      } else {
        loading = false;
        msg = 'Something went wrong...!!';
        setState(() {});
      }
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void init() {
    mycontroller[1].text = '${currentDateTime()}';
  }

  String currentDateTime() {
    DateTime now = DateTime.now();
    setState(() {});
    return "${now.day}-${now.month.toString().padLeft(2, '0')}-${now.year.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
  }

  String adrress =
      'BOA VIDA CORPORATION \nTanzaniya \nVisit regarding new product discussion';
  String checkindata = 'cheked-in @ 15-jan-2023 11:23:45 AM';
  String visitRun = 'Visit running since 15-jan-2023 11:23:45 AM';

  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());

  Future<bool> onbackpress() {
    Get.offAllNamed<dynamic>(FurneyRoutes.home);
    return Future.value(true);
  }

  Config config = Config();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        drawer: drawer(context),
        appBar: salesappBar(context, _scaffoldKey, widget.title),
        body: (loading == true && msg.isEmpty && checkedINData.isEmpty)
            ? Center(child: CircularProgressIndicator())
            : (loading == false && msg.isNotEmpty && checkedINData.isEmpty)
                ? Center(child: Text(msg))
                : Container(
                    width: Screens.width(context),
                    height: Screens.heigth(context),
                    padding: EdgeInsets.symmetric(
                      vertical: Screens.heigth(context) * 0.01,
                      horizontal: Screens.width(context) * 0.02,
                    ),
                    child: Column(
                      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: Screens.heigth(context) * 0.01,
                            horizontal: Screens.width(context) * 0.02,
                          ),
                          width: Screens.width(context),
                          decoration: BoxDecoration(color: Colors.grey[200]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(checkedINData.isEmpty
                                    ? ''
                                    : checkedINData[0].CardCode!),
                              ),
                              SizedBox(
                                height: Screens.heigth(context) * 0.01,
                              ),
                              Container(
                                child: Text(checkedINData.isEmpty
                                    ? ''
                                    : checkedINData[0].CardName!),
                              ),
                              SizedBox(
                                height: Screens.heigth(context) * 0.01,
                              ),
                              Container(
                                child: Text(checkedINData.isEmpty
                                    ? ''
                                    : "Visit regarding " +
                                        checkedINData[0].VisitReg!),
                              ),
                              SizedBox(
                                height: Screens.heigth(context) * 0.01,
                              ),
                              Container(
                                child: Text(checkedINData.isEmpty
                                    ? ''
                                    : "checked-in @ " +
                                        config.alignDate(
                                            checkedINData[0].CntctDate!) +
                                        ' ' +
                                        config.convertintToTime(
                                            checkedINData[0].CntctTime!)),
                              ),
                              SizedBox(
                                height: Screens.heigth(context) * 0.01,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Screens.heigth(context) * 0.01,
                        ),
                        Container(
                          width: Screens.width(context),
                          color: Colors.grey[200],
                          padding:
                              EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                          child: Text(
                              'Visit running since ' + mycontroller[1].text),
                        ),
                        //  config.alignDate(checkedINData[0].CntctDate!) +' '+
                        //  config.convertintToTime(checkedINData[0].CntctTime!))),
                        SizedBox(
                          height: Screens.heigth(context) * 0.01,
                        ),
                        Container(
                          child: CustomSpinkitdButton(
                            onTap: () async {
                              Get.toNamed<void>(FurneyRoutes.checkoutPage);
                            },
                            label: 'Check out',
                          ),
                        )
                      ],
                    ),
                  ),
      ),
    );
  }
}
