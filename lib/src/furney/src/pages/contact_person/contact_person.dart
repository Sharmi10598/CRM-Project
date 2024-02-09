// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/contact_person_api/contact_person_api.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/contact_person_modal/contact_person_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/widget/logistic_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/creation/header_creation.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class ContactPerson extends StatefulWidget {
  const ContactPerson({ required this.title, Key? key }) : super(key: key);
  final String title;
  @override
  ContactPersonState createState() => ContactPersonState();
}

class ContactPersonState extends State<ContactPerson> {
   List<ContactEmployeValue> contactValue=[];
   List<ContactEmployeValue> filtercontactValue=[];
    @override
  void initState() {
     ContactPersonsAPi.getGlobalData().then((value){
       if(value.deliveryModaleValue!.length>0){
         setState(() {
           contactValue = value.deliveryModaleValue!;
         filtercontactValue =contactValue;
         LogisticPageState.shipto = value.ShipToDefault.toString(); 
         LogisticPageState.billto = value.BilltoDefault.toString();
         });
       }
     });
  }
  static int pageChanged2=1;
  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return Scaffold(
      appBar: appBar(context, _scaffoldKey, widget.title),
      body:contactValue.isEmpty? Center(
              child:  SpinKitThreeBounce(
                            size: Screens.heigth(context)*0.06,
                            color:theme.primaryColor,
                          ),
            ): SafeArea(
              child: Column(
        children: [
                Stack(children: [
                    Container(
                      height: Screens.heigth(context) * 0.06,
                      decoration: BoxDecoration(
                        color: theme.hintColor.withOpacity(.05),
                        borderRadius: BorderRadius.circular(Const.radius),
                      ),
                      child: TextField(
                      //  controller: mycontroller[0],
                        autocorrect: false,
                        style: theme.textTheme.bodyMedium,
                        onChanged: (v) {
                          setState(() {
                            filtercontactValue = contactValue
                                .where((e) =>
                                    e
                                        .name!
                                        .toLowerCase()
                                        .contains(v.toLowerCase()) ||
                                    e
                                        .Cardcode!
                                        .toLowerCase()
                                        .contains(v.toLowerCase()),)
                                .toList();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search for contact person',
                          // AppLocalizations.of(context)!
                          //     .search_sales_quot,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              // SalesQuotAPi.searchValue = mycontroller[0].text;
                              setState(() {
                                // quotData.clear();
                                // quotDataFilter.clear();
                              });

                              // SalesQuotAPi.searchData().then((value) {
                              //       if(value.salesQuotValue!=null){
                              //         setState(() {
                              //           print(value.salesQuotValue![0].docEntry);
                              //           // quotData = value.salesQuotValue!;
                              //           // quotDataFilter =quotData;
                              //         });
                              //       }
                              // });
                            }, //
                            color: theme.primaryColor,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 5,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        left: Screens.width(context) * 0.8,
                        child: IconButton(
                            onPressed: () {
                           Get.back<dynamic>();
                    
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: theme.primaryColor,
                              size: Screens.width(context) * 0.08,
                            ),),)
                  ],),
       Expanded(
                  child: ListView.builder(
                    itemCount: 
                    filtercontactValue.length,
                    itemBuilder: (context , i){
                    return InkWell(
                      onTap: (){
                        HeaderCreationState.contactPerson = filtercontactValue[i].name.toString();  
                      },
                      child: Card(
                        child: Container(
                          width: Screens.width(context),
                         // height: Screens.heigth(context),
                         // color: Colors.grey[300],
                          padding: EdgeInsets.symmetric(horizontal:Screens.width(context)*0.02,
                          vertical: Screens.heigth(context)*0.02,
                           ),
                           child: Column(
                             children: [
                                SizedBox(
                                 // color: Colors.indigo,
                                 width: Screens.width(context),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                     //   color: Colors.indigo,
                                 width: Screens.width(context)*0.17,
                                        child: Text('Name',
                                        style: GoogleFonts.poppins(
                                        fontSize: Screens.heigth(context) * 0.018,
                                        color: theme.primaryColor,
                                         fontWeight: FontWeight.bold,),),
                                      ),
                                     // SizedBox(width: Screens.width(context)*0.025,),
                                      SizedBox(
                                     //   color: Colors.amber,
                                         width: Screens.width(context)*0.02,
                                        child: Text(':',
                                    style: GoogleFonts.poppins(
                                        fontSize: Screens.heigth(context) * 0.018,
                                        color: theme.primaryColor,
                                         fontWeight: FontWeight.bold,),),
                                      ),

                                       SizedBox(
                                     //     color: Colors.indigo,
                                 width: Screens.width(context)*0.57,
                                         child: Text(
                                           '${filtercontactValue[i].name}',
                                         style: GoogleFonts.poppins(
                                      fontSize: Screens.heigth(context) * 0.018,
                                      color:  Colors.black,),
                                         ),
                                       ),
                                    ],
                                  ),
                                ),
                              SizedBox(
                                 // color: Colors.indigo,
                                 width: Screens.width(context),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                    //    color: Colors.indigo,
                                 width: Screens.width(context)*0.17,
                                        child: Text('Code',
                                        style: GoogleFonts.poppins(
                                        fontSize: Screens.heigth(context) * 0.018,
                                        color: theme.primaryColor,
                                         fontWeight: FontWeight.bold,),),
                                      ),
                                     // SizedBox(width: Screens.width(context)*0.025,),
                                      SizedBox(
                                    //    color: Colors.amber,
                                         width: Screens.width(context)*0.02,
                                        child: Text(':',
                                    style: GoogleFonts.poppins(
                                        fontSize: Screens.heigth(context) * 0.018,
                                        color: theme.primaryColor,
                                         fontWeight: FontWeight.bold,),),
                                      ),

                                       SizedBox(
                                     //     color: Colors.indigo,
                                 width: Screens.width(context)*0.57,
                                         child: Text(
                                          '${filtercontactValue[i].Cardcode}',
                                         style: GoogleFonts.poppins(
                                      fontSize: Screens.heigth(context) * 0.018,
                                      color:  Colors.black,),
                                         ),
                                       ),
                                    ],
                                  ),
                                ),
                               SizedBox(
                                 // color: Colors.indigo,
                                 width: Screens.width(context),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                    //    color: Colors.indigo,
                                 width: Screens.width(context)*0.17,
                                        child: Text('Phone',
                                        style: GoogleFonts.poppins(
                                        fontSize: Screens.heigth(context) * 0.018,
                                        color: theme.primaryColor,
                                         fontWeight: FontWeight.bold,),),
                                      ),
                                     // SizedBox(width: Screens.width(context)*0.025,),
                                      SizedBox(
                                     //   color: Colors.amber,
                                         width: Screens.width(context)*0.02,
                                        child: Text(':',
                                    style: GoogleFonts.poppins(
                                        fontSize: Screens.heigth(context) * 0.018,
                                        color: theme.primaryColor,
                                         fontWeight: FontWeight.bold,),),
                                      ),

                                       SizedBox(
                                    //      color: Colors.indigo,
                                 width: Screens.width(context)*0.57,
                                         child: Text(
                                          '${filtercontactValue[i].phone}',
                                         style: GoogleFonts.poppins(
                                      fontSize: Screens.heigth(context) * 0.018,
                                      color:  Colors.black,),
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
                  },),
                ),
        ],
      ),
            ),
    );
  }
}//LogisticPageState