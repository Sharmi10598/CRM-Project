// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, require_trailing_commas, prefer_single_quotes, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';

class SwitchBtn {
  static bool siwtchTrue = false;
}

AppBar orderAppBar(
    BuildContext context, GlobalKey<ScaffoldState> key, String title) {
  key;
  final width = MediaQuery.of(context).size.width;
  const isTSH = false;
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
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                child: Column(
                  children: [
                    Text(
                      title, //AppLocalizations.of(context)!.dashboard,
                      style: TextStyle(
                          fontSize: title.length > 10
                              ? Screens.width(context) * 0.04
                              : Screens.width(context) * 0.045,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: Container(
        height: 46,
        width: Screens.width(context),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Const.space5),
            border: Border.all(color: theme.colorScheme.surface),
            color: theme.colorScheme.surface),
        child: TabBar(
          labelStyle: TextStyles.bodytextBlack2(context),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(Const.space5),
            border: Border.all(color: theme.primaryColor),
            color: theme.primaryColor,
          ),
          labelColor: theme.colorScheme.surface,
          unselectedLabelColor: theme.primaryColor,
          tabs: [
            Tab(text: 'All'),
            // Tab(text:'Closed'),
            Tab(text: 'Approved'),
            Tab(text: 'Draft'),
          ],
        ),
      ),
    ),
  );
}
