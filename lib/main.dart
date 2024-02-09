// ignore_for_file: cascade_invocations, unused_import, directives_ordering, unnecessary_new, require_trailing_commas, prefer_single_quotes, prefer_interpolation_to_compose_strings, unused_local_variable, prefer_final_locals, omit_local_variable_types, unawaited_futures
// import 'package:cached_network_image/cached_network_image.dart';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
// import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ultimate_bundle/helpers/routes.dart';
import 'package:ultimate_bundle/helpers/themes.dart';
import 'package:ultimate_bundle/helpers/uikit_model.dart';
import 'package:ultimate_bundle/l10n/l10n.dart';
import 'package:ultimate_bundle/providers/locale_provider.dart';
import 'package:ultimate_bundle/providers/theme_provider.dart';
import 'package:ultimate_bundle/src/furney/main.dart';
import 'package:ultimate_bundle/src/furney/src/DB/DBHelper.dart';
import 'package:ultimate_bundle/src/furney/src/DB/DBModal/NotificationModelDB.dart';
import 'package:ultimate_bundle/src/furney/src/pages/home/home_page.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:ultimate_bundle/helpers/LocalNotification.dart';
import 'package:ultimate_bundle/helpers/constants.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  List<NotificationModel2> notify = [];
  DataBaseHelper dbHelper2 = DataBaseHelper();
  Config config2 = Config();
  if (message.notification!.android!.imageUrl != null) {
    notify.add(NotificationModel2(
        docEntry: 0,

        ///int.parse(message.data['DocEntry'].toString()),
        titile: message.notification!.title,
        description: message.notification!.body!,
        receiveTime: config2.currentDate(),
        seenTime: '0',
        imgUrl: message.notification!.android!.imageUrl.toString(),
        naviScn: ''));
    await dbHelper2.insertNotification(notify);
  } else {
    notify.add(NotificationModel2(
        docEntry: 0,

        ///int.parse(message.data['DocEntry'].toString()),
        titile: message.notification!.title,
        description: message.notification!.body!,
        receiveTime: config2.currentDate(),
        seenTime: '0',
        imgUrl: message.notification!.android!.imageUrl.toString(),
        naviScn: ''));
    await dbHelper2.insertNotification(notify);
  }
}

Future<void> onReciveFCM() async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    log("datta: " + message.notification!.title.toString());
    List<NotificationModel2> notify = [];
    Config config2 = Config();
    DataBaseHelper dbHelper2 = DataBaseHelper();
    if (message.notification != null) {
      int cont = await dbHelper2.getUnSeenNotificationCount() ?? 10;
      FlutterAppBadger.isAppBadgeSupported().then((isSupported) {
        if (isSupported) {
          FlutterAppBadger.updateBadgeCount(cont);
          log("$cont");
          localNotificationService.showNitification(
              notifycount: cont,
              titile: message.notification!.title,
              msg: message.notification!.body,
              message: message);
          // localNotificationService().showLocalNotification(count,"Test","EMPTY");
        }
      });

      //   NotificationUpdateApi.getData(
      //   docEntry: int.parse(message.data['DocEntry'].toString()),
      //   deliveryDT: config.currentDate(),
      //   readDT: 'null',
      //   deviceCode: 'null'
      // );

      if (message.notification!.android!.imageUrl != null) {
        // log(message.data['DocEntry'].toString());
        // log(message.data['NaviScreen'].toString());
        notify.add(NotificationModel2(
            docEntry: 0,

            ///int.parse(message.data['DocEntry'].toString()),
            titile: message.notification!.title,
            description: message.notification!.body!,
            receiveTime: config2.currentDate(),
            seenTime: '0',
            imgUrl: message.notification!.android!.imageUrl.toString(),
            naviScn: ''));
        dbHelper2.insertNotification(notify);
      } else {
        notify.add(NotificationModel2(
            docEntry: 0,

            ///int.parse(message.data['DocEntry'].toString()),
            titile: message.notification!.title,
            description: message.notification!.body!,
            receiveTime: config2.currentDate(),
            seenTime: '0',
            imgUrl: message.notification!.android!.imageUrl.toString(),
            naviScn: ''));
        dbHelper2.insertNotification(notify);
      }
    }
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await localNotificationService.flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(localNotificationService.channel);
  onReciveFCM();

  runApp(const MyApp());
}

