// ignore_for_file: file_names, require_trailing_commas, prefer_single_quotes, prefer_if_elements_to_conditional_expressions

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

import 'package:ultimate_bundle/src/furney/main.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sign_in/sign_in_page.dart';

class CategoryModel2 {
  int? id;
  String? name;
  String? image;
  IconData? icon;
  VoidCallback? onTap;

  CategoryModel2({
    this.id,
    this.name,
    this.image,
    this.icon,
    this.onTap,
  });
}

List<CategoryModel2> topCategoryList2(BuildContext context) => [
      if (FurneySignInScreenState.menuListItem.contains('1') == true)
        CategoryModel2(
          name: AppLocalizations.of(context)!.salesQuote,
          icon: Icons.auto_awesome_motion,
          image: '',
          onTap: () => Get.toNamed<dynamic>(FurneyRoutes.newSalesQuot),
        ),
      if (FurneySignInScreenState.menuListItem.contains('1') == true)
        CategoryModel2(
          name: AppLocalizations.of(context)!.salesorder,
          icon: Icons.request_quote, //FaIcon(FontAwesomeIcons.gamepad),
          image: '',
          onTap: () => Get.toNamed<dynamic>(FurneyRoutes.newSalesOrders),
        ),
      CategoryModel2(
          name: AppLocalizations.of(context)!.other,
          icon: Icons.apps, //FaIcon(FontAwesomeIcons.gamepad),
          image: '',
          onTap: () => Get.toNamed<dynamic>(FurneyRoutes.others)),
    ];
