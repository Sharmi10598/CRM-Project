// ignore_for_file: avoid_redundant_argument_values, prefer_single_quotes

import 'package:flutter/material.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';

class HeaderImage extends StatelessWidget {
  const HeaderImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Screens.width(context) * 0.45,
          height: Screens.heigth(context) * 0.1,
          decoration: const BoxDecoration(
              //  color: Colors.green,
              image: DecorationImage(
            image: AssetImage("assets/CRM/logologin.png"),
          ),),
        ),
      ],
    );
  }
}
