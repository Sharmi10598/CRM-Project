// import 'dart:async';
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:platform_device_id_v3/platform_device_id.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/helpers/uikit_model.dart';
import 'package:ultimate_bundle/src/appVersion.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/checkapi/checkUserApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/getMenuApi/GetMenuApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/CheckVersionpage/Configuration.dart';
import 'package:ultimate_bundle/src/furney/src/pages/Setting/SettingPage.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sign_in/sign_in_page.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class FurneySplashScreen extends StatefulWidget {
  const FurneySplashScreen({Key? key}) : super(key: key);
  @override
  FurneySplashScreenState createState() => FurneySplashScreenState();
}

class FurneySplashScreenState extends State<FurneySplashScreen> {
  Future<SharedPreferences> pref = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    showVersion(context);

    // checkVesionNum();
    _addBadge();
    setBadgeNum();
    showConnection();
    // connectivityAlert();
  }

  callGetAuthMenuApi() async {
    final pref2 = await SharedPreferences.getInstance();
    var menuListItem22x = '';
    var menuListItem22y = '';
    final getMenuId = pref2.getString('Id').toString();
    await GetMenuAuthAPi.getGlobalData(getMenuId).then((value) async {
      FurneySignInScreenState.menuListItem22 = value.response;
      menuListItem22x =
          FurneySignInScreenState.menuListItem22.toString().replaceAll('[', '');
      menuListItem22y = menuListItem22x.replaceAll(']', '');
      FurneySignInScreenState.menuListItem22 = menuListItem22y;
      FurneySignInScreenState.menuListItem =
          FurneySignInScreenState.menuListItem22.toString().split(',');
      await Get.offAllNamed<dynamic>(FurneyRoutes.home);
      log('menuListItem22 length::${FurneySignInScreenState.menuListItem22}');
    });
  }

  // String appName = '';
  // String packageName = '';
  // String versionNumber = '';
  // String buildNumber = '';
  // getVersionInfromation() async {
  //   appName = '';
  //   packageName = '';
  //   versionNumber = '';
  //   buildNumber = '';
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   appName = packageInfo.appName;
  //   packageName = packageInfo.packageName;
  //   versionNumber = packageInfo.version;
  //   buildNumber = packageInfo.buildNumber;
  //   log('versionNumber::$versionNumber');
  // }

  void _addBadge() {
    FlutterAppBadger.updateBadgeCount(1);
  }

  bool visibleLoading = true;
  String? plyStoreVersionNumber = '';
  Future<void> showVersion(BuildContext context) async {
    var config = Configuration();
    var packageInfo = await PackageInfo.fromPlatform();
    AppVersion.version = packageInfo.version;

    bool? netbool = await config.haveInterNet();

    if (netbool == true) {
      log('messagemmmmm');
      checkVesionNum(context);
    } else {
      showSnackBar('Check your internet !!..', context);
    }
  }

  void showSnackBar(String msg, BuildContext context) {
    final sn = SnackBar(
      content: Text(
        '$msg',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.maybeOf(context)!.showSnackBar(sn);
  }
  // void showSnackBar(String msg, BuildContext context) {
  //   final sn = SnackBar(
  //     content: Text(
  //       "$msg",
  //       style: TextStyle(color: Colors.white),
  //     ),
  //     backgroundColor: Colors.red,
  //   );
  //   ScaffoldMessenger.maybeOf(context)!.showSnackBar(sn);
  // }

  Future<void> checkVesionNum(BuildContext context) async {
    var checkverConfig = CheckVersionConfig();

    visibleLoading = true;
    plyStoreVersionNumber =
        await checkverConfig.getStoreVersion('com.buson.insigniacrm');
    log('versionNumber11::$plyStoreVersionNumber::AppVersionversion11::${AppVersion.version}');

    if (plyStoreVersionNumber != null) {
      if (plyStoreVersionNumber == AppVersion.version) {
        connectivityAlert();
      } else {
        log('versionNumber22::$plyStoreVersionNumber::AppVersionversion22::${AppVersion.version}');

        await Future.delayed(
          const Duration(seconds: 1),
          () {
            visibleLoading = true;
            updateDialog(context);
          },
        );
      }
    }
  }

  updateDialog(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SizedBox(
            width: Screens.width(context) * 0.25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Update Available',
                  style: theme.textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: Screens.heigth(context) * 0.01,
                ),
                Text(
                  'There is a new version of the app',
                  style: theme.textTheme.bodyMedium,
                ),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        height: Screens.heigth(context) * 0.1,
                        width: Screens.width(context) * 0.25,
                        padding:
                            EdgeInsets.all(Screens.heigth(context) * 0.008),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Image.asset(
                          'assets/CRM/applogo.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.all(Screens.heigth(context) * 0.008),
                        child: Text(
                          'Version : $plyStoreVersionNumber',
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Screens.heigth(context) * 0.01,
                ),
                SizedBox(
                  width: Screens.width(context) * 0.3,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                    ),
                    onPressed: () async {
                      if (Platform.isAndroid || Platform.isIOS) {
                        final appId = Platform.isAndroid
                            ? 'com.buson.insigniacrm'
                            : 'com.buson.insigniacrm';
                        final url = Uri.parse(
                          Platform.isAndroid
                              ? 'https://play.google.com/store/apps/details?id=com.buson.insigniacrm'
                              : 'https://apps.apple.com/app/id$appId',
                        );
                        await DefaultCacheManager().emptyCache();
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        ).then((value) {});
                      }
                    },
                    child: Text(
                      'Update',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    subscription!.cancel();
    super.dispose();
  }

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
    var deviceId = await PlatformDeviceId.getDeviceId;
    return deviceId ?? '';
  }

  bool noInternet = false;
  StreamSubscription? subscription;

  // Future<void> checkVesionNum() async {
  //   CheckVersionConfig checkverConfig = CheckVersionConfig();

  //   visibleLoading = true;
  //   String? plyStoreVersionNumber =
  //       await checkverConfig.getStoreVersion('com.buson.insigniacrm');
  //   if (plyStoreVersionNumber == AppVersion.version) {
  //     connectivityAlert();
  //     log('versionNumber11::$plyStoreVersionNumber::AppVersionversion11::${AppVersion.version}');
  //   } else {
  //     final theme = Theme.of(context);

  //     log('versionNumber22::$plyStoreVersionNumber::AppVersionversion22::${AppVersion.version}');

  //     await Future.delayed(
  //       const Duration(seconds: 1),
  //       () {
  //         visibleLoading = true;
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             duration: const Duration(seconds: 7),
  //             backgroundColor: Colors.white,
  //             content: Text(
  //               'Please Download the Latest Version($plyStoreVersionNumber) From PlayStore',
  //               style: TextStyle(color: theme.primaryColor),
  //             ),
  //           ),
  //         );
  //       },
  //     );

  // final snackBar = SnackBar(
  //   duration: Duration(seconds: 5),
  //   backgroundColor: Colors.red,
  //   content: Text(
  //     'Please Download the Latest Version From PalyStore',
  //     style: TextStyle(color: Colors.white),
  //   ),
  // );
  // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // Future.delayed(
  //   const Duration(seconds: 2),
  //   () {
  //     Get.back<dynamic>();
  //     visibleLoading = true;
  //   },
  // );
  //   }
  // }

  void connectivityAlert() async {
    subscription = Connectivity().onConnectivityChanged.listen((event) async {
      //   print("event"+event.toString());
      final hasInternet = event != ConnectivityResult.none;
      if (hasInternet == true) {
        // setState(() async {
        noInternet = false;
        visibleLoading = true;
        var preff = await SharedPreferences.getInstance();
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        await checkAuth();
        CheckUserAPi.deviceId = deviceId; //deviceId ;

        if (preff.getString('countryCode') != null &&
            preff.getString('userCode') != null &&
            preff.getString('UserName') != null) {
          URL.urlLocal = preff.getString('localURL')!;
          URL.dynamicUrl = preff.getString('queryUrl')!;
          URL.reportUrl = preff.getString('reportUrl')!;

          log('urlLocal::${URL.urlLocal}');
          log('dynamicUrl::${URL.dynamicUrl}');
          log('reportUrl::${URL.reportUrl}');
          await checkVersion();
        } else {
          await preff.remove('countryCode');
          SettingWidgetState.mycontroller[3].text = '';

          await Get.offAllNamed<dynamic>(FurneyRoutes.signIn);
        }
        // callUSerApi();
        // });
      } else if (hasInternet == false) {
        setState(() {
          noInternet = true;
          visibleLoading = false;
          showConnection();
        });
      }
    });
  }

  checkVersion() async {
    // await CheckVersionAPi.getGlobalData().then((value) async { --commanded by sharmi
    //   if (value.deviceData != null) {
    //     print(value.deviceData![0].Version);
    //     setState(() {
    //       toLaunch = value.deviceData![0].Url;
    //       content = value.deviceData![0].Content;
    //     });
    //     if (AppVersion.version == value.deviceData![0].Version) {
    await callUserApi();
    //     } else {
    //       setState(() {
    //         visibleLoading = false;
    //       });
    //       updateDialog();
    //     }
    //   }
    // });
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
    var now = DateTime.now();
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

  Future<void> setBadgeNum() async {
    String appBadgeSupported;
    try {
      final res = await FlutterAppBadger.isAppBadgeSupported();
      if (res) {
        appBadgeSupported = 'Supported';
        await FlutterAppBadger.updateBadgeCount(1);
      } else {
        appBadgeSupported = 'Not supported';
      }
    } on PlatformException {
    } catch (e) {
      log('ABAA::$e');
    }
  }

  callUserApi() async {
    final tokenFCM = await getToken();
    log('FCM Token: $tokenFCM');
    final pref2 = await pref;

    await CheckUserAPi.getGlobalData(tokenFCM!).then((value) async {
      if (value.loginUserData != null) {
        await pref2.setString(
          'UserName',
          value.loginUserData![0].userName.toString(),
        );
        await pref2.setString(
          'userCode',
          value.loginUserData![0].userCode.toString(),
        );
        await pref2.setString(
          'userRoll',
          value.loginUserData![0].userRoll.toString(),
        );
        await pref2.setString(
          'active',
          value.loginUserData![0].active.toString(),
        );
        await pref2.setString(
          'branch',
          value.loginUserData![0].branch.toString(),
        );
        await pref2.setString(
          'email',
          value.loginUserData![0].email.toString(),
        );
        await pref2.setString(
          'crmUserID',
          value.loginUserData![0].id.toString(),
        );
        await pref2.setString(
          'password',
          value.loginUserData![0].password.toString(),
        );
        await pref2.setString(
          'reportTo',
          value.loginUserData![0].reportTo.toString(),
        );
        await pref2.setString(
          'sapPassword',
          value.loginUserData![0].sapPassword.toString(),
        );

        await pref2.setString(
          'sapUrl',
          value.loginUserData![0].sapUrl.toString(),
        );
        URL.url = value.loginUserData![0].sapUrl.toString();
        await pref2.setString(
          'sapUserName',
          value.loginUserData![0].sapUserName.toString(),
        );
        GetValues.sapUserName = pref2.getString('sapUserName');

        await pref2.setString(
          'SlpCode',
          value.loginUserData![0].slpCode.toString(),
        );
        GetValues.slpCode = pref2.getString('SlpCode');

        await pref2.setString(
          'DeviceCode',
          value.loginUserData![0].deviceCode.toString(),
        );
        await pref2.setString(
          'SapDB',
          value.loginUserData![0].sapDB.toString(),
        );
        GetValues.sapDB = pref2.getString('SapDB');
        // 'InsigniaLimited';
        await pref2.setString(
          'LeadToken',
          value.loginUserData![0].ManagerFCM.toString(),
        );
        await pref2.setString(
          'FCMToken',
          value.loginUserData![0].FCM.toString(),
        );
        await pref2.setString(
          'U_CrpUsr',
          value.loginUserData![0].U_CrpUsr.toString(),
        );

        if (pref2.getString('countryCode')!.toLowerCase().trim() == 'tanzania'
            // ||
            //     pref2.getString('countryCode') == 'Tanzania'
            ) {
          // pref2.setString('TSapPassword', 'Insignia@2021#');

          // GetValues.sapPassword = 'Insignia@2021#';
          GetValues.sapPassword = pref2.getString('TSapPassword');
          log('sappassword ::${pref2.getString('TSapPassword')}');
          GetValues.currency = 'TZS';
          GetValues.countryCode = pref2.getString('countryCode');
        } else if (pref2.getString('countryCode')!.toLowerCase().trim() ==
                'zambia'
            //  ||
            //     pref2.getString('countryCode') == 'Zambia'
            ) {
          // pref2.setString('ZSapPassword', 'Insignia@2023#');
          // GetValues.sapPassword = 'Insignia@2023#';
          GetValues.sapPassword = pref2.getString('ZSapPassword');
          log('sappassword ::${pref2.getString('ZSapPassword')}');

          GetValues.currency = 'ZMW';
          GetValues.countryCode = pref2.getString('countryCode');
        }
        await callGetAuthMenuApi();
      } else if (value.loginUserData == null && value.status == false) {
        SettingWidgetState.mycontroller[3].text = '';
        await pref2.remove('countryCode');

        await Get.offAllNamed<dynamic>(FurneyRoutes.signIn);
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

  checkAuth() async {
    final pref2 = await pref;
    await pref2.remove('y');
  }

  Future<void> showConnection() async {
    deviceId = await getDeviceId();

    final pref2 = await pref;

    await pref2.setString('deviceID', deviceId);
    // final result = await Connectivity().checkConnectivity();
    // //  print("111111111"+result.toString());
    // final hasInternet = result != ConnectivityResult.none;
    final result = await Connectivity().checkConnectivity();
    final hasInternet = result != ConnectivityResult.none;
    log('1res${result != ConnectivityResult.none}');
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
        () async {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          await Get.offAllNamed<void>(FurneyRoutes.dashBoard);
        },
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
