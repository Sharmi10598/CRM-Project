// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, require_trailing_commas, prefer_single_quotes, prefer_const_constructors, file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

AppBar appBar(
    BuildContext context, GlobalKey<ScaffoldState> key, String title) {
  key:
  key;
  final width = MediaQuery.of(context).size.width;
  var isTSH = false;
  final theme = Theme.of(context);

  return AppBar(
      leading: GestureDetector(
          onTap: () {
            key.currentState!.openDrawer();
          },
          child: Icon(
            Icons.menu,
            color: Colors.white,
          )),
      backgroundColor: theme.primaryColor,
      title: StatefulBuilder(
        builder: (context, setState) => SizedBox(
          // color: Colors.amber,
          width: Screens.width(context) * 1,
          // padding: EdgeInsets.only(left: 20),
          // alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    title, //AppLocalizations.of(context)!.dashboard,
                    style: TextStyle(
                        fontSize:
                            //Screens.width(context) * 0.04,
                            title.length > 10
                                ? Screens.width(context) * 0.04
                                : Screens.width(context) * 0.045,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              // ),
              // ),

              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.usd,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        textStyle:
                            TextStyle(fontSize: Screens.width(context) * 0.04)),
                  ),
                  Switch(
                    value: isTSH,
                    onChanged: (value) {
                      setState(() {
                        isTSH = value;
                        log("isTSH D:::$isTSH");
                      });
                    },
                    // activeColor: theme.primaryColor,
                    // activeTrackColor: Colors.white,
                    inactiveTrackColor: theme.primaryColor,
                  ),
                  Text(
                    GetValues.currency == 'TZS'
                        ? AppLocalizations.of(context)!.tzs
                        : AppLocalizations.of(context)!.zmw,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        textStyle: TextStyle(
                            fontSize: Screens.width(context) * 0.030)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
}
