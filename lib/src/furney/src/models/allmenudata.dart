import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class AllMenuData {
  IconData ? icon;
  VoidCallback? onTap;
  String? name;

  AllMenuData({
    required this.icon,
    required this.name,
    required this.onTap,
  });
}

List<AllMenuData> dataList(BuildContext context)=>[

  AllMenuData(
    icon: Icons.home,
   name: AppLocalizations.of(context)!.dashboard,
   onTap: ()=> Get.back<dynamic>(),
   ),
   AllMenuData(
    icon: Icons.list_alt,
   name: AppLocalizations.of(context)!.depot_performance,//
   onTap:()=>Get.toNamed<dynamic>(FurneyRoutes.depotperformance),
   ),
     AllMenuData(
    icon: Icons.list_alt,
   name: AppLocalizations.of(context)!.sales_rep,//
   onTap: ()=>Get.toNamed<dynamic>(FurneyRoutes.salesRep),
   ),
   AllMenuData(
    icon: Icons.list_alt,
   name: AppLocalizations.of(context)!.approvals,//
   onTap:  ()=> Get.toNamed<dynamic>(FurneyRoutes.approvalsNew),
   ),
     AllMenuData(
    icon: Icons.calendar_today,
   name: AppLocalizations.of(context)!.attendance,
   onTap:  ()=> Get.toNamed<dynamic>(FurneyRoutes.attendance),
   ),
   AllMenuData(
    icon: Icons.people_alt,
   name: AppLocalizations.of(context)!.customer,
   onTap:  ()=> Get.toNamed<dynamic>(FurneyRoutes.customerpage),
   ),
     AllMenuData(
    icon: Icons.list_alt,
   name: AppLocalizations.of(context)!.stock_at_warehouse,//
   onTap:  ()=> Get.toNamed<dynamic>(FurneyRoutes.stockItem),
   ),
   AllMenuData(
    icon: Icons.auto_awesome_motion,
   name: AppLocalizations.of(context)!.sales_quote,
   onTap:  ()=> Get.toNamed<dynamic>(FurneyRoutes.newSalesQuot),
   ),
     AllMenuData(
    icon: Icons.request_quote,
   name: AppLocalizations.of(context)!.sales_orders,
   onTap:  ()=> Get.toNamed<dynamic>(FurneyRoutes.newSalesOrders),
   ),
   AllMenuData(
    icon: Icons.local_shipping,
   name: AppLocalizations.of(context)!.deliveries,
   onTap: ()=> Get.toNamed<dynamic>(FurneyRoutes.deliveyPage),
   ),
      AllMenuData(
    icon: Icons.list_alt,
   name: AppLocalizations.of(context)!.payment_from_customers,//
   onTap: null,
   //()=> Get.toNamed<dynamic>(FurneyRoutes.paymentCustomers),
   ),
      AllMenuData(
    icon: Icons.list_alt,
   name: AppLocalizations.of(context)!.notes,//
   onTap:  ()=> Get.toNamed<dynamic>(FurneyRoutes.notesPage),
   ),
      AllMenuData(
    icon: Icons.question_answer,
   name: AppLocalizations.of(context)!.complaints,
   onTap: ()=> Get.toNamed<dynamic>(FurneyRoutes.complaintsPage),
   ),
      AllMenuData(
    icon: Icons.list_alt,
   name: AppLocalizations.of(context)!.reports,//
   onTap: ()=> Get.toNamed<dynamic>(FurneyRoutes.reports),
   ),

   // sales app

    AllMenuData(
    icon: Icons.play_lesson,
   name: 'Planing',
   onTap: ()=> Get.toNamed<dynamic>(FurneyRoutes.planningPage),
   ),

     AllMenuData(
    icon: Icons.check,
   name: 'Checkin',
   onTap: ()=> Get.toNamed<dynamic>(FurneyRoutes.checkedin),
   ),

    AllMenuData(
    icon: Icons.fact_check_sharp,
   name: 'Checkout',
   onTap: ()=> Get.toNamed<dynamic>(FurneyRoutes.checkoutPage),
   ),

     AllMenuData(
    icon: Icons.airline_stops_sharp,
   name: 'Visit Approvals',
   onTap: GetValues.userRoll == '0'?
   ()=> Get.toNamed<dynamic>(FurneyRoutes.approvalTask):null,
   ),

      AllMenuData(
    icon: Icons.location_on,
   name: 'Location Approvals',
   onTap: GetValues.userRoll == '0'?
   ()=> Get.toNamed<dynamic>(FurneyRoutes.locationApproval):null,
   ),

   
];