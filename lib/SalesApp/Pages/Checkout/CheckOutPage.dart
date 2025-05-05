import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ultimate_bundle/SalesApp/Api/AddressGetApi/AddressGetApi.dart';
import 'package:ultimate_bundle/SalesApp/Api/CheckOutPost/CheckOutNextFolowPostApi.dart';
import 'package:ultimate_bundle/SalesApp/Api/CheckOutPost/CheckOutPostApi.dart';
import 'package:ultimate_bundle/SalesApp/Api/CheckinApi/CheckInApi.dart';
import 'package:ultimate_bundle/SalesApp/Api/CheckinApi/GerCheckedInApi.dart';
import 'package:ultimate_bundle/SalesApp/Api/FileUploadApi/FileUploadApi.dart';
import 'package:ultimate_bundle/SalesApp/Api/ProjectApi/projectsApi.dart';
import 'package:ultimate_bundle/SalesApp/Model/GetActivities/GetAprvActivityModel.dart';
import 'package:ultimate_bundle/SalesApp/Model/GetActivities/GetCheckedInModel.dart';
import 'package:ultimate_bundle/SalesApp/Model/ProjectModel/ProjectModel.dart';
import 'package:ultimate_bundle/SalesApp/Pages/Planning/CreateVisit.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/items_api/mainsubApi/subGroup.dart';
import 'package:ultimate_bundle/src/furney/src/DB/DBHelper.dart';
import 'package:ultimate_bundle/src/furney/src/DB/DBModal/GetApprovedCust.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/Login_User_Modal/login_user_modal.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/item_modal/mainsubModal/subModal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/SalesAppBar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  State<CheckOutPage> createState() => _firstpageState();
}

class _firstpageState extends State<CheckOutPage> {
  @override
  void initState() {
    super.initState();
// setState(() {
//   isselected=false;
// });
    checkInternet();
  }

  bool isselected = false;
  checkInternet() async {
    final internet = await config.haveInterNet();
    log('datatata: ${GetValues.U_CrpUsr!.toLowerCase()}');
    if (internet) {
      log('internet:::$internet');
      await getActivityApi();
      await allSubGroupApi();
      await allActiveProjectApi();
      await determinePosition55(context);

      // determinePosition();
    } else {
      await determinePosition55(context);
      // await determinePosition();
      await getValuesFromDB();
      await getSubGrpFDB();
      await getActiveProjectFDB();
    }
  }

