// ignore_for_file: invariant_booleans, prefer_interpolation_to_compose_strings, unawaited_futures, cascade_invocations, unnecessary_parenthesis, unused_local_variable, prefer_final_locals, omit_local_variable_types, avoid_void_async, directives_ordering, library_private_types_in_public_api

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
// import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:platform_device_id_v3/platform_device_id.dart';
import 'package:share/share.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/appVersion.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/checkVersion/checkVersionApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/checkapi/checkUserApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
//import 'package:ultimate_bundle/src/furney/src/Api/checkapi/checkUserApi.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class FurneySplashScreen extends StatefulWidget {
  const FurneySplashScreen({Key? key}) : super(key: key);
  @override
  _FurneySplashScreenState createState() => _FurneySplashScreenState();
}

class _FurneySplashScreenState extends State<FurneySplashScreen> {
  Future<SharedPreferences> pref = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _addBadge();
    setBadgeNum();
    showConnection();
    connectivityAlert();
  }

  void _addBadge() {
    FlutterAppBadger.updateBadgeCount(1);
  }

  @override
  void dispose() {
    subscription!.cancel();
    super.dispose();
  }

  bool visibleLoading = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SingleChildScrollView(
        child: Container(
          width: Screens.width(context),
          height: Screens.heigth(context),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/CRM/newsplash.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Screens.heigth(context) * 0.7,
              ),
              Text(
                'Customer Relationship at your fingerpoint',
                style: TextStyles.whiteText(context),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              Text(
                'Version ${AppVersion.version}',
                style: TextStyles.whiteText(context),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              InkWell(
                onTap: () {
                  Share.share(
                    'Dear Sir/Madam,\n Kindly Register My Mobile For CRM App,\n My Device ID : \n $deviceId \n Thanks & Regards',
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: Screens.width(context) * 0.4,
                  // color: Colors.red,
                  child: Text(deviceId, style: TextStyles.whiteText(context)),
                ),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.1,
              ),
              Visibility(
                visible: visibleLoading,
                child: const SpinKitThreeBounce(
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String deviceId = '';
  // Future fetchData() async {
  //   var deviceId = '';
  //   final deviceInfoPlugin = DeviceInfoPlugin();
  //   try {
  //     if (Platform.isAndroid) {
  //       var build = await deviceInfoPlugin.androidInfo;
  //       //  _deviceName=build.model;
  //       //  _deviceVersion = build.version.toString();
  //       deviceId = ''; // build.androidId!; //device id
  //       deviceId = deviceId;
  //      // print("device id: " + _deviceId);
  //       final pref2 = await pref;
  //       await pref2.setString('deviceID', deviceId);

  //     } else if (Platform.isIOS) {
  //       var data = await deviceInfoPlugin.iosInfo;
  //       //    _deviceName = data.name;
  //       //    _deviceVersion = data.systemVersion;
  //       deviceId = data.identifierForVendor!;
  //       deviceId = deviceId;
  //       print('deviceId $deviceId');
  //     }
  //   } on PlatformException {
  //     deviceId = 'Failed to get deviced id';
  //   }
  // }

  Future<String> getDeviceId() async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    return deviceId ?? '';
  }

  bool noInternet = false;
  StreamSubscription? subscription;
  void connectivityAlert() async {
    subscription = Connectivity().onConnectivityChanged.listen((event) async {
      //   print("event"+event.toString());
      final hasInternet = event != ConnectivityResult.none;
      if (hasInternet == true) {
        // setState(() async {
        noInternet = false;
        visibleLoading = true;
        var preff = await SharedPreferences.getInstance();
        // print("sssssssss");
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        checkAuth();
        CheckUserAPi.deviceId = deviceId; //deviceId ;
        //
        //       Future.delayed(
        //  const Duration(seconds: 3),
        //   () => Get.offAllNamed<dynamic>(FurneyRoutes.signIn),
        //);
        if (preff.getString('countryCode') != null) {
          URL.urlLocal = preff.getString('localURL')!;
          URL.dynamicUrl = preff.getString('queryUrl')!;
          URL.reportUrl = preff.getString('reportUrl')!;
          checkVersion();
        } else {
          Get.offAllNamed<dynamic>(FurneyRoutes.signIn);
        }
        // callUSerApi();
        // });
      } else if (hasInternet == false) {
        // Utils.showTopSnackBar(context, "You have no internet", Colors.red);
        setState(() {
          noInternet = true;
          //  print("aaaaaaaaaaaaaaa");
          visibleLoading = false;
          showConnection();
        });
      }
    });
  }

  void checkVersion() async {
    await CheckVersionAPi.getGlobalData().then((value) {
      if (value.deviceData != null) {
        print(value.deviceData![0].Version);
        setState(() {
          toLaunch = value.deviceData![0].Url;
          content = value.deviceData![0].Content;
        });
        if (AppVersion.version == value.deviceData![0].Version) {
          log('comeeeeee111: ');
          callUSerApi();
        } else {
          setState(() {
            visibleLoading = false;
          });
          updateDialog();
        }
      }
    });
  }

  String? content;
  Future<void> updateDialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return WillPopScope(
              onWillPop: dialogBackBun,
              child: AlertDialog(
                //content:
                title: Text(
                  'Update is Available!!',
                  style: GoogleFonts.poppins(
                    color: Colors.indigo,
                  ),
                ),
                content: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [Text(content.toString())],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      //  Navigator.of(context).pop();
                      // Navigator.of(context).pop(true);
                      exit(0);
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    child: Text(
                      'No',
                      style: GoogleFonts.poppins(
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      setState(() {
                        _launchInBrowser(toLaunch!);
                      });
                    },
                    child: Text(
                      'Yes',
                      style: GoogleFonts.poppins(
                        color: Colors.indigo,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  String? toLaunch;
  //"https://drive.google.com/file/d/15zlBCFGgrZLuklr4dlGloltjCPryxEUv/view?usp=sharing";
  Future<void> _launchInBrowser(String url) async {
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

  DateTime? currentBackPressTime;
  Future<bool> dialogBackBun() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 1)) {
      setState(() {
        currentBackPressTime = now;
      });
      return Future.value(false);
    }
    return Future.value(false);
  }

  //FCM ID;
  final firebaseMessaging = FirebaseMessaging.instance;
  Future<String?> getToken() async {
    return firebaseMessaging.getToken();
  }
//  void  setBadgeNum1(int count, BuildContext context) async {
//     try {
//       if(Platform.isAndroid)
//       {
//       await FlutterDynamicIcon.setApplicationIconBadgeNumber(count);
//     }} on PlatformException {
//       print('Exception: Platform not supported');
//     } catch (e) {
//       print(e);
//     }
//     // To get currently badge number that was set.
//     int badgeNumber = await FlutterDynamicIcon.getApplicationIconBadgeNumber();
//     // Quick alert box for acknowledgement
//     // showDialog(
//     //   context: context,

//     //   title: 'Badge Number set as $badgeNumber',
//     //   text: 'Minimize the app to check it out!',
//     //   type: QuickAlertType.success,
//     //   confirmBtnColor: primaryColor,
//     // );
//   }

  void setBadgeNum() async {
    log('AAAAAAA1111');
    String appBadgeSupported;
    try {
      bool res = await FlutterAppBadger.isAppBadgeSupported();
      if (res) {
        appBadgeSupported = 'Supported';
        log('AAAA22222');
        FlutterAppBadger.updateBadgeCount(1);
      } else {
        appBadgeSupported = 'Not supported';
        log('AAAA');
      }
    } on PlatformException {
      print('Exception: Platform not supported');
    } catch (e) {
      log('ABAA::' + e.toString());
    }
  }

  void callUSerApi() async {
    String? tokenFCM = await getToken();
    log('FCM Token: $tokenFCM');

    await CheckUserAPi.getGlobalData(tokenFCM!).then((value) async {
      if (value.loginUserData != null) {
        print('username: ' + value.loginUserData![0].userName.toString());
        final pref2 = await pref;
        pref2.setString(
          'UserName',
          value.loginUserData![0].userName.toString(),
        );
        pref2.setString(
          'userCode',
          value.loginUserData![0].userCode.toString(),
        );
        pref2.setString(
          'userRoll',
          value.loginUserData![0].userRoll.toString(),
        );
        pref2.setString('active', value.loginUserData![0].active.toString());
        pref2.setString('branch', value.loginUserData![0].branch.toString());
        pref2.setString('email', value.loginUserData![0].email.toString());
        pref2.setString('crmUserID', value.loginUserData![0].id.toString());
        pref2.setString(
          'password',
          value.loginUserData![0].password.toString(),
        );
        pref2.setString(
          'reportTo',
          value.loginUserData![0].reportTo.toString(),
        );
        pref2.setString(
          'sapPassword',
          value.loginUserData![0].sapPassword.toString(),
        );
        pref2.setString('sapUrl', value.loginUserData![0].sapUrl.toString());
        URL.url = value.loginUserData![0].sapUrl.toString();
        print('sapUrl:' + URL.url);
        pref2.setString(
          'sapUserName',
          value.loginUserData![0].sapUserName.toString(),
        );
        pref2.setString('SlpCode', value.loginUserData![0].slpCode.toString());
        pref2.setString(
          'DeviceCode',
          value.loginUserData![0].deviceCode.toString(),
        );
        pref2.setString('SapDB', value.loginUserData![0].sapDB.toString());
        pref2.setString(
          'LeadToken',
          value.loginUserData![0].ManagerFCM.toString(),
        );
        pref2.setString('FCMToken', value.loginUserData![0].FCM.toString());
        pref2.setString(
          'U_CrpUsr',
          value.loginUserData![0].U_CrpUsr.toString(),
        );
        Get.offAllNamed<dynamic>(FurneyRoutes.home);
      } else if (value.loginUserData == null && value.status == false) {
        Get.offAllNamed<dynamic>(FurneyRoutes.signIn);
      } else if (value.error != null) {
        setState(() => visibleLoading = false);
        final snackBar = SnackBar(
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          content: Text(
            value.error.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  void checkAuth() async {
    final pref2 = await pref;
    await pref2.remove('y');
  }

  void showConnection() async {
    deviceId = await getDeviceId();
    var preff = await SharedPreferences.getInstance();
    final pref2 = await pref;

    pref2.setString("deviceID", deviceId);
    final result = await Connectivity().checkConnectivity();
    //  print("111111111"+result.toString());
    final hasInternet = result != ConnectivityResult.none;
    //  print("1res"+(result != ConnectivityResult.none).toString());
    if (hasInternet == false) {
      setState(() {
        noInternet = true;
        visibleLoading = false;
      });
      //   print("2"+hasInternet.toString());
      // final message = "You Have No Internet !!..";
      // final color = Colors.red;
      // Utils.showTopSnackBar(context, message, color);
      const snackBar = SnackBar(
        duration: Duration(days: 1),
        backgroundColor: Colors.white,
        content: Text(
          'You Have No Internet Please Check!!..',
          style: TextStyle(color: Colors.red),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Future.delayed(
        const Duration(seconds: 1),
        (() {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          Get.offAllNamed<void>(FurneyRoutes.dashBoard);
        }),
      );
    } else {
      setState(() {
        noInternet = false;
        visibleLoading = true;
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
      });
    }
    // print("3"+hasInternet.toString());
  }
}
