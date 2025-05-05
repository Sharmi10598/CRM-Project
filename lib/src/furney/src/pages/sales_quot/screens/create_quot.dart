// ignore_for_file: require_trailing_commas, prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_parenthesis

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/widget/logistic_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/delivery/widgets/delivery_appbar.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/creation/content_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/creation/header_creation.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class CreateDetails extends StatefulWidget {
  const CreateDetails({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  CreateDetailsState createState() => CreateDetailsState();
}

class CreateDetailsState extends State<CreateDetails> {
  static bool contentAddItems = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void currentDate() {
    final now = DateTime.now();
    setState(() {
      HeaderCreationState.currentDateTime =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
      print('date: ${HeaderCreationState.currentDateTime}');
    });
  }

  @override
  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    final now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print('are you sure');
      //  Get.offAllNamed<dynamic>(FurneyRoutes.salesQuotes);
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Are you want to exit press again!!..',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Future.value(false);
    }
    Navigator.pop(context);
    Get.toNamed<dynamic>(FurneyRoutes.newSalesQuot);
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return Future.value(true);
  }

  @override
  void initState() {
    super.initState();
    currentDate();
  }

  static TabController? tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      // child:
      // WillPopScope(
      //   onWillPop: onbackpress,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
          backgroundColor: Colors.grey[200],
          appBar: deliveryAppBar(context, _scaffoldKey, widget.title),
          drawer:
              // GetValues.userRoll == '3' ? drawer2(context) :
              drawer(context),
          body: Padding(
            padding: EdgeInsets.only(
              top: Screens.heigth(context) * 0.01,
            ), //left: Screens.width(context)*0.02,right: Screens.width(context)*0.02,bottom: Screens.heigth(context)*0.01
            child: TabBarView(
                //controller: tabController,
                // physics: const NeverScrollableScrollPhysics(),
                children: [
                  const HeaderCreation(),
                  const ContentCreation(),
                  const LogisticPage(),
                ]),
          )),
      // ),
    );
  }
  // static void changepage(BuildContext context){
  //   DefaultTabController.of(context)!.animateTo(1);
  // }
}
