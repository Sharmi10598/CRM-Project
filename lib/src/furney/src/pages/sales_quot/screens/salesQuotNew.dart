// ignore_for_file: require_trailing_commas, prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_parenthesis, file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/screens/quotations.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/creation/header_creation.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class SalesQuotationNew extends StatefulWidget {
  const SalesQuotationNew({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  SalesQuotationNewState createState() => SalesQuotationNewState();
}

class SalesQuotationNewState extends State<SalesQuotationNew> {
  static bool contentAddItems = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void currentDate() {
    final now = DateTime.now();
    setState(() {
      HeaderCreationState.currentDateTime =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    });
  }

  @override
  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    // final now = DateTime.now();
    // if (currentBackPressTime == null ||
    //   now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
    // currentBackPressTime = now;
    // print('are you sure');
    // //  Get.offAllNamed<dynamic>(FurneyRoutes.salesQuotes);
    // const snackBar = SnackBar(
    //   duration: Duration(seconds: 5),
    //   backgroundColor: Colors.red,
    //   content: Text(
    //     'Are you want to exit press again!!..',
    //     style: TextStyle(color: Colors.white),
    //   ),
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // return Future.value(false);
    // }
    Get.offAllNamed<dynamic>(FurneyRoutes.home);
    // ScaffoldMessenger.of(context).removeCurrentSnackBar();
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
    // final theme = Theme.of(context);
    return
        //  DefaultTabController(
        //   length: 2,
        //   child:
        PopScope(
            canPop: false,
            onPopInvoked: (bool didpop) {
              if (didpop) return;
              log('bbbbbbbb');
              onbackpress();
            },
            child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.grey[200],
              appBar: appBar(context, _scaffoldKey, widget.title),
              drawer:
                  // GetValues.userRoll == '3'
                  //     ? drawer2(context)
                  //     :
                  drawer(context),
              body: Padding(
                padding: EdgeInsets.only(
                  top: Screens.heigth(context) * 0.01,
                ), //left: Screens.width(context)*0.02,right: Screens.width(context)*0.02,bottom: Screens.heigth(context)*0.01
                child:

                    /// Ciolumn
                    //TabBarView(
                    //controller: tabController,
                    // physics: const NeverScrollableScrollPhysics(),
                    // children: [
                    const SalesQuot(),
                // const ClosedQuot(),
                // const ApprovalsQuotDetails(),
                // ]
              ),
            ));
    //  );
  }
  // static void changepage(BuildContext context){
  //   DefaultTabController.of(context)!.animateTo(1);
  // }
}
