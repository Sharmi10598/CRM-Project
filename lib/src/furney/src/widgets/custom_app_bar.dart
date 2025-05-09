import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: non_constant_identifier_names
AppBar CustomAppBar(
  BuildContext context, {
  String? title,
  bool centerTitle = true,
  bool enableLeading = true,
  List<Widget>? actions,
  void Function()? leadingOntap,
  PreferredSizeWidget? bottom,
  Color? backgroundColor,
}
) {
  final theme = Theme.of(context);
  return AppBar(
    backgroundColor:
        (backgroundColor == null) ? theme.colorScheme.surface : backgroundColor,
    centerTitle: centerTitle,
    leading: enableLeading
        ? IconButton(
            icon:const Icon(Icons.arrow_back),
            onPressed: (leadingOntap == null) ? buildBackOnTap : leadingOntap,
            color: theme.primaryColor,
          )
        : const SizedBox(),
    title: Text(title ?? '', style: theme.textTheme.displaySmall),
    actions: actions,
    bottom: bottom,
  );
}

void buildBackOnTap() {
  Get.back<dynamic>();
}
