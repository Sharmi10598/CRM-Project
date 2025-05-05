// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  ContentPageState createState() => ContentPageState();
}

class ContentPageState extends State<ContentPage> {
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
                  horizontal: Screens.width(context) * 0.02),
              color: Colors.white,
              width: Screens.width(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed<dynamic>(FurneyRoutes.details);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: Screens.width(context) * 0.6,
                                      //  color: Colors.blue,
                                      child: Text(
                                        'Tower Case with Power supply',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              Screens.heigth(context) * 0.018,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Screens.width(context) * 0.03),
                                    SizedBox(
                                      //  color: Colors.pink,
                                      width: Screens.width(context) * 0.2,
                                      child: Text(
                                        '5.00',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              Screens.heigth(context) * 0.015,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                //
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: Screens.width(context) * 0.6,
                                      // color: Colors.blue,
                                      child: Text(
                                        'C00004',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              Screens.heigth(context) * 0.018,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Screens.width(context) * 0.03),
                                    SizedBox(
                                      width: Screens.width(context) * 0.2,
                                      child: Text(
                                        r'218.75$',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              Screens.heigth(context) * 0.015,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Icon(
                              Icons.navigate_next_outlined,
                              color: theme.primaryColor,
                              size: Screens.heigth(context) * 0.05,
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1.5,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed<dynamic>(FurneyRoutes.details);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: Screens.width(context) * 0.6,
                                      //  color: Colors.blue,
                                      child: Text(
                                        'Hard Disk 3TB',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              Screens.heigth(context) * 0.018,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Screens.width(context) * 0.03),
                                    SizedBox(
                                      //  color: Colors.pink,
                                      width: Screens.width(context) * 0.2,
                                      child: Text(
                                        '9.00',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              Screens.heigth(context) * 0.015,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                //
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: Screens.width(context) * 0.6,
                                      // color: Colors.blue,
                                      child: Text(
                                        'C00007',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              Screens.heigth(context) * 0.018,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Screens.width(context) * 0.03),
                                    SizedBox(
                                      width: Screens.width(context) * 0.2,
                                      child: Text(
                                        r'5.675$',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              Screens.heigth(context) * 0.015,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Icon(
                              Icons.navigate_next_outlined,
                              color: theme.primaryColor,
                              size: Screens.heigth(context) * 0.05,
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1.5,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed<dynamic>(FurneyRoutes.details);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: Screens.width(context) * 0.6,
                                      //  color: Colors.blue,
                                      child: Text(
                                        'J.B Officeprint 1420',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              Screens.heigth(context) * 0.018,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Screens.width(context) * 0.03),
                                    SizedBox(
                                      //  color: Colors.pink,
                                      width: Screens.width(context) * 0.2,
                                      child: Text(
                                        '5.00',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              Screens.heigth(context) * 0.015,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                //
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: Screens.width(context) * 0.6,
                                      // color: Colors.blue,
                                      child: Text(
                                        'A00001',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              Screens.heigth(context) * 0.018,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Screens.width(context) * 0.03),
                                    SizedBox(
                                      width: Screens.width(context) * 0.2,
                                      child: Text(
                                        r'2,500.00$',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              Screens.heigth(context) * 0.015,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Icon(
                              Icons.navigate_next_outlined,
                              color: theme.primaryColor,
                              size: Screens.heigth(context) * 0.05,
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1.5,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed<dynamic>(FurneyRoutes.details);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: Screens.width(context) * 0.6,
                                      //  color: Colors.blue,
                                      child: Text(
                                        'RainBow Color Printer 7.5',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              Screens.heigth(context) * 0.018,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Screens.width(context) * 0.03),
                                    SizedBox(
                                      //  color: Colors.pink,
                                      width: Screens.width(context) * 0.2,
                                      child: Text(
                                        '6.00',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              Screens.heigth(context) * 0.015,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                //
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: Screens.width(context) * 0.6,
                                      // color: Colors.blue,
                                      child: Text(
                                        'A00005',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              Screens.heigth(context) * 0.018,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Screens.width(context) * 0.03),
                                    SizedBox(
                                      width: Screens.width(context) * 0.2,
                                      child: Text(
                                        r'3,000.00$',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              Screens.heigth(context) * 0.015,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Icon(
                              Icons.navigate_next_outlined,
                              color: theme.primaryColor,
                              size: Screens.heigth(context) * 0.05,
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1.5,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed<dynamic>(FurneyRoutes.details);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: Screens.width(context) * 0.6,
                                      //  color: Colors.blue,
                                      child: Text(
                                        'Gigabit NetWork Card',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              Screens.heigth(context) * 0.018,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Screens.width(context) * 0.03),
                                    SizedBox(
                                      //  color: Colors.pink,
                                      width: Screens.width(context) * 0.2,
                                      child: Text(
                                        '8.00',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              Screens.heigth(context) * 0.015,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                //
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: Screens.width(context) * 0.6,
                                      // color: Colors.blue,
                                      child: Text(
                                        'C00006',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              Screens.heigth(context) * 0.018,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Screens.width(context) * 0.03),
                                    SizedBox(
                                      width: Screens.width(context) * 0.2,
                                      child: Text(
                                        r'150.00$',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              Screens.heigth(context) * 0.015,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Icon(
                              Icons.navigate_next_outlined,
                              color: theme.primaryColor,
                              size: Screens.heigth(context) * 0.05,
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1.5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Screens.heigth(context) * 0.01,
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
