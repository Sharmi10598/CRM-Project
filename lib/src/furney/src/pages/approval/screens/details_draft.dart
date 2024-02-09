// ignore_for_file: require_trailing_commas, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/widget/Contents_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/widget/accounting_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/widget/approval_app_bar.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/widget/header_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/widget/logistic_page.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class DraftDetails extends StatefulWidget {
  const DraftDetails({ required this.title, Key? key }) : super(key: key);
   final String title;
  @override
  _DraftDetailsState createState() => _DraftDetailsState();
}

class _DraftDetailsState extends State<DraftDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key:_scaffoldKey ,
        backgroundColor: Colors.grey[200],
        appBar: approvalAppBar(context,_scaffoldKey,widget.title),
        drawer: drawer(context),
        body:Padding(
          padding: EdgeInsets.only(top:Screens.heigth(context)*0.01,),//left: Screens.width(context)*0.02,right: Screens.width(context)*0.02,bottom: Screens.heigth(context)*0.01
          child: TabBarView(
          //  physics: const ScrollPhysics(parent: ),
            children: [
           const HeaderPage(),
            const ContentPage(),
           const LogisticPage(),
          const  AccountingPage()
          ]),
        )
      ),
    );
  }
}