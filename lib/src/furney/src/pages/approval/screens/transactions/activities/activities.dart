import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class Activities extends StatefulWidget {
  const Activities({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  ActivitiesState createState() => ActivitiesState();
}

class ActivitiesState extends State<Activities> {
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
          SizedBox(
            //padding: EdgeInsets.symmetric(horizontal: Screens.width(context)*0.02 ),
            width: Screens.width(context),
            // height: Screens.heigth(context) * 0.3,
            // color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: Screens.width(context) * 0.09,
                    ),
                    Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: Screens.width(context) * 0.1,
                    ),
                    SizedBox(
                      width: Screens.width(context) * 0.03,
                    ),
                    Text(
                      'November',
                      style: GoogleFonts.poppins(
                        fontSize: Screens.width(context) * 0.08,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: Screens.width(context) * 0.03,
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: Screens.width(context) * 0.1,
                    ),
                    SizedBox(
                      width: Screens.width(context) * 0.09,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed<dynamic>(FurneyRoutes.editactivity);
                      },
                      child: Icon(
                        Icons.add,
                        color: theme.primaryColor,
                        size: Screens.width(context) * 0.08,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Screens.width(context) * 0.02,
                    vertical: Screens.width(context) * 0.02,
                  ),
                  height: Screens.heigth(context) * 0.82,
                  width: Screens.width(context),
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: 100,
                    itemBuilder: (BuildContext context, int i) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed<dynamic>(FurneyRoutes.activitiesDetails);
                        },
                        child: SizedBox(
                          width: Screens.width(context),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.supervisor_account_rounded,
                                    color: Colors.red,
                                    size: Screens.width(context) * 0.1,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Activity recording',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              Screens.heigth(context) * 0.025,
                                          //color: heme.prtimaryColor
                                          color: Colors.black87,
                                          // fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Activity recording',
                                            style: GoogleFonts.poppins(
                                              fontSize:
                                                  Screens.heigth(context) *
                                                      0.015,
                                              //color: heme.prtimaryColor
                                              color: Colors.black54,
                                              // fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          SizedBox(
                                            width: Screens.width(context) * 0.3,
                                          ),
                                          Text(
                                            '2021-11-03 15:00',
                                            style: GoogleFonts.poppins(
                                              fontSize:
                                                  Screens.width(context) * 0.03,
                                              //color: heme.prtimaryColor
                                              color: Colors.black87,
                                              // fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(
                                thickness: 1.5,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
