// ignore_for_file: use_build_context_synchronously, avoid_print, omit_local_variable_types, prefer_single_quotes, prefer_interpolation_to_compose_strings, unnecessary_lambdas, unawaited_futures, prefer_const_constructors

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geocoding/geocoding.dart';
//import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/attendance_api/attendance_api.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sign_in/widgets/custom_elevatedBtn.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../../SalesApp/Api/AddressGetApi/AddressGetApi.dart';

// changed
class AttendancePage extends StatefulWidget {
  const AttendancePage({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? _timer;
  @override
  void initState() {
    determinePosition55(context); //new

    _timeString = DateFormat.jm().format(
      DateFormat("hh:mm")
          .parse("${DateTime.now().hour}:${DateTime.now().minute}"),
    );
    //"${DateTime.now().hour} : ${DateTime.now().minute}";
    _timer = Timer.periodic(
        const Duration(seconds: 1), (Timer t) => _getCurrentTime());

    // determinePosition(); //old
    super.initState();
    getUserDetails();
  }

  String adrresss = '';
  double? lati1;
  double? lang2;
  Future<void> determinePosition55(BuildContext context) async {
    bool? serviceEnabled;
    latitude = "";
    langitude = "";
    LocationPermission permission;
    try {
      LocationPermission permission;
      permission = await Geolocator.requestPermission();
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (serviceEnabled == false) {
        try {
          await Geolocator.getCurrentPosition();
          permission = await Geolocator.checkPermission();
          if (permission == LocationPermission.denied) {
            permission = await Geolocator.requestPermission();
            if (permission == LocationPermission.denied) {
              //return Future.error('Location permissions are denied');
            }
          }
          // await config.getSetup();

          // if (permission == LocationPermission.deniedForever) {}
          var pos = await Geolocator.getCurrentPosition();
          latitude = pos.latitude == '' || pos.latitude == 'null'
              ? '0.0'
              : pos.latitude.toString();
          langitude = pos.longitude == '' || pos.longitude == 'null'
              ? '0.0'
              : pos.longitude.toString();
          // longi = langitude;
          // lati = latitude;
          // DayStartEndPageState.lati1 = double.parse(
          //      pos.latitude == '' ||  pos.latitude == 'null'
          //         ? '0.0'
          //         :  pos.latitude.toString());
          // DayStartEndPageState.lang2 = double.parse(
          //     pos.longitude == '' ||
          //             pos.longitude == 'null'
          //         ? '0.0'
          //         : pos.longitude.toString());
          // DayEndPageState.lati1 = double.parse(latitude);
          // DayEndPageState.lang2 = double.parse(langitude);

          url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';
          // MapSampleState.lati1 = double.parse(latitude);
          // MapSampleState.lang2 = double.parse(langitude);
          var lat = double.parse(latitude);
          var long = double.parse(langitude);
          lati1 = double.parse(latitude);
          lang2 = double.parse(langitude);
          AttendanceAPi.latitude = latitude;
          AttendanceAPi.longitude = langitude;
          await AddressMasterApi.getData(lat.toString(), long.toString())
              .then((value) {
            log("value.stcode::" + value!.stcode.toString());
            if (200 >= value.stcode! && 210 <= value.stcode!) {
              adrresss = value.results[1].formattedAddress;

              log("adress::" + adrresss.toString());
            } else {
              print("error:api");
            }
          });
        } catch (e) {
          const snackBar = SnackBar(
              duration: Duration(seconds: 1),
              backgroundColor: Colors.red,
              content: Text('Please turn on the Location!!..'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Future.delayed(
            const Duration(seconds: 2),
            () => Get.back<dynamic>(),
          );
        }
      } else if (serviceEnabled == true) {
        var pos = await Geolocator.getCurrentPosition();
        // print('lattitude: ' + pos.latitude.toString());
        // await config.getSetup();

        latitude = pos.latitude == '' || pos.latitude == 'null'
            ? '0.0'
            : pos.latitude.toString();
        langitude = pos.longitude == '' || pos.longitude == 'null'
            ? '0.0'
            : pos.longitude.toString();

        // longi = langitude;
        // lati = latitude;
        // DayStartEndPageState.lati1 = double.parse(
        //      pos.latitude == '' ||  pos.latitude == 'null'
        //         ? '0.0'
        //         :  pos.latitude.toString());
        // DayStartEndPageState.lang2 = double.parse(
        //     pos.longitude == '' ||
        //             pos.longitude == 'null'
        //         ? '0.0'
        //         : pos.longitude.toString());
        // DayEndPageState.lati1 = double.parse(
        //      pos.latitude == '' ||  pos.latitude == 'null'
        //         ? '0.0'
        //         :  pos.latitude.toString());
        // DayEndPageState.lang2 = double.parse(pos.longitude == '' ||
        //         pos.longitude == 'null'
        //     ? '0.0'
        //     : pos.longitude.toString());
        // url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';

        var lat = double.parse(latitude);
        var long = double.parse(langitude);
        lati1 = double.parse(latitude);
        lang2 = double.parse(langitude);
        AttendanceAPi.latitude = latitude;
        AttendanceAPi.longitude = langitude;
        await AddressMasterApi.getData(lat.toString(), long.toString())
            .then((value) {
          log("value.stcode::" + value.stcode.toString());
          if (value.stcode! >= 200 && value.stcode! <= 210) {
            adrresss = value.results[1].formattedAddress;
            log("adress::" + adrresss.toString());
          } else {
            print("error:api");
          }
        });
      }
    } catch (e) {
      final snackBar =
          SnackBar(backgroundColor: Colors.red, content: Text('$e'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // Future.delayed(
      //     const Duration(seconds: 2),
      //     () => Get.back<dynamic>(),
      //   );
    }
    loading = false;
    _isLoading = false;
  }

  Future<void> getUserDetails() async {
    final preff = await SharedPreferences.getInstance();
    AttendanceAPi.deviceID = preff.getString('deviceID');
    AttendanceAPi.userid = preff.getString('crmUserID');
    print('userid........' + AttendanceAPi.userid.toString());
    print('deviceID........' + AttendanceAPi.deviceID.toString());
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  String latitude = '';
  String langitude = '';

  bool? _serviceEnabled;
  bool? backEnabled;

  String? longi;
  String? lati;
  Future<void> determinePosition() async {
    bool? serviceEnabled;
    LocationPermission permission;
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (serviceEnabled == false) {
        try {
          log("AA");
          await Geolocator.getCurrentPosition();
          permission = await Geolocator.checkPermission();
          if (permission == LocationPermission.denied) {
            log("AA@");
            permission = await Geolocator.requestPermission();
            if (permission == LocationPermission.denied) {
              //return Future.error('Location permissions are denied');
            }
          }

          if (permission == LocationPermission.deniedForever) {}
          log("AA@22");
          final Position pos = await Geolocator.getCurrentPosition();
          log("lattitude: " + pos.latitude.toString());
          latitude = pos.latitude.toString();
          langitude = pos.longitude.toString();
          longi = langitude;
          lati = latitude;
          AttendanceAPi.latitude = latitude;
          AttendanceAPi.longitude = langitude;

          setState(() {
            url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';
          });
          final double lat = double.parse(latitude);
          final double long = double.parse(langitude);

          List<Placemark> placemarks =
              await placemarkFromCoordinates(lat, long);
          setState(() {
            adrress = placemarks[0].street.toString() +
                " " +
                placemarks[0].thoroughfare.toString() +
                " " +
                placemarks[0].locality.toString();
          });
          await loadWebView();
        } catch (e) {
          const snackBar = SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Colors.red,
            content: Text("Please turn on the Location!!.."),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Future.delayed(
            const Duration(seconds: 2),
            () => Get.back<dynamic>(),
          );
        }
      } else if (serviceEnabled == true) {
        final Position pos = await Geolocator.getCurrentPosition();
        print("lattitude: " + pos.latitude.toString());
        latitude = pos.latitude.toString();
        langitude = pos.longitude.toString();
        longi = langitude;
        lati = latitude;
        AttendanceAPi.latitude = latitude;
        AttendanceAPi.longitude = langitude;

        setState(() {
          url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';
        });
        final double lat = double.parse(latitude);
        final double long = double.parse(langitude);

        List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
        setState(() {
          adrress = placemarks[0].street.toString() +
              " " +
              placemarks[0].thoroughfare.toString() +
              " " +
              placemarks[0].locality.toString();
        });
        await loadWebView();
      }
    } catch (e) {
      final snackBar =
          SnackBar(backgroundColor: Colors.red, content: Text("$e"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  WebViewController? controllerGlobal;
  bool loading = true;

  Future loadWebView() async {
    controllerGlobal = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              loading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          //   onNavigationRequest: (NavigationRequest request) {
          //     if (request.url.startsWith('https://www.youtube.com/')) {
          //       return NavigationDecision.prevent;
          //     }
          //     return NavigationDecision.navigate;
          //   },
        ),
      )
      ..loadRequest(Uri.parse(url!));
  }

  String? adrress;
  String? url;
  List<TextEditingController> textController =
      List.generate(15, (i) => TextEditingController());
  String? currentDateTime;
  void currentDate() {
    final DateTime now = DateTime.now();
    setState(() {
      currentDateTime =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}T${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
      AttendanceAPi.timeStamp = currentDateTime;
      print("date: " + AttendanceAPi.timeStamp.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawer(context),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[200],
      appBar: appBar(context, _scaffoldKey, widget.title),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: Screens.heigth(context) * 0.02,
            left: Screens.width(context) * 0.02,
            right: Screens.width(context) * 0.02,
            bottom: Screens.width(context) * 0.02,
          ),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Screens.width(context),
                  height: Screens.heigth(context) * 0.22,
                  // color: Colors.blue,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Right Now, IT IS",
                        style: TextStyles.boldBlock1(context),
                      ),
                      SizedBox(height: Screens.heigth(context) * 0.025),
                      Text(
                        " $_timeString",
                        style: TextStyles.boldBlock1(context),
                      ),
                      SizedBox(height: Screens.heigth(context) * 0.05),
                      Container(
                        decoration: BoxDecoration(),
                        child: Text(
                          " $adrresss",
                          maxLines: 2,
                          style: TextStyles.headlineBlack1(context),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(width: Screens.width(context),
                //     height: Screens.heigth(context) * 0.25,
                //     decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(8),),
                //   child: Column(

                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Container(
                //        padding: EdgeInsets.only(left: 0.05),
                //         width: Screens.width(context),
                //         height: Screens.heigth(context) * 0.25,
                //         decoration: const BoxDecoration( ),
                //         child: Column(
                //           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //           children: [
                //             Row(children:[
                //               Text("Lattitude",style: TextStyles.boldBlock1(context),),
                //               SizedBox(width: 15,),
                //               Text(":",style: TextStyles.boldBlock1(context),),
                //              SizedBox(width: 10,),
                //               Text("$latitude",style: TextStyles.headlineBlack1(context),),
                //             ],),
                //             SizedBox(height: 10,),
                //         Row(children:[
                //           Text("Longitude",style: TextStyles.boldBlock1(context),),
                //           SizedBox(width: 15,),
                //           Text(":",style: TextStyles.boldBlock1(context),),
                //           SizedBox(width: 10,),
                //           Text("$langitude",style: TextStyles.headlineBlack1(context),),
                //         ],),
                //         SizedBox(height: 10,),
                //         Padding(
                //         padding: EdgeInsets.symmetric(
                //             vertical: Screens.heigth(context) * 0.012,),
                //         child: adrress == null
                //             ? const SizedBox()
                //             : Row(
                //                 // mainAxisAlignment: MainAxisAlignment.center,
                //                 children: [
                //                   const Icon(Icons.location_on),
                //                   Container(
                //                     width: Screens.width(context)*0.86,
                //                     child: Text(
                //                       "$adrress",
                //                       style: TextStyles.headlineBlack1(context),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //       ),

                //           ],
                //         ),

                //           //             loading == false?
                //           // WebViewWidget(controller: controllerGlobal!):
                //           // Center(child: CircularProgressIndicator(),)
                //       ),

                //     ],
                //   ),
                // ),
                SingleChildScrollView(
                  child: Container(
                    width: Screens.width(context),
                    height: Screens.heigth(context) * 0.22,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: Screens.width(context),
                          height: Screens.heigth(context) * 0.14,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Screens.heigth(context) * 0.012,
                              vertical: Screens.heigth(context) * 0.02,
                            ),
                            child: SizedBox(
                              child: TextFormField(
                                controller: textController[0],
                                minLines: 2,
                                maxLines: 8,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  hintText: 'Type in some notes',
                                  hintStyle: TextStyles.headlineBlack1(context),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isAtCustomer = false;
                                });
                              },
                              child: Container(
                                width: Screens.width(context) * 0.48,
                                height: Screens.heigth(context) * 0.08,
                                decoration: BoxDecoration(
                                  color: isAtCustomer == false
                                      ? theme.primaryColor
                                      : Colors.white70,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    "At Work",
                                    style: isAtCustomer == false
                                        ? TextStyles.whiteTextHead(context)
                                        : TextStyles.headlineBlack1(context),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isAtCustomer = true;
                                });
                              },
                              child: Container(
                                width: Screens.width(context) * 0.48,
                                height: Screens.heigth(context) * 0.08,
                                decoration: BoxDecoration(
                                  color: isAtCustomer == true
                                      ? theme.primaryColor
                                      : Colors.white70,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    "At Customer's site",
                                    style: isAtCustomer == true
                                        ? TextStyles.whiteTextHead(context)
                                        : TextStyles.headlineBlack1(context),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: CustomSpinkitdButton(
                      onTap: _isLoading == true
                          ? null
                          : adrresss == null || adrresss.isEmpty
                              ? null
                              : () async {
                                  setState(() => _isLoading = true);
                                  // Future.delayed(const Duration(seconds: 2), () {
                                  //    setState(() => _isLoading = false);
                                  //  // Get.offAllNamed<dynamic>(FurneyRoutes.home);
                                  // });
                                  currentDate();
                                  AttendanceAPi.location = adrresss;
                                  AttendanceAPi.comments =
                                      textController[0].text;
                                  AttendanceAPi.locationType =
                                      isAtCustomer == true ? '2' : '1';
                                  print(
                                    "location: " +
                                        AttendanceAPi.location.toString(),
                                  );
                                  print(
                                    "comments: " + AttendanceAPi.comments,
                                  );
                                  print(
                                    "deviceID: " +
                                        AttendanceAPi.deviceID.toString(),
                                  );
                                  print(
                                    "latitude: " +
                                        AttendanceAPi.latitude.toString(),
                                  );
                                  print(
                                    "longitude: " +
                                        AttendanceAPi.longitude.toString(),
                                  );
                                  print(
                                    "timeStamp: " +
                                        AttendanceAPi.timeStamp.toString(),
                                  );
                                  print(
                                    "userid: " +
                                        AttendanceAPi.userid.toString(),
                                  );
                                  print(
                                    "locationType: " +
                                        AttendanceAPi.locationType.toString(),
                                  );
                                  await AttendanceAPi.getGlobalData()
                                      .then((value) {
                                    if (value.attendanceData![0].msg ==
                                        "Successfully Inserted") {
                                      setState(() => _isLoading = true);
                                      const snackBar = SnackBar(
                                        backgroundColor: Colors.green,
                                        duration: Duration(seconds: 1),
                                        content: Text(
                                          'Attendance Successfully Completed',
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      Future.delayed(
                                        const Duration(seconds: 2),
                                        () => Get.back<dynamic>(),
                                      );
                                    } else if (value.attendanceData == null &&
                                        value.status == false) {
                                      setState(() => _isLoading = false);
                                      const snackBar = SnackBar(
                                        backgroundColor: Colors.red,
                                        duration: Duration(seconds: 1),
                                        content: Text(
                                          'Attendance NotSuccessfully Completed',
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      Future.delayed(
                                        const Duration(seconds: 2),
                                        () => Get.back<dynamic>(),
                                      );
                                    }
                                    // print(value.attendanceData![0].msg);
                                  });
                                },
                      isLoading: _isLoading,
                      labelLoading:
                          '', //AppLocalizations.of(context)!.checking_in,
                      label:
                          'Check In - Check Out' //AppLocalizations.of(context)!.check_in,
                      ),
                ),
                SizedBox(
                  height: Screens.heigth(context) * 0.015,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool? isAtCustomer = false;
  String? _timeString;
  bool _isLoading = false;
  void _getCurrentTime() {
    setState(() {
      _timeString = DateFormat.jm().format(
        DateFormat('hh:mm')
            .parse('${DateTime.now().hour}:${DateTime.now().minute}'),
      );
      //"${DateTime.now().hour} : ${DateTime.now().minute}";
    });
  }
}

//Future<void> _determinePosition() async {
//   try{
//         _serviceEnabled = await location.serviceEnabled();
// if (!_serviceEnabled!) {
//   _serviceEnabled = await location.requestService();
//   //print("service enbale or not.....: "+_serviceEnabled.toString());
//   if (!_serviceEnabled!) {
//            const snackBar = SnackBar(
//        backgroundColor: Colors.red,
//        content:  Text("Please turn on the Location!!.."));
//      ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }
//   }catch (e){
//      print("service"+e.toString());
//   }

// try{
//       backEnabled = await location.enableBackgroundMode(enable: true);
// if (backEnabled==true) {
//  // print("background Enabled or not.....: "+backEnabled.toString());

// }else{
//     if (backEnabled ==false) {
//     // return Future.error(
//     //   'Location permissions are permanently denied, we cannot request permissions.');
//   //  print("background  not garanteed.......");
//   }
// }
// }catch (e){
//    print("backEnabled excep"+e.toString());
// }
// if(_serviceEnabled == true){
//     _locationData = await location.getLocation();
// //  print("Latiiii Langiiii: "+_locationData!.latitude.toString());
//   latitude =_locationData!.latitude.toString();
//   langitude = _locationData!.longitude.toString();
//   setState(() {
//        url=  'https://www.openstreetmap.org/#map=11/$latitude/$langitude';
//   });

//  // print("Urllll:  "+url.toString());

// }

//}

// if(serviceEnabled== true){
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       //return Future.error('Location permissions are denied');
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//   }
//   Position pos = await Geolocator.getCurrentPosition();
//   print("lattitude: "+pos.latitude.toString());
//   latitude = pos.latitude.toString();
//   langitude = pos.longitude.toString();
//   longi = langitude;
//   lati = latitude;

//     setState(() {
//          url=  'https://www.openstreetmap.org/#map=11/$latitude/$langitude';
//     });
//     double lat = double.parse(latitude);
//      double long = double.parse(langitude);

//      List<Placemark> placemarks = await placemarkFromCoordinates(lat,long);
//      setState(() {
//        adrress = placemarks[0].street .toString()+" "+placemarks[0].thoroughfare .toString()+" "+placemarks[0].locality.toString();
//      });}
//return await Geolocator.getCurrentPosition();