LocalNotificationService localNotificationService =
    new LocalNotificationService();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyApp> {
  final quick = const QuickActions();

  @override
  void initState() {
    checkDark();

    super.initState();

    quick.setShortcutItems([
      const ShortcutItem(
          type: 'Attendance',
          localizedTitle: 'Attendance',
          icon:
              'outline_calendar_today_black_24'), //icon: 'outline_dashboard_black_24dp'
      const ShortcutItem(
          type: 'Approval',
          localizedTitle: 'Approval',
          icon:
              'outline_fact_check_black_24'), //icon:'outline_pie_chart_black_24dp'
      const ShortcutItem(
          type: 'Notifications',
          localizedTitle: 'Notifications',
          icon:
              'outline_format_list_bulleted_black_24'), //icon:'outline_reorder_black_24dp'
    ]);

    quick.initialize((type) {
      if (type == 'Attendance') {
        Get.toNamed<dynamic>(FurneyRoutes.attendance);
      } else if (type == 'Approval') {
        Get.toNamed<dynamic>(FurneyRoutes.approvals);
      } else if (type == 'Notifications') {
        Get.toNamed<dynamic>(FurneyRoutes.notification);
      }
    });
    //  check();
  }

  final String _appBadgeSupported = 'Unknown';

  Future<void> check() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      //  serviceEnabled = await Geolocator.isLocationServiceEnabled();
    }
    print("service: " + serviceEnabled.toString());
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        //return Future.error('Location permissions are denied');
      }
    }
    if (serviceEnabled == true) {
      Position pos = await Geolocator.getCurrentPosition();
      print("lattitude: " + pos.latitude.toString());
      print("longitude: " + pos.longitude.toString());
    }
  }

  bool? isDarkMode;
  void checkDark() {
    var brightness = SchedulerBinding.instance.window.platformBrightness; //cha!
    setState(() {
      isDarkMode = brightness == Brightness.dark;
    });

    print("darkmode: " + isDarkMode.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer2<LocaleProvider, ThemeProvider>(
        builder: (context, locale, theme, snapshot) {
          return GetMaterialApp(
            title: 'CRM',
            debugShowCheckedModeBanner: false,
            theme: themeLight(context),
            // ThemeData(
            //   primarySwatch: Colors.red
            // ),
            // themeLight(context),
            // darkTheme: themeDark(context),
            themeMode:
                (theme.isDarkTheme == true) ? ThemeMode.dark : ThemeMode.light,
            supportedLocales: L10n.all,
            getPages: allRoutesFurney,
            locale: locale.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const FurneySplashScreen(),
          );
        },
      ),
    );
    // return const FurneySplashScreen();
  }
}

// class _DashboardScreen extends StatelessWidget {
//   const _DashboardScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {

//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: const Text(
//             'Ultimate Bundle Kit',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           actions: [
//             IconButton(
//               onPressed: () => Get.to<dynamic>(()=> const SettingsScreen()),
//               icon: const Icon(Icons.settings),
//               color: Colors.white,
//             ),
//           ],
//           bottom: const TabBar(
//             isScrollable: true,
//             tabs: [
//               Tab(text: 'Full UI Kit'),
//               Tab(text: 'On Boarding'),
//             ],
//           ),
//         ),
//         body: const TabBarView(
//           children: [
//             _UIKitTabBar(),
//             _OnBoardingTabBar(),
//           ],
//         ),
//       ),
//     );
//   }
// }
