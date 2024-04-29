// ignore_for_file: file_names, prefer_const_constructors, prefer_single_quotes, require_trailing_commas, prefer_if_elements_to_conditional_expressions

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/appVersion.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';


class GetValues{
  static String ?deviceID ;
  static List<bool> isAtive = [false,false,];
  static  String ?userName;
  static String ?sessionID ;
  static  String maximumfetchValue ='70';
  static String? crmUserID; 
  static String? sapUserID; 
  static String? sapUserName; 
  static String? sapPassword;
  static String? slpCode; 
  static String? branch; 
  static String? sapDB; 
  static String? currency; 
  static String? countryCode; 
  static String? seriresOrder; 
  static String? userRoll; 
  static String? LeadToken; 
  static String? UserToken; 
  static String? U_CrpUsr;
}


 Drawer drawer(BuildContext context){
   final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
     final theme = Theme.of(context);
  return Drawer(
     child: ListView(
       children: [
          //          UserAccountsDrawerHeader(
          //   currentAccountPicture: null,
          //   // const CircleAvatar(
          //   //   backgroundColor: Colors.white70,
          //   //   backgroundImage: AssetImage(
          //   //     "assets/CRM/drawer.png"),
          //   // ),
          //   accountEmail: Text("userID"),
          //   accountName: Text("CompanyID"),
          //   decoration: BoxDecoration(
          //     color: theme.primaryColor,
          //   ),
          // ),
         Container(
           padding: EdgeInsets.symmetric(vertical: Screens.heigth(context)*0.02,
           horizontal: Screens.width(context)*0.02),
           width: Screens.width(context),
           height: Screens.heigth(context)*0.1,
           color: theme.primaryColor,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text('${GetValues.userName}',
           style: TextStyles.whiteText(context)),
               Text('${GetValues.branch}',
                 style: TextStyles.whiteText(context))
             ],
           ),
         ),

                    ListTile(
           // selected: GetValues.isAtive[0],
           //  tileColor: Colors.green,
         //     selectedTileColor: Colors.red[100],
             // focusColor: Colors.white,
            leading: Icon(Icons.home),
            onTap: () {
              GetValues.isAtive[0]=true;
              GetValues.isAtive[1]=false;
              Navigator.pop(context);
             Get.offAllNamed<dynamic>(FurneyRoutes.home);
            },
            title:  Text(
              "Dashbord",
              style: TextStyles.headlineBlack1(context)
            ),
          ),

             ListTile(
            leading: Icon(Icons.contact_mail,
            // color: Colors.grey[400],
            ),
            onTap: () {
              Navigator.pop(context);
               Get.toNamed<dynamic>(FurneyRoutes.depotperformance);
            },
            title:  Text(
              "Depot Performance",
              style: TextStyles.headlineBlack1(context)
            ),
          ),

            ListTile(
            leading: Icon(Icons.date_range,
            
            ),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed<dynamic>(FurneyRoutes.salesRep);
            },
            title:  Text(
              "Sales Rep",
              style: TextStyles.headlineBlack1(context)
            ),
          ),

          ListTile(
            leading: Icon(Icons.date_range),
            onTap: () {
              Navigator.pop(context);
               Get.toNamed<dynamic>(FurneyRoutes.attendance);
            },
            title:  Text(
              "Attendance",
              style: TextStyles.headlineBlack1(context)
            ),
          ),

           ListTile(
           //   selected: isSelected,
            leading: Icon(Icons.dehaze_outlined),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed<dynamic>(FurneyRoutes.approvalsNew);
            },
            title:  Text(
              "Approvals",
              style:TextStyles.headlineBlack1(context)
            ),
          ),
           ListTile(
            leading: Icon(Icons.people_alt),
            onTap: () {
             Navigator.pop(context);
             Get.toNamed<dynamic>(FurneyRoutes.customerpage);
            },
            title:  Text(
              "Customers",
              style: TextStyles.headlineBlack1(context)
            ),
          ),
           ListTile(
            leading: Icon(Icons.call_missed_outgoing_outlined),
            onTap: () {
              Navigator.pop(context);
               Get.toNamed<dynamic>(FurneyRoutes.stockItem);
            },
            title:  Text(
              "Stock At Warehouse",
              style: TextStyles.headlineBlack1(context)
            ),
          ),
           ListTile(
            leading: Icon(Icons.auto_awesome_motion),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed<dynamic>(FurneyRoutes.newSalesQuot);
              // Get.toNamed<dynamic>(FurneyRoutes.salesQuotes);
            },
            title:  Text(
              "Sales Quote",
              style: TextStyles.headlineBlack1(context)
            ),
          ),
           ListTile(
              selected: GetValues.isAtive[1],
              selectedTileColor: Colors.red[100],
            leading: Icon(Icons.request_quote),
            onTap: () {
               Navigator.pop(context);
               Get.toNamed<dynamic>(FurneyRoutes.newSalesOrders);
            },
            title:  Text(
              "Sales Orders",
              style: TextStyles.headlineBlack1(context)
            ),
          ),
           ListTile(
            leading: Icon(Icons.local_shipping),
            onTap: () {
              Navigator.pop(context);
               Get.toNamed<dynamic>(FurneyRoutes.deliveyPage);
            },
            title:  Text(
              "Deliveries",
              style: TextStyles.headlineBlack1(context)
            ),
          ),

           ListTile(
            leading: Icon(Icons.local_parking_rounded,
            color: Colors.grey[400],
            ),
            onTap: () {
              Navigator.pop(context);
            //  Get.toNamed<dynamic>(FurneyRoutes.paymentCustomers);
            },
            title:  Text(
              "Payment From Customers",
              style: TextStyles.headlineGrey(context)
            ),
          ),
           ListTile(
            leading: Icon(Icons.note_add),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed<dynamic>(FurneyRoutes.notesPage);
            },
            title:  Text(
              "Notes",
              style:TextStyles.headlineBlack1(context)
            ),
          ),
           ListTile(
            leading: Icon(Icons.question_answer),
            onTap: () {
              Navigator.pop(context);
             Get.toNamed<dynamic>(FurneyRoutes.complaintsPage);
            },
            title:  Text(
              "Complaints",
              style:TextStyles.headlineBlack1(context)
            ),
          ),
           ListTile(
            leading: Icon(Icons.receipt_rounded,
            //  color: Colors.grey[400],
            ),
            onTap: () {
              Navigator.pop(context);
             Get.toNamed<dynamic>(FurneyRoutes.reports); 
            },
            title:  Text(
              "Reports",
              style: TextStyles.headlineBlack1(context)
            ),
          ),
          SizedBox(height: Screens.heigth(context)*0.01,),
           GetValues.userRoll == "0"?
          ListTile(
            leading: Icon(Icons.airline_stops_sharp,
            ),
            onTap: () {
              Navigator.pop(context);
             Get.toNamed<dynamic>(FurneyRoutes.approvalTask); 
            },
            title: Text(
              "Visit Approvals",
              style: TextStyles.headlineBlack1(context)
            ),
          ): SizedBox(),
             SizedBox(height: Screens.heigth(context)*0.01,),
           GetValues.userRoll == "0"?
          ListTile(
            leading: Icon(Icons.location_on,
            ),
            onTap: () {
              Navigator.pop(context);
             Get.toNamed<dynamic>(FurneyRoutes.locationApproval); 
            },
            title: Text(
              "Location Approvals",
              style: TextStyles.headlineBlack1(context)
            ),
          ): SizedBox(),
          SizedBox(height: Screens.heigth(context)*0.01,),
          ListTile(
            leading: Icon(Icons.play_lesson,
            //  color: Colors.grey[400],
            ),
            onTap: () {
              Navigator.pop(context);
             Get.toNamed<dynamic>(FurneyRoutes.planningPage); 
            },
            title:  Text(
              "Planning",
              style: TextStyles.headlineBlack1(context)
            ),
          ),
          SizedBox(height: Screens.heigth(context)*0.01,),
          ListTile(
            leading: Icon(Icons.check,
            //  color: Colors.grey[400],
            ),
            onTap: () {
              Navigator.pop(context);
             Get.toNamed<dynamic>(FurneyRoutes.checkin); 
            },
            title:  Text(
              "Check in",
              style: TextStyles.headlineBlack1(context)
            ),
          ),
          SizedBox(height: Screens.heigth(context)*0.01,),
          ListTile(
            leading: Icon(Icons.fact_check_sharp,
            //  color: Colors.grey[400],
            ),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed<dynamic>(FurneyRoutes.checkoutPage);
            },
            title:  Text(
              "Check out",
              style: TextStyles.headlineBlack1(context)
            ),
          ),
          SizedBox(height: Screens.heigth(context)*0.01,),
          Center(
            child: Column(
              children: [
                Text("Version ${AppVersion.version}",style: GoogleFonts.poppins(
                  color: Colors.grey[300],
                  fontSize: Screens.width(context)*0.04
                ),),
                SelectableText(GetValues.deviceID!=null?'${GetValues.deviceID}':'',style: GoogleFonts.poppins(
                  color: Colors.grey[300],
                  fontSize: Screens.width(context)*0.04
                ),),
              ],
            ),
          ),
           SizedBox(height: Screens.heigth(context)*0.025,),
       ],
     )
  );
}