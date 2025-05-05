// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class InventoryWarehouse extends StatefulWidget {
  const InventoryWarehouse({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  InventoryWarehouseState createState() => InventoryWarehouseState();
}

class InventoryWarehouseState extends State<InventoryWarehouse> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: _scaffoldKey,
      drawer:
          // GetValues.userRoll == '3' ? drawer2(context) :
          drawer(context),
      appBar: appBar(context, _scaffoldKey, widget.title),
      body:
          // Padding(
          //  padding: EdgeInsets.only(top:Screens.heigth(context)*0.01,),//left: Screens.width(context)*0.01,right: Screens.width(context)*0.01,
          // child:
          SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            // left:Screens.width(context) * 0.02,
            // right: Screens.width(context) * 0.02,
            top: Screens.heigth(context) * 0.01,
            bottom: Screens.width(context) * 0.01,
          ),
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
                          // AppLocalizations.of(context)!.docNo,
                          'All',
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.018,
                            color: theme.primaryColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.3,
                              // color: Colors.blue,
                              child: Text(
                                'Available: 2101',
                                style: GoogleFonts.poppins(
                                  fontSize: Screens.heigth(context) * 0.02,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Screens.width(context) * 0.3,
                              // color: Colors.blue,
                              child: Text(
                                'In Stock: 52',
                                style: GoogleFonts.poppins(
                                  fontSize: Screens.heigth(context) * 0.02,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.3,
                              // color: Colors.blue,
                              child: Text(
                                'Ordered: 2101',
                                style: GoogleFonts.poppins(
                                  fontSize: Screens.heigth(context) * 0.02,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Screens.width(context) * 0.3,
                              // color: Colors.blue,
                              child: Text(
                                'Committed: 762',
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
                          'General Warehouse',
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.018,
                            color: theme.primaryColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.3,
                              // color: Colors.blue,
                              child: Text(
                                'Available: 2101',
                                style: GoogleFonts.poppins(
                                  fontSize: Screens.heigth(context) * 0.02,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Screens.width(context) * 0.3,
                              // color: Colors.blue,
                              child: Text(
                                'In Stock: 52',
                                style: GoogleFonts.poppins(
                                  fontSize: Screens.heigth(context) * 0.02,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.3,
                              // color: Colors.blue,
                              child: Text(
                                'Ordered: 2101',
                                style: GoogleFonts.poppins(
                                  fontSize: Screens.heigth(context) * 0.02,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Screens.width(context) * 0.3,
                              // color: Colors.blue,
                              child: Text(
                                'Committed: 762',
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
                    SizedBox(
                      height: Screens.heigth(context) * 0.01,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // AppLocalizations.of(context)!.docNo,
                          'West Cost Warehouse',
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.018,
                            color: theme.primaryColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.3,
                              // color: Colors.blue,
                              child: Text(
                                'Available: 2101',
                                style: GoogleFonts.poppins(
                                  fontSize: Screens.heigth(context) * 0.02,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Screens.width(context) * 0.3,
                              // color: Colors.blue,
                              child: Text(
                                'In Stock: 52',
                                style: GoogleFonts.poppins(
                                  fontSize: Screens.heigth(context) * 0.02,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.3,
                              // color: Colors.blue,
                              child: Text(
                                'Ordered: 2101',
                                style: GoogleFonts.poppins(
                                  fontSize: Screens.heigth(context) * 0.02,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Screens.width(context) * 0.3,
                              // color: Colors.blue,
                              child: Text(
                                'Committed: 762',
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
                    SizedBox(
                      height: Screens.heigth(context) * 0.01,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // AppLocalizations.of(context)!.docNo,
                          'Dropship Warehouse',
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.018,
                            color: theme.primaryColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.3,
                              // color: Colors.blue,
                              child: Text(
                                'Available: 2101',
                                style: GoogleFonts.poppins(
                                  fontSize: Screens.heigth(context) * 0.02,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Screens.width(context) * 0.3,
                              // color: Colors.blue,
                              child: Text(
                                'In Stock: 52',
                                style: GoogleFonts.poppins(
                                  fontSize: Screens.heigth(context) * 0.02,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.3,
                              // color: Colors.blue,
                              child: Text(
                                'Ordered: 2101',
                                style: GoogleFonts.poppins(
                                  fontSize: Screens.heigth(context) * 0.02,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Screens.width(context) * 0.3,
                              // color: Colors.blue,
                              child: Text(
                                'Committed: 762',
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
                    SizedBox(
                      height: Screens.heigth(context) * 0.01,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // AppLocalizations.of(context)!.docNo,
                          'Consignmentl Warehouse',
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.018,
                            color: theme.primaryColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.3,
                              // color: Colors.blue,
                              child: Text(
                                'Available: 2101',
                                style: GoogleFonts.poppins(
                                  fontSize: Screens.heigth(context) * 0.02,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Screens.width(context) * 0.3,
                              // color: Colors.blue,
                              child: Text(
                                'In Stock: 52',
                                style: GoogleFonts.poppins(
                                  fontSize: Screens.heigth(context) * 0.02,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.3,
                              // color: Colors.blue,
                              child: Text(
                                'Ordered: 2101',
                                style: GoogleFonts.poppins(
                                  fontSize: Screens.heigth(context) * 0.02,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Screens.width(context) * 0.3,
                              // color: Colors.blue,
                              child: Text(
                                'Committed: 762',
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
                    SizedBox(
                      height: Screens.heigth(context) * 0.01,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // AppLocalizations.of(context)!.docNo,
                          'Bin Warehouse',
                          style: GoogleFonts.poppins(
                            fontSize: Screens.heigth(context) * 0.018,
                            color: theme.primaryColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.3,
                              // color: Colors.blue,
                              child: Text(
                                'Available: 2101',
                                style: GoogleFonts.poppins(
                                  fontSize: Screens.heigth(context) * 0.02,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Screens.width(context) * 0.3,
                              // color: Colors.blue,
                              child: Text(
                                'In Stock: 52',
                                style: GoogleFonts.poppins(
                                  fontSize: Screens.heigth(context) * 0.02,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.3,
                              // color: Colors.blue,
                              child: Text(
                                'Ordered: 2101',
                                style: GoogleFonts.poppins(
                                  fontSize: Screens.heigth(context) * 0.02,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Screens.width(context) * 0.3,
                              // color: Colors.blue,
                              child: Text(
                                'Committed: 762',
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
