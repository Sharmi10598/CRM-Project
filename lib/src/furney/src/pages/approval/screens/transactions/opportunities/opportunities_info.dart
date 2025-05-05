import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class OpportunitiesInfo extends StatefulWidget {
  const OpportunitiesInfo({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  OpportunitiesInfoState createState() => OpportunitiesInfoState();
}

class OpportunitiesInfoState extends State<OpportunitiesInfo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(context, _scaffoldKey, widget.title),
      drawer:
          // GetValues.userRoll == '3' ? drawer2(context) :
          drawer(context),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          SizedBox(
            height: Screens.heigth(context) * 0.01,
          ),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: Screens.width(context) * 0.02),
            width: Screens.width(context),
            height: Screens.heigth(context) * 0.84,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                        'Opportunity No.',
                        style: GoogleFonts.poppins(
                          fontSize: Screens.heigth(context) * 0.018,
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          '1976',
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
                        'Opportunity Name',
                        style: GoogleFonts.poppins(
                          fontSize: Screens.heigth(context) * 0.018,
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          '',
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
                                'EarthShaker Corporation',
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
                                'Bob McKensly',
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
                          'Sophie Klogg',
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
                          '',
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
                          'Won',
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
                        'Closing Rate',
                        style: GoogleFonts.poppins(
                          fontSize: Screens.heigth(context) * 0.018,
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          '6%',
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
                        'Potential Amount',
                        style: GoogleFonts.poppins(
                          fontSize: Screens.heigth(context) * 0.018,
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          '2000.00',
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
                        'Satge',
                        style: GoogleFonts.poppins(
                          fontSize: Screens.heigth(context) * 0.018,
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          'Lead',
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
                        'Stage Start Date',
                        style: GoogleFonts.poppins(
                          fontSize: Screens.heigth(context) * 0.018,
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          '2021-11-03 ',
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
                        'Sateg Close Date',
                        style: GoogleFonts.poppins(
                          fontSize: Screens.heigth(context) * 0.018,
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          '2021-11-03 ',
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
                          'Sophie Klogg',
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
                          '',
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
                            'All Stages',
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
          ),
        ],
      ),
    );
  }

  Future<void> showbottomsheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (builder) {
        return Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Form(
            // key: formkey[2],
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Follow-up Activity',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18,
                      // fontWeight: FontWeight.bold
                    ),
                  ),
                  const Divider(
                    thickness: 1.5,
                  ),
                  Text(
                    'Close Activity',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18,
                      //   fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.02,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
