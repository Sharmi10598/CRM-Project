// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/models/home_Menu.dart';
// ignore: always_use_package_imports
import 'menu_catagorycard.dart';

class BuildCategory2 extends StatelessWidget {
  final List<CategoryModel2> itemCount;

  const BuildCategory2({required this.itemCount, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount.length,
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: Const.margin),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        // childAspectRatio: 9 / 11.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final category = itemCount[index];
        return CategoryCard2(category: category);
      },
    );
  }
}
