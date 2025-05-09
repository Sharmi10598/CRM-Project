// ignore: file_names
// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_oder/sales_orderdetails_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/order_items_details.dart';

class ContentOrder extends StatefulWidget {
  const ContentOrder({Key? key}) : super(key: key);

  @override
  ContentOrderState createState() => ContentOrderState();
}

class ContentOrderState extends State<ContentOrder> {
  static List<DocumentSalesOrdeValue>? documentLines = [];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body:
          // Padding(
          //  padding: EdgeInsets.only(top:Screens.heigth(context)*0.01,),//left: Screens.width(context)*0.01,right: Screens.width(context)*0.01,
          // child:
          // SingleChildScrollView(
          //   child:
          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: documentLines!.length, //dataSocialMedia.length,
              itemBuilder: (context, i) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Screens.width(context) * 0.02,
                  ),
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
                          SalesOrderItemsState.index = i;
                          SalesOrderItemsState.documentLines = documentLines;
                          log('documentLinesdiscountper::${documentLines![0].discountPercent}');

                          Get.toNamed<dynamic>(FurneyRoutes.salesOrderItems);
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: Screens.width(context) * 0.6,
                                            //  color: Colors.blue,
                                            child: Text(
                                              '${documentLines![i].ItemDescription}',
                                              style: TextStyles.bodytextBlack1(
                                                context,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                Screens.width(context) * 0.03,
                                          ),
                                          SizedBox(
                                            //  color: Colors.pink,
                                            width: Screens.width(context) * 0.2,
                                            child: Text(
                                              '${documentLines![i].Quantity}',
                                              style: TextStyles.bodytextBlack2(
                                                context,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      //
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: Screens.width(context) * 0.6,
                                            // color: Colors.blue,
                                            child: Text(
                                              '${documentLines![i].ItemCode}',
                                              style: TextStyles.bodytextBlack2(
                                                context,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                Screens.width(context) * 0.03,
                                          ),
                                          SizedBox(
                                            width: Screens.width(context) * 0.2,
                                            child: Text(
                                              //  '${documentLines![i].Price}',
                                              TextStyles.splitValues(
                                                '${documentLines![i].UnitPrice}',
                                              ),
                                              style: TextStyles.bodytextBlack2(
                                                context,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.navigate_next_outlined,
                                    color: theme.primaryColor,
                                    size: Screens.heigth(context) * 0.05,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Screens.width(context) * 0.1,
                                ),
                                child: const Divider(
                                  thickness: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          //   SizedBox(height: Screens.heigth(context) * 0.01, ),
        ],
      ),
      //  ),
      // ),
    );
  }
}
