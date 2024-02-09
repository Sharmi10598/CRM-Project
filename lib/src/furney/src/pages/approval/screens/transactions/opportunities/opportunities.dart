// ignore_for_file: prefer_single_quotes, sort_child_properties_last


import 'package:flutter/material.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/transactions/opportunities/opportunities_listView.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class Opportunities extends StatefulWidget {
  const Opportunities({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  OpportunitiesState createState() => OpportunitiesState();
}

class OpportunitiesState extends State<Opportunities> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: _scaffoldKey,
      appBar: appBar(context, _scaffoldKey, widget.title),
      drawer: drawer(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
             left: Screens.width(context) * 0.02,
             right: Screens.width(context) * 0.02,
              top: Screens.heigth(context) * 0.01,
              bottom: Screens.width(context) * 0.01,),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Icon(Icons.search,
                      color: theme.primaryColor,
                      size: Screens.width(context)*0.1,),
                    ),
                    SizedBox(width:  Screens.width(context)*0.03,),
                       Container(
                      child: Icon(Icons.alt_route_sharp,
                      color: theme.primaryColor,
                      size: Screens.width(context)*0.1,),
                    ),
                     SizedBox(width:  Screens.width(context)*0.03,),
                    Container(
                      child: Icon(Icons.add,
                      color: theme.primaryColor,
                      size: Screens.width(context)*0.1,),
                    ),
                  ],
                ),
              ),
              const ListOfOpportunities()
            ],
          ),
        ),
      ),
    );
  }
}
