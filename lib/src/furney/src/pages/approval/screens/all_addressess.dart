import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class AllAddresses extends StatefulWidget {
  const AllAddresses({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  AllAddressesState createState() => AllAddressesState();
}

class AllAddressesState extends State<AllAddresses> {
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
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
               Padding(
                 padding:  EdgeInsets.symmetric(horizontal: Screens.width(context)*0.02,vertical: Screens.width(context)*0.02 ),
                 child: SizedBox(
                 
           width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                     child: Text(
                       'Bill To',
                     style: GoogleFonts.poppins(
                          fontSize: Screens.heigth(context) * 0.02,
                            color: Colors.black,),
                        ),
                  ),
               ),
           
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
                                          'Bill To',
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
                                                '18700 MacArthur Blvd Irvine California 9296 US',
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

            Padding(
                 padding:  EdgeInsets.symmetric(horizontal: Screens.width(context)*0.02,vertical: Screens.width(context)*0.02 ),
                 child: SizedBox(
                 
           width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                     child: Text(
                       'Ship To',
                     style: GoogleFonts.poppins(
                          fontSize: Screens.heigth(context) * 0.02,
                            color: Colors.black,),
                        ),
                  ),
               ),

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
                                          'Ship To',
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
                                                '18700 MacArthur Blvd Irvine California 9296 US',
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
