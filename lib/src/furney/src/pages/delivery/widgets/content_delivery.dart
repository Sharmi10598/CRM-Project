// ignore: file_names
// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/delivery_modal/delivery_details_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/delivery/widgets/delivery_items_details.dart';

class ContentDelivery extends StatefulWidget {
  const ContentDelivery({Key? key}) : super(key: key);

  @override
  ContentDeliveryState createState() => ContentDeliveryState();
}

class ContentDeliveryState extends State<ContentDelivery> {
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
        // SingleChildScrollView(
        //   child: 
          Column(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Expanded(
                child:
                ListView.builder(  itemCount: documentLines!.length,//dataSocialMedia.length,
                  itemBuilder: (context, i) {
                    return 
                 Container(
                  padding: EdgeInsets.symmetric(horizontal: Screens.width(context)*0.02 ),
                  color: Colors.white,
                  width: Screens.width(context),
                  child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        SizedBox(height: Screens.heigth(context) * 0.01, ),
                  GestureDetector(
                              onTap: (){
                                DeliveryItemsState.index = i;
                                DeliveryItemsState.documentLines = documentLines;
                              Get.toNamed<dynamic>(FurneyRoutes.deliveryItemsdetails);
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                    SizedBox(
                                          width: Screens.width(context) * 0.6,
                                      //  color: Colors.blue,
                                          child: Text(
                                            '${documentLines![i].ItemDescription}',
                                            style: TextStyles.headlinePC1(context),
                                          ),
                                        ),
                                  SizedBox(width:Screens.width(context)*0.03),
                                           SizedBox(
                                           //  color: Colors.pink,
                                             width:Screens.width(context) * 0.2 ,
                                             child: Text(
                                                    //'${documentLines![i].Quantity}',
                                                    TextStyles.splitValues('${documentLines![i].Quantity}'),
                                                    style:TextStyles.bodytextBlack1(context),
                                                  ),
                                           ),
                                              ],
                                            ),

                                            //
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                             
                                                    SizedBox(
                                          width: Screens.width(context) * 0.6,
                                          // color: Colors.blue,
                                          child: Text(
                                            '${documentLines![i].ItemCode}',
                                            style:TextStyles.bodytextBlack1(context),
                                          ),
                                        ),
                                    SizedBox(width:Screens.width(context)*0.03),
                                           SizedBox(
                                             width:Screens.width(context) * 0.2 ,
                                             child: Text(
                                                   // '${documentLines![i].Price}',
                                                    TextStyles.splitValues('${documentLines![i].Price}'),
                                                    style: TextStyles.bodytextBlack1(context),
                                                  ),
                                           ),
                                              ],
                                            ),
                                          ],
                                        ),
                                              Container(
                                           //     color: Colors.blue,
                                          child: Icon(
                                            Icons.navigate_next_outlined,
                                            color: theme.primaryColor,
                                            size: Screens.heigth(context) * 0.05,
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: Screens.width(context)*0.1),
                                      child: const Divider(thickness: 1.5,),
                                    )
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                );
                   },), ),
      //   SizedBox(height: Screens.heigth(context) * 0.01, ),
            ],
          ),
      //  ),
     // ),
    );
  }
}
