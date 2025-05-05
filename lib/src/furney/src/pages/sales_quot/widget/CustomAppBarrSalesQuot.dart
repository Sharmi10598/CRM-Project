// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, require_trailing_commas, prefer_single_quotes, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';


AppBar appBarTabbar(
    BuildContext context, GlobalKey<ScaffoldState> key, String title) {
  key:
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
            // SizedBox(
            //   width: width *0.02,
            // ),
            // Row(
            //   children: [
            //     Text(
            //       AppLocalizations.of(context)!.usd,
            //       style: GoogleFonts.poppins(
            //           color: Colors.white,
            //           textStyle:
            //               TextStyle(fontSize: Screens.width(context) * 0.042)),
            //     ),
            //     Switch(
            //       onChanged: (value) {
            //         print(value);
            //         setState(() {
            //           isTSH = value;
            //         });
            //       },
            //       activeColor: Colors.white,
            //       activeTrackColor: Colors.white,
            //       value: isTSH,
            //     ),
            //     Text(
            //       GetValues.currency == "TZS"
            //           ? AppLocalizations.of(context)!.tzs
            //           : AppLocalizations.of(context)!.zmw,
            //       style: GoogleFonts.poppins(
            //           color: Colors.white,
            //           textStyle:
            //               TextStyle(fontSize: Screens.width(context) * 0.042)),
            //     ),
            //   ],
            // ),
         
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
          labelStyle:
              theme.textTheme.titleSmall?.copyWith(color: theme.primaryColor),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(Const.space5),
            border: Border.all(color: theme.primaryColor),
            color: theme.primaryColor,
          ),
          labelColor: theme.colorScheme.surface,
          unselectedLabelColor: theme.primaryColor,
          tabs: [
            Tab(text: AppLocalizations.of(context)!.upcoming),
            Tab(text: AppLocalizations.of(context)!.completed),
            Tab(text: AppLocalizations.of(context)!.cancelled),
          ],
        ),
      ),
    ),
  );
}
