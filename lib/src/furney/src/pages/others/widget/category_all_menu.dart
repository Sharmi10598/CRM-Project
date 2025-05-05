// ignore_for_file: unused_element

import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/models/allmenudata.dart';

class CategoryAllMenu extends StatelessWidget {
  final AllMenuData category;

  const CategoryAllMenu({required this.category, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: category.onTap,
      borderRadius: BorderRadius.circular(Const.radius),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(Const.radius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: Const.space15),
            FaIcon(
              category.icon,
              color: theme.primaryColor,
              size: Screens.width(context) * 0.08, //30,
            ),
            const SizedBox(height: Const.space15),
            Expanded(
              child: category.name != null
                  ? Text(
                      category.name!,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleSmall!.copyWith(
                        height: 1.2,
                        fontSize: 10,
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
