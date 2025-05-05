// ignore_for_file: prefer_single_quotes, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class ItemInfo extends StatefulWidget {
  const ItemInfo({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  ItemInfoState createState() => ItemInfoState();
}

class ItemInfoState extends State<ItemInfo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: _scaffoldKey,
      appBar: appBar(context, _scaffoldKey, widget.title),
      drawer:
          // GetValues.userRoll == '3' ? drawer2(context) :
          drawer(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            //   left: Screens.width(context) * 0.02,
            //   right: Screens.width(context) * 0.02,
            top: Screens.heigth(context) * 0.01,
            bottom: Screens.width(context) * 0.01,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            color: theme.primaryColor,
                            width: Screens.width(context) * 0.07,
                            height: Screens.heigth(context) * 0.04,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Screens.heigth(context) * 0.005,
                      ),
                      Row(
                        children: [
                          Container(
                            color: theme.primaryColor,
                            width: Screens.width(context) * 0.07,
                            height: Screens.heigth(context) * 0.04,
                          ),
                          SizedBox(
                            width: Screens.heigth(context) * 0.005,
                          ),
                          Container(
                            color: theme.primaryColor,
                            width: Screens.width(context) * 0.07,
                            height: Screens.heigth(context) * 0.04,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "Hard Disk 3TB",
                    style: GoogleFonts.poppins(
                      fontSize: Screens.width(context) * 0.07,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Screens.heigth(context) * 0.05,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Screens.width(context) * 0.02,
                ),
                width: Screens.width(context),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Item Code",
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.018,
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                            "C00007",
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
                          "Item Description",
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.018,
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                            "Hard Disk 3TB",
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
                        Get.toNamed<dynamic>(FurneyRoutes.priceList);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Unit price",
                            style: GoogleFonts.poppins(
                              fontSize: Screens.heigth(context) * 0.018,
                              color: theme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: Screens.width(context) * 0.83,
                                // color: Colors.blue,
                                child: Text(
                                  r"500.00 $",
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
                        Get.toNamed<dynamic>(FurneyRoutes.inventoryWarehouse);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "In-Stock Qty",
                            style: GoogleFonts.poppins(
                              fontSize: Screens.heigth(context) * 0.018,
                              color: theme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: Screens.width(context) * 0.83,
                                // color: Colors.blue,
                                child: Text(
                                  "8934",
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
                          "Shipping Type",
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.018,
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                            "Fedex EM",
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
                          "Manufacturer",
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.018,
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                            "I-Tech",
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
                          "Spec.",
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.018,
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                            "",
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
                      child: InkWell(
                        highlightColor: Colors.green,
                        splashColor: Colors.red,
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
                                "Attachments",
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
