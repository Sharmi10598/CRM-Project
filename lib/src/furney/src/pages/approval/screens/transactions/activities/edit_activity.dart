import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class EditActivity extends StatefulWidget {
  const EditActivity({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  EditActivityState createState() => EditActivityState();
}

class EditActivityState extends State<EditActivity> {
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
          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap:(){
               //   showbottomsheet(context);
                },
                child: Container(
                  child: Icon(Icons.done,
                  color:theme.primaryColor,
                  size: Screens.width(context)*0.08,
              
                  ),
                ),
              ),
              SizedBox(width: Screens.width(context) * 0.04, ),
            ],
          ),
          SizedBox(height: Screens.heigth(context) * 0.01, ),
          Container(padding: EdgeInsets.symmetric(horizontal: Screens.width(context)*0.02 ),
            width: Screens.width(context),
           height: Screens.heigth(context) * 0.84,
            color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Screens.heigth(context) * 0.01, ),
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // AppLocalizations.of(context)!.docNo,
                            'Activity',
                            style: GoogleFonts.poppins(
                                fontSize: Screens.heigth(context) * 0.018,
                                color: theme.primaryColor,),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              'Meeting',
                              style: GoogleFonts.poppins(
                                  fontSize: Screens.heigth(context) * 0.02,
                                  color: Colors.black,),
                            ),
                          ),
                        ],
                      ),
                       SizedBox(height: Screens.heigth(context) * 0.01, ),
                          GestureDetector(
                                    onTap: (){
                                     Get.toNamed<dynamic>(FurneyRoutes.bpinfo);
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'BP',
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
                                                'Earthshaker Corporation',
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
                                    Get.toNamed<dynamic>(FurneyRoutes.contactInfo);
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Contact',
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
                                                'Bob McKensly',
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
              
                  SizedBox(height: Screens.heigth(context) * 0.01, ),
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // AppLocalizations.of(context)!.docNo,
                            'Type',
                            style: GoogleFonts.poppins(
                                fontSize: Screens.heigth(context) * 0.018,
                                color: theme.primaryColor,),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              'General',
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
                            'Subject',
                            style: GoogleFonts.poppins(
                                fontSize: Screens.heigth(context) * 0.018,
                                color: theme.primaryColor,),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              'No Subject',
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
                            'Link To',
                            style: GoogleFonts.poppins(
                                fontSize: Screens.heigth(context) * 0.018,
                                color: theme.primaryColor,),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              '-No Link-',
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
                            'Remarks',
                            style: GoogleFonts.poppins(
                                fontSize: Screens.heigth(context) * 0.018,
                                color: theme.primaryColor,),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              'Activity Recording',
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
                            'Content',
                            style: GoogleFonts.poppins(
                                fontSize: Screens.heigth(context) * 0.018,
                                color: theme.primaryColor,),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              '',
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
                            'Handled By',
                            style: GoogleFonts.poppins(
                                fontSize: Screens.heigth(context) * 0.018,
                                color: theme.primaryColor,),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              'Tom Mobile',
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
                            'Start Time',
                            style: GoogleFonts.poppins(
                                fontSize: Screens.heigth(context) * 0.018,
                                color: theme.primaryColor,),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              '2021-11-03 15:00',
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
                            'End Time',
                            style: GoogleFonts.poppins(
                                fontSize: Screens.heigth(context) * 0.018,
                                color: theme.primaryColor,),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              '2021-11-03 15:15',
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
                          'Address',
                          style: GoogleFonts.poppins(
                              fontSize: Screens.heigth(context) * 0.018,
                              color: theme.primaryColor,),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                            '18700 MacArthur Blvd Irvine California',
                            style: GoogleFonts.poppins(
                                fontSize: Screens.heigth(context) * 0.02,
                                color: Colors.black,),
                          ),
                        ),
                      ],
                    ),
              SizedBox(height: Screens.heigth(context) * 0.01, ),
             GestureDetector(
                          onTap: (){
                                Get.toNamed<dynamic>(FurneyRoutes.more);
                              },
                        child: Center(
                          child: Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(width: Screens.width(context)*0.4,),
                              Text(
                              'More',
                              style: GoogleFonts.poppins(
                                  fontSize: Screens.heigth(context) * 0.02,
                                  color: Colors.black,),
                            ),
                            SizedBox(width: Screens.width(context)*0.32,),
                              Container(
                                        child: Icon(
                                          Icons.navigate_next_outlined,
                                          color: theme.primaryColor,
                                          size: Screens.heigth(context) * 0.06,
                                        ),
                                      )
                            ],
                          ),
                        ),
                      )
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
          builder: (builder){
            return  Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Form(
           // key: formkey[2],
            child: Container(
            //  height:  Screens.heigth(context) * 0.2,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              Text('Follow-up Activity',
                 style: GoogleFonts.poppins(
                    color:Colors.black,
                    fontSize: 18,
                   // fontWeight: FontWeight.bold
                  ),),
              const Divider(
                thickness: 1.5,
              ),
               Text('Close Activity',
                 style: GoogleFonts.poppins(
                    color:Colors.black,
                    fontSize: 18,
                 //   fontWeight: FontWeight.bold
                  ),),
                    SizedBox(height: Screens.heigth(context) * 0.02,
              ),        
                  ],
                ),
              ),
            ),
          ),
            );
          },
      );
  }
}
