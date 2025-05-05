import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/route_manager.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/SalesQutApiNew/GetAllSalesQutApi.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/approvals_modal/approvals_details.modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesOrderEdit/Screens/ContentEdit.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesOrderEdit/Screens/HederEdit.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesOrderEdit/Screens/LogisticOrderEdit.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/ordersTabBarAppbar.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class EditORderDetails extends StatefulWidget {
  const EditORderDetails({
    required this.title,
    required this.docEntry,
    required this.isAproved,
    Key? key,
  }) : super(key: key);
  final String title;
  final int docEntry;
  final bool isAproved;
  @override
  EditORderDetailsState createState() => EditORderDetailsState();
}

class EditORderDetailsState extends State<EditORderDetails> {
  static bool isCameFromqutation = false;

  static bool isCameforapprovalsales = false;
  static bool contentAddItems = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ApprovalDetailsValue? approvaldetailsvalue;
  List<DocumentApprovalValue> documentApprovalValue = [];

  void currentDate() {
    final DateTime now = DateTime.now();
    setState(() {
      HeaderEditOrderPageState.currentDateTime =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    });
  }

  clearData() {
    HeaderEditOrderPageState.mycontroller[0].clear();
    LogisticEditORderState.valueSelectedGPApproval = null;
    LogisticEditORderState.valueSelectedOrder = null;
    LogisticEditORderState.mycontroller[1].clear();
    LogisticEditORderState.mycontroller[0].clear();
    setState(() {});
  }

  @override
  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    final DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      //  Get.offAllNamed<dynamic>(FurneyRoutes.salesQuotes);
      const snackBar = SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        content: Text(
          'Are you want to exit press again!!..',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Future.value(false);
    }
    isCameFromqutation = false;
    isCameforapprovalsales = false;
    ContentOrderEditState.isCalculated = false;
    //  final List<AddItem> itemsDetails2 = [];
    Get.offAllNamed<dynamic>(FurneyRoutes.newSalesOrders);
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return Future.value(true);
  }

  LocationPermission? permission;
  static String? latitude;
  static String? longitude;

  @override
  void initState() {
    super.initState();
    //   if(isCameFromqutation==true){
    //  sotruethen();
    //   }
    // sotruethen();
    currentDate();
    getLocation();
    clearData();
    //checkPermision();
  }

  List<ValueData> filtervalues = [];

  void getLocation() async {
    final bool checkper = await checkPermision();
    //  print("checkper $checkper");

    if (checkper == false) {
      showsnb();
    } else if (checkper == true) {
      final bool isa = await isLocationAvailable();
      if (isa == false) {
        showsnb();
      } else if (isa == true) {
        final Position pos = await Geolocator.getCurrentPosition();
        latitude = pos.latitude.toString();
        longitude = pos.longitude.toString();
        setState(() {
          isloading = false;
        });
      }
    }
  }

  Future<bool> checkPermision() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      // showsnb();
      return Future.value(false);
    } else if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      //showsnb();
      // permission = await Geolocator.checkPermission();
      return Future.value(false);
    } else if (permission == LocationPermission.unableToDetermine) {
      permission = await Geolocator.requestPermission();
      return Future.value(false);
    } else if (permission == LocationPermission.always) {
      permission = await Geolocator.requestPermission();
      return Future.value(true);
    }
    return Future.value(false);
  }

  void showsnb() {
    const snackBar = SnackBar(
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
      content: Text(
        "Please give location permission to crm app & turn on the Location!!..",
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Future.delayed(
      const Duration(seconds: 3),
      () => Get.back<dynamic>(),
    );
  }

  Future<bool> isLocationAvailable() async {
    bool? serviceEnabled;
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (serviceEnabled == true) {
        //  print("serviceEnabled1111 $serviceEnabled");
        return Future.value(true);
      } else if (serviceEnabled == false) {
        //  print("serviceEnabled2222 $serviceEnabled");

        return Future.value(false);
      }
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
    return Future.value(false);
  }

  bool isloading = true;
  Widget lodingWid() {
    return Center(
      child: SpinKitThreeBounce(
        color: Theme.of(context).primaryColor,
      ),
      // CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return DefaultTabController(
      length: 3,
      child:
          // WillPopScope(
          //   onWillPop: onbackpress,
          //  child:
          Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        backgroundColor: Colors.grey[200],
        appBar: saleOrderAppBar(context, _scaffoldKey, widget.title),
        drawer:
            //  GetValues.userRoll == '3'
            //     ? drawer2(context)
            //     :
            drawer(context),
        body: Padding(
          padding: EdgeInsets.only(
            top: Screens.heigth(context) * 0.01,
          ), //left: Screens.width(context)*0.02,right: Screens.width(context)*0.02,bottom: Screens.heigth(context)*0.01
          child: TabBarView(
            //  physics: const ScrollPhysics(parent: ),
            children: [
              isloading == true ? lodingWid() : const HeaderEditOrderPage(),
              isloading == true ? lodingWid() : const ContentOrderEdit(),
              isloading == true
                  ? lodingWid()
                  : LogisticEditORder(
                      docEntry: widget.docEntry,
                      isAproved: widget.isAproved,
                    ),
              // const OthersOrder()
            ],
          ),
        ),
      ),
      //  ),
    );
  }
}
