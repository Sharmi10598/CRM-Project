// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_final_locals, prefer_interpolation_to_compose_strings, prefer_single_quotes, prefer_const_constructors, omit_local_variable_types, unawaited_futures, require_trailing_commas, unnecessary_brace_in_string_interps, sort_child_properties_last, unnecessary_string_interpolations

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/route_manager.dart';
import 'package:ultimate_bundle/SalesApp/Api/CheckinApi/CheckInApi.dart';
import 'package:ultimate_bundle/SalesApp/Api/CheckinApi/GetApprovedApi.dart';
import 'package:ultimate_bundle/SalesApp/Api/CheckinApi/GetCountApi.dart';
import 'package:ultimate_bundle/SalesApp/Model/GetActivities/GetContApi.dart';
import 'package:ultimate_bundle/SalesApp/Model/SelectionCustModel.dart';
import 'package:ultimate_bundle/SalesApp/Pages/Checkin/Widgets/SelectCustApproved.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/uikit_model.dart';
import 'package:ultimate_bundle/src/furney/src/DB/DBHelper.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sign_in/widgets/custom_elevatedBtn.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/LoadAppBar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Api/AddressGetApi/AddressGetApi.dart';

class CheckinPage extends StatefulWidget {
  const CheckinPage({required this.title, Key? key}) : super(key: key);
  final String title;

  @override
  State<CheckinPage> createState() => CheckinPageState();
}

