// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';

class ListOfOpportunities extends StatelessWidget {
  const ListOfOpportunities({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return Expanded(
      child: ListView.builder(
        itemCount: 25,
        itemBuilder: (BuildContext context, int i) {
        return Card(
          child: InkWell(
            onTap: (){
             // print("object");
              Get.toNamed<dynamic>(FurneyRoutes.opportunitiesInfo);
            },
            child: Container(
                height: Screens.heigth(context)*0.08,
                width: Screens.width(context),
                decoration: BoxDecoration(
                    // color:Colors.green,
                   // borderRadius: BorderRadius.circular(Const.radius),
                   border: Border.all(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(//row 1
                        children: [
                          Container(
                            width: 10,
                            height: double.infinity,
                            color: Colors.red,
                          ),
                          SizedBox(width: Screens.width(context)*0.01,),
                          SizedBox(
                            width: Screens.width(context)*0.65,
                           // color: Colors.grey,
                            child: Text('Opportunity with Earthshaker Cor..',
                            style: theme.textTheme.bodyLarge,),
                          ),
                          // Text("MAxi-Taxi",
                          // style: theme.textTheme.bodyText1,)
                        ],
                      ),
          
                      Padding(
                        padding:  EdgeInsets.only(top:Screens.width(context)*0.02),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: Screens.width(context)*0.1,
                                  //color: Colors.red,
                                  child: Text('Lost', style:GoogleFonts.poppins(
                                        fontSize: Screens.heigth(context) * 0.02,
                                        color: Colors.grey,),),
                                ),
                                SizedBox(
                                   width: Screens.width(context)*0.2,
                                  child: Text('2021-07-21' ,style:GoogleFonts.poppins(
                                        fontSize: Screens.heigth(context) * 0.015,
                                        color: Colors.grey,),),),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
            ),
          ),
        );
        },
      ),
    );
  }
}