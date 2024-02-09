// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_quot/salesQuot_details_moda.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';


class LogisticQuot extends StatefulWidget {
  const LogisticQuot({Key? key}) : super(key: key);

  @override
  LogisticQuotState createState() => LogisticQuotState();
}

class LogisticQuotState extends State<LogisticQuot> {
  static AddressExtensionSalesQuot? addressdata;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body:
          // Padding(
          //  padding: EdgeInsets.only(top:Screens.heigth(context)*0.01,),//left: Screens.width(context)*0.01,right: Screens.width(context)*0.01,
          // child:
          SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Screens.width(context) * 0.02,),
              color: Colors.white,
              width: Screens.width(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  GestureDetector(
                    onTap: () {
                      //  Get.toNamed<dynamic>(FurneyRoutes.draftDetails);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bill To',
                          style: TextStyles.boldPC1(context),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: Screens.width(context) * 0.83,
                                  // color: Colors.blue,
                                  child: Text(
                                    '${addressdata!.billToStreet}',
                                    style:TextStyles.headlineBlack1(context),
                                  ),
                                ),
                                     SizedBox(
                                  width: Screens.width(context) * 0.83,
                                  // color: Colors.blue,
                                  child: Text(
                                  '${addressdata!.billToCity} ${addressdata!.billToState}',
                                    style: TextStyles.headlineBlack1(context),
                                  ),
                                ),
                              ],
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
               const Divider(thickness: 1.5,),
                 GestureDetector(
                    onTap: () {
                      //  Get.toNamed<dynamic>(FurneyRoutes.draftDetails);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ship To',
                          style: TextStyles.boldPC1(context),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: Screens.width(context) * 0.83,
                                  // color: Colors.blue,
                                  child: Text(
                                   '${addressdata!.shipToStreet}',
                                    style: TextStyles.headlineBlack1(context),
                                  ),
                                ),
                                     SizedBox(
                                  width: Screens.width(context) * 0.83,
                                  // color: Colors.blue,
                                  child: Text(
                                '${addressdata!.shipToCity} ${addressdata!.shipToState} \n${addressdata!.shipToCountry}',
                                    style:TextStyles.headlineBlack1(context),
                                  ),
                                ),
                              ],
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
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //      "Shipping Type",
                    //       style: GoogleFonts.poppins(
                    //           fontSize: Screens.heigth(context) * 0.018,
                    //           color: theme.primaryColor),
                    //     ),
                    //     Container(
                    //       width: Screens.width(context) * 0.83,
                    //       // color: Colors.blue,
                    //       child: Text(
                    //         "Motor Express",
                    //         style: GoogleFonts.poppins(
                    //             fontSize: Screens.heigth(context) * 0.02,
                    //             color: Colors.black),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                ],
              ),
            ),
            SizedBox(
              height: Screens.heigth(context) * 0.01,
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
