import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
// import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

// import 'package:ultimate_bundle/src/furney/main.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sign_in/sign_in_page.dart';

class AllMenuData {
  IconData? icon;
  VoidCallback? onTap;
  String? name;

  AllMenuData({
    this.icon,
    this.name,
    this.onTap,
  });
}

List<AllMenuData> dataList2(BuildContext context) => [
      AllMenuData(
        icon: Icons.home,
        name: AppLocalizations.of(context)!.dashboard,
        onTap: () => Get.back<dynamic>(),
      ),
      AllMenuData(
        icon: Icons.auto_awesome_motion,
        name: AppLocalizations.of(context)!.sales_quote,
        onTap: () {
          Navigator.pop(context);
          Get.offAllNamed<dynamic>(FurneyRoutes.newSalesQuot);
        },
      ),
      AllMenuData(
        icon: Icons.request_quote,
        name: AppLocalizations.of(context)!.sales_orders,
        onTap: () {
          Navigator.pop(context);
          Get.offAllNamed<dynamic>(FurneyRoutes.newSalesOrders);
        },
      ),
    ];

List<AllMenuData> dataList(BuildContext context) => [
      AllMenuData(
        icon: Icons.home,
        name: AppLocalizations.of(context)!.dashboard,
        onTap: () => Get.offAllNamed<dynamic>(FurneyRoutes.dashBoard),
      ),
      if (FurneySignInScreenState.menuListItem.contains('2') == true)
        AllMenuData(
          icon: Icons.list_alt,
          name: AppLocalizations.of(context)!.depot_performance, //
          onTap: () => Get.toNamed<dynamic>(FurneyRoutes.depotperformance),
        ),
      if (FurneySignInScreenState.menuListItem.contains('3') == true)
        AllMenuData(
          icon: Icons.list_alt,
          name: AppLocalizations.of(context)!.sales_rep, //
          onTap: () => Get.toNamed<dynamic>(FurneyRoutes.salesRep),
        ),
      if (FurneySignInScreenState.menuListItem.contains('4') == true)
        AllMenuData(
          icon: Icons.calendar_today,
          name: AppLocalizations.of(context)!.attendance,
          onTap: () => Get.toNamed<dynamic>(FurneyRoutes.attendance),
        ),
      if (FurneySignInScreenState.menuListItem.contains('5') == true)
        AllMenuData(
          icon: Icons.list_alt,
          name: AppLocalizations.of(context)!.approvals, //
          onTap: () => Get.toNamed<dynamic>(FurneyRoutes.approvalsNew),
        ),
      if (FurneySignInScreenState.menuListItem.contains('6') == true)
        AllMenuData(
          icon: Icons.people_alt,
          name: AppLocalizations.of(context)!.customer,
          onTap: () => Get.toNamed<dynamic>(
            FurneyRoutes.customerpage,
          ),
        ),
      if (FurneySignInScreenState.menuListItem.contains('7') == true)
        AllMenuData(
          icon: Icons.list_alt,
          name: AppLocalizations.of(context)!.stock_at_warehouse, //
          onTap: () => Get.toNamed<dynamic>(
            FurneyRoutes.stockItem,
          ),
        ),
      if (FurneySignInScreenState.menuListItem.contains('8') == true)
        AllMenuData(
          icon: Icons.auto_awesome_motion,
          name: AppLocalizations.of(context)!.sales_quote,
          onTap: () {
            Navigator.pop(context);
            Get.offAllNamed<dynamic>(
              FurneyRoutes.newSalesQuot,
            );
          },
        ),
      if (FurneySignInScreenState.menuListItem.contains('9') == true)
        AllMenuData(
          icon: Icons.request_quote,
          name: AppLocalizations.of(context)!.sales_orders,
          onTap: () {
            Navigator.pop(context);
            Get.offAllNamed<dynamic>(
              FurneyRoutes.newSalesOrders,
            );
          },
        ),
      if (FurneySignInScreenState.menuListItem.contains('10') == true)
        AllMenuData(
          icon: Icons.local_shipping,
          name: AppLocalizations.of(
            context,
          )!
              .deliveries,
          onTap: () => Get.toNamed<dynamic>(
            FurneyRoutes.deliveyPage,
          ),
        ),
      if (FurneySignInScreenState.menuListItem.contains('11') == true)
        AllMenuData(
          icon: Icons.list_alt,
          name: AppLocalizations.of(
            context,
          )!
              .payment_from_customers, //
          //()=> Get.toNamed<dynamic>(FurneyRoutes.paymentCustomers),
        ),
      if (FurneySignInScreenState.menuListItem.contains('12') == true)
        AllMenuData(
          icon: Icons.list_alt,
          name: AppLocalizations.of(context)!.notes, //
          onTap: () => Get.toNamed<dynamic>(
            FurneyRoutes.notesPage,
          ),
        ),
      if (FurneySignInScreenState.menuListItem.contains('13') == true)
        AllMenuData(
          icon: Icons.question_answer,
          name: AppLocalizations.of(context)!.complaints,
          onTap: () => Get.toNamed<dynamic>(
            FurneyRoutes.complaintsPage,
          ),
        ),
      if (FurneySignInScreenState.menuListItem.contains('14') == true)
        AllMenuData(
          icon: Icons.list_alt,
          name: AppLocalizations.of(
            context,
          )!
              .reports, //
          onTap: () => Get.toNamed<dynamic>(
            FurneyRoutes.reports,
          ),
        ),
      if (FurneySignInScreenState.menuListItem.contains('15') == true)

        // sales app

        AllMenuData(
          icon: Icons.play_lesson,
          name: 'Planing',
          onTap: () => Get.toNamed<dynamic>(
            FurneyRoutes.planningPage,
          ),
        ),
      if (FurneySignInScreenState.menuListItem.contains('16') == true)
        AllMenuData(
          icon: Icons.check,
          name: 'Checkin',
          onTap: () => Get.toNamed<dynamic>(FurneyRoutes.checkedin),
        ),
      if (FurneySignInScreenState.menuListItem.contains('17') == true)
        AllMenuData(
          icon: Icons.fact_check_sharp,
          name: 'Checkout',
          onTap: () => Get.toNamed<dynamic>(FurneyRoutes.checkoutPage),
        ),
      if (FurneySignInScreenState.menuListItem.contains('18') == true)
        AllMenuData(
          icon: Icons.airline_stops_sharp,
          name: 'Visit Approvals',
          onTap: () =>
              // GetValues.userRoll == '0'
              //     ? () =>
              Get.toNamed<dynamic>(FurneyRoutes.approvalTask),
          // : null,
        ),
      if (FurneySignInScreenState.menuListItem.contains('19') == true)
        AllMenuData(
          icon: Icons.location_on,
          name: 'Location Approvals',
          onTap: () =>
              // GetValues.userRoll == '0'
              //     ? () =>
              Get.toNamed<dynamic>(FurneyRoutes.locationApproval),
          // : null,
        ),
    ];