class CheckinPageState extends State<CheckinPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    init();
    //timergetDate();
    //deleteaLL();
    checkInternet();
  }

  String? adrresss;

  String? adrress1;

  String? adrress2;

  String? adrress3;
  static double? lati1;
  static double? lang2;
  Future<void> deleteaLL() async {
    await DataBaseHelper.deleteALL();
  }

  Future<void> checkInternet() async {
    bool internet = await config.haveInterNet();
    if (internet) {
      log(internet.toString());
      await DataBaseHelper.getAlreadyCheckin().then((value) async {
        if (value.isEmpty) {
          await determinePosition55(context);
          // await determinePosition();
          await callAlreadyCheckin();
          await callApprovedActivity();
        } else {
          Get.toNamed<void>(FurneyRoutes.checkedin);
          // Get.defaultDialog<void>(
          //   title: 'Alert',
          //   middleText:'Already check in follow up not closed..!!'
          // ).then((value) {
          //    Get.offAllNamed<dynamic>(FurneyRoutes.home);
          // });
        }
      });
    } else {
      log(internet.toString());
      await DataBaseHelper.getAlreadyCheckin().then((value) {
        if (value.isNotEmpty) {
          Get.toNamed<void>(FurneyRoutes.checkedin);
        } else {
          determinePosition55(context);
          // determinePosition();
          setState(() {
            apiCountMsg = '';
            loadingApiCount = false;
            activitiesData.add(GetcountData(count: 0));
          });
        }
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  String? longi;
  String? lati;
  String latitude = '';
  String langitude = '';
  // String? adrress;
  String? url;
  String selectedCust = '';
  String selectedCustCode = '';
  int? selectedClgCode;

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
          await AddressMasterApi.getData(lat.toString(), long.toString())
              .then((value) {
            log("value.stcode::" + value!.stcode.toString());
            if (200 >= value.stcode! && 210 <= value.stcode!) {
              adrresss = value.results[1].formattedAddress;

              adrress2 = value.results[1].formattedAddress;
              adrress3 = value.results[1].formattedAddress;

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
  }

  Future<void> determinePosition() async {
    bool? serviceEnabled;
    LocationPermission permission;
    try {
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

          if (permission == LocationPermission.deniedForever) {}
          var pos = await Geolocator.getCurrentPosition();
          print('lattitude: ' + pos.latitude.toString());
          latitude = pos.latitude.toString();
          langitude = pos.longitude.toString();
          longi = langitude;
          lati = latitude;
          log("XXXXXXXXX" +
              ' https://www.openstreetmap.org/#map=11/$latitude/$langitude');
          setState(() {
            url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';
          });
          var lat = double.parse(latitude);
          var long = double.parse(langitude);
          lati1 = double.parse(latitude);
          lang2 = double.parse(langitude);
          var placemarks = await placemarkFromCoordinates(lat, long);
          setState(() {
            adrresss = placemarks[0].street.toString() +
                ' ' +
                placemarks[0].thoroughfare.toString() +
                ' ' +
                placemarks[0].locality.toString();
          });
          await loadWebView();
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
        print('lattitude: ' + pos.latitude.toString());
        latitude = pos.latitude.toString();
        langitude = pos.longitude.toString();
        longi = langitude;
        lati = latitude;

        setState(() {
          url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';
        });
        var lat = double.parse(latitude);
        var long = double.parse(langitude);
        lati1 = double.parse(latitude);
        lang2 = double.parse(langitude);
        var placemarks = await placemarkFromCoordinates(lat, long);
        setState(() {
          adrresss = placemarks[0].street.toString() +
              ' ' +
              placemarks[0].thoroughfare.toString() +
              ' ' +
              placemarks[0].locality.toString();
        });
        await loadWebView();
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
  }

  void init() {
    selectedCust = '';
    mycontroller[1].text = 'Checkin Time ${currentDateTime()}';
  }

  void timergetDate() {
    final periodicTimer = Timer.periodic(
      const Duration(seconds: 60),
      (timer) {
        print("timer: ${timer}");
        // Update user about remaining time
      },
    );
  }

  String currentDateTime() {
    DateTime now = DateTime.now();
    setState(() {});
    return "${now.day}-${now.month.toString().padLeft(2, '0')}-${now.year.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
  }

  String currentDateTimeServer() {
    DateTime now = DateTime.now();
    setState(() {});
    return "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
  }

  String currentTimeServer() {
    DateTime now = DateTime.now();
    setState(() {});
    return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
  }

  bool loadingApiCount = false;
  String apiCountMsg = '';
  List<GetcountData> activitiesData = [];
  Future callAlreadyCheckin() async {
    loadingApiCount = true;
    setState(() {});
    if (GetValues.slpCode == null) {
      Get.offAllNamed<dynamic>(FurneyRoutes.splash);
    } else {
      await GetContAPi.getGlobalData(
              GetValues.slpCode!, config.currentDateTimeServer())
          .then((value) {
        if (value.statusCode! >= 200 && value.statusCode! <= 210) {
          loadingApiCount = false;
          setState(() {});
          if (value.activitiesData != null) {
            if (value.activitiesData![0].count! > 0) {
              Get.toNamed<void>(FurneyRoutes.checkedin);
            } else {
              activitiesData = value.activitiesData!;
            }
          }
        } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
          loadingApiCount = false;
          setState(() {});
        } else {
          loadingApiCount = false;
          setState(() {});
        }
      });
    }
  }

  Future<void> onreloadApproved() async {
    callApprovedActivity();
  }

  bool approvedisLoading = false;
  String approvedmessage = '';
// List<GetActivityApvdData> data = [];
  Future callApprovedActivity() async {
    try {
      approvedisLoading = true;
      approvedmessage = '';
      setState(() {});

      List<CheckinModel> checkin = await DataBaseHelper.getPostCheckinData();
// checked in not completed

      await GetActivityApvdAPi.getGlobalData(GetValues.slpCode!)
          .then((value) async {
        if (value.statusCode! >= 200 && value.statusCode! <= 210) {
          if (value.activitiesData != null) {
            log("value.activitiesData:::${value.activitiesData!.length}");
            if (checkin.isNotEmpty) {
              for (int i = 0; i < value.activitiesData!.length; i++) {
                await DataBaseHelper.getSlctCustData(checkin[0].clgcode)
                    .then((alue) {
                  if (alue.isNotEmpty) {
                    value.activitiesData![i].status = 'yes';
                  }
                });
              }
              await DataBaseHelper.insertAproveCust(value.activitiesData!);
            } else {
              await DataBaseHelper.insertAproveCust(value.activitiesData!);
            }
            setState(() {
              approvedisLoading = false;
              value.activitiesData!;
            });
          } else {
            await DataBaseHelper.dltAprovcust();
            setState(() {
              approvedmessage = 'No data';
              approvedisLoading = false;
            });
          }
        } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
          setState(() {
            approvedmessage = value.message!;
            approvedisLoading = false;
          });
        } else {
          setState(() {
            approvedmessage = value.message!;
            approvedisLoading = false;
          });
        }
      });
    } catch (e) {
      config.showDialog("${e}", 'Exception last');
    }
  }

  Future<bool> onbackpress() {
    Get.offAllNamed<dynamic>(FurneyRoutes.home);
    return Future.value(true);
  }
  // web view

  WebViewController? controllerGlobal;
  bool loading = true;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(lati1!, lang2!),
    zoom: 19.95,
  );
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: true,
          drawer: drawer(context),
          appBar:
              loadappBar(context, _scaffoldKey, widget.title, onreloadApproved),
          body: (apiCountMsg.isEmpty &&
                  loadingApiCount == true &&
                  activitiesData.isEmpty)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : (apiCountMsg.isNotEmpty &&
                      loadingApiCount == false &&
                      activitiesData.isEmpty)
                  ? Center(child: Text(apiCountMsg))
                  : Container(
                      width: Screens.width(context),
                      height: Screens.heigth(context),
                      padding: EdgeInsets.symmetric(
                          vertical: Screens.heigth(context) * 0.01,
                          horizontal: Screens.width(context) * 0.02),
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: Screens.width(context),
                                    height: Screens.heigth(context) * 0.37,
                                    decoration: const BoxDecoration(),
                                    child: loading == false
                                        ?

                                        // WebViewWidget(
                                        //     controller: controllerGlobal!)
                                        GoogleMap(
                                            mapType: MapType.normal,
                                            myLocationEnabled: true,
                                            initialCameraPosition: _kGooglePlex,
                                            onMapCreated: (GoogleMapController
                                                controller) {
                                              _controller.complete(controller);
                                            },
                                          )
                                        : Center(
                                            child: CircularProgressIndicator(),
                                          )),
                                SizedBox(
                                  height: Screens.heigth(context) * 0.01,
                                ),
                                SizedBox(
                                  width: Screens.width(context),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: Screens.width(context) * 0.4,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  child: Text("Lattitude")),
                                              Container(child: Text(latitude)),
                                            ],
                                          )),
                                      SizedBox(
                                          width: Screens.width(context) * 0.4,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  child: Text("Longitude")),
                                              Container(child: Text(langitude)),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: Screens.heigth(context) * 0.01,
                                ),
                                Container(
                                  width: Screens.width(context),
                                  alignment: Alignment.center,
                                  child: Text(adrresss == null
                                      ? ''
                                      : adrresss.toString()),
                                ),
                                SizedBox(
                                  height: Screens.heigth(context) * 0.01,
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog<void>(
                                        context: context,
                                        builder: (_) {
                                          return SlctcustApDialog();
                                        }).then((value) {
                                      selectedCust =
                                          SelectedCustModel.CustomerName != null
                                              ? SelectedCustModel.CustomerName!
                                              : '';
                                      selectedCustCode =
                                          SelectedCustModel.CustomerCode != null
                                              ? SelectedCustModel.CustomerCode!
                                              : '';
                                      selectedClgCode =
                                          SelectedCustModel.clgcode;
                                      mycontroller[0].text =
                                          SelectedCustModel.details != null
                                              ? SelectedCustModel.details!
                                              : '';
                                      setState(() {});
                                    });
                                    // Get.toNamed<void>(FurneyRoutes.selectionCustomer)!.then((value){
                                    //   SelectedCustModel.CustomerCode;
                                    // selectedCust =  SelectedCustModel.CustomerName!;
                                    // setState(() {
                                    // });
                                    // });
                                  },
                                  child: Container(
                                    width: Screens.width(context),
                                    height: Screens.heigth(context) * 0.08,
                                    padding: EdgeInsets.all(10),
                                    decoration:
                                        BoxDecoration(color: Colors.grey[200]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            child: Text(selectedCust == ''
                                                ? 'Select Customer'
                                                : selectedCust)),
                                        Container(
                                          child: Icon(
                                            Icons
                                                .arrow_drop_down_circle_outlined,
                                            color: theme.primaryColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Screens.heigth(context) * 0.01,
                                ),
                                Container(
                                    width: Screens.width(context),
                                    color: Colors.grey[200],
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1, horizontal: 10),
                                    child: TextField(
                                      controller: mycontroller[0],
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          hintText: "Purpose of Visit",
                                          hintStyle: theme.textTheme.bodyMedium!
                                              .copyWith(
                                            color: theme.primaryColor,
                                          )),
                                    )),
                                SizedBox(
                                  height: Screens.heigth(context) * 0.01,
                                ),
                                Container(
                                    width: Screens.width(context),
                                    color: Colors.grey[200],
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1, horizontal: 10),
                                    child: TextFormField(
                                      controller: mycontroller[1],
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      ),
                                    )),
                                SizedBox(
                                  height: Screens.heigth(context) * 0.01,
                                ),
                                Container(
                                  child: CustomSpinkitdButton(
                                    onTap: () async {
                                      bool haveInterNet =
                                          await config.haveInterNet();
                                      if (haveInterNet) {
                                        callpatchActivity();
                                      } else {
                                        saveTODB();
                                      }
                                      log("Internet: ${haveInterNet}");
                                      //
                                    },
                                    isLoading: loadingApi,
                                    label: 'Check in',
                                  ),
                                )
                              ],
                            ),
                          ),
                          Visibility(
                            visible: approvedisLoading,
                            child: Container(
                              width: Screens.width(context),
                              height: Screens.heigth(context),
                              child: approvedisLoading == true &&
                                      approvedmessage.isEmpty
                                  ? Center(child: CircularProgressIndicator())
                                  : Center(child: Text("${approvedmessage}")),
                              color: Colors.white54,
                            ),
                          )
                        ],
                      ),
                    )),
    );
  }

  Future<void> saveTODB() async {
    CheckinModel apdata = CheckinModel(
        clgcode: selectedClgCode!,
        ActivityDate: currentDateTimeServer(),
        ActivityTime: currentTimeServer(),
        StartDate: currentDateTimeServer(),
        StartTime: currentTimeServer(),
        U_Latitude: latitude,
        U_Longitude: langitude,
        U_CheckinAdd: adrresss.toString(),
        U_CheckedIn: 'Yes',
        status: 'N');
    await DataBaseHelper.insertPostCheckin(apdata).then((value) {
      DataBaseHelper.updateStatus(selectedClgCode!).then((value) {
        config.showDialog('Successfully saved..!!', 'Alert').then((value) {
          Get.offAllNamed<void>(FurneyRoutes.checkedin);
        });
      });
    });
  }

  bool loadingApi = false;
  Config config = Config();
  Future<void> callpatchActivity() async {
    if (selectedClgCode != null) {
      loadingApi = true;
      setState(() {});
      CheckinModel apdata = CheckinModel(
        clgcode: selectedClgCode!,
        ActivityDate: currentDateTimeServer(),
        ActivityTime: currentTimeServer(),
        StartDate: currentDateTimeServer(),
        StartTime: currentTimeServer(),
        U_Latitude: latitude,
        U_Longitude: langitude,
        U_CheckedIn: 'Yes',
        status: 'C',
        U_CheckinAdd: adrresss.toString(),
      );
      CheckinAPi.getGlobalData(apdata).then((value) async {
        if (value.statusCode! >= 200 && value.statusCode! <= 210) {
          await DataBaseHelper.updateStatus(selectedClgCode!);
          loadingApi = false;
          setState(() {});
          config.showDialog('Success..!!', 'Alert').then((value) {
            Get.toNamed<void>(FurneyRoutes.checkedin);
          });
        } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
          loadingApi = false;
          setState(() {});
          config.showDialog('${value.ErrorMsg!.message!.Value}', 'Alert');
        } else {
          loadingApi = false;
          setState(() {});
          config.showDialog('Something went wrong..!!', 'Alert');
        }
      });
    } else {
      config.showDialog('Select Customer', 'Alert');
    }
  }

  void clearData() {
    selectedClgCode = null;
    selectedCust = '';
    selectedCustCode = '';
    mycontroller[0].clear();
  }
}
