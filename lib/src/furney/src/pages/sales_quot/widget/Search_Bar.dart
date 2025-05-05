// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';

class SearchBar extends StatelessWidget {
  final String searchHint;
  final TextEditingController? searchController;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSearchTap;
  const SearchBar(
      {required this.searchHint,
      Key? key,
      this.searchController,
      this.onChanged,
      this.onSearchTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: Screens.heigth(context) * 0.06,
      decoration: BoxDecoration(
        color: theme.hintColor.withOpacity(.05),
        borderRadius: BorderRadius.circular(Const.radius),
      ),
      child: TextField(
        controller: searchController,
        autocorrect: false,
        style: theme.textTheme.bodyMedium,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: searchHint,
          // AppLocalizations.of(context)!
          //     .search_sales_quot,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          prefixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: onSearchTap, //
            color: theme.primaryColorLight,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 5,
          ),
        ),
      ),
    );
  }
}
