// ignore_for_file: prefer_single_quotes

import 'package:flutter/material.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  TransactionsState createState() => TransactionsState();
}

class TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return  SingleChildScrollView(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
               Container(
                 padding: EdgeInsets.symmetric(horizontal: Screens.width(context)*0.02 ),
      width: Screens.width(context),
    //  height: Screens.heigth(context) * 0.3,
      color: Colors.white,
                 child: Column(
                 children: [
                   SizedBox(height: Screens.heigth(context) * 0.01, ),
                         GestureDetector(
                           onTap: (){
                              //Get.toNamed<dynamic>(FurneyRoutes.activities);
                           },
                           child: Container(
                             color: Colors.transparent,
                             child: Center(
                             child:Row(
                             // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: Screens.width(context)*0.2,),
                                SizedBox(
                                 width: Screens.width(context)*0.3,
                                  child: Text(
                                  "Activities",
                                  style: TextStyles.boldPC1(context),
                              ),
                                ),
                              SizedBox(width: Screens.width(context)*0.2,),
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
                           ),
                         ),
               //  SizedBox(height: Screens.heigth(context) * 0.01, ),
                        //  GestureDetector(
                        //    onTap: (){
                        //       Get.toNamed<dynamic>(FurneyRoutes.specialPrices);
                        //    },
                        //    child: Container(
                        //      width: Screens.width(context),
                        //      color: Colors.transparent,
                        //      child: Center(
                        //        child:Row(
                        //      // crossAxisAlignment: CrossAxisAlignment.center,
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         SizedBox(width: Screens.width(context)*0.2,),
                        //         Container(
                        //          width: Screens.width(context)*0.3,
                        //           child: Text(
                        //           "Special Prices",
                        //           style: GoogleFonts.poppins(
                        //               fontSize: Screens.heigth(context) * 0.02,
                        //               color: Colors.black),
                        //       ),
                        //         ),
                        //       SizedBox(width: Screens.width(context)*0.2,),
                        //         Container(
                        //                   child: Icon(
                        //                     Icons.navigate_next_outlined,
                        //                     color: theme.primaryColor,
                        //                     size: Screens.heigth(context) * 0.06,
                        //                   ),
                        //                 )
                        //       ],
                        //                          ),
                        //                        ),
                        //    ),
                        //  ),
    //  SizedBox(height: Screens.heigth(context) * 0.01, ),
    //                      GestureDetector(
    //                        onTap: (){
    //                           Get.toNamed<dynamic>(FurneyRoutes.opportunities);
    //                        },
    //                        child: Container(
    //                          color: Colors.transparent,
    //                          child: Center(
    //                                              child: Row(
    //                          // crossAxisAlignment: CrossAxisAlignment.center,
    //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                           children: [
    //                             SizedBox(width: Screens.width(context)*0.2,),
    //                             Container(
    //                              width: Screens.width(context)*0.3,
    //                               child: Text(
    //                               "Opportunities",
    //                               style: GoogleFonts.poppins(
    //                                   fontSize: Screens.heigth(context) * 0.02,
    //                                   color: Colors.black),
    //                           ),
    //                             ),
    //                           SizedBox(width: Screens.width(context)*0.2,),
    //                             Container(
    //                                       child: Icon(
    //                                         Icons.navigate_next_outlined,
    //                                         color: theme.primaryColor,
    //                                         size: Screens.heigth(context) * 0.06,
    //                                       ),
    //                                     )
    //                           ],
    //                                              ),
    //                                            ),
    //                        ),
    //                      ),
       SizedBox(height: Screens.heigth(context) * 0.01, ),
                         Center(
                        child: Row(
                         // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: Screens.width(context)*0.2,),
                            SizedBox(
                             width: Screens.width(context)*0.3,
                              child: Text(
                              "Sales Quotations",
                              style:TextStyles.boldPC1(context),
                          ),
                            ),
                          SizedBox(width: Screens.width(context)*0.2,),
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
                       SizedBox(height: Screens.heigth(context) * 0.01, ),
                         Center(
                        child: Row(
                         // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: Screens.width(context)*0.2,),
                            SizedBox(
                             width: Screens.width(context)*0.3,
                              child: Text(
                              "Sales Orders",
                              style:TextStyles.boldPC1(context),
                          ),
                            ),
                          SizedBox(width: Screens.width(context)*0.2,),
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

          SizedBox(height: Screens.heigth(context) * 0.01, ),
                         Center(
                        child: Row(
                         // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: Screens.width(context)*0.2,),
                            SizedBox(
                             width: Screens.width(context)*0.3,
                              child: Text(
                              "Deliveries",
                              style: TextStyles.boldPC1(context),
                          ),
                            ),
                          SizedBox(width: Screens.width(context)*0.2,),
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
        //     SizedBox(height: Screens.heigth(context) * 0.01, ),
        //                  Center(
        //                 child: Row(
        //                  // crossAxisAlignment: CrossAxisAlignment.center,
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     SizedBox(width: Screens.width(context)*0.2,),
        //                     Container(
        //                      width: Screens.width(context)*0.3,
        //                       child: Text(
        //                       "Service Contract",
        //                       style: GoogleFonts.poppins(
        //                           fontSize: Screens.heigth(context) * 0.02,
        //                           color: Colors.black),
        //                   ),
        //                     ),
        //                   SizedBox(width: Screens.width(context)*0.2,),
        //                     Container(
        //                               child: Icon(
        //                                 Icons.navigate_next_outlined,
        //                                 color: theme.primaryColor,
        //                                 size: Screens.heigth(context) * 0.06,
        //                               ),
        //                             )
        //                   ],
        //                 ),
        //               ),
        // SizedBox(height: Screens.heigth(context) * 0.01, ),
        //                  Center(
        //                 child: Row(
        //                  // crossAxisAlignment: CrossAxisAlignment.center,
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     SizedBox(width: Screens.width(context)*0.2,),
        //                     Container(
        //                      width: Screens.width(context)*0.3,
        //                       child: Text(
        //                       "Service Call",
        //                       style: GoogleFonts.poppins(
        //                           fontSize: Screens.heigth(context) * 0.02,
        //                           color: Colors.black),
        //                   ),
        //                     ),
        //                   SizedBox(width: Screens.width(context)*0.2,),
        //                     Container(
        //                               child: Icon(
        //                                 Icons.navigate_next_outlined,
        //                                 color: theme.primaryColor,
        //                                 size: Screens.heigth(context) * 0.06,
        //                               ),
        //                             )
        //                   ],
        //                 ),
        //               ),
                 ],
               ),),

          ],
        ),
    
    );
  }
}
