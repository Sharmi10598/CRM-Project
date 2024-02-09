// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, omit_local_variable_types, unnecessary_lambdas, prefer_single_quotes, use_build_context_synchronously, unawaited_futures, cascade_invocations, avoid_bool_literals_in_conditional_expressions, always_declare_return_types, unnecessary_new, prefer_const_constructors, avoid_void_async

part of '../home_page.dart';

class FurneyHomeScreen extends StatefulWidget {
  const FurneyHomeScreen({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  State<FurneyHomeScreen> createState() => _FurneyHomeScreenState();
}

class _FurneyHomeScreenState extends State<FurneyHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<ApprovalsValue> aprovals = [];
  List<SalesChartData> salesdetails = [];
  List<SalesChartData> salesdata = [];
  List<InPaymentChartData> collectiondetails = [];
  List<InPaymentChartData> collectiondata = [];
  List<VolumeChartData> volumedetails = [];
  List<VolumeChartData> volumedata = [];

  @override
  void initState() {
    super.initState();

    // GetValues.isAtive[0]=true;
    // GetValues.isAtive[1]=false;
    //
    notifycheck2();
    checkHaveInternet();
    createDB();
    // DataBaseHelper. deletedata();

    // DataBaseHelper.getFileData();
    // DataBaseHelper.getPostCheckoutData();
    DataBaseHelper.deletePostedCheckout(32);
    DataBaseHelper.checkdataHave();
  }

  LocalNotificationService localNotificationService =
      new LocalNotificationService();
  void notifycheck2() async {
    final DataBaseHelper dbHelper2 = DataBaseHelper();
    final int cont = await dbHelper2.getUnSeenNotificationCount() ?? 10;
    FlutterAppBadger.isAppBadgeSupported().then((isSupported) {
      if (isSupported) {
        // setState(() {
        FlutterAppBadger.updateBadgeCount(cont);
        log("NOTIFY::::$cont");

        // });
        localNotificationService.showNitification(
          notifycount: cont,
        );
      }
    });
  }

  Config config = new Config();
  void checkHaveInternet() async {
    final bool internet = await config.haveInterNet();

    if (internet) {
      // saleschartapi();
      // Collectionchartapi();
      // Volumechartapi();

      checkVersion();
    } else {
      setState(() {
        getAllMEthods();
        loadingscrn = true;
        msg = 'No Internet';
      });
    }
  }

  void checkVersion() {
    CheckVersionAPi.getGlobalData().then((value) {
      if (value.deviceData != null) {
        if (AppVersion.version == value.deviceData![0].Version) {
          setState(() {
            log("comeeeeee: ${AppVersion.version} ");
            callServiceLayerApi();
            getAllMEthods();
          });
        } else {
          Get.offAllNamed<void>(FurneyRoutes.splash);
        }
      }
    });
  }

  Future<void> ploadCheckinCheckout() async {
    List<CheckinModel> postData = [];
    postData = await DataBaseHelper.getAllPostCheckinData();
    for (int i = 0; i < postData.length; i++) {
      final CheckinModel apdata = CheckinModel(
        clgcode: postData[i].clgcode,
        ActivityDate: postData[i].ActivityDate,
        ActivityTime: postData[i].ActivityTime,
        StartDate: postData[i].StartDate,
        StartTime: postData[i].StartTime,
        U_Latitude: postData[i].U_Latitude,
        U_Longitude: postData[i].U_Longitude,
        U_CheckedIn: postData[i].U_CheckedIn,
        status: postData[i].status,
        U_CheckinAdd: postData[i].U_CheckinAdd,
      );
      await CheckinAPi.getGlobalData(apdata).then((value) async {
        if (value.statusCode! >= 200 && value.statusCode! <= 210) {
          checkoutPost(apdata);
        }
      });
    }

    if (mounted) {
      setState(() => loadingscrn = false);
    }
  }

  void checkoutPost(CheckinModel postData) async {
    List<FilesData> filedata = [];
    // =[];
    List<FilesPostData> filedataDB =
        await DataBaseHelper.getFileData(postData.clgcode);
    for (int i = 0; i < filedataDB.length; i++) {
      final File files = File(filedataDB[i].filePath);
      List<int> intdata = files.readAsBytesSync();
      filedata.add(
        FilesData(
          fileBytes: base64Encode(intdata),
          fileName: files.path.split('/').last,
        ),
      );
    }
    List<CheckOutModel> checkoutdata =
        await DataBaseHelper.getPostCheckoutData(postData.clgcode);
    for (int i = 0; i < filedata.length; i++) {
      await FilePostApi.getFilePostData(
        filedata[i].fileBytes,
        filedata[i].fileName,
      ).then((value) {
        setState(() {
          if (value.stCode! >= 200 && value.stCode! <= 210) {
            setState(() {
              print("Api PAth: " + value.filepath.toString());
              // filelink.add(value.filepath!);
              if (i == 0) {
                checkoutdata[0].U_Link1 = value.filepath!;
              } else if (i == 1) {
                checkoutdata[0].U_Link2 = value.filepath!;
              } else if (i == 2) {
                checkoutdata[0].U_Link3 = value.filepath!;
              } else if (i == 3) {
                checkoutdata[0].U_Link4 = value.filepath!;
              }
            });
          } else if (value.stCode! >= 400 && value.stCode! <= 410) {
            setState(() {
              //  fileException.add(value.filepath![i]);
            });
          } else {
            setState(() {
              // fileException.add(value.exception!);
            });
          }
        });
      });
    }
    final CheckOutModel chekcOut = new CheckOutModel();
    chekcOut.U_CheckOutAdd = checkoutdata[0].U_CheckOutAdd;
    chekcOut.Notes = checkoutdata[0].Notes;
    chekcOut.U_NxtFollowup = checkoutdata[0].U_NxtFollowup;
    chekcOut.U_COLatitude = checkoutdata[0].U_COLatitude;
    chekcOut.U_COLongitude = checkoutdata[0].U_COLongitude;
    chekcOut.U_Advertise = checkoutdata[0].U_Advertise;
    chekcOut.U_AdvFormt = checkoutdata[0].U_AdvFormt;
    chekcOut.U_Products = checkoutdata[0].U_Products;
    chekcOut.U_BrandContr = checkoutdata[0].U_BrandContr;
    chekcOut.U_PPComp = checkoutdata[0].U_PPComp;
    chekcOut.U_BrandinPromo = checkoutdata[0].U_BrandinPromo;
    chekcOut.U_OrdProsValue = checkoutdata[0].U_OrdProsValue;
    chekcOut.U_PymntVal = checkoutdata[0].U_PymntVal;
    chekcOut.U_Complaints = checkoutdata[0].U_Complaints;
    chekcOut.U_Remarks1 = checkoutdata[0].U_Remarks1;
    chekcOut.U_Remarks2 = checkoutdata[0].U_Remarks2;
    chekcOut.clgCode = checkoutdata[0].clgCode;
    chekcOut.Duration = checkoutdata[0].Duration;
    chekcOut.U_Link1 = checkoutdata[0].U_Link1;
    chekcOut.U_Link2 = checkoutdata[0].U_Link2;
    chekcOut.U_Link3 = checkoutdata[0].U_Link3;
    chekcOut.U_Link4 = checkoutdata[0].U_Link4;
    chekcOut.Closed = 'Y';
    chekcOut.U_status = 'C';
    chekcOut.CloseDate = config.currentDateTimeServer();
    chekcOut.EndTime =
        config.currentTimeServer().replaceAll(":", "").padLeft(6, '0');
    chekcOut.U_Customer = checkoutdata[0].U_Customer;
    chekcOut.U_Consultant = checkoutdata[0].U_Consultant;
    chekcOut.U_Project = checkoutdata[0].U_Project;
    chekcOut.U_Subgroup = checkoutdata[0].U_Subgroup;
    await CheckOutPatchAPi.getGlobalData(chekcOut).then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (chekcOut.U_NxtFollowup!.isNotEmpty &&
            chekcOut.U_NxtFollowup != null &&
            chekcOut.U_NxtFollowup != 'null') {
          callNFCheckOtApi(chekcOut.U_NxtFollowup!, postData);
        } else {
          await DataBaseHelper.deletePostedCheckin(chekcOut.clgCode!);
          await DataBaseHelper.deleteApproved(chekcOut.clgCode!);
          await DataBaseHelper.deleteFileCheckout(chekcOut.clgCode!);
          await DataBaseHelper.deletePostedCheckout(chekcOut.clgCode!);
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
      } else {}
    });
  }

  List<CheckinModel> data = [];
  List<GetActivityApvdData> cust = [];
  List<GetCheckedINData> checkedINData = [];
  void callNFCheckOtApi(String datefolle, CheckinModel data) async {
    //data = await DataBaseHelper.getPostCheckinData();
    // if (data.isNotEmpty) {
    cust = await DataBaseHelper.getSlctCustData(data.clgcode);
    checkedINData.add(
      GetCheckedINData(
        CardCode: cust[0].CardCode,
        CardName: cust[0].CardName,
        VisitReg: cust[0].Name,
        CntctTime: int.parse(data.ActivityTime.replaceAll(":", "")),
        CntctDate: data.ActivityDate,
        ClgCode: data.clgcode,
        Details: cust[0].Details,
        CntctSbjct: 0,
      ),
    );
    if (checkedINData.isNotEmpty) {}
    // }
    final CheckOutNFPModel purpVisitModel = new CheckOutNFPModel(
      Activity: '',
      SaleEmpCode: int.parse(GetValues.slpCode.toString()),
      U_PlanDate: datefolle,
      U_PlanTime: config.currentTimeServer(),
      cardCode: checkedINData[0].CardCode!,
      notes: checkedINData[0].Details!,
      subject: checkedINData[0].CntctSbjct!,
      PreviousActivity: checkedINData[0].ClgCode!,
    );
    await CheckOutNFPostAPi.getGlobalData(purpVisitModel).then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        await DataBaseHelper.deletePostedCheckin(data.clgcode);
        await DataBaseHelper.deleteApproved(data.clgcode);
        await DataBaseHelper.deleteFileCheckout(data.clgcode);
        await DataBaseHelper.deletePostedCheckout(data.clgcode);
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
      } else {}
    });
  }

  void createDB() {
    DataBaseHelper.createDB().then((value) {
      print("DB Created!!.......");
    });
  }

  int loadingCompleted = 0;
  @override
  void dispose() {
    super.dispose();
  }

  //charts
  void saleschartapi() async {
    //  await GetSalesChartApi.getSalesChartData().then((value) {
    //     setState(() {
    //       if (value.CustomerData != null) {
    //         salesdetails = value.CustomerData!;
    //         salesdata = salesdetails;
    //         generateChart(salesdata);
    //       }
    //     });
    //   });
  }

  void Collectionchartapi() async {
    await GetInPaymentChartApi.getInPaymentChartData().then((value) {
      if (mounted) {
        setState(() {
          if (value.CustomerData != null) {
            collectiondetails = value.CustomerData!;
            collectiondata = collectiondetails;
            generateCollectionChart(collectiondata);
          }
        });
      }
    });
  }

  void Volumechartapi() {
    // GetVolumeChartApi.getVolumeChartData().then((value) {
    //   setState(() {
    //     if (value.CustomerData != null) {
    //       volumedetails = value.CustomerData!;
    //       volumedata = volumedetails;
    //       generateVolumeChart(volumedata);
    //     }
    //   });
    // });
  }

  List<ChartRecord> targetsales = [];
  List<ChartRecord> achsales = [];

  List<CollectionChartRecord> col_targetsales = [];
  List<CollectionChartRecord> col_achsales = [];

  List<VolumeChartRecord> vol_targetsales = [];
  List<VolumeChartRecord> vol_achsales = [];
  double s = 1.4;
  double c = 1.4;
  double v = 1.4;
  void generateChart(List<SalesChartData> chartslist) {
    targetsales.clear();
    achsales.clear();
    setState(() {
      for (int i = 0; i < chartslist.length; i++) {
        targetsales.add(
          ChartRecord(
            name: chartslist[i].slpname,
            sales: chartslist[i].targetSales,
            barColor: Color(0xFF1c305d),
          ),
        );
        achsales.add(
          ChartRecord(
            name: chartslist[i].slpname,
            sales: chartslist[i].achSales,
            barColor: Color(0xFF294689),
          ),
        );
      }
    });
  }

  void generateCollectionChart(List<InPaymentChartData> chartslist) {
    col_targetsales.clear();
    col_achsales.clear();
    setState(() {
      for (int i = 0; i < chartslist.length; i++) {
        col_targetsales.add(
          CollectionChartRecord(
            name: chartslist[i].slpname,
            collection: chartslist[i].targetSales,
            barColor: Color(0xFF1c305d),
          ),
        );
        col_achsales.add(
          CollectionChartRecord(
            name: chartslist[i].slpname,
            collection: chartslist[i].achSales,
            barColor: Color(0xFF294689),
          ),
        );
      }
    });
  }

  void generateVolumeChart(List<VolumeChartData> chartslist) {
    vol_targetsales.clear();
    vol_achsales.clear();
    setState(() {
      for (int i = 0; i < chartslist.length; i++) {
        vol_targetsales.add(
          VolumeChartRecord(
            name: chartslist[i].slpname,
            volume: chartslist[i].targetSales,
            barColor: Color(0xFF1c305d),
          ),
        );
        vol_achsales.add(
          VolumeChartRecord(
            name: chartslist[i].slpname,
            volume: chartslist[i].achSales,
            barColor: Color(0xFF294689),
          ),
        );
      }
    });
  }

  List<charts.Series<ChartRecord, String>> cretaedChart() {
    return [
      new charts.Series<ChartRecord, String>(
        id: 'Desktop',
        domainFn: (ChartRecord sales, _) => sales.name,
        measureFn: (ChartRecord sales, _) => sales.sales,
        data: targetsales,
        overlaySeries: true,
        colorFn: (ChartRecord sales, _) =>
            charts.ColorUtil.fromDartColor(sales.barColor),
        labelAccessorFn: (ChartRecord sales, _) =>
            sales.sales.toStringAsFixed(0),
        displayName: "atatata",
      ),
      new charts.Series<ChartRecord, String>(
        id: 'Tablet',
        domainFn: (ChartRecord sales, _) => sales.name,
        measureFn: (ChartRecord sales, _) => sales.sales,
        data: achsales,
        colorFn: (ChartRecord sales, _) =>
            charts.ColorUtil.fromDartColor(sales.barColor),
        labelAccessorFn: (ChartRecord sales, _) =>
            sales.sales.toStringAsFixed(0),
        overlaySeries: true,
        displayName: "atatata",
      ),
    ];
  }

  List<charts.Series<CollectionChartRecord, String>> CollectionChart() {
    return [
      new charts.Series<CollectionChartRecord, String>(
        id: 'Desktop',
        domainFn: (CollectionChartRecord sales, _) => sales.name,
        measureFn: (CollectionChartRecord sales, _) => sales.collection,
        data: col_targetsales,
        colorFn: (CollectionChartRecord sales, _) =>
            charts.ColorUtil.fromDartColor(sales.barColor),
        overlaySeries: true,
        labelAccessorFn: (CollectionChartRecord sales, _) =>
            sales.collection.toStringAsFixed(0),
        displayName: "atatata",
      ),
      new charts.Series<CollectionChartRecord, String>(
        id: 'Tablet',
        domainFn: (CollectionChartRecord sales, _) => sales.name,
        measureFn: (CollectionChartRecord sales, _) => sales.collection,
        colorFn: (CollectionChartRecord sales, _) =>
            charts.ColorUtil.fromDartColor(sales.barColor),
        labelAccessorFn: (CollectionChartRecord sales, _) =>
            sales.collection.toStringAsFixed(0),
        data: col_achsales,
        overlaySeries: true,
        displayName: "atatata",
      ),
    ];
  }

  List<charts.Series<VolumeChartRecord, String>> VolumeChart() {
    return [
      new charts.Series<VolumeChartRecord, String>(
        id: 'Desktop',
        domainFn: (VolumeChartRecord sales, _) => sales.name,
        measureFn: (VolumeChartRecord sales, _) => sales.volume,
        colorFn: (VolumeChartRecord sales, _) =>
            charts.ColorUtil.fromDartColor(sales.barColor),
        labelAccessorFn: (VolumeChartRecord sales, _) =>
            sales.volume.toStringAsFixed(0),
        data: vol_targetsales,
        overlaySeries: true,
        displayName: "atatata",
      ),
      new charts.Series<VolumeChartRecord, String>(
        id: 'Tablet',
        domainFn: (VolumeChartRecord sales, _) => sales.name,
        colorFn: (VolumeChartRecord sales, _) =>
            charts.ColorUtil.fromDartColor(sales.barColor),
        measureFn: (VolumeChartRecord sales, _) => sales.volume,
        labelAccessorFn: (VolumeChartRecord sales, _) =>
            sales.volume.toStringAsFixed(0),
        data: vol_achsales,
        overlaySeries: true,
        displayName: "atatata",
      ),
    ];
  }

  //
  //

  void callServiceLayerApi() async {
    final preff = await SharedPreferences.getInstance();
    PostLoginAPi.username =
        preff.getString('sapUserName'); //'crmapp';//sapUserName;
    PostLoginAPi.password = preff.getString('sapPassword');
    final pref2 = await pref;
    GetValues.sapDB = preff.getString('SapDB');
    GetValues.slpCode = preff.getString('SlpCode');
    log("url: ${preff.getString('sapUrl')}, user ${preff.getString('sapUserName')}, pass ${preff.getString('sapPassword')} ");
    URL.url = preff.getString('sapUrl')!;

    //'Tanzania';sapUserPass;//Tanzania crmapp
    //  print( "sap name"+PostLoginAPi.username.toString());
    //     print( "sap password"+PostLoginAPi.password.toString());
    await PostLoginAPi.getGlobalData().then((value) async {
      print("SapDBdbdbdb: ${value.stCode!}" + GetValues.sapDB.toString());
      if (value.stCode! >= 200 && value.stCode! <= 210) {
        if (value.sessionId != null) {
          pref2.setString("sessionId", value.sessionId.toString());
          pref2.setString("sessionTimeout", value.sessionTimeout.toString());
          print("sessionID: " + value.sessionId.toString());
          //    Future.delayed(const Duration(seconds: 2), () {
          getSession();
        }
      } else if (value.stCode! >= 400 && value.stCode! <= 410) {
        if (value.error!.code != null) {
          setState(() => loadingscrn = false);
          final snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              bottom: Screens.heigth(context) * 0.3,
            ),
            duration: Duration(seconds: 4),
            backgroundColor: Colors.red,
            content: Text(
              "${value.error!.message!.value}\nCheck Your Sap Details !!..",
              style: const TextStyle(color: Colors.white),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Future.delayed(const Duration(seconds: 5), () {
            exit(0);
          });
        }
      } else if (value.stCode == 500) {
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: Screens.heigth(context) * 0.3,
          ),
          duration: Duration(seconds: 4),
          backgroundColor: Colors.red,
          content: Text(
            "Opps Somthing went wrong !!..",
            style: const TextStyle(color: Colors.white),
          ),
        );
      } else {
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: Screens.heigth(context) * 0.3,
          ),
          duration: Duration(seconds: 4),
          backgroundColor: Colors.red,
          content: Text(
            "Opps Somthing went wrong !!..",
            style: const TextStyle(color: Colors.white),
          ),
        );
      }
    });
  }

  //String? sessionID;
  void getSession() async {
    final preff = await SharedPreferences.getInstance();
    GetValues.sessionID = preff.getString('sessionId');
    GetValues.crmUserID = preff.getString('crmUserID');
    GetValues.sapUserName = preff.getString('sapUserName');
    // print('sessionId........'+GetValues.sessionID .toString());
    //  print('crmUserID........'+ GetValues.crmUserID .toString());
    //  print('sapUserName........'+ GetValues.sapUserName .toString());
    getSapUserID();
  }

  void getSapUserID() async {
    await SapUserIDAPi.getGlobalData().then((value) {
      if (value.sapUserIDValue != null) {
        //value.sapUserIDValue!.length>0 &&
        //   print("code...."+value.sapUserIDValue![0].InternalKey.toString());
        if (value.sapUserIDValue!.isNotEmpty) {
          GetValues.sapUserID = value.sapUserIDValue![0].InternalKey.toString();
          callAprovals();
          callNotesApi();
          callSeriesApi();
          ploadCheckinCheckout();
          // if (mounted) {
          //   setState(() => loadingscrn = false);
          // }
        }
      } else if (value.error != null) {
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: Screens.heigth(context) * 0.3,
          ),
          backgroundColor: Colors.red,
          content: Text(
            '${value.error!.code}!!..',
            style: const TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Future.delayed(const Duration(seconds: 5), () {
          exit(0);
        });
      }
    });
  }

  int notes = 0;
  int total = 0;
  List<NotesData> notesData = [];
  void callNotesApi() async {
    int reads = 0;
    await NotesAPi.getGlobalData().then((value) {
      if (value.notesData != null) {
        loadingCompleted = loadingCompleted + 1;
        if (mounted) {
          setState(() {
            print(value.notesData![0].HeaderId);
            notesData = value.notesData!;
            total = value.notesData![0].total!;
            reads = value.notesData![0].read!;
            notes = total - reads;
            print("ans: $notes");
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
      }
    });
  }

  void callAprovals() async {
    await ApprovalsAPi.getGlobalData().then((value) {
      if (value.approvalsvalue!.isNotEmpty) {
        loadingCompleted = loadingCompleted + 1;
        if (mounted) {
          setState(() {
            print(
              "approvalsvalue: " + value.approvalsvalue![0].ObjType.toString(),
            );
            print("FromUser: " + value.approvalsvalue![0].FromUser.toString());
            aprovals = value.approvalsvalue!;
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
      } else if (value.approvalsvalue!.isEmpty) {
        //   const snackBar = SnackBar(
        //   duration:  Duration(seconds: 4),
        //   backgroundColor: Colors.red,
        //   content: Text(
        //     'No Approvals!!..',
        //     style: const TextStyle(color: Colors.white),
        //   ),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // Future.delayed(const Duration(seconds: 5),(){
        //  Navigator.pop(context);
        //  });
      }
    });
  }

  String? isauth;
  void getAllMEthods() async {
    final preff = await SharedPreferences.getInstance();
    // setState(() {
    GetValues.UserToken = preff.getString('FCMToken');
    GetValues.LeadToken = preff.getString('LeadToken');
    GetValues.deviceID = preff.getString('deviceID');
    GetValues.userName = preff.getString('UserName');
    GetValues.branch = preff.getString('branch');
    GetValues.slpCode = preff.getString('SlpCode');
    GetValues.userRoll = preff.getString('userRoll');
    GetValues.U_CrpUsr = preff.getString('U_CrpUsr');
    // "Yes";
    //
    //

    log("U_CrpUsr::::UUUU::::" + GetValues.U_CrpUsr.toString());
    log("U_CrpUsr::::UUUUBBBBB::::" + preff.getString('U_CrpUsr').toString());
    //  auth(preff);
    // }
    // );
  }

  // void auth(SharedPreferences preff) async {
  //   final pref2 = await pref;
  //   if (pref2.containsKey('y') == true) {
  //     isauth = preff.getString('y')!;
  //     //     print("object");
  //   }
  //   if (isauth == null) {
  //    // checkLocalAuth();
  //   }
  // }

  bool loadingscrn = true;
  String msg = '';
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(context, _scaffoldKey, widget.title),
      drawer: drawer(context),
      body: Stack(
        children: [
          ListView(
            children: [
              // _BuildSwiper(),
              // ChartSwiper(context),
              const SizedBox(height: Const.space25),

              // _BuildLabelSection(
              //   label:"Quick Menu" ,//AppLocalizations.of(context)!.categories,
              //   onViewAllTap: () => Get.toNamed<dynamic>(FurneyRoutes.category),
              // ),
              BuildCategory2(itemCount: topCategoryList(context)),
              const SizedBox(height: Const.space12),
              // const _BuildCategoryList(),
              const SizedBox(height: Const.space25),
              _BuildLabelSection(
                label: notes > 0 ? 'Notes $notes/$total' : 'Notes',
                //AppLocalizations.of(context)! .notes,
                //com.byneetdev.ultimate_bundle
                onViewAllTap: ()
                    //   {
                    //     StreamDataAPi.getGlobalData();
                    // //   StreamDataAPi.mainss();
                    //   }
                    =>
                    Get.toNamed<dynamic>(
                  FurneyRoutes.notesPage,
                  arguments: AppLocalizations.of(context)!.notes,
                ),
              ),
              const SizedBox(height: Const.space12),
              _BuildScrollableList(
                notes: notesData,
              ),
              const SizedBox(height: Const.space25),
              _BuildLabelSection(
                label: AppLocalizations.of(context)!.approvals,
                onViewAllTap: () => Get.toNamed<dynamic>(
                  FurneyRoutes.approvalsNew,
                  arguments: AppLocalizations.of(context)!.approvals,
                ),
              ),
              const SizedBox(height: Const.space12),
              _BuildVerticalList(
                aproval: aprovals,
              ),
              const SizedBox(height: 20),
            ],
          ),
          Visibility(
            visible:
                loadingscrn, //loadingCompleted==3?false:true,// loadingscrn,
            child: loadingscrn == true && msg == 'No Internet'
                ? Container(
                    alignment: Alignment.center,
                    width: Screens.width(context),
                    height: Screens.heigth(context),
                    padding: EdgeInsets.all(20),
                    color: Colors.white,
                    child: Center(
                      child: Text(
                          "You have no internet so you can access only checkin and checkout"),
                    ),
                  )
                : Container(
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

  Container ChartSwiper(BuildContext context) {
    return Container(
      width: Screens.width(context),
      height: Screens.width(context) / 2,
      margin: const EdgeInsets.symmetric(horizontal: Const.margin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        // color: Colors.black,
      ),
      child: Swiper(
        itemCount: 2,
        autoplay: true,
        itemBuilder: (context, index) {
          //   final data = SwiperList.series[index];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              // image: DecorationImage(
              //   fit: BoxFit.fitWidth,
              //   image: CachedNetworkImageProvider(data.images!.first),
              // ),

              // color: Colors.red
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: collectiondata.isNotEmpty
                  ? SizedBox(
                      // color: Colors.red,
                      width: targetsales.length <= 3
                          ? Screens.width(context)
                          : Screens.width(context) * s,
                      height: Screens.heigth(context) * 0.28,
                      child: Center(
                        child: charts.BarChart(
                          CollectionChart(),
                          animate: true,
                          barGroupingType: charts.BarGroupingType.grouped,
                          barRendererDecorator: new charts.BarLabelDecorator(
                              outsideLabelStyleSpec:
                                  new charts.TextStyleSpec(fontSize: 10),
                              insideLabelStyleSpec:
                                  new charts.TextStyleSpec(fontSize: 10)),
                        ),
                      ),
                    )
                  : salesdata.isNotEmpty
                      ? SizedBox(
                          // color: Colors.blue,
                          // color: theme.primaryColor.withOpacity(0.5),
                          width: targetsales.length <= 3
                              ? Screens.width(context)
                              : Screens.width(context) * s,
                          height: Screens.heigth(context) * 0.28,
                          child: Center(
                            child: charts.BarChart(
                              cretaedChart(),
                              animate: true,
                              barGroupingType: charts.BarGroupingType.grouped,
                              barRendererDecorator: new charts
                                  .BarLabelDecorator(
                                  outsideLabelStyleSpec:
                                      new charts.TextStyleSpec(fontSize: 10),
                                  insideLabelStyleSpec:
                                      new charts.TextStyleSpec(fontSize: 10)),
                            ),
                          ),
                        )
                      : volumedata.isNotEmpty
                          ? SizedBox(
                              // color: Colors.green,
                              // color: theme.primaryColor.withOpacity(0.5),
                              width: targetsales.length <= 3
                                  ? Screens.width(context)
                                  : Screens.width(context) * s,
                              height: Screens.heigth(context) * 0.28,
                              child: Center(
                                child: charts.BarChart(
                                  VolumeChart(),
                                  animate: true,
                                  barGroupingType:
                                      charts.BarGroupingType.grouped,
                                  barRendererDecorator:
                                      new charts.BarLabelDecorator(
                                          outsideLabelStyleSpec:
                                              new charts.TextStyleSpec(
                                                  fontSize: 10),
                                          insideLabelStyleSpec:
                                              new charts.TextStyleSpec(
                                                  fontSize: 10)),
                                ),
                              ),
                            )
                          : SizedBox(
                              // color: theme.primaryColor.withOpacity(0.5),
                              width: Screens.width(context),
                              height: Screens.heigth(context) * 0.28,
                              child: Center(
                                child: charts.BarChart(
                                  SwiperList.series,
                                  animate: true,
                                  animationDuration:
                                      const Duration(milliseconds: 500),
                                  barGroupingType:
                                      charts.BarGroupingType.stacked,
                                ),
                              ),
                            ),
            ),
          );
        },
      ),
    );
  }

  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  String isauthticate = '';
  // Future<void> checkLocalAuth() async {
  //   final localAuth = LocalAuthentication();
  //   final canCheckBiometrics = await localAuth.canCheckBiometrics;
  //   List<BiometricType> availableBiometrics =
  //       await localAuth.getAvailableBiometrics();
  //   print(
  //       "canCheckBiometrics : " + canCheckBiometrics.toString()); //no security
  //   if (canCheckBiometrics) {
  //     try {
  //       final didAuthenticate = await localAuth.authenticate(
  //           useErrorDialogs: true,
  //           stickyAuth: true,
  //           localizedReason: 'Please authenticate to open app');
  //       if (didAuthenticate) {
  //         setState(() {
  //           setlocalauth();
  //         });
  //         print('didAuthenticate: ' + didAuthenticate.toString());
  //       } else if (didAuthenticate == false) {
  //         print('didAuthenticate trueee: ' + didAuthenticate.toString());
  //         exit(0);
  //         //  const snackBar =  SnackBar(
  //         //   duration: Duration(seconds: 1),
  //         //   backgroundColor: Colors.white,
  //         //   content: Text(
  //         //     "Please Enter Correct Pin!!..",
  //         //     style: TextStyle(
  //         //          color: Colors.red
  //         //         ),
  //         //   ),
  //         // );
  //         //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //       }
  //     } on PlatformException catch (e) {
  //       //  print("eception: "+e.toString());
  //       //final snackbar =
  //     }
  //   } else {
  //     print('no authentication!!!........');
  //   }
  // }

  void setlocalauth() async {
    final pref2 = await pref;
    await pref2.setString('y', isauthticate);
  }
//  Widget  bottomsheet(){
//    return

//    Container();
// }

  // _modalBottomSheetMenu(){
  //     showModalBottomSheet(
  //         context: context,
  //         builder: (builder){
  //           return  Container(
  //             height: 350.0,
  //             color: Colors.transparent, //could change this to Color(0xFF737373),
  //                        //so you don't have to change MaterialApp canvasColor
  //             child: new Container(
  //                 decoration: new BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: new BorderRadius.only(
  //                         topLeft: const Radius.circular(10.0),
  //                         topRight: const Radius.circular(10.0))),
  //                 child: new Center(
  //                   child: new Text("This is a modal sheet"),
  //                 )),
  //           );
  //         }
  //     );
  //   }

  void callSeriesApi() async {
    await SeriesAPi.getGlobalData().then((value) {
      if (value.Series != null) {
        loadingCompleted = loadingCompleted + 1;
        GetValues.seriresOrder = value.Series.toString();
        print("seriessssszzz::: " + GetValues.seriresOrder.toString());
        // setState(() {
        //    setState(() => loadingscrn = false);
        // });
      } else if (value.error != null) {
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: Screens.heigth(context) * 0.3,
          ),
          backgroundColor: Colors.red,
          content: Text(
            '${value.error!.code}\n${value.error!.message!.value}!!..',
            style: const TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }
}

class ChartRecord {
  String name;
  double sales;
  final Color barColor;

  ChartRecord({
    required this.name,
    required this.sales,
    required this.barColor,
  });
}

class VolumeChartRecord {
  String name;
  double volume;
  final Color barColor;

  VolumeChartRecord({
    required this.name,
    required this.volume,
    required this.barColor,
  });
}

class CollectionChartRecord {
  String name;
  double collection;
  final Color barColor;

  CollectionChartRecord({
    required this.name,
    required this.collection,
    required this.barColor,
  });
}
