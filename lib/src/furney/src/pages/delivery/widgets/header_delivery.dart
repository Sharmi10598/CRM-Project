// ignore_for_file: file_names, noop_primitive_operations, omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/delivery_modal/delivery_details_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';

class HeaderDelivery extends StatefulWidget {
  const HeaderDelivery({Key? key, }) : super(key: key);
  // List<DeliveryDetailsValue> deliveryDetails =[];//required this.deliveryDetails
  @override
  HeaderDeliveryState createState() => HeaderDeliveryState();
}

class HeaderDeliveryState extends State<HeaderDelivery> {
 @override
 void initState(){
   super.initState();
    //  double totaldiscnt = deliveryDetails[0].totalDiscount!.toDouble();
    //  double vatsum = deliveryDetails[0].vatSum !.toDouble();
    // totalBeforeDisc = (deliveryDetails[0].docTotal!-(totaldiscnt+vatsum)).toString();
   
 }

   static String? docNO;
  static String? cusName;
  static String? contactPerson;//no
  static String? currency;
  static String? salesEmployee;//no
  static String? customerRefNo;//no
  static String? status;
  static String? postingDate;//no
  static String? validUntill;//no
  static String? documentDate;
  static String? remarks;//no
static String? totalBeforeDisc;//no
  static String? discnt;//no
  static String? Tax;
  static String? total;
  static List<DocumentDeliveryValue>? documentLines = [];
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
                          AppLocalizations.of(context)!.docNo,
                         // "Doc No.",
                          style:TextStyles.boldPC1(context),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                       //'${deliveryDetails[0].DocNum}',//
                        '$docNO',
                            style:TextStyles.headlineBlack1(context),
                          ),
                        ),
                      ],
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
                                  'Business Partner',
                                  style:TextStyles.boldPC1(context),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: Screens.width(context) * 0.83,
                                      // color: Colors.blue,
                                      child: Text(
                                     // '',// '${deliveryDetails[0].cardName}',// 
                                       '$cusName',
                                        style: TextStyles.headlineBlack1(context),
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
                // GestureDetector(
                //             onTap: (){
                //             Get.toNamed<dynamic>(FurneyRoutes.contactInfo);
                //             },
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   "Contact Person",
                //                   style: GoogleFonts.poppins(
                //                       fontSize: Screens.heigth(context) * 0.018,
                //                       color: theme.primaryColor),
                //                 ),
                //                 Row(
                //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                   children: [
                //                     Container(
                //                       width: Screens.width(context) * 0.83,
                //                       // color: Colors.blue,
                //                       child: Text(
                //                         " ",
                //                         style: GoogleFonts.poppins(
                //                             fontSize: Screens.heigth(context) * 0.02,
                //                             color: Colors.black),
                //                       ),
                //                     ),
                //                     // Container(
                //                     //   child: Icon(
                //                     //     Icons.navigate_next_outlined,
                //                     //     color: theme.primaryColor,
                //                     //     size: Screens.heigth(context) * 0.06,
                //                     //   ),
                //                     // )
                //                   ],
                //                 )
                //               ],
                //             ),
                //           ),
                //      SizedBox(height: Screens.heigth(context) * 0.01, ),
                   Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // AppLocalizations.of(context)!.docNo,
                          'Currency',
                          style: TextStyles.boldPC1(context),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                         // '',//   '${deliveryDetails[0].DocCurrency }',//
                          '$currency',
                            style: TextStyles.headlineBlack1(context),
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
                          'Sales Employee',
                          style: TextStyles.boldPC1(context),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                          // '',// '${deliveryDetails[0].salesPersonCode}',// 
                           '$salesEmployee',
                            style: TextStyles.headlineBlack1(context),
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
                          'Customer Ref.No',
                          style: TextStyles.boldPC1(context),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                        //  '',// '${deliveryDetails[0].numAtCard}',// 
                           '$customerRefNo',
                            style:TextStyles.headlineBlack1(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
         SizedBox(height: Screens.heigth(context) * 0.01, ),
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
                          'Status',
                          style: TextStyles.boldPC1(context),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                          //'',//  '${deliveryDetails[0].DocumentStatus}',// 
                          '$status',
                            style: TextStyles.headlineBlack1(context),
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
                          'Posting Date',
                          style:TextStyles.boldPC1(context),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                         //'',//  '${deliveryDetails[0].taxDate}',// 
                          '$postingDate',
                            style:TextStyles.headlineBlack1(context),
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
                          'Valid until',
                          style:TextStyles.boldPC1(context),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                       // '',//  '${deliveryDetails[0].docDueDate}',//   
                        '$validUntill',
                            style:TextStyles.headlineBlack1(context),
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
                          'Document Date',
                          style: TextStyles.boldPC1(context),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                        // '',//   '${deliveryDetails[0].DocDate}',////
                          '$documentDate',
                            style: TextStyles.headlineBlack1(context),
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
                          style: TextStyles.boldPC1(context),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                     // '',//      deliveryDetails[0].comments==null?'':'${deliveryDetails[0].comments}',//  
                      '$remarks',
                            style: TextStyles.headlineBlack1(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
                 SizedBox(height: Screens.heigth(context) * 0.01, ),
            Container(
              color: Colors.white,
              width: Screens.width(context),
              padding: EdgeInsets.symmetric(horizontal: Screens.width(context)*0.02 ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   SizedBox(height: Screens.heigth(context) * 0.01, ),
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // AppLocalizations.of(context)!.docNo,
                          'Total Before Discount',
                          style: TextStyles.boldPC1(context),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                           //'$totalBeforeDisc',// "$totalBeforeDisc",//11,492.75 \$
                           TextStyles.splitValues('$totalBeforeDisc'),
                            style:TextStyles.headlineBlack1(context),
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
                          'Discount %',
                          style:TextStyles.boldPC1(context),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                         // '${documentLines![0].discountPercent}',
                          TextStyles.splitValues('${documentLines![0].discountPercent}'),      //      '${deliveryDetails[0].totalDiscount}',
                            style: TextStyles.headlineBlack1(context),
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
                          'Discount',
                          style:TextStyles.boldPC1(context),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                        // "$discnt",// '${deliveryDetails[0].totalDiscount}',
                         TextStyles.splitValues('$discnt'),
                            style: TextStyles.headlineBlack1(context),
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
                          'Tax',
                          style: TextStyles.boldPC1(context),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                        //'${documentLines![0].TaxTotal}',                   
                         TextStyles.splitValues('${documentLines![0].TaxTotal}'),                     //   '${deliveryDetails[0].vatSum}',//'${documentLines![0].TaxTotal}',
                            style:TextStyles.headlineBlack1(context),
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
                          'Total',
                          style: TextStyles.boldPC1(context),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                        //   "$total",// '${deliveryDetails[0].docTotal}',
                           TextStyles.splitValues('$total'),
                            style:TextStyles.headlineBlack1(context),
                          ),
                        ),
                      ],
                    ),
                      SizedBox(height: Screens.heigth(context) * 0.01, ),
                      // GestureDetector(
                      //     onTap: (){
                      //             Get.toNamed<dynamic>(FurneyRoutes.attachments);
                      //         },
                      //   child: Center(
                      //     child: Row(
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //       children: [
                      //         SizedBox(width: Screens.width(context)*0.3,),
                      //         Text(
                      //         "Attachments",
                      //         style: GoogleFonts.poppins(
                      //             fontSize: Screens.heigth(context) * 0.02,
                      //             color: Colors.black),
                      //       ),
                      //       SizedBox(width: Screens.width(context)*0.25,),
                      //         Container(
                      //                   child: Icon(
                      //                     Icons.navigate_next_outlined,
                      //                     color: theme.primaryColor,
                      //                     size: Screens.heigth(context) * 0.06,
                      //                   ),
                      //                 )
                      //       ],
                      //     ),
                      //   ),
                      // )
                ],
              ),
            )
            ],
          ),
        ),
     // ),
    );
  }
}
