import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfo extends StatefulWidget {
  const ContactInfo({ required this.title, Key? key }) : super(key: key);
   final String title;
  @override
  _ContactInfoState createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key:_scaffoldKey ,
      drawer: drawer(context),
      appBar: appBar(context, _scaffoldKey, widget.title),
      body: SafeArea(
        child: Container(
          padding:  EdgeInsets.only(
          // left:Screens.width(context) * 0.02,
          // right: Screens.width(context) * 0.02,
          top: Screens.heigth(context) * 0.01,
          bottom: Screens.width(context) * 0.01,
        ),
          child: Column(
            children: [
             Container(
                  padding: EdgeInsets.symmetric(horizontal: Screens.width(context)*0.02 ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   SizedBox(width: Screens.width(context)*0.1,),
                   SizedBox(
                     width: Screens.width(context)*0.35,
                     child: Text('Bob McKensly Mr.Consultant',
                     style: GoogleFonts.poppins(
                        color:Colors.black54,
                        fontSize:  Screens.width(context) * 0.04,
                        fontWeight: FontWeight.bold,),
                     ),
                   ),
                  GestureDetector(
                    onTap: (){
                       showbottomsheet(context);
                    },
                    child: Icon(Icons.add,
                    color: theme.primaryColor,
                    size: Screens.heigth(context)*0.04,),
                  )
                 ],
               ),
             ),
              SizedBox(height: Screens.heigth(context) * 0.01, ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: Screens.width(context)*0.02 ),
                width: Screens.width(context),
                color: Colors.white,
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                       SizedBox(height: Screens.heigth(context) * 0.01, ),
                  GestureDetector(
                              onTap: (){
                               makecall('tel:555-0172');
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mobile',
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
                                          '555-0172',
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
                  GestureDetector(
                              onTap: (){
                               makecall('tel:555-0122');
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Telephone 1',
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
                                          '555-0122',
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
                  GestureDetector(
                              onTap: (){
                             //  Get.toNamed<dynamic>(FurneyRoutes.bpinfo);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Telephone 2',
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
                                          '',
                                          style: GoogleFonts.poppins(
                                              fontSize: Screens.heigth(context) * 0.02,
                                              color: Colors.black,),
                                        ),
                                      ),
                                      // Container(
                                      //   child: Icon(
                                      //     Icons.navigate_next_outlined,
                                      //     color: theme.primaryColor,
                                      //     size: Screens.heigth(context) * 0.06,
                                      //   ),
                                      // )
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
                        //    AppLocalizations.of(context)!.docNo,
                          'Fax',
                            style: GoogleFonts.poppins(
                                fontSize: Screens.heigth(context) * 0.018,
                                color: theme.primaryColor,),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              '555-0121',
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
                            //   Get.toNamed<dynamic>(FurneyRoutes.bpinfo);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'E-Mail',
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
                                          'bob.mKensly@earth.sap.com',
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
                  GestureDetector(
                              onTap: (){
                               Get.back<dynamic>();
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
                                          'EarthShaker Corporation',
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
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> makecall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'exception $url';
    }
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
              Text('Create New Contact',
                 style: GoogleFonts.poppins(
                    color:Colors.black,
                    fontSize: 18,
                   // fontWeight: FontWeight.bold
                  ),),
              const Divider(
                thickness: 1.5,
              ),
               Text('Update Existing Contact',
                 style: GoogleFonts.poppins(
                    color:Colors.black,
                    fontSize: 18,
                 //   fontWeight: FontWeight.bold
                  ),),
                    SizedBox(
                height: Screens.heigth(context) * 0.02,
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