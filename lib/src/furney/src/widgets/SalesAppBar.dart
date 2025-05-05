// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, require_trailing_commas, prefer_single_quotes, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';

AppBar salesappBar(
    BuildContext context, GlobalKey<ScaffoldState> key, String title) {
  key;
  final width = MediaQuery.of(context).size.width;
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
        builder: (context, setState) => Container(
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
            ],
          ),
        ),
      ));
}
