import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class AllContacts extends StatefulWidget {
  const AllContacts({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  AllContactsState createState() => AllContactsState();
}

class AllContactsState extends State<AllContacts> {
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(context, _scaffoldKey, widget.title),
      drawer: drawer(context),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          SizedBox(height: Screens.heigth(context) * 0.01, ),
          Container(padding: EdgeInsets.symmetric(horizontal: Screens.width(context)*0.02 ),
            width: Screens.width(context),
           // height: Screens.heigth(context) * 0.3,
            color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                 crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     SizedBox(height: Screens.heigth(context) * 0.01, ),
                        GestureDetector(
                                  onTap: (){
                                  // Get.toNamed<dynamic>(FurneyRoutes.regularSalesPrice);
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Max Teq',
                                        style: GoogleFonts.poppins(
                                            fontSize: Screens.heigth(context) * 0.018,
                                            color: theme.primaryColor,),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: Screens.width(context) * 0.83,
                                            // color: Colors.blue,
                                            child: Text(
                                              'CEO',
                                              style: GoogleFonts.poppins(
                                                  fontSize: Screens.heigth(context) * 0.02,
                                                  color: Colors.black,),
                                            ),
                                          ),
                                          Container(
                                            child: Icon(
                                              Icons.navigate_next_outlined,
                                              color: theme.primaryColor,
                                              size: Screens.heigth(context) * 0.06,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ), 
                GestureDetector(
                                  onTap: (){
                                  // Get.toNamed<dynamic>(FurneyRoutes.regularSalesPrice);
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Amanda Costner',
                                        style: GoogleFonts.poppins(
                                            fontSize: Screens.heigth(context) * 0.018,
                                            color: theme.primaryColor,),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: Screens.width(context) * 0.83,
                                            // color: Colors.blue,
                                            child: Text(
                                              'Sales Manager',
                                              style: GoogleFonts.poppins(
                                                  fontSize: Screens.heigth(context) * 0.02,
                                                  color: Colors.black,),
                                            ),
                                          ),
                                          Container(
                                            child: Icon(
                                              Icons.navigate_next_outlined,
                                              color: theme.primaryColor,
                                              size: Screens.heigth(context) * 0.06,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
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
