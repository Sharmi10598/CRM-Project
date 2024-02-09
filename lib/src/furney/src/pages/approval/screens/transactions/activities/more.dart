// ignore_for_file: prefer_single_quotes, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class More extends StatefulWidget {
  const More({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  MoreState createState() => MoreState();
}

class MoreState extends State<More> {
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
          child: Center(
            child: Text("No Data",
            style: GoogleFonts.poppins(
                fontSize: Screens.width(context) * 0.07,
                color: Colors.black,),),
          ),
        ),
      ),
    );
  }
}