  List<CheckinModel> data = [];
  List<GetActivityApvdData> cust = [];
  Future<dynamic> getValuesFromDB() async {
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
          CntctTime: int.parse(data[0].ActivityTime.replaceAll(':', '')),
          CntctDate: data[0].ActivityDate,
          ClgCode: data[0].clgcode,
          Details: cust[0].Details,
          CntctSbjct: 0,
        ),
      );
      mycontroller[0].text = cust[0].Details!;
      mycontroller[16].text = cust[0].CardName!;
      if (checkedINData.isNotEmpty) {
        loading = false;
        msg = '';
        setState(() {});
      } else {
        loading = false;
        msg = 'No data checkin first';
        setState(() {});
      }
    } else {
      loading = false;
      msg = 'No data checkin first';
      setState(() {});
    }
  }

  bool loading = false;
  String msg = '';
  List<GetCheckedINData> checkedINData = [];
  Future<dynamic> getActivityApi() async {
    loading = true;
    msg = '';
    setState(() {});

    await GetCheckedINAPi.getGlobalData(
      GetValues.slpCode!,
      config.currentDateTimeServer(),
    ).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        loading = false;
        msg = '';
        setState(() {});
        if (value.activitiesData != null) {
          checkedINData = value.activitiesData!;
          log('CntctTime: ${checkedINData[0].CntctTime}');
          mycontroller[0].text = checkedINData[0].Details.toString();
          mycontroller[16].text = checkedINData[0].CardName!;
        } else {
          loading = false;
          msg = ' No data found';
          setState(() {});
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

  String? longi;
  String? lati;
  String latitudee = '';
  String langitudee = '';
  // String? adrress;
  String? url;
  List<LoginUserData>? loginUserData;

  String? adrresss;

  String? adrress1;

  String? adrress2;

  String? adrress3;
  static double? lati1;
  static double? lang2;

  Future<void> determinePosition55(BuildContext context) async {
    bool? serviceEnabled;
    latitudee = '';
    adrresss = '';
    langitudee = '';

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
          final pos = await Geolocator.getCurrentPosition();
          latitudee = pos.latitude == '' || pos.latitude == 'null'
              ? '0.0'
              : pos.latitude.toString();
          langitudee = pos.longitude == '' || pos.longitude == 'null'
              ? '0.0'
              : pos.longitude.toString();
          final lat = double.parse(latitudee);
          final long = double.parse(langitudee);
          lati1 = double.parse(latitudee);
          lang2 = double.parse(langitudee);

          log('lat and lang::${lati1!}, ${lang2!}');
          // url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';
          // MapSampleState.lati1 = double.parse(latitude);
          // MapSampleState.lang2 = double.parse(langitude);

          await AddressMasterApi.getData(lat.toString(), long.toString())
              .then((value) {
            log('value.stcode::${value.stcode}');
            if (200 >= value.stcode! && 210 <= value.stcode!) {
              adrresss = value.results[1].formattedAddress;
              adrress2 = value.results[1].formattedAddress;
              adrress3 = value.results[1].formattedAddress;

              log('adress::$adrresss');
            } else {
              print('error:api');
            }
          });
          // await loadWebView();
        } catch (e) {
          log('XXXXXXXXXXXXXX');
          const snackBar = SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Colors.red,
            content: Text('Please turn on the Location!!..'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Future.delayed(
            const Duration(seconds: 2),
            () => Get.back<dynamic>(),
          );
        }
      } else if (serviceEnabled == true) {
        final pos = await Geolocator.getCurrentPosition();
        latitudee =
            pos.latitude.toString() == '' || pos.latitude.toString() == 'null'
                ? '0.0'
                : pos.latitude.toString();
        langitudee =
            pos.longitude.toString() == '' || pos.longitude.toString() == 'null'
                ? '0.0'
                : pos.longitude.toString();

        final lat = double.parse(latitudee);
        final long = double.parse(langitudee);
        lati1 = double.parse(latitudee);
        lang2 = double.parse(langitudee);
        loading = false;
        await AddressMasterApi.getData(lat.toString(), long.toString())
            .then((value) {
          log('value.stcode::${value.stcode}');
          if (value.stcode! >= 200 && value.stcode! <= 210) {
            adrresss = value.results[1].formattedAddress;
            log('adress::$adrresss');
          } else {
            // print("error:api");
          }
        });
        // await loadWebView();
      }
    } catch (e) {
      log('YYYYYYYYYYYYYYYYS');

      final snackBar =
          SnackBar(backgroundColor: Colors.red, content: Text('$e'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // Future.delayed(
      //     const Duration(seconds: 2),
      //     () => Get.back<dynamic>(),
      //   );
    }
    loadingWebView = false;
    loading = false;

    log('lat and lang::${lati1!}, ${lang2!}');
  }

  // Future<void> determinePosition() async {
  //   bool? serviceEnabled;
  //   LocationPermission permission;
  //   try {
  //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //     if (serviceEnabled == false) {
  //       try {
  //         await Geolocator.getCurrentPosition();
  //         permission = await Geolocator.checkPermission();
  //         if (permission == LocationPermission.denied) {
  //           permission = await Geolocator.requestPermission();
  //           if (permission == LocationPermission.denied) {
  //             //return Future.error('Location permissions are denied');
  //           }
  //         }

  //         if (permission == LocationPermission.deniedForever) {}
  //         var pos = await Geolocator.getCurrentPosition();
  //         print('lattitude: ' + pos.latitude.toString());
  //         latitude = pos.latitude.toString();
  //         langitude = pos.longitude.toString();
  //         longi = langitude;
  //         lati = latitude;

  //         setState(() {
  //           url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';
  //         });
  //         var lat = double.parse(latitude);
  //         var long = double.parse(langitude);

  //         var placemarks = await placemarkFromCoordinates(lat, long);
  //         setState(() {
  //           adrresss = placemarks[0].street.toString() +
  //               ' ' +
  //               placemarks[0].thoroughfare.toString() +
  //               ' ' +
  //               placemarks[0].locality.toString();
  //         });
  //         await loadWebView();
  //       } catch (e) {
  //         const snackBar = SnackBar(
  //             duration: Duration(seconds: 1),
  //             backgroundColor: Colors.red,
  //             content: Text('Please turn on the Location!!..'));
  //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //         Future.delayed(
  //           const Duration(seconds: 2),
  //           () => Get.back<dynamic>(),
  //         );
  //       }
  //     } else if (serviceEnabled == true) {
  //       var pos = await Geolocator.getCurrentPosition();
  //       print('lattitude: ' + pos.latitude.toString());
  //       latitude = pos.latitude.toString();
  //       langitude = pos.longitude.toString();
  //       longi = langitude;
  //       lati = latitude;

  //       setState(() {
  //         url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';
  //       });
  //       var lat = double.parse(latitude);
  //       var long = double.parse(langitude);

  //       var placemarks = await placemarkFromCoordinates(lat, long);
  //       setState(() {
  //         adrresss = placemarks[0].street.toString() +
  //             ' ' +
  //             placemarks[0].thoroughfare.toString() +
  //             ' ' +
  //             placemarks[0].locality.toString();
  //       });
  //       await loadWebView();
  //     }
  //   } catch (e) {
  //     final snackBar =
  //         SnackBar(backgroundColor: Colors.red, content: Text('$e'));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  // }

  // // web view
  WebViewController? controllerGlobal;
  bool loadingWebView = true;
  Future<dynamic> loadWebView() async {
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
              loadingWebView = false;
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

  List<TextEditingController> mycontroller =
      List.generate(20, (i) => TextEditingController());

  List<GlobalKey<FormState>> formkey =
      List.generate(3, (i) => GlobalKey<FormState>());
  int pageChanged = 0;
  PageController pageController = PageController();
  bool? fileValidation = false;
  List<SubModalValue> subValueValue = [];
  List<SubModalValue> filtersubValueValue = [];
  List<SubModalValue> showsubValue = [];
  List<GetProjectData> activeProject = [];
  List<GetProjectData> filteractiveProject = [];

  Future<dynamic> allSubGroupApi() async {
    await SubGroupAPi.getGlobalData().then((value) async {
      // if (mounted) {
      if (value.itemValueValue != null) {
        setState(() {
          // value.itemValueValue![0].code;
          subValueValue = value.itemValueValue!;
          filtersubValueValue = subValueValue;
          log('filtersubValueValue::${filtersubValueValue.length}');
        });
        await DataBaseHelper.deleteSubGrp();
        await DataBaseHelper.insertsubGroup(value.itemValueValue!);
      } else {
        loading = false;
        msg = 'No data try again';
      }
      // }
    });
  }

  Future<dynamic> getSubGrpFDB() async {
    subValueValue = await DataBaseHelper.getSubGrp();
    filtersubValueValue = subValueValue;
    setState(() {});
  }

  //
  Future<dynamic> allActiveProjectApi() async {
    await GetActiveProjectAPi.getGlobalData().then((value) async {
      if (mounted) {
        if (value.statusCode! >= 200 && value.statusCode! <= 210) {
          if (value.activitiesData != null) {
            setState(() {
              activeProject = value.activitiesData!;
            });
            await DataBaseHelper.deleteActiveProject();
            await DataBaseHelper.insertActiveProject(activeProject);
          } else {
            loading = false;
            msg = 'No data try again';
          }
        }
      }
    });
  }

  Future<dynamic> getActiveProjectFDB() async {
    activeProject = await DataBaseHelper.getActiveProject();
    setState(() {});
  }

  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  static final CameraPosition _kGooglePlexxx = CameraPosition(
    target: LatLng(lati1!, lang2!),
    zoom: 19.95,
  );
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didpop) {
        if (didpop) return;
        log('bbbbbbbb');
        onbackpress();
      },
      child: Scaffold(
        appBar: salesappBar(context, _scaffoldKey, widget.title),
        // appBar: AppBar(
        //   backgroundColor: theme.primaryColor,
        //   title: Text(
        //     "Site Check-Out",
        //     style: theme.textTheme.bodyLarge!
        //         .copyWith(color: Colors.white, fontSize: 18),
        //   ),
        // ),
        // resizeToAvoidBottomInset: false,
        drawer:
            // GetValues.userRoll == '3' ? drawer2(context) :
            drawer(context),
        body: (loading == true &&
                msg.isEmpty &&
                checkedINData.isEmpty &&
                filtersubValueValue.isEmpty &&
                activeProject.isEmpty)
            ? const Center(child: CircularProgressIndicator())
            : (loading == false &&
                    msg.isNotEmpty &&
                    (checkedINData.isEmpty ||
                        filtersubValueValue.isEmpty ||
                        activeProject.isEmpty))
                ? Center(child: Text(msg))
                : PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    onPageChanged: (index) {
                      log('index: $index');
                      log('U_CrpUsrU_CrpUsr:  ${GetValues.U_CrpUsr!.toLowerCase()}');
                      setState(() {
                        pageChanged = index;
                      });
                      //  print(pageChanged);
                    },
                    children: [
                      firstPage(context, theme),
                      GetValues.U_CrpUsr!.toLowerCase() == 'yes'
                          ? secondPageCPUSer(context, theme)
                          : secondPage(context, theme),
                    ],
                  ),
      ),
    );
  }

  Container secondPage(BuildContext context, ThemeData theme) {
    return Container(
      width: Screens.width(context),
      height: Screens.heigth(context),
      color: theme.primaryColor.withOpacity(0.3),
      padding: EdgeInsets.only(
        top: Screens.heigth(context) * 0.01,
        left: Screens.width(context) * 0.02,
        right: Screens.width(context) * 0.02,
        bottom: Screens.heigth(context) * 0.01,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: formkey[1],
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: Screens.heigth(context) * 0.02,
                  left: Screens.width(context) * 0.02,
                  right: Screens.width(context) * 0.02,
                  bottom: Screens.heigth(context) * 0.02,
                ),
                width: Screens.width(context),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Screens.width(context) * 0.1,
                      child: const Text('Geo:'),
                    ),
                    //  Row(
                    //    children: [
                    SizedBox(
                      width: Screens.width(context) * 0.37,
                      child: Text('Lat: $latitudee'),
                    ),
                    SizedBox(
                      width: Screens.width(context) * 0.03,
                      child: const Text('|'),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: Screens.width(context) * 0.37,
                      child: Text('Long: $langitudee'),
                    ),
                    //    ],
                    //  ),
                  ],
                ),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              Container(
                width: Screens.width(context),
                height: Screens.heigth(context) * 0.37,
                decoration: const BoxDecoration(),
                child: loading == true || lati1 == null || lang2 == null
                    // loadingWebView == true
                    // loadingWebView == false
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : GoogleMap(
                        myLocationEnabled: true,
                        initialCameraPosition: _kGooglePlexxx,
                        onMapCreated: mapController.complete,
                      ),
                // WebViewWidget(controller: controllerGlobal!)
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              SizedBox(
                //       padding: EdgeInsets.only(
                //   top: Screens.heigth(context) * 0.02,
                //   left: Screens.width(context) * 0.02,
                //   right: Screens.width(context) * 0.02,
                //   bottom: Screens.heigth(context) * 0.02,
                // ),
                width: Screens.width(context),
                //  color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Screens.width(context) * 0.3,
                      child: const Text('Photo Snap'),
                    ),
                    Row(
                      children: [
                        // InkWell(
                        //   onTap: files.length > 5
                        //       ? null
                        //       : () {
                        //           setState(() {
                        //             log("files length" +
                        //                 files.length.toString());
                        //             // showtoast();
                        //             if (files.length <= 3) {
                        //               setState(() {
                        //                 imagetoBinary(ImageSource.camera);
                        //                 // fileValidation = false;
                        //               });
                        //             } else {
                        //               showtoast();
                        //             }
                        //           });
                        //         },
                        //   child: Container(
                        //       color: Colors.white,
                        //       padding: EdgeInsets.only(
                        //         top: Screens.heigth(context) * 0.02,
                        //         left: Screens.width(context) * 0.02,
                        //         right: Screens.width(context) * 0.02,
                        //         bottom: Screens.heigth(context) * 0.02,
                        //       ),
                        //       width: Screens.width(context) * 0.2,
                        //       child: Icon(Icons.camera)),
                        // ),
                        InkWell(
                          onTap: files.length > 5
                              ? null
                              : () {
                                  setState(() {
                                    log(
                                      'files length${files.length}',
                                    );
                                    // showtoast();
                                    if (files.length <= 3) {
                                      setState(() {
                                        selectattachment();

                                        fileValidation = false;
                                      });
                                    } else {
                                      showtoast();
                                    }
                                  });
                                },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: Screens.heigth(context) * 0.02,
                              left: Screens.width(context) * 0.02,
                              right: Screens.width(context) * 0.02,
                              bottom: Screens.heigth(context) * 0.02,
                            ),
                            color: Colors.white,
                            width: Screens.width(context) * 0.2,
                            child: const Icon(Icons.photo),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              files.isEmpty
                  ? const SizedBox()
                  :
                  // Container(
                  //     height: Screens.heigth(context) * 0.3,
                  //     padding: EdgeInsets.only(
                  //       top: Screens.heigth(context) * 0.001,
                  //       right: Screens.heigth(context) * 0.015,
                  //       left: Screens.heigth(context) * 0.015,
                  //       bottom: Screens.heigth(context) * 0.015,
                  //     ),
                  //     child:
                  ListView.builder(
                      itemCount: files.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int i) {
                        if (files[i].path.split('/').last.contains('png')) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(),
                                    width: Screens.width(context) * 0.09,
                                    height: Screens.heigth(context) * 0.06,
                                    child: Center(
                                      child: Image.asset(
                                        'assets/CRM/img.jpg',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(),
                                    width: Screens.width(context) * 0.6,
                                    // height: Screens.padingHeight(context) * 0.06,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      files[i].path.split('/').last,
                                      // overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Screens.width(context) * 0.1,
                                    height: Screens.heigth(context) * 0.06,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          files.removeAt(i);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.cancel_rounded,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else if (files[i]
                            .path
                            .split('/')
                            .last
                            .contains('jp')) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(),
                                    width: Screens.width(context) * 0.09,
                                    height: Screens.heigth(context) * 0.06,
                                    child: Center(
                                      child: Image.asset(
                                        'assets/CRM/img.jpg',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(),
                                    width: Screens.width(context) * 0.6,
                                    // height: Screens.padingHeight(context) * 0.06,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      files[i].path.split('/').last,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Screens.width(context) * 0.1,
                                    height: Screens.heigth(context) * 0.06,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          files.removeAt(i);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.cancel_rounded,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else if (files[i]
                            .path
                            .split('/')
                            .last
                            .contains('pdf')) {
                          return Column(
                            children: [
                              SizedBox(
                                height: Screens.heigth(context) * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(),
                                    width: Screens.width(context) * 0.09,
                                    height: Screens.heigth(context) * 0.06,
                                    child: Center(
                                      child: Image.asset(
                                        'assets/CRM/PDFimg.png',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(),
                                    width: Screens.width(context) * 0.6,
                                    // height: Screens.padingHeight(context) * 0.06,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      files[i].path.split('/').last,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Screens.width(context) * 0.1,
                                    height: Screens.heigth(context) * 0.06,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          files.removeAt(i);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.cancel_rounded,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else if (files[i]
                            .path
                            .split('/')
                            .last
                            .contains('xlsx')) {
                          return Column(
                            children: [
                              SizedBox(
                                height: Screens.heigth(context) * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(),
                                    width: Screens.width(context) * 0.09,
                                    height: Screens.heigth(context) * 0.06,
                                    child: Center(
                                      child: Image.asset(
                                        'assets/CRM/xls.png',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(),
                                    width: Screens.width(context) * 0.6,
                                    // height: Screens.padingHeight(context) * 0.06,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      files[i].path.split('/').last,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Screens.width(context) * 0.1,
                                    height: Screens.heigth(context) * 0.06,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          files.removeAt(i);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.cancel_rounded,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                        return Column(
                          children: [
                            SizedBox(
                              height: Screens.heigth(context) * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(),
                                  width: Screens.width(context) * 0.09,
                                  height: Screens.heigth(context) * 0.06,
                                  child: Center(
                                    child: Image.asset('assets/CRM/txt.png'),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(),
                                  width: Screens.width(context) * 0.6,
                                  // height: Screens.padingHeight(context) * 0.06,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    files[i].path.split('/').last,
                                  ),
                                ),
                                SizedBox(
                                  width: Screens.width(context) * 0.1,
                                  height: Screens.heigth(context) * 0.06,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        files.removeAt(i);
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.cancel_rounded,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
              //),
              Visibility(
                visible: fileValidation!,
                child: Text(
                  'Please Choose At Least One File..',
                  style: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
                ),
              ),

              //
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              Container(
                width: Screens.width(context),
                color: Colors.grey[200],
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: TextFormField(
                  controller: mycontroller[4],
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Reqtuired *';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Advertise',
                    hintStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              Container(
                width: Screens.width(context),
                color: Colors.grey[200],
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: TextFormField(
                  controller: mycontroller[5],
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Reqtuired *';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Advertise Format',
                    hintStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              Container(
                width: Screens.width(context),
                color: Colors.grey[200],
                padding: EdgeInsets.symmetric(
                  vertical: Screens.heigth(context) * 0.02,
                  horizontal: Screens.width(context) * 0.02,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            //  showProductDialog();
                          },
                          child: SizedBox(
                            //  color: Colors.blue,
                            width: Screens.width(context) * 0.6,
                            child: const Text('Product'),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              for (var i = 0; i < product.length; i++) {
                                product[i].code = 0;
                              }
                              productText.clear();
                              controllerTxt.clear();
                            });
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            // color: Colors.red,
                            width: Screens.width(context) * 0.2,
                            child: const Icon(
                              Icons.close,
                            ),
                          ),
                        ),
                      ],
                    ),
                    product.isEmpty
                        ? const SizedBox()
                        : Column(
                            children: [
                              SizedBox(
                                height: Screens.heigth(context) * 0.02,
                              ),
                              Container(
                                width: Screens.width(context),
                                color: Colors.white,
                                padding: EdgeInsets.only(
                                  top: Screens.heigth(context) * 0.02,
                                  left: Screens.width(context) * 0.02,
                                  right: Screens.width(context) * 0.02,
                                  bottom: Screens.heigth(context) * 0.02,
                                ),
                                child: Wrap(
                                  spacing: 5, // width
                                  runSpacing: 10, // height
                                  children: listProduct(
                                    theme,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Screens.heigth(context) * 0.02,
                              ),
                              Container(
                                width: Screens.width(context),
                                color: Colors.white,
                                padding: EdgeInsets.only(
                                  top: Screens.heigth(context) * 0.02,
                                  left: Screens.width(context) * 0.02,
                                  right: Screens.width(context) * 0.02,
                                  bottom: Screens.heigth(context) * 0.02,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Display Brand Contribution',
                                      style:
                                          theme.textTheme.bodyMedium?.copyWith(
                                        color: theme.primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Screens.heigth(context) * 0.02,
                                    ),
                                    Wrap(
                                      // spacing: 5.0, // width
                                      runSpacing: 10, // height
                                      children: listProductTextField(
                                        theme,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),

              // SizedBox(
              //   height: Screens.heigth(context) * 0.02,
              // ),
              // Container(
              //     width: Screens.width(context),
              //     color: Colors.grey[200],
              //     padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
              //     child: TextFormField(
              //       controller: mycontroller[7],
              //       decoration: InputDecoration(
              //           border: InputBorder.none,
              //           focusedBorder: InputBorder.none,
              //           enabledBorder: InputBorder.none,
              //           errorBorder: InputBorder.none,
              //           disabledBorder: InputBorder.none,
              //           hintText: "Display Brand Contribution",
              //           hintStyle: theme.textTheme.bodyText2!.copyWith(
              //             color: theme.primaryColor,
              //           )),
              //     )),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              Container(
                width: Screens.width(context),
                color: Colors.grey[200],
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: TextFormField(
                  controller: mycontroller[8],
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Reqtuired *';
                    }
                    return null;
                  },
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Price point comparable',
                    hintStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              Container(
                width: Screens.width(context),
                color: Colors.grey[200],
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: TextFormField(
                  controller: mycontroller[9],
                  maxLines: 4,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Reqtuired *';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Brands in promo Board',
                    hintStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              Container(
                width: Screens.width(context),
                color: Colors.grey[200],
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: TextFormField(
                  controller: mycontroller[10],
                  validator: (v) {
                    if (GetValues.U_CrpUsr == 'Yes' ||
                        GetValues.U_CrpUsr == 'No' ||
                        GetValues.U_CrpUsr == 'null') {
                      if (v!.isEmpty) {
                        return 'Reqtuired *';
                      }
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Order Prospect value',
                    hintStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              Container(
                width: Screens.width(context),
                color: Colors.grey[200],
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: TextFormField(
                  controller: mycontroller[11],
                  validator: (v) {
                    if (GetValues.U_CrpUsr == 'Yes' ||
                        GetValues.U_CrpUsr == 'No' ||
                        GetValues.U_CrpUsr == 'null') {
                      if (v!.isEmpty) {
                        return 'Reqtuired *';
                      }
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Payment value',
                    hintStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              Container(
                width: Screens.width(context),
                color: Colors.grey[200],
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: TextFormField(
                  controller: mycontroller[12],
                  maxLines: 4,
                  validator: (v) {
                    if (GetValues.U_CrpUsr == 'Yes' ||
                        GetValues.U_CrpUsr == 'No' ||
                        GetValues.U_CrpUsr == 'null') {
                      if (v!.isEmpty) {
                        return 'Reqtuired *';
                      }
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Any complants from customer',
                    hintStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              Container(
                width: Screens.width(context),
                color: Colors.grey[200],
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: TextFormField(
                  controller: mycontroller[13],
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Remarks 1',
                    hintStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              Container(
                width: Screens.width(context),
                color: Colors.grey[200],
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: TextFormField(
                  controller: mycontroller[14],
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Remarks 2',
                    hintStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              SizedBox(
                width: Screens.width(context),
                height: Screens.heigth(context) * 0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    foregroundColor: Colors.white,
                    backgroundColor: theme.primaryColor,
                  ),
                  onPressed: () {
                    log('ANBBBB::::${GetValues.U_CrpUsr}');
                    // if(GetValues.U_CrpUsr =="Yes"){
                    //   // if (formkey[2].currentState!.validate()
                    //   // && formkey[3].currentState!.validate() && formkey[4].currentState!.validate()
                    //   // ){
                    //   //    updatedSite = true;
                    //   //     onbackpress();
                    //   // }

                    // }
                    // if(GetValues.U_CrpUsr == "No" || GetValues.U_CrpUsr == null){
                    setState(() {
                      if (formkey[1].currentState!.validate()) {
                        log('ANBBBBvalidate');
                        if (product.isEmpty) {
                          log('ANBBBBproduct');
                          config.showDialog(
                            'Produt is required..!!',
                            'Alert',
                          );
                        } else {
                          setState(() {
                            log('pageChanged::$pageChanged');
                            updatedSite = true;
                            onbackpress();
                          });

                          //crt
                        }
                      }
                    });

                    // };
                  },
                  child: const Text(
                    'Update Site Survey Details',
                  ),
                ),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container secondPageCPUSer(BuildContext context, ThemeData theme) {
    return Container(
      width: Screens.width(context),
      height: Screens.heigth(context),
      color: theme.primaryColor.withOpacity(0.3),
      padding: EdgeInsets.only(
        top: Screens.heigth(context) * 0.01,
        left: Screens.width(context) * 0.02,
        right: Screens.width(context) * 0.02,
        bottom: Screens.heigth(context) * 0.01,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: formkey[2],
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: Screens.heigth(context) * 0.02,
                  left: Screens.width(context) * 0.02,
                  right: Screens.width(context) * 0.02,
                  bottom: Screens.heigth(context) * 0.02,
                ),
                width: Screens.width(context),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Screens.width(context) * 0.1,
                      child: const Text('Geo:'),
                    ),
                    //  Row(
                    //    children: [
                    SizedBox(
                      width: Screens.width(context) * 0.37,
                      child: Text('Lat: $latitudee'),
                    ),
                    SizedBox(
                      width: Screens.width(context) * 0.03,
                      child: const Text('|'),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: Screens.width(context) * 0.37,
                      child: Text('Long: $langitudee'),
                    ),
                    //    ],
                    //  ),
                  ],
                ),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              Container(
                width: Screens.width(context),
                height: Screens.heigth(context) * 0.37,
                decoration: const BoxDecoration(),
                child: loading == true || lati1 == null || lang2 == null
                    // loadingWebView == false
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : GoogleMap(
                        myLocationEnabled: true,
                        initialCameraPosition: _kGooglePlexxx,
                        onMapCreated: mapController.complete,
                      ),
                // loadingWebView == false
                //     ? WebViewWidget(controller: controllerGlobal!)
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              SizedBox(
                width: Screens.width(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Screens.width(context) * 0.3,
                      child: const Text('Photo Snap'),
                    ),
                    Row(
                      children: [
                        // InkWell(
                        //   onTap: files.length > 5
                        //       ? null
                        //       : () {
                        //           setState(() {
                        //             log("files length" +
                        //                 files.length.toString());
                        //             // showtoast();
                        //             if (files.length <= 3) {
                        //               setState(() {
                        //                 imagetoBinary(ImageSource.camera);
                        //                 // fileValidation = false;
                        //               });
                        //             } else {
                        //               showtoast();
                        //             }
                        //           });
                        //         },
                        //   child: Container(
                        //       color: Colors.white,
                        //       padding: EdgeInsets.only(
                        //         top: Screens.heigth(context) * 0.02,
                        //         left: Screens.width(context) * 0.02,
                        //         right: Screens.width(context) * 0.02,
                        //         bottom: Screens.heigth(context) * 0.02,
                        //       ),
                        //       width: Screens.width(context) * 0.2,
                        //       child: Icon(Icons.camera)),
                        // ),
                        InkWell(
                          onTap: files.length > 5
                              ? null
                              : () {
                                  setState(() {
                                    log(
                                      'files length${files.length}',
                                    );
                                    // showtoast();
                                    if (files.length <= 3) {
                                      setState(() {
                                        selectattachment();

                                        fileValidation = false;
                                      });
                                    } else {
                                      showtoast();
                                    }
                                  });
                                },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: Screens.heigth(context) * 0.02,
                              left: Screens.width(context) * 0.02,
                              right: Screens.width(context) * 0.02,
                              bottom: Screens.heigth(context) * 0.02,
                            ),
                            color: Colors.white,
                            width: Screens.width(context) * 0.2,
                            child: const Icon(Icons.photo),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              files.isEmpty
                  ? const SizedBox()
                  :
                  // Container(
                  //     height: Screens.heigth(context) * 0.3,
                  //     padding: EdgeInsets.only(
                  //       top: Screens.heigth(context) * 0.001,
                  //       right: Screens.heigth(context) * 0.015,
                  //       left: Screens.heigth(context) * 0.015,
                  //       bottom: Screens.heigth(context) * 0.015,
                  //     ),
                  //     child:
                  ListView.builder(
                      itemCount: files.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int i) {
                        if (files[i].path.split('/').last.contains('png')) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(),
                                    width: Screens.width(context) * 0.09,
                                    height: Screens.heigth(context) * 0.06,
                                    child: Center(
                                      child: Image.asset(
                                        'assets/CRM/img.jpg',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(),
                                    width: Screens.width(context) * 0.6,
                                    // height: Screens.padingHeight(context) * 0.06,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      files[i].path.split('/').last,
                                      // overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Screens.width(context) * 0.1,
                                    height: Screens.heigth(context) * 0.06,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          files.removeAt(i);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.cancel_rounded,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else if (files[i]
                            .path
                            .split('/')
                            .last
                            .contains('jp')) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(),
                                    width: Screens.width(context) * 0.09,
                                    height: Screens.heigth(context) * 0.06,
                                    child: Center(
                                      child: Image.asset(
                                        'assets/CRM/img.jpg',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(),
                                    width: Screens.width(context) * 0.6,
                                    // height: Screens.padingHeight(context) * 0.06,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      files[i].path.split('/').last,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Screens.width(context) * 0.1,
                                    height: Screens.heigth(context) * 0.06,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          files.removeAt(i);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.cancel_rounded,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else if (files[i]
                            .path
                            .split('/')
                            .last
                            .contains('pdf')) {
                          return Column(
                            children: [
                              SizedBox(
                                height: Screens.heigth(context) * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(),
                                    width: Screens.width(context) * 0.09,
                                    height: Screens.heigth(context) * 0.06,
                                    child: Center(
                                      child: Image.asset(
                                        'assets/CRM/PDFimg.png',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(),
                                    width: Screens.width(context) * 0.6,
                                    // height: Screens.padingHeight(context) * 0.06,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      files[i].path.split('/').last,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Screens.width(context) * 0.1,
                                    height: Screens.heigth(context) * 0.06,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          files.removeAt(i);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.cancel_rounded,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else if (files[i]
                            .path
                            .split('/')
                            .last
                            .contains('xlsx')) {
                          return Column(
                            children: [
                              SizedBox(
                                height: Screens.heigth(context) * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(),
                                    width: Screens.width(context) * 0.09,
                                    height: Screens.heigth(context) * 0.06,
                                    child: Center(
                                      child: Image.asset(
                                        'assets/CRM/xls.png',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(),
                                    width: Screens.width(context) * 0.6,
                                    // height: Screens.padingHeight(context) * 0.06,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      files[i].path.split('/').last,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Screens.width(context) * 0.1,
                                    height: Screens.heigth(context) * 0.06,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          files.removeAt(i);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.cancel_rounded,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                        return Column(
                          children: [
                            SizedBox(
                              height: Screens.heigth(context) * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(),
                                  width: Screens.width(context) * 0.09,
                                  height: Screens.heigth(context) * 0.06,
                                  child: Center(
                                    child: Image.asset('assets/CRM/txt.png'),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(),
                                  width: Screens.width(context) * 0.6,
                                  // height: Screens.padingHeight(context) * 0.06,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    files[i].path.split('/').last,
                                  ),
                                ),
                                SizedBox(
                                  width: Screens.width(context) * 0.1,
                                  height: Screens.heigth(context) * 0.06,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        files.removeAt(i);
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.cancel_rounded,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
              //),
              Visibility(
                visible: fileValidation!,
                child: Text(
                  'Please Choose At Least One File..',
                  style: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
                ),
              ),

              //new

              Container(
                width: Screens.width(context),
                color: Colors.grey[200],
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: TextFormField(
                  onTap: showActiveProject,
                  controller: mycontroller[15],
                  readOnly: true,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Reqtuired *';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Project',
                    hintStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              Container(
                width: Screens.width(context),
                color: Colors.grey[200],
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: TextFormField(
                  onTap: choosedSubGrp,
                  controller: mycontroller[16],
                  readOnly: true,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Reqtuired *';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Customer',
                    hintStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              Container(
                width: Screens.width(context),
                color: Colors.grey[200],
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: TextFormField(
                  controller: mycontroller[17],
                  // validator: (v) {

                  //   if (v!.isEmpty) {
                  //     return 'Reqtuired *';
                  //   }
                  // },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Architect/Consultant',
                    hintStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),

              //
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              Container(
                width: Screens.width(context),
                color: Colors.grey[200],
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: TextFormField(
                  controller: mycontroller[4],
                  // validator: (v) {

                  //   if (v!.isEmpty) {
                  //     return 'Reqtuired *';
                  //   }
                  // },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Advertise',
                    hintStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              // Container(
              //     width: Screens.width(context),
              //     color: Colors.grey[200],
              //     padding:
              //         EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
              //     child: TextFormField(
              //       controller: mycontroller[5],
              //       validator: (v) {

              //         if (v!.isEmpty) {
              //           return 'Reqtuired *';
              //         }
              //           };
              //       },
              //       decoration: InputDecoration(
              //           border: InputBorder.none,
              //           focusedBorder: InputBorder.none,
              //           enabledBorder: InputBorder.none,
              //           errorBorder: InputBorder.none,
              //           disabledBorder: InputBorder.none,
              //           hintText: "Advertise Format",
              //           hintStyle: theme.textTheme.bodyText2!.copyWith(
              //             color: theme.primaryColor,
              //           )),
              //     )),
              // SizedBox(
              //   height: Screens.heigth(context) * 0.02,
              // ),
              Container(
                width: Screens.width(context),
                color: Colors.grey[200],
                padding: EdgeInsets.symmetric(
                  vertical: Screens.heigth(context) * 0.02,
                  horizontal: Screens.width(context) * 0.02,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            //  showProductDialog();
                          },
                          child: SizedBox(
                            //  color: Colors.blue,
                            width: Screens.width(context) * 0.6,
                            child: const Text('Product'),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              for (var i = 0; i < product.length; i++) {
                                product[i].code = 0;
                              }
                              productText.clear();
                              controllerTxt.clear();
                            });
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            // color: Colors.red,
                            width: Screens.width(context) * 0.2,
                            child: const Icon(
                              Icons.close,
                            ),
                          ),
                        ),
                      ],
                    ),
                    product.isEmpty
                        ? const SizedBox()
                        : Column(
                            children: [
                              SizedBox(
                                height: Screens.heigth(context) * 0.02,
                              ),
                              Container(
                                width: Screens.width(context),
                                color: Colors.white,
                                padding: EdgeInsets.only(
                                  top: Screens.heigth(context) * 0.02,
                                  left: Screens.width(context) * 0.02,
                                  right: Screens.width(context) * 0.02,
                                  bottom: Screens.heigth(context) * 0.02,
                                ),
                                child: Wrap(
                                  spacing: 5, // width
                                  runSpacing: 10, // height
                                  children: listProduct(
                                    theme,
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   height: Screens.heigth(context) * 0.02,
                              // ),
                              // Container(
                              //   width: Screens.width(context),
                              //   color: Colors.white,
                              //   padding: EdgeInsets.only(
                              //     top: Screens.heigth(context) * 0.02,
                              //     left: Screens.width(context) * 0.02,
                              //     right: Screens.width(context) * 0.02,
                              //     bottom: Screens.heigth(context) * 0.02,
                              //   ),
                              //   child: Column(
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     crossAxisAlignment:
                              //         CrossAxisAlignment.start,
                              //     children: [
                              // Text(
                              //   'Display Brand Contribution',
                              //   style: theme.textTheme.bodyText2
                              //       ?.copyWith(
                              //           color: theme.primaryColor),
                              // ),
                              // SizedBox(
                              //     height:
                              //         Screens.heigth(context) * 0.02),
                              // Wrap(
                              //     // spacing: 5.0, // width
                              //     runSpacing: 10.0, // height
                              //     children: listProductTextField(
                              //       theme,
                              //     )),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                  ],
                ),
              ),

              // SizedBox(
              //   height: Screens.heigth(context) * 0.02,
              // ),
              // Container(
              //     width: Screens.width(context),
              //     color: Colors.grey[200],
              //     padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
              //     child: TextFormField(
              //       controller: mycontroller[7],
              //       decoration: InputDecoration(
              //           border: InputBorder.none,
              //           focusedBorder: InputBorder.none,
              //           enabledBorder: InputBorder.none,
              //           errorBorder: InputBorder.none,
              //           disabledBorder: InputBorder.none,
              //           hintText: "Display Brand Contribution",
              //           hintStyle: theme.textTheme.bodyText2!.copyWith(
              //             color: theme.primaryColor,
              //           )),
              //     )),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),

              Container(
                width: Screens.width(context),
                color: Colors.grey[200],
                padding: EdgeInsets.symmetric(
                  vertical: Screens.heigth(context) * 0.02,
                  horizontal: Screens.width(context) * 0.02,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            for (var i = 0;
                                i < filtersubValueValue.length;
                                i++) {
                              filtersubValueValue[i].selected = 0;
                            }
                            setState(() {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return filterpage(context, theme);
                                },
                              ).then((value) {});
                            });

                            //  showProductDialog();
                          },
                          child: SizedBox(
                            //  color: Colors.blue,
                            width: Screens.width(context) * 0.6,
                            child: const Text('Sub Group'),
                          ),
                        ),
                        showsubValue.isEmpty
                            ? InkWell(
                                onTap: () {
                                  for (var i = 0;
                                      i < filtersubValueValue.length;
                                      i++) {
                                    filtersubValueValue[i].selected = 0;
                                  }
                                  setState(() {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return filterpage(context, theme);
                                      },
                                    ).then((value) {});
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  // color: Colors.red,
                                  width: Screens.width(context) * 0.2,
                                  child: const Icon(
                                    Icons.search,
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    showsubValue.clear();
                                    // isselected=false;
                                    for (var i = 0;
                                        i < filtersubValueValue.length;
                                        i++) {
                                      filtersubValueValue[i].selected = 0;
                                    }
                                    // subValueValue.clear();
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  // color: Colors.red,
                                  width: Screens.width(context) * 0.2,
                                  child: const Icon(
                                    Icons.close,
                                  ),
                                ),
                              ),
                      ],
                    ),
                    showsubValue.isEmpty
                        ? const SizedBox()
                        : Column(
                            children: [
                              SizedBox(
                                height: Screens.heigth(context) * 0.02,
                              ),
                              Container(
                                width: Screens.width(context),
                                // height:Screens.heigth(context)*0.4,

                                color: Colors.white,
                                padding: EdgeInsets.only(
                                  top: Screens.heigth(context) * 0.02,
                                  left: Screens.width(context) * 0.02,
                                  right: Screens.width(context) * 0.02,
                                  bottom: Screens.heigth(context) * 0.02,
                                ),
                                child: SingleChildScrollView(
                                  child: Wrap(
                                    spacing: 5, // width
                                    runSpacing: 5, // height
                                    children: listSubGroup22(
                                      theme,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
              // Container(
              //     width: Screens.width(context),
              //     color: Colors.grey[200],
              //     padding:
              //         EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
              //     child: TextFormField(
              //       controller: mycontroller[8],
              //       validator: (v) {

              //         if (v!.isEmpty) {
              //           return 'Reqtuired *';
              //         }
              //           };
              //       },
              //       maxLines: 4,
              //       decoration: InputDecoration(
              //           border: InputBorder.none,
              //           focusedBorder: InputBorder.none,
              //           enabledBorder: InputBorder.none,
              //           errorBorder: InputBorder.none,
              //           disabledBorder: InputBorder.none,
              //           hintText: "Price point comparable",
              //           hintStyle: theme.textTheme.bodyText2!.copyWith(
              //             color: theme.primaryColor,
              //           )),
              //     )),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              // Container(
              //     width: Screens.width(context),
              //     color: Colors.grey[200],
              //     padding:
              //         EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
              //     child: TextFormField(
              //       controller: mycontroller[9],
              //       maxLines: 4,
              //       validator: (v) {
              //         if (v!.isEmpty) {
              //           return 'Reqtuired *';
              //         }
              //          };
              //       },
              //       decoration: InputDecoration(
              //           border: InputBorder.none,
              //           focusedBorder: InputBorder.none,
              //           enabledBorder: InputBorder.none,
              //           errorBorder: InputBorder.none,
              //           disabledBorder: InputBorder.none,
              //           hintText: "Brands in promo Board",
              //           hintStyle: theme.textTheme.bodyText2!.copyWith(
              //             color: theme.primaryColor,
              //           )),
              //     )),
              // SizedBox(
              //   height: Screens.heigth(context) * 0.02,
              // ),
              Container(
                width: Screens.width(context),
                color: Colors.grey[200],
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: TextFormField(
                  controller: mycontroller[10],
                  validator: (v) {
                    if (GetValues.U_CrpUsr == 'Yes' ||
                        GetValues.U_CrpUsr == 'No' ||
                        GetValues.U_CrpUsr == 'null') {
                      if (v!.isEmpty) {
                        return 'Reqtuired *';
                      }
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Order Prospect value',
                    hintStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              Container(
                width: Screens.width(context),
                color: Colors.grey[200],
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: TextFormField(
                  controller: mycontroller[11],
                  validator: (v) {
                    if (GetValues.U_CrpUsr == 'Yes' ||
                        GetValues.U_CrpUsr == 'No' ||
                        GetValues.U_CrpUsr == 'null') {
                      if (v!.isEmpty) {
                        return 'Reqtuired *';
                      }
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Payment value',
                    hintStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              Container(
                width: Screens.width(context),
                color: Colors.grey[200],
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: TextFormField(
                  controller: mycontroller[12],
                  maxLines: 4,
                  validator: (v) {
                    if (GetValues.U_CrpUsr == 'Yes' ||
                        GetValues.U_CrpUsr == 'No' ||
                        GetValues.U_CrpUsr == 'null') {
                      if (v!.isEmpty) {
                        return 'Reqtuired *';
                      }
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Any complants from customer',
                    hintStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              Container(
                width: Screens.width(context),
                color: Colors.grey[200],
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: TextFormField(
                  controller: mycontroller[13],
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Description 1',
                    hintStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              Container(
                width: Screens.width(context),
                color: Colors.grey[200],
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: TextFormField(
                  controller: mycontroller[14],
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Description 2',
                    hintStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
              SizedBox(
                width: Screens.width(context),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    backgroundColor: theme.primaryColor,
                  ),
                  onPressed: () {
                    log('ANBBBB::::${GetValues.U_CrpUsr}');
                    // if(GetValues.U_CrpUsr =="Yes"){
                    //   // if (formkey[2].currentState!.validate()
                    //   // && formkey[3].currentState!.validate() && formkey[4].currentState!.validate()
                    //   // ){
                    //   //    updatedSite = true;
                    //   //     onbackpress();
                    //   // }

                    // }
                    // if(GetValues.U_CrpUsr == "No" || GetValues.U_CrpUsr == null){

                    // };

                    if (formkey[2].currentState!.validate()) {
                      if (product.isEmpty) {
                        config.showDialog('Produt is required..!!', 'Alert');
                      } else if (checkSubSelected() == false) {
                        config.showDialog(
                          'Sub Group is required..!!',
                          'Alert',
                        );
                      } else {
                        updatedSite = true;
                        onbackpress();
                      }
                    }
                  },
                  child: const Text('Update Site Survey Details'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void filterproduct(String v) {
    filteractiveProject = activeProject
        .where((e) => e.projectName!.toLowerCase().contains(v.toLowerCase()))
        .toList();
  }

  Future<void> showActiveProject() async {
    mycontroller[18].clear();
    filteractiveProject = activeProject;
    await Get.defaultDialog<void>(
      title: 'Active Projects',
      content: StatefulBuilder(
        builder: (context, st) {
          return Container(
            width: Screens.width(context),
            height: Screens.heigth(context) * 0.4,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  controller: mycontroller[18],
                  onChanged: (v) {
                    st(() {
                      filterproduct(v);
                    });
                  },
                  onEditingComplete: () {
                    mycontroller[15].text = mycontroller[18].text;
                    Get.back<void>();
                  },
                  decoration: InputDecoration(
                    hintText: 'Search for Customer',
                    // AppLocalizations.of(context)!
                    //     .search_sales_quot,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        final focus = FocusScope.of(context);
                        if (!focus.hasPrimaryFocus) {
                          focus.unfocus();
                        }
                      }, //
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 5,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteractiveProject.length,
                    itemBuilder: (BuildContext context, int ind) {
                      return InkWell(
                        onTap: () {
                          mycontroller[15].text =
                              filteractiveProject[ind].projectName!;
                          Get.back<void>();
                        },
                        child: Card(
                          child: Container(
                            width: Screens.width(context),
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(8),
                            child: Text(filteractiveProject[ind].projectName!),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  bool updatedSite = false;

  SingleChildScrollView firstPage(BuildContext context, ThemeData theme) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: Screens.heigth(context) * 0.01,
          left: Screens.heigth(context) * 0.005,
          right: Screens.heigth(context) * 0.005,
          bottom: Screens.heigth(context) * 0.01,
        ),
        child: Form(
          key: formkey[0],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
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
                        Text(
                          checkedINData.isEmpty
                              ? ''
                              : checkedINData[0].CardCode!,
                        ),
                        SizedBox(
                          height: Screens.heigth(context) * 0.01,
                        ),
                        Text(
                          checkedINData.isEmpty
                              ? ''
                              : checkedINData[0].CardName!,
                        ),
                        SizedBox(
                          height: Screens.heigth(context) * 0.01,
                        ),
                        Text(
                          checkedINData.isEmpty
                              ? ''
                              : 'Visit regarding ${checkedINData[0].VisitReg!}',
                        ),
                        SizedBox(
                          height: Screens.heigth(context) * 0.01,
                        ),
                        Text(
                          checkedINData.isEmpty
                              ? ''
                              : 'checked-in @ ${config.alignDate(
                                  checkedINData[0].CntctDate!,
                                )} ${config.convertintToTime(
                                  checkedINData[0].CntctTime!,
                                )}',
                        ),
                        SizedBox(
                          height: Screens.heigth(context) * 0.01,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.02,
                  ),
                  Container(
                    height: Screens.heigth(context) * 0.10,
                    width: Screens.width(context),
                    color: Colors.grey[200],
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: SizedBox.expand(
                      child: TextFormField(
                        controller: mycontroller[0],
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: 'Type Purpose of Visit',
                          hintStyle: theme.textTheme.bodyLarge!.copyWith(
                            color: theme.primaryColor,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.02,
                  ),
                  Container(
                    height: Screens.heigth(context) * 0.20,
                    width: Screens.width(context),
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 20,
                    ),
                    color: Colors.grey[200],
                    child:
                        // SizedBox.expand(
                        // child:
                        TextFormField(
                      controller: mycontroller[1],
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Reqtuired *';
                        }
                        return null;
                      },
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: 'Visit Discussion',
                        hintStyle: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.primaryColor,
                          fontSize: 15,
                        ),
                      ),
                      // ),
                    ),
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.02,
                  ),
                  Container(
                    height: Screens.heigth(context) * 0.10,
                    width: Screens.width(context),
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    color: Colors.grey[200],
                    child: SizedBox.expand(
                      child: TextFormField(
                        controller: mycontroller[2],
                        onTap: () {
                          showDate(context);
                        },
                        readOnly: true,
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: 'Next Followup Meeting On',
                          hintStyle: theme.textTheme.bodyLarge!.copyWith(
                            color: theme.primaryColor,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.05,
                  ),
                  InkWell(
                    onTap: () {
                      if (pageChanged == 0) {
                        // aasea

                        // setState(() {
                        //   isselected=false;
                        // });
                        pageController.jumpToPage(++pageChanged);
                        log('++pageChanged++pageChanged::${++pageChanged}');
                      }
                    },
                    child: Text(
                      'Update Site Survey details',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: theme.primaryColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.09,
              ),
              SizedBox(
                width: Screens.width(context),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    backgroundColor: theme.primaryColor,
                  ),
                  onPressed: checkOutapiLoad == false
                      ? () async {
                          if (formkey[0].currentState!.validate()) {
                            if (latitudee.isNotEmpty && langitudee.isNotEmpty) {
                              final haveInterNet = await config.haveInterNet();
                              if (haveInterNet) {
                                callMediaApi();
                              } else {
                                saveToDB();
                              }
                            } else {
                              config.showDialog(
                                'Missing Latitude and longitude turn on location and reopen checkout page..!!',
                                'Alert',
                              );
                            }
                          }
                          //else{
                          //   config.showDialog("Missing required valu", '');
                          // }
                        }
                      : null,
                  child: checkOutapiLoad == false
                      ? Text(
                          'Site Check-Out',
                          style: theme.textTheme.bodyLarge!
                              .copyWith(color: Colors.white, fontSize: 18),
                        )
                      : SizedBox(
                          width: Screens.width(context) * 0.05,
                          height: Screens.heigth(context) * 0.03,
                          child: const CircularProgressIndicator(),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveToDB() async {
    //insertPostCheckOut
    final chekcOut = CheckOutModel();
    final checkendtime = config.checkedinExpired(checkedINData[0].CntctDate!);
    final calculatedDate = checkedINData[0]
        .CntctDate!
        .replaceAll(':', '')
        .replaceAll('T', '')
        .replaceAll('00', '');

    chekcOut.uCheckOutAdd = adrresss;
    chekcOut.notes = mycontroller[1].text;
    chekcOut.uNxtFollowup = selectedDateApi;
    chekcOut.uCOLatitude = latitudee;
    chekcOut.uCOLongitude = langitudee;
    chekcOut.uAdvertise = mycontroller[4].text;
    chekcOut.uAdvFormt = mycontroller[5].text;
    chekcOut.uProducts = choosedProduct(); //mycontroller[6].text;
    chekcOut.uBrandContr = brandContribData();
    chekcOut.uPPComp = mycontroller[8].text;
    chekcOut.uBrandinPromo = mycontroller[9].text;
    chekcOut.uOrdProsValue = double.parse(mycontroller[10].text);
    chekcOut.uPymntVal = double.parse(mycontroller[11].text);
    chekcOut.uComplaints = mycontroller[12].text;
    chekcOut.uRemarks1 = mycontroller[13].text;
    chekcOut.uRemarks2 = mycontroller[14].text;
    chekcOut.clgCode = checkedINData[0].ClgCode;
    print('chekcOut.clgCode: ${chekcOut.clgCode}');
    chekcOut.closed = 'Y';
    chekcOut.ustatus = 'C';
    chekcOut.duration = checkendtime == 0
        ? double.parse(differenceTime().toStringAsFixed(0))
        : double.parse(differenceTimenextD().toStringAsFixed(0));
    chekcOut.closedate =
        checkendtime == 0 ? config.currentDateTimeServer() : calculatedDate;

    chekcOut.endTime = checkendtime == 0
        ? config.currentTimeServer().replaceAll(':', '').padLeft(6, '0')
        : ('23:58:00').replaceAll(':', '');
    chekcOut.uProject = mycontroller[15].text;
    chekcOut.uCustomer = mycontroller[16].text;
    chekcOut.uConsultant = mycontroller[17].text;
    chekcOut.uSubgroup = choosedSubGrp();

    final filevalue = <FilesPostData>[];
    for (var i = 0; i < files.length; i++) {
      filevalue.add(
        FilesPostData(filePath: files[i].path, clgcode: chekcOut.clgCode!),
      );
    }
    await DataBaseHelper.insertFiles(filevalue);
    await DataBaseHelper.insertPostCheckOut(chekcOut).then((value) async {
      await DataBaseHelper.updateStatuschecdin(chekcOut.clgCode!);
      await DataBaseHelper.getFileData(chekcOut.clgCode!);
      await DataBaseHelper.getPostCheckoutData(chekcOut.clgCode!);
      config.showDialogSucessDB('Successfully saved...', 'Success');
    });
  }

  bool checkOutapiLoad = false;
  Future<void> callMediaApi() async {
    print('datata: ');
    if (updatedSite == false) {
      await Get.defaultDialog<void>(middleText: 'Update the site details');
      return;
    }
    checkOutapiLoad = true;
    setState(() {});
    final chekcOut = CheckOutModel();
    for (var i = 0; i < filedata.length; i++) {
      await FilePostApi.getFilePostData(
        filedata[i].fileBytes,
        filedata[i].fileName,
      ).then((value) {
        setState(() {
          if (value.stCode! >= 200 && value.stCode! <= 210) {
            setState(() {
              // print('Api PAth: ${value.filepath}');
              // filelink.add(value.filepath!);
              if (i == 0) {
                chekcOut.uLink1 = value.filepath;
              } else if (i == 1) {
                chekcOut.uLink2 = value.filepath;
              } else if (i == 2) {
                chekcOut.uLink3 = value.filepath;
              } else if (i == 3) {
                chekcOut.uLink4 = value.filepath;
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
    final checkendtime = config.checkedinExpired(checkedINData[0].CntctDate!);
    log('checkendtimecheckendtime::$checkendtime');
    var calculatedDate = checkedINData[0]
        .CntctDate!
        .replaceAll(':', '')
        .replaceAll('T', '')
        .replaceAll('00', '');
    calculatedDate = '$calculatedDate 23:58:00';
    chekcOut.notes = mycontroller[1].text;
    chekcOut.uCheckOutAdd = adrresss;
    chekcOut.uNxtFollowup = selectedDateApi;
    chekcOut.uCOLatitude = latitudee;
    chekcOut.uCOLongitude = langitudee;
    chekcOut.uAdvertise = mycontroller[4].text;
    chekcOut.uAdvFormt = mycontroller[5].text;
    chekcOut.uProducts = choosedProduct(); // mycontroller[6].text;
    chekcOut.uBrandContr = brandContribData();
    chekcOut.uPPComp = mycontroller[8].text;
    chekcOut.uBrandinPromo = mycontroller[9].text;
    chekcOut.uOrdProsValue = double.parse(
      mycontroller[10].text.isEmpty ? '0.00' : mycontroller[10].text,
    );
    chekcOut.uPymntVal = double.parse(
      mycontroller[11].text.isEmpty ? '0.00' : mycontroller[11].text,
    );
    chekcOut.uComplaints = mycontroller[12].text;
    chekcOut.uRemarks1 = mycontroller[13].text;
    chekcOut.uRemarks2 = mycontroller[14].text;
    chekcOut.clgCode = checkedINData[0].ClgCode;
    chekcOut.closed = 'Y';
    chekcOut.ustatus = 'C';
    chekcOut.duration = checkendtime == 0
        ? double.parse(differenceTime().toStringAsFixed(0))
        : double.parse(differenceTimenextD().toStringAsFixed(0));
    chekcOut.closedate =
        checkendtime == 0 ? config.currentDateTimeServer() : calculatedDate;
    //    String data = config.currentTimeServer().replaceAll(":", "").padLeft(6,'0');
    // int data2 = int.parse(data);
    chekcOut.endTime = checkendtime == 0
        ? config.currentTimeServer().replaceAll(':', '').padLeft(6, '0')
        : ('23:58:00').replaceAll(':', '');

    // int.parse(config.currentTimeServer().replaceAll(":", "").padLeft(6,'0'))
    // :int.parse(("23:58:00").replaceAll(":", ""));
//config.convertSD(checkedINData[0].CntctDate);

    chekcOut.uProject = mycontroller[15].text;
    chekcOut.uCustomer = mycontroller[16].text;
    chekcOut.uConsultant = mycontroller[17].text;
    chekcOut.uSubgroup = choosedSubGrp();

    await CheckOutPatchAPi.getGlobalData(chekcOut).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (selectedDateApi.isNotEmpty) {
          callNFCheckOtApi();
        } else {
          checkOutapiLoad = false;
          setState(() {});
          config.showDialogSucessDB('Successfully saved...', 'Success');
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        checkOutapiLoad = false;
        setState(() {});
        config.showDialog('${value.ErrorMsg!.message!.Value}', 'Alert');
      } else {
        checkOutapiLoad = false;
        setState(() {});
        config.showDialog('Something went wrong try again...', 'Alert');
      }
    });
  }

  void callNFCheckOtApi() async {
    final purpVisitModel = CheckOutNFPModel(
      Activity: '',
      SaleEmpCode: int.parse(GetValues.slpCode!),
      U_PlanDate: selectedDateApi,
      U_PlanTime: config.currentTimeServer(),
      cardCode: checkedINData[0].CardCode!,
      notes: checkedINData[0].Details!,
      subject: checkedINData[0].CntctSbjct!,
      PreviousActivity: checkedINData[0].ClgCode!,
    );
    await CheckOutNFPostAPi.getGlobalData(purpVisitModel).then((value) {
      checkOutapiLoad = false;
      setState(() {});
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        config.showDialogSucessDB('Successfully saved...', 'Success');
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        config.showDialog('${value.ErrorMsg!.message!.Value}', 'Alert');
      } else {
        config.showDialog('Something went wrong try again...', 'Alert');
      }
    });
  }

  double differenceTime() {
    final starDate =
        config.alignDate(checkedINData[0].CntctDate.toString()).split('-');
    final stTime =
        config.convertintToTime(checkedINData[0].CntctTime!).split(':');

    final startTime = DateTime(
      int.parse(starDate[2]),
      int.parse(starDate[1]),
      int.parse(starDate[0]),
      int.parse(stTime[0]),
      int.parse(stTime[1]),
    );
    final currentTime = DateTime.now();
    final diff = currentTime.difference(startTime).inSeconds;

    log('diff: $diff');
    return double.parse(diff.toString());
  }

  double differenceTimenextD() {
    log('checkedINData[0].CntctDate:${checkedINData[0].CntctTime}');
    final starDate =
        config.alignDate(checkedINData[0].CntctDate.toString()).split('-');
    log('splitdate:::${config.convertintToTime(checkedINData[0].CntctTime!).split(":")}');
    final stTime =
        config.convertintToTime(checkedINData[0].CntctTime!).split(':');
    log('message::${stTime[0]}');
    final startTime = DateTime(
      int.parse(starDate[2]),
      int.parse(starDate[1]),
      int.parse(starDate[0]),
      stTime.isNotEmpty && stTime[0].isNotEmpty ? int.parse(stTime[0]) : 0,
      stTime.isNotEmpty && stTime[0].isNotEmpty ? int.parse(stTime[1]) : 0,
    );
    final currentTime = DateTime.parse(
      '${checkedINData[0].CntctDate!.replaceAll(':', '').replaceAll('T', '').replaceAll('00', '')} 23:58:00',
    );
    final diff = currentTime.difference(startTime).inSeconds;

    log('diff: $diff');
    return double.parse(diff.toString());
  }

  String selectedDateApi = '';
  String selectedDate = '';

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
        final date = DateTime.parse(selectedDate);
        selectedDate = '';
        mycontroller[2].text =
            "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().padLeft(2, '0')}";
        selectedDateApi =
            "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      });
    });
  }

// Second Page Functions
  List<File> files = [];

  Future<dynamic> imagetoBinary(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    setState(() {
      files.add(File(image.path));
      final List<int> intdata = files[0].readAsBytesSync();
      filedata.add(
        FilesData(
          fileBytes: base64Encode(intdata),
          fileName: files[0].path.split('/').last,
        ),
      );
    });
    setState(showtoast);
    // List<int> imageBytes = files!.readAsBytesSync();
    // String Data = base64Encode(imageBytes);
    // data1 = Data;
    // notifyListeners();
    // callProfileUpdateApi1();
  }

  void showtoast() {
    Fluttertoast.showToast(
      msg: 'More than Four Document Not Allowed..',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 14,
    );
  }

  FilePickerResult? result;
  List<FilesData> filedata = [];
  //  filesz = [];
  void selectattachment() async {
    result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      filedata.clear();
      final filesz = result!.paths.map((path) => File(path!)).toList();
      print(files);

      for (var i = 0; i < filesz.length; i++) {
        // createAString();

        if (files.length <= 3) {
          setState(() {
            // showtoast();
            files.add(filesz[i]);
            final List<int> intdata = filesz[i].readAsBytesSync();
            filedata.add(
              FilesData(
                fileBytes: base64Encode(intdata),
                fileName: files[i].path.split('/').last,
              ),
            );
          });
          // return null;
        } else {
          setState(showtoast);
        }
      }
    }
  }

  // void showProductDialog(){
  //   Get.defaultDialog<void>(
  //     title: 'Add Product',
  //     content: Container(
  //       child: Column(
  //         children: [
  //            Container(
  //               width: Screens.width(context),
  //               color: Colors.grey[200],
  //               padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
  //               child: TextFormField(
  //                 controller: mycontroller[6],
  //                 decoration: InputDecoration(
  //                     border: InputBorder.none,
  //                     focusedBorder: InputBorder.none,
  //                     enabledBorder: InputBorder.none,
  //                     errorBorder: InputBorder.none,
  //                     disabledBorder: InputBorder.none,
  //                     hintText: "Product",
  //                   ),
  //               )),
  //               SizedBox(height: Screens.heigth(context)*0.02,),
  //               Container(
  //                 width: Screens.width(context),
  //                 child: ElevatedButton(
  //                   onPressed: (){
  //                   //  splitData();
  //                 }, child: Text('Add')),
  //               )
  //         ],
  //       ),
  //     )
  //   ).then((value) {
  //   });
  // }
  List<TextEditingController> controllerTxt = [];
  List<TextEditingController> textContriler(int len) {
    final controllerTxt = List<TextEditingController>.generate(
        len, (i) => TextEditingController());
    return controllerTxt;
  }

  List<ProductData> product = [
    ProductData(code: 0, name: 'Coral'),
    ProductData(code: 0, name: 'Galaxy'),
    ProductData(code: 0, name: 'Plascon'),
    ProductData(code: 0, name: 'Goldstar'),
    ProductData(code: 0, name: 'Kiboko'),
    ProductData(code: 0, name: 'Other'),
  ];
  // void splitData(){
  //   Get.back<void>();
  //   List<String> data =  mycontroller[6].text.toString().trim().split(",");
  //   product = data;
  // controllerTxt =  textContriler(product.length);
  //   setState(() {});
  // }

  String brandContribData() {
    var data = '';
    log('controllerTxt: ${controllerTxt.length}');
    for (var i = 0; i < productText.length; i++) {
      if (i == productText.length - 1) {
        data = '$data${productText[i]}: ${controllerTxt[i].text}';
      } else {
        data = '$data${productText[i]}: ${controllerTxt[i].text},';
      }
    }
    log('brand contribn: $data');
    return data;
  }

// List<S> data4=[];
//   void showSubGrp(){
//     data3.clear();
//   for (int i = 0; i < filtersubValueValue.length; i++) {
//     if(filtersubValueValue[i].selected == 1){
//       setState(() {
//          data3 .add(filtersubValueValue[i].name!);
// log("ANBU::"+data3.length.toString());
//       });

//     }}
//   }

  String choosedSubGrp() {
    showsubValue.clear();
    var data = '';
    for (var i = 0; i < filtersubValueValue.length; i++) {
      if (filtersubValueValue[i].selected == 1) {
        setState(() {
          showsubValue.add(
            SubModalValue(
              code: filtersubValueValue[i].code,
              name: filtersubValueValue[i].name,
              selected: filtersubValueValue[i].selected,
            ),
          );
          log('showsubValue::${showsubValue.length}');
        });
        if (i == filtersubValueValue.length - 1) {
          data = data + filtersubValueValue[i].name!;
        } else {
          data = '$data${filtersubValueValue[i].name!},';
        }
      }
    }
    log('Sub contribn: $data');
    return data;
  }

  String choosedProduct() {
    var data = '';
    for (var i = 0; i < product.length; i++) {
      if (product[i].code == 1) {
        if (i == product.length - 1) {
          data = data + product[i].name;
        } else {
          data = '$data${product[i].name},';
        }
      }
    }
    log('Sub contribn: $data');
    return data;
  }

  bool checkSubSelected() {
    var data = false;
    for (var i = 0; i < filtersubValueValue.length; i++) {
      if (filtersubValueValue[i].selected == 1) {
        data = true;
      }
    }
    return data;
  }

  List<Widget> listProduct(ThemeData theme) {
    return List.generate(
      product.length,
      (index) => InkWell(
        onTap: () {
          setState(() {
            if (product[index].code == 1) {
              product[index].code = 0;
              productText.remove(product[index].name);
              controllerTxt = textContriler(productText.length);
            } else {
              product[index].code = 1;
              productText.add(product[index].name);
              controllerTxt = textContriler(productText.length);
            }
          });
        },
        child: Container(
          padding: EdgeInsets.only(
            top: Screens.heigth(context) * 0.01,
            left: Screens.width(context) * 0.02,
            right: Screens.width(context) * 0.02,
            bottom: Screens.heigth(context) * 0.01,
          ),
          decoration: BoxDecoration(
            color: product[index].code == 0
                ? Colors.grey[300]
                : theme.primaryColor,
            border: Border.all(
              color:
                  product[index].code == 0 ? theme.primaryColor : Colors.white,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                product[index].name,
                maxLines: 8,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: product[index].code == 0
                      ? theme.primaryColor
                      : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//new search for sub value
  AlertDialog filterpage(BuildContext context, ThemeData theme) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: StatefulBuilder(
        builder: (context, st) {
          return SingleChildScrollView(
            child: Container(
              color: Colors.grey[200],
              width: Screens.width(context),
              height: Screens.heigth(context) * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        // color: Colors.grey[200],
                        //  color: Colors.blue,
                        width: Screens.width(context) * 0.6,
                        child: const Text('Sub Group'),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          // color: Colors.red,
                          width: Screens.width(context) * 0.2,
                          child: const Icon(
                            Icons.close,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: Screens.width(context),
                    height: Screens.heigth(context) * 0.48,
                    color: Colors.white,
                    padding: EdgeInsets.only(
                      top: Screens.heigth(context) * 0.01,
                      left: Screens.width(context) * 0.02,
                      right: Screens.width(context) * 0.02,
                      bottom: Screens.heigth(context) * 0.02,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: Screens.heigth(context) * 0.06,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(
                                Screens.width(context) * 0.01,
                              ),
                            ),
                            child: TextField(
                              // textAlign: TextA,

                              // controller:context.read<NewEnqController>().mycontroller[5] ,
                              onTap: () {
                                // Get.toNamed(ConstantRoutes.screenshot);
                              },
                              autocorrect: false,
                              onChanged: (v) {
                                st(() {
                                  filterListAssignData(v);
                                });
                              },
                              decoration: InputDecoration(
                                filled: false,
                                hintText: 'Search',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: theme.primaryColor,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 5,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.01,
                          ),
                          Wrap(
                            spacing: 5, // width
                            runSpacing: 10, // height
                            children: listSubGroup(theme, st),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Screens.width(context),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                        backgroundColor: theme.primaryColor,
                      ),
                      onPressed: () {
                        // setState(() {
                        //   isselected=true;
                        // });

                        log('ANBBBB::::${GetValues.U_CrpUsr}');
                        choosedSubGrp();
                        Navigator.pop(context);
                        //  showSubGrp();
                        // if (formkey[1].currentState!.validate()) {
                        //   log("ANBBBBvalidate::::");
                        //   if (product.isEmpty) {
                        //     log("ANBBBBproduct::::");
                        //     config.showDialog("Produt is required..!!", "Alert");
                        //   } else {
                        //     updatedSite = true;
                        //     onbackpress();
                        //   }
                        // }
                        // };
                      },
                      child: const Text('Ok'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

//filter subvalue
  filterListAssignData(String v) {
    if (v.isNotEmpty) {
      setState(() {
        filtersubValueValue = subValueValue
            .where(
              (e) => e.name!.toLowerCase().contains(v.toLowerCase()),
              // ||
              // e.s!.toLowerCase().contains(v.toLowerCase())
            )
            .toList();
      });
    } else if (v.isEmpty) {
      setState(() {
        filtersubValueValue = subValueValue;
      });
    }
  }

//new seconde sub value
  List<Widget> listSubGroup22(
    ThemeData theme,
  ) {
    return List.generate(
      showsubValue.length,
      (index) => InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.only(
            top: Screens.heigth(context) * 0.01,
            left: Screens.width(context) * 0.02,
            right: Screens.width(context) * 0.02,
            bottom: Screens.heigth(context) * 0.01,
          ),
          decoration: BoxDecoration(
            color:
                // showsubValue[index].selected == 0
                //     ? Colors.grey[300]
                //     :
                theme.primaryColor,
            border: Border.all(
              color:
                  //  filtersubValueValue[index].selected == 0
                  //     ? theme.primaryColor
                  //     :
                  Colors.white,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                showsubValue[index].name!,
                maxLines: 8,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color:
                      // filtersubValueValue[index].selected == 0
                      //     ? theme.primaryColor
                      //     :
                      Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // subValueValue

  List<Widget> listSubGroup(ThemeData theme, Function st) {
    return List.generate(
      filtersubValueValue.length,
      (index) => InkWell(
        onTap: () {
          st(() {
            if (filtersubValueValue[index].selected == 1) {
              filtersubValueValue[index].selected = 0;
              // subValueValue.remove("${product[index].name}");
              // controllerTxt = textContriler(productText.length);
            } else {
              filtersubValueValue[index].selected = 1;
              // subValueValue.add("${product[index].name}");
              // controllerTxt = textContriler(productText.length);
            }
          });
        },
        child: Container(
          padding: EdgeInsets.only(
            top: Screens.heigth(context) * 0.01,
            left: Screens.width(context) * 0.02,
            right: Screens.width(context) * 0.02,
            bottom: Screens.heigth(context) * 0.01,
          ),
          decoration: BoxDecoration(
            color: filtersubValueValue[index].selected == 0
                ? Colors.grey[300]
                : theme.primaryColor,
            border: Border.all(
              color: filtersubValueValue[index].selected == 0
                  ? theme.primaryColor
                  : Colors.white,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                filtersubValueValue[index].name!,
                maxLines: 8,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: filtersubValueValue[index].selected == 0
                      ? theme.primaryColor
                      : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> productText = [];
  List<Widget> listProductTextField(ThemeData theme) {
    return List.generate(
      productText.length,
      (index) => Container(
        width: Screens.width(context),
        color: Colors.grey[200],
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
        child: TextFormField(
          controller: controllerTxt[index],
          validator: (v) {
            if (v!.isEmpty) {
              return 'Required';
            }
            return null;
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: productText[index],
          ),
        ),
      ),
    );
  }

  Future<bool> onbackpress() {
    // DateTime now = DateTime.now();
    log('pageChanged11x::$pageChanged');
    if (pageChanged == 1) {
      log('message11x');
      pageController.jumpToPage(--pageChanged);
    } else if (pageChanged == 2) {
      log('message22y');
      pageController.jumpToPage(--pageChanged);
    } else if (pageChanged == 0) {
      log('message33z');

      return Future.value(true);
    }
    return Future.value(false);
  }
}

class FilesData {
  String fileBytes;
  String fileName;

  FilesData({required this.fileBytes, required this.fileName});

  // Map<String, Object?> toMap() => {
  //       PostFilesModel.fileBytes: fileBytes,
  //       PostFilesModel.fileName: fileName,
  //     };
}

class ProductData {
  String name;
  int code;

  ProductData({required this.code, required this.name});
}

class FilesPostData {
  String filePath;
  int clgcode;

  FilesPostData({required this.filePath, required this.clgcode});

  Map<String, Object?> toMap() => {
        PostFilesModel.filePath: filePath,
        PostFilesModel.clgcode: clgcode,
        //PostFilesModel.fileName: fileName,
      };
}

// class seatchpage extends StatefulWidget {
//   const seatchpage({Key? key}) : super(key: key);

//   @override
//   State<seatchpage> createState() => _seatchpageState();
// }

// class _seatchpageState extends State<seatchpage> {
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       insetPadding: EdgeInsets.all(10),
//       contentPadding: EdgeInsets.all(5),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       content: filterpage(context),
//     );
//   }

// }
