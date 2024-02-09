// ignore_for_file: prefer_interpolation_to_compose_strings, omit_local_variable_types, prefer_final_locals, noop_primitive_operations, prefer_single_quotes

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ultimate_bundle/helpers/colors.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
class TextStyles{
  // static TextStyle txtCard = GoogleFonts.poppins(
  //       color:PrimaryColorLight.furney,
  //       fontSize: Screens.width(context)* 0.018,
  //       fontWeight: FontWeight.w500,
  //     );

static TextStyle boldPC1(BuildContext context) {
    return  TextStyle(
      color:PrimaryColorLight.furney,
      fontWeight: FontWeight.bold,
       fontSize: Screens.width(context)* 0.048,
       fontFamily: 'Segoe',
    );
    // GoogleFonts.poppins(
    //     color:PrimaryColorLight.furney,
    //     fontSize: Screens.width(context)* 0.04,
    //     fontWeight: FontWeight.bold,
    //   );
  }

  static TextStyle boldgrey(BuildContext context) {
    return  TextStyle(
      color:Colors.grey,
      fontWeight: FontWeight.bold,
       fontSize: Screens.width(context)* 0.048,
       fontFamily: 'Segoe',
    );
    // GoogleFonts.poppins(
    //     color:PrimaryColorLight.furney,
    //     fontSize: Screens.width(context)* 0.04,
    //     fontWeight: FontWeight.bold,
    //   );
  }

  static TextStyle boldBlock1(BuildContext context) {
    return  TextStyle(
      color:Colors.black,
      fontWeight: FontWeight.bold,
       fontSize: Screens.width(context)* 0.048,
       fontFamily: 'Segoe',
    );
    // GoogleFonts.poppins(
    //     color:PrimaryColorLight.furney,
    //     fontSize: Screens.width(context)* 0.04,
    //     fontWeight: FontWeight.bold,
    //   );
  }

  static TextStyle headlineBlack1(BuildContext context) {
    return  TextStyle(
      color:Colors.black,
     fontWeight: FontWeight.w500,
      fontSize: Screens.width(context)* 0.043,
       fontFamily: 'Segoe',
    );
    // GoogleFonts.poppins(
    //     color:Colors.black54,
    //     fontSize: Screens.width(context)* 0.04,
    //     fontWeight: FontWeight.w500,
    //   );
  }

  static TextStyle headlineGrey(BuildContext context) {
    return  TextStyle(
      color:Colors.grey[400],
     fontWeight: FontWeight.w100,
      fontSize: Screens.width(context)* 0.043,
       fontFamily: 'Segoe',
    );
    // GoogleFonts.poppins(
    //     color:Colors.black54,
    //     fontSize: Screens.width(context)* 0.04,
    //     fontWeight: FontWeight.w500,
    //   );
  }

   static TextStyle headlinePC1(BuildContext context) {
    return TextStyle(
      color:PrimaryColorLight.furney,
     fontWeight: FontWeight.w500,
      fontSize: Screens.width(context)* 0.043,
       fontFamily: 'Segoe',
    );
    //  GoogleFonts.poppins(
    //     color:PrimaryColorLight.furney,
    //     fontSize: Screens.width(context)* 0.04,
    //     fontWeight: FontWeight.w500,
    //   );
  }

  static TextStyle bodytextBlack1(BuildContext context) {
    return  TextStyle(
      color:Colors.black,
      fontSize: Screens.width(context)* 0.035,
       fontFamily: 'Segoe',
    );
    //  GoogleFonts.poppins(
    //     color:Colors.black54,
    //     fontSize: Screens.width(context)* 0.03,
    //   );
  }
//  fontFamily: 'Segoe'
  static TextStyle bodytextPC1(BuildContext context) {
    return 
    TextStyle(
      color:PrimaryColorLight.furney,
      fontSize: Screens.width(context)* 0.035,
       fontFamily: 'Segoe',
    );
    //  GoogleFonts.poppins(
    //     color:PrimaryColorLight.furney,
    //     fontSize: Screens.width(context)* 0.03,
    //   );
  }

   static TextStyle bodytextgrey1(BuildContext context) {
    return  TextStyle(
      color:Colors.grey,
      fontSize: Screens.width(context)* 0.035,
       fontFamily: 'Segoe',
    );
    
    // GoogleFonts.poppins(
    //     color:Colors.grey,
    //     fontSize: Screens.width(context)* 0.03,
    //   );
  }

  static TextStyle bodytextBlack2(BuildContext context) {
    return   TextStyle(
        color:Colors.black,
       fontSize: Screens.width(context)* 0.03,
       fontFamily: 'Segoe',
    );
    // GoogleFonts.poppins(
    //     color:Colors.black54,
    //     fontSize: Screens.width(context)* 0.025,
    //   );
  }
 static TextStyle whiteText(BuildContext context) {
    return  TextStyle(
         color:Colors.white,
      fontSize: Screens.width(context)* 0.035,
       fontFamily: 'Segoe',
        fontWeight: FontWeight.bold,
    );
    //  GoogleFonts.poppins(
    //     color:Colors.white,
    //     fontSize: Screens.width(context)* 0.035,
    //     fontWeight: FontWeight.w500,
    //   );
  }

   static TextStyle whiteTextHead(BuildContext context) {
    return  TextStyle(
         color:Colors.white,
      fontSize: Screens.width(context)* 0.045,
       fontFamily: 'Segoe',
        fontWeight: FontWeight.bold,
    );
    //  GoogleFonts.poppins(
    //     color:Colors.white,
    //     fontSize: Screens.width(context)* 0.035,
    //     fontWeight: FontWeight.w500,
    //   );
  }
 static TextStyle underLine(BuildContext context) {
    return TextStyle(
      color:PrimaryColorLight.furney,
     fontWeight: FontWeight.bold,
      fontSize: Screens.width(context)* 0.05,
       fontFamily: 'Segoe',
       decoration: TextDecoration.underline,
    );
    //  GoogleFonts.poppins(
    //     color:PrimaryColorLight.furney,
    //     fontSize: Screens.width(context)* 0.04,
    //     fontWeight: FontWeight.w500,
    //   );
  }

 static  String splitValues( String val){
   // print("vvvvv: "+val);'
   if(val == 'null'){
    return '';
   }

     var formatter = NumberFormat('###,000.00');
     double formatNO = double.parse(val);
    // print("formatedd: "+formatter.format(formatNO));
     String retunVal = formatter.format(formatNO).toString();
     return retunVal;
  }
}