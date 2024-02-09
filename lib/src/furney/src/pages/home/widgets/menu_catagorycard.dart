// ignore_for_file: unused_element

import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/models/home_Menu.dart';


class CategoryCard2 extends StatelessWidget {
  final CategoryModel2 category;

  const CategoryCard2({required this.category, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: category.onTap,
      borderRadius: BorderRadius.circular(Const.radius),
      child: Container(
        decoration: BoxDecoration(
          //color: theme.cardColor,
          borderRadius: BorderRadius.circular(Const.radius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: Const.space8),
            // SvgPicture.asset(
            //   category.icon!,
            //   width: 20,
            //   height: 20,
            // ),
             FaIcon(category.icon,
             color:theme.primaryColor,
             size: 25,
             ),
            const SizedBox(height: Const.space15),
            Expanded(
              child: Text(
                category.name!,
                textAlign: TextAlign.center,
                style: TextStyles.bodytextBlack2(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
