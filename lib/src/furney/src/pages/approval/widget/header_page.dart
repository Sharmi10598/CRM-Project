import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';

class HeaderPage extends StatefulWidget {
  const HeaderPage({Key? key}) : super(key: key);

  @override
  _HeaderPageState createState() => _HeaderPageState();
}

class _HeaderPageState extends State<HeaderPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body:
          // Padding(
          //  padding: EdgeInsets.only(top:Screens.heigth(context)*0.01,),//left: Screens.width(context)*0.01,right: Screens.width(context)*0.01,
          // child:
          SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Screens.width(context) * 0.02,
              ),
              color: Colors.white,
              width: Screens.width(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.docNo,
                        // "Doc No.",
                        style: GoogleFonts.poppins(
                          fontSize: Screens.heigth(context) * 0.018,
                          color: theme.primaryColor,
                          // fontWeight:FontWeight.bold
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          'Hardware - 1495',
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.02,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed<dynamic>(FurneyRoutes.bpinfo);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Business Partner',
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.018,
                            color: theme.primaryColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.83,
                              // color: Colors.blue,
                              child: Text(
                                'Sales quotation based on draft no. 1485',
                                style: GoogleFonts.poppins(
                                  fontSize: Screens.heigth(context) * 0.02,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.navigate_next_outlined,
                              color: theme.primaryColor,
                              size: Screens.heigth(context) * 0.06,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed<dynamic>(FurneyRoutes.contactInfo);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact Person',
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.018,
                            color: theme.primaryColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.83,
                              // color: Colors.blue,
                              child: Text(
                                'Bob Mckensly',
                                style: GoogleFonts.poppins(
                                  fontSize: Screens.heigth(context) * 0.02,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.navigate_next_outlined,
                              color: theme.primaryColor,
                              size: Screens.heigth(context) * 0.06,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Currency',
                        style: GoogleFonts.poppins(
                          fontSize: Screens.heigth(context) * 0.018,
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          r'Local Currency: $',
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.02,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Sales Employee',
                        style: GoogleFonts.poppins(
                          fontSize: Screens.heigth(context) * 0.018,
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          'sophie klogg',
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.02,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Customer Ref.No',
                        style: GoogleFonts.poppins(
                          fontSize: Screens.heigth(context) * 0.018,
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          ' ',
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.02,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Screens.heigth(context) * 0.01,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Screens.width(context) * 0.02,
              ),
              color: Colors.white,
              width: Screens.width(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Status',
                        style: GoogleFonts.poppins(
                          fontSize: Screens.heigth(context) * 0.018,
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          'Pending',
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.02,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Posting Date',
                        style: GoogleFonts.poppins(
                          fontSize: Screens.heigth(context) * 0.018,
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          '2015/06/17',
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.02,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Valid until',
                        style: GoogleFonts.poppins(
                          fontSize: Screens.heigth(context) * 0.018,
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          '2015/06/27',
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.02,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Document Date',
                        style: GoogleFonts.poppins(
                          fontSize: Screens.heigth(context) * 0.018,
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          '2015/06/17',
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.02,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Remarks',
                        style: GoogleFonts.poppins(
                          fontSize: Screens.heigth(context) * 0.018,
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          ' ',
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.02,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Screens.heigth(context) * 0.01,
            ),
            Container(
              color: Colors.white,
              width: Screens.width(context),
              padding: EdgeInsets.symmetric(
                horizontal: Screens.width(context) * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Total Before Discount',
                        style: GoogleFonts.poppins(
                          fontSize: Screens.heigth(context) * 0.018,
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          r'11,492.75 $',
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.02,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Discount %',
                        style: GoogleFonts.poppins(
                          fontSize: Screens.heigth(context) * 0.018,
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          '23%',
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.02,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Discount',
                        style: GoogleFonts.poppins(
                          fontSize: Screens.heigth(context) * 0.018,
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          r'2643.56$',
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.02,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Tax',
                        style: GoogleFonts.poppins(
                          fontSize: Screens.heigth(context) * 0.018,
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          r'539.56$',
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.02,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Total',
                        style: GoogleFonts.poppins(
                          fontSize: Screens.heigth(context) * 0.018,
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          r'9447.56$',
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.02,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed<dynamic>(FurneyRoutes.attachments);
                    },
                    child: Center(
                      child: Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: Screens.width(context) * 0.3,
                          ),
                          Text(
                            'Attachments',
                            style: GoogleFonts.poppins(
                              fontSize: Screens.heigth(context) * 0.02,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.25,
                          ),
                          Icon(
                            Icons.navigate_next_outlined,
                            color: theme.primaryColor,
                            size: Screens.heigth(context) * 0.06,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
