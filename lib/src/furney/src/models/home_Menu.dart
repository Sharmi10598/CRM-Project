// ignore_for_file: file_names, require_trailing_commas, prefer_single_quotes, prefer_if_elements_to_conditional_expressions

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class CategoryModel2 {
  int? id;
  String? name;
  String? image;
  IconData ? icon;
  VoidCallback? onTap;

  CategoryModel2({
    this.id,
    this.name,
    this.image,
    this.icon,
    this.onTap,
  });
}

List<CategoryModel2> topCategoryList(BuildContext context) => [
      CategoryModel2(
        name: AppLocalizations.of(context)!.stock,
       icon:Icons.list_alt,
        image:
            'https://images.unsplash.com/photo-1476718406336-bb5a9690ee2a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8Zm9vZHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
       onTap: ()=> Get.toNamed<dynamic>(FurneyRoutes.stockItem),
      ),
      CategoryModel2(
        name: AppLocalizations.of(context)!.customers,
        icon:Icons.people_alt,
        image:
            'https://images.unsplash.com/photo-1566174053879-31528523f8ae?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8ZHJlc3N8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        onTap: ()=> Get.toNamed<dynamic>(FurneyRoutes.customerpage),
      ),
      CategoryModel2(
        name: AppLocalizations.of(context)!.complaints,
     icon:Icons.question_answer,//FaIcon(FontAwesomeIcons.gamepad),
        
        image:
            'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bWFrZSUyMHVwfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        onTap: ()=> Get.toNamed<dynamic>(FurneyRoutes.complaintsPage),
      ),
      CategoryModel2(
        name: AppLocalizations.of(context)!.attendance,
     icon:Icons.calendar_today ,//aIcon(FontAwesomeIcons.gamepad),
        image:
            'https://images.unsplash.com/photo-1527719327859-c6ce80353573?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dHNoaXJ0fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        onTap: ()=> Get.toNamed<dynamic>(FurneyRoutes.attendance),
      ),
      CategoryModel2(
        name: AppLocalizations.of(context)!.salesQuote,
       icon:Icons.auto_awesome_motion,
        image: '',
        onTap: ()=> Get.toNamed<dynamic>(FurneyRoutes.newSalesQuot),
      ),
      CategoryModel2(
        name: AppLocalizations.of(context)!.salesorder,
       icon:Icons.request_quote,//FaIcon(FontAwesomeIcons.gamepad),
        image: '',
        onTap: ()=> Get.toNamed<dynamic>(FurneyRoutes.newSalesOrders),
      ),
      CategoryModel2(
        name: AppLocalizations.of(context)!.deliveries,
       icon:Icons.local_shipping,//FaIcon(FontAwesomeIcons.gamepad),
        image: '',
       onTap: ()=> Get.toNamed<dynamic>(FurneyRoutes.deliveyPage),
      ),
      
      //
       
         //  GetValues.userRoll == "0"?
            CategoryModel2(
        name: "Visit Approvals",
      icon:Icons.airline_stops_sharp,//FaIcon(FontAwesomeIcons.gamepad),
        image: '',
        onTap:GetValues.userRoll == "0"?
         ()=> Get.toNamed<dynamic>(FurneyRoutes.approvalTask):null
      )
    //  :CategoryModel2( )
    ,
            CategoryModel2(
        name:"Planning",
      icon:Icons.play_lesson,//FaIcon(FontAwesomeIcons.gamepad),
        image: '',
        onTap: ()=> Get.toNamed<dynamic>(FurneyRoutes.planningPage)
      ),
            CategoryModel2(
        name: "Check in",
      icon:Icons.check,//FaIcon(FontAwesomeIcons.gamepad),
        image: '',
        onTap: ()=> Get.toNamed<dynamic>(FurneyRoutes.checkin)
      ),
            CategoryModel2(
        name:"Check out",
      icon:Icons.fact_check_sharp,//FaIcon(FontAwesomeIcons.gamepad),
        image: '',
        onTap: ()=> Get.toNamed<dynamic>(FurneyRoutes.checkoutPage)
      ),
      CategoryModel2(
        name: AppLocalizations.of(context)!.other,
      icon:Icons.apps,//FaIcon(FontAwesomeIcons.gamepad),
        image: '',
        onTap: ()=> Get.toNamed<dynamic>(FurneyRoutes.others)
      ),
    ];
