// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/approvals_modal/approvals_details.modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  DetailsPageState createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  static int index = 0;
  static List<DocumentApprovalValue> documentApprovalValue = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: _scaffoldKey,
      drawer: drawer(context),
      appBar: appBar(context, _scaffoldKey, widget.title),
      body:
          // Padding(
          //  padding: EdgeInsets.only(top:Screens.heigth(context)*0.01,),//left: Screens.width(context)*0.01,right: Screens.width(context)*0.01,
          // child:
          SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            // left:Screens.width(context) * 0.02,
            // right: Screens.width(context) * 0.02,
            top: Screens.heigth(context) * 0.01,
            bottom: Screens.width(context) * 0.01,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Screens.width(context) * 0.02),
                color: Colors.white,
                width: Screens.width(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Screens.heigth(context) * 0.01,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // AppLocalizations.of(context)!.docNo,
                          'Items',
                          style: TextStyles.boldPC1(context),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                            '${documentApprovalValue[index].itemDescription}',
                            style: TextStyles.headlineBlack1(context),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Screens.heigth(context) * 0.01,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // AppLocalizations.of(context)!.docNo,
                          'Warehouse',
                          style: TextStyles.boldPC1(context),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                            '${documentApprovalValue[index].warehouseCode}',
                            style: TextStyles.headlineBlack1(context),
                          ),
                        ),
                      ],
                    ),
                    //  SizedBox(height: Screens.heigth(context) * 0.01, ),
                    //             Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Text(
                    //                   // AppLocalizations.of(context)!.docNo,
                    //                  "Delivery Date",
                    //                   style: GoogleFonts.poppins(
                    //                       fontSize: Screens.heigth(context) * 0.018,
                    //                       color: theme.primaryColor),
                    //                 ),
                    //                 Container(
                    //                   width: Screens.width(context) * 0.83,
                    //                   // color: Colors.blue,
                    //                   child: Text(
                    //                      '${documentApprovalValue[index].d}',
                    //                     style: GoogleFonts.poppins(
                    //                         fontSize: Screens.heigth(context) * 0.02,
                    //                         color: Colors.black),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    SizedBox(
                      height: Screens.heigth(context) * 0.01,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // AppLocalizations.of(context)!.docNo,
                          'Quantity',
                          style: TextStyles.boldPC1(context),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                            //   '${documentApprovalValue[index].Quantity}',
                            TextStyles.splitValues(
                                '${documentApprovalValue[index].quantity}'),
                            style: TextStyles.headlineBlack1(context),
                            //hintStyle: TextStyles.bodytextBlack1(context),
                          ),
                        ),
                      ],
                    ),
                    //  SizedBox(height: Screens.heigth(context) * 0.01, ),
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Text(
                    //                 // AppLocalizations.of(context)!.docNo,
                    //                "Items Per Unit",
                    //                 style: GoogleFonts.poppins(
                    //                     fontSize: Screens.heigth(context) * 0.018,
                    //                     color: theme.primaryColor),
                    //               ),
                    //               Container(
                    //                 width: Screens.width(context) * 0.83,
                    //                 // color: Colors.blue,
                    //                 child: Text(
                    //                   "1",
                    //                   style: GoogleFonts.poppins(
                    //                       fontSize: Screens.heigth(context) * 0.02,
                    //                       color: Colors.black),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),

                    SizedBox(
                      height: Screens.heigth(context) * 0.01,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // AppLocalizations.of(context)!.docNo,
                          'Unit Price',
                          style: TextStyles.boldPC1(context),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                            //'${documentApprovalValue[index].Price}',
                            TextStyles.splitValues(
                                '${documentApprovalValue[index].unitPrice}'),
                            // TextStyles.splitValues('${documentApprovalValue[index].price}'),
                            style: TextStyles.headlineBlack1(context),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Screens.heigth(context) * 0.01,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // AppLocalizations.of(context)!.docNo,
                          'Value before tax',
                          style: TextStyles.boldPC1(context),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                            // '${documentApprovalValue[index].LineTotal}',
                            TextStyles.splitValues(
                                '${documentApprovalValue[index].lineTotal}'),
                            style: TextStyles.headlineBlack1(context),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Screens.heigth(context) * 0.01,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // AppLocalizations.of(context)!.docNo,
                          'Tax total',
                          style: TextStyles.boldPC1(context),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                            //'${documentApprovalValue[index].TaxTotal}',
                            TextStyles.splitValues(
                                '${documentApprovalValue[index].taxTotal}'),
                            style: TextStyles.headlineBlack1(context),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Screens.heigth(context) * 0.01,
                    ),
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
                            //'${documentApprovalValue[index].total}',
                            TextStyles.splitValues(
                                '${documentApprovalValue[index].lineTotal! + documentApprovalValue[index].taxTotal!}'),
                            style: TextStyles.headlineBlack1(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