// {"DocEntry":1,"MenuName":"DASHBOARD","IsPortal":null},
// {"DocEntry":2,"MenuName":"DEPOT_PERFORMANCE","IsPortal":null},
// {"DocEntry":3,"MenuName":"SALES_REP","IsPortal":null},
// {"DocEntry":4,"MenuName":"ATTENDANCE","IsPortal":null},
// {"DocEntry":5,"MenuName":"APPROVALS","IsPortal":null},
// {"DocEntry":6,"MenuName":"CUSTOMERS","IsPortal":null},
// {"DocEntry":7,"MenuName":"STOCK_AT_WAREHOUSE","IsPortal":null},
// {"DocEntry":8,"MenuName":"SALES_QUOTE","IsPortal":null},
// {"DocEntry":9,"MenuName":"SALES_ORDER","IsPortal":null},
// {"DocEntry":10,"MenuName":"DELIVERY","IsPortal":null},
// {"DocEntry":11,"MenuName":"PAYMENT_FROM_CUSTOMERS","IsPortal":null},
// {"DocEntry":12,"MenuName":"NOTES","IsPortal":null},
// {"DocEntry":13,"MenuName":"COMPLAINTS","IsPortal":null},
// {"DocEntry":14,"MenuName":"REPORTS","IsPortal":null},
// {"DocEntry":15,"MenuName":"PLANNING","IsPortal":null},
// {"DocEntry":16,"MenuName":"CHECKIN","IsPortal":null},
// {"DocEntry":17,"MenuName":"CHECKOUT","IsPortal":null}
// ,{"DocEntry":18,"MenuName":"VISIT APPROVALS","IsPortal":null},
// {"DocEntry":19,"MenuName":"LOCATION APPROVALS","IsPortal":null},
// {"DocEntry":20,"MenuName":"STOCK","IsPortal":null}
List<CategoryModel2> topCategoryList(BuildContext context) => [
      if (FurneySignInScreenState.menuListItem.contains('20') == true)
        CategoryModel2(
            name: AppLocalizations.of(context)!.stock,
            icon: Icons.list_alt,
            image:
                'https://images.unsplash.com/photo-1476718406336-bb5a9690ee2a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8Zm9vZHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
            onTap: () {
              Get.toNamed<dynamic>(FurneyRoutes.stockItem);
            }),
      if (FurneySignInScreenState.menuListItem.contains('6') == true)
        CategoryModel2(
          name: AppLocalizations.of(context)!.customers,
          icon: Icons.people_alt,
          image:
              'https://images.unsplash.com/photo-1566174053879-31528523f8ae?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8ZHJlc3N8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          onTap: () => Get.toNamed<dynamic>(FurneyRoutes.customerpage),
        ),
      if (FurneySignInScreenState.menuListItem.contains('13') == true)
        CategoryModel2(
          name: AppLocalizations.of(context)!.complaints,
          icon: Icons.question_answer, //FaIcon(FontAwesomeIcons.gamepad),

          image:
              'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bWFrZSUyMHVwfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          onTap: () => Get.toNamed<dynamic>(FurneyRoutes.complaintsPage),
        ),
      if (FurneySignInScreenState.menuListItem.contains('4') == true)
        CategoryModel2(
          name: AppLocalizations.of(context)!.attendance,
          icon: Icons.calendar_today, //aIcon(FontAwesomeIcons.gamepad),
          image:
              'https://images.unsplash.com/photo-1527719327859-c6ce80353573?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dHNoaXJ0fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          onTap: () => Get.toNamed<dynamic>(FurneyRoutes.attendance),
        ),
      if (FurneySignInScreenState.menuListItem.contains('8') == true)
        CategoryModel2(
          name: AppLocalizations.of(context)!.salesQuote,
          icon: Icons.auto_awesome_motion,
          image: '',
          onTap: () => Get.toNamed<dynamic>(FurneyRoutes.newSalesQuot),
        ),
      if (FurneySignInScreenState.menuListItem.contains('9') == true)
        CategoryModel2(
          name: AppLocalizations.of(context)!.salesorder,
          icon: Icons.request_quote, //FaIcon(FontAwesomeIcons.gamepad),
          image: '',
          onTap: () => Get.toNamed<dynamic>(FurneyRoutes.newSalesOrders),
        ),
      if (FurneySignInScreenState.menuListItem.contains('10') == true)
        CategoryModel2(
          name: AppLocalizations.of(context)!.deliveries,
          icon: Icons.local_shipping, //FaIcon(FontAwesomeIcons.gamepad),
          image: '',
          onTap: () => Get.toNamed<dynamic>(FurneyRoutes.deliveyPage),
        ),
      if (FurneySignInScreenState.menuListItem.contains('18') == true)
        CategoryModel2(
          name: "Visit Approvals",
          icon: Icons.airline_stops_sharp, //FaIcon(FontAwesomeIcons.gamepad),
          image: '',
          onTap: () =>
              // GetValues.userRoll == "0"
              //     ? () =>
              Get.toNamed<dynamic>(FurneyRoutes.approvalTask),
          // : null
        ),
      //  :CategoryModel2( )

      if (FurneySignInScreenState.menuListItem.contains('15') == true)
        CategoryModel2(
            name: "Planning",
            icon: Icons.play_lesson, //FaIcon(FontAwesomeIcons.gamepad),
            image: '',
            onTap: () => Get.toNamed<dynamic>(FurneyRoutes.planningPage)),
      if (FurneySignInScreenState.menuListItem.contains('16') == true)
        CategoryModel2(
            name: "Check in",
            icon: Icons.check, //FaIcon(FontAwesomeIcons.gamepad),
            image: '',
            onTap: () => Get.toNamed<dynamic>(FurneyRoutes.checkin)),
      if (FurneySignInScreenState.menuListItem.contains('17') == true)
        CategoryModel2(
            name: "Check out",
            icon: Icons.fact_check_sharp, //FaIcon(FontAwesomeIcons.gamepad),
            image: '',
            onTap: () => Get.toNamed<dynamic>(FurneyRoutes.checkoutPage)),
      CategoryModel2(
          name: AppLocalizations.of(context)!.other,
          icon: Icons.apps, //FaIcon(FontAwesomeIcons.gamepad),
          image: '',
          onTap: () => Get.toNamed<dynamic>(FurneyRoutes.others)),
    ];
