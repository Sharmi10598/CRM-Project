// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/models/allmenudata.dart';

import 'package:ultimate_bundle/src/furney/src/pages/others/widget/category_all_menu.dart';
// ignore: always_use_package_imports





class Allmenu extends StatelessWidget {
  final List<AllMenuData> itemCount;

  const Allmenu({required this.itemCount, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount.length,
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: Const.margin),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        // childAspectRatio: 9 / 11.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final category = itemCount[index];
        return CategoryAllMenu(category: category);
      },
    );
  }
}
