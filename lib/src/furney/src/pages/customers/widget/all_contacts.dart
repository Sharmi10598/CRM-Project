import 'package:flutter/material.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/customer_bp/new_customer_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class AllContact extends StatefulWidget {
  const AllContact({ required this.title, Key? key }) : super(key: key);
  final String title;
  @override
  AllContactState createState() => AllContactState();
}

class AllContactState extends State<AllContact> {
  static CustomerDetailsValue? customerDetailsValue;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      key:_scaffoldKey ,
      appBar: appBar(context, _scaffoldKey, widget.title),
      drawer: drawer(context),
      body: SafeArea(
        child: Container(
           width: Screens.width(context),
         height: Screens.heigth(context),
          color: Colors.grey[300],
          padding: EdgeInsets.symmetric(horizontal:Screens.width(context)*0.02,
           vertical: Screens.heigth(context)*0.02,),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 
                  customerDetailsValue!.contactEmployees!.length,
                  itemBuilder: (context , i){
                  return Card(
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
                                    style: TextStyles.boldPC1(context),),
                                  ),
                                 // SizedBox(width: Screens.width(context)*0.025,),
                                  SizedBox(
                                 //   color: Colors.amber,
                                     width: Screens.width(context)*0.02,
                                    child: Text(':',
                                style:TextStyles.boldPC1(context),),
                                  ),

                                   SizedBox(
                                 //     color: Colors.indigo,
                             width: Screens.width(context)*0.57,
                                     child: Text(
                                       '${customerDetailsValue!.contactEmployees![i].name}',
                                     style: TextStyles.headlineBlack1(context),
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
                                    style:TextStyles.boldPC1(context),),
                                  ),
                                 // SizedBox(width: Screens.width(context)*0.025,),
                                  SizedBox(
                                //    color: Colors.amber,
                                     width: Screens.width(context)*0.02,
                                    child: Text(':',
                                style: TextStyles.boldPC1(context),),
                                  ),

                                   SizedBox(
                                 //     color: Colors.indigo,
                             width: Screens.width(context)*0.57,
                                     child: Text(
                                      '${customerDetailsValue!.contactEmployees![i].cardCode}',
                                     style:TextStyles.headlineBlack1(context),
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
                                    style: TextStyles.boldPC1(context),),
                                  ),
                                 // SizedBox(width: Screens.width(context)*0.025,),
                                  SizedBox(
                                 //   color: Colors.amber,
                                     width: Screens.width(context)*0.02,
                                    child: Text(':',
                                style: TextStyles.boldPC1(context),),
                                  ),

                                   SizedBox(
                                //      color: Colors.indigo,
                             width: Screens.width(context)*0.57,
                                     child: Text(
                                      '${customerDetailsValue!.contactEmployees![i].phone1}',
                                     style: TextStyles.headlineBlack1(context),
                                     ),
                                   ),
                                ],
                              ),
                            ),
                         
                         ],
                       ),
                    ),
                  );
                },),
              ),
            ],
          ),
        ),
      ),
    );
  }
}