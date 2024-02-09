// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class PriceListPage extends StatefulWidget {
  const PriceListPage({required this.title, Key? key}) : super(key: key);
   final String title;
  @override
  PriceListPageState createState() => PriceListPageState();
}

class PriceListPageState extends State<PriceListPage> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
       backgroundColor: Colors.grey[200],
      key:_scaffoldKey ,
      drawer: drawer(context),
      appBar: appBar(context, _scaffoldKey, widget.title),
      body: 
      // Padding(
      //  padding: EdgeInsets.only(top:Screens.heigth(context)*0.01,),//left: Screens.width(context)*0.01,right: Screens.width(context)*0.01,
       // child: 
        SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.only(
          // left:Screens.width(context) * 0.02,
          // right: Screens.width(context) * 0.02,
          top: Screens.heigth(context) * 0.01,
          bottom: Screens.width(context) * 0.01,
        ),
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: Screens.width(context)*0.02 ),
                  color: Colors.white,
                  width: Screens.width(context),
                  child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        SizedBox(height: Screens.heigth(context) * 0.01, ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                         // AppLocalizations.of(context)!.docNo,
                          'Base Price',
                          style: GoogleFonts.poppins(
                              fontSize: Screens.heigth(context) * 0.018,
                              color: theme.primaryColor,),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                            r'35.00 $',
                            style: GoogleFonts.poppins(
                                fontSize: Screens.heigth(context) * 0.02,
                                color: Colors.black,),
                          ),
                        ),
                      ],
                    ),    
         SizedBox(height: Screens.heigth(context) * 0.01, ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // AppLocalizations.of(context)!.docNo,
                         'Discount Purchase Price',
                          style: GoogleFonts.poppins(
                              fontSize: Screens.heigth(context) * 0.018,
                              color: theme.primaryColor,),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                            r'17.50 $',
                            style: GoogleFonts.poppins(
                                fontSize: Screens.heigth(context) * 0.02,
                                color: Colors.black,),
                          ),
                        ),
                      ],
                    ),
          SizedBox(height: Screens.heigth(context) * 0.01, ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // AppLocalizations.of(context)!.docNo,
                         'Distributor Sales Price',
                          style: GoogleFonts.poppins(
                              fontSize: Screens.heigth(context) * 0.018,
                              color: theme.primaryColor,),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                            r'43.75 $',
                            style: GoogleFonts.poppins(
                                fontSize: Screens.heigth(context) * 0.02,
                                color: Colors.black,),
                          ),
                        ),
                      ],
                    ),
           SizedBox(height: Screens.heigth(context) * 0.01, ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // AppLocalizations.of(context)!.docNo,
                         'Regular Purchase Price',
                          style: GoogleFonts.poppins(
                              fontSize: Screens.heigth(context) * 0.018,
                              color: theme.primaryColor,),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                            r'26.22 $',
                            style: GoogleFonts.poppins(
                                fontSize: Screens.heigth(context) * 0.02,
                                color: Colors.black,),
                          ),
                        ),
                      ],
                    ),

            SizedBox(height: Screens.heigth(context) * 0.01, ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // AppLocalizations.of(context)!.docNo,
                         'Small Account Sales Price',
                          style: GoogleFonts.poppins(
                              fontSize: Screens.heigth(context) * 0.018,
                              color: theme.primaryColor,),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                            r'61.25 $',
                            style: GoogleFonts.poppins(
                                fontSize: Screens.heigth(context) * 0.02,
                                color: Colors.black,),
                          ),
                        ),
                      ],
                    ),
         SizedBox(height: Screens.heigth(context) * 0.01, ),
                          
              ],
            ),
          ),
              ],),),
      ),
    );
  }
}
