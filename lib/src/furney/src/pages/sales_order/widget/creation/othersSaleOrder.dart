// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/post_order_api/post_sales_order_api.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/screens/create_order.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/creation/content_order_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/creation/header_order_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sign_in/widgets/custom_elevatedBtn.dart';

class OthersOrder extends StatefulWidget {
  const OthersOrder({Key? key}) : super(key: key);
  @override
  OthersOrderState createState() => OthersOrderState();
}

class OthersOrderState extends State<OthersOrder> {
 static String billto='';
 static String shipto='';
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body:
          // Padding(
          //  padding: EdgeInsets.only(top:Screens.heigth(context)*0.01,),//left: Screens.width(context)*0.01,right: Screens.width(context)*0.01,
          // child:
          Stack(
            children: [
              SingleChildScrollView(
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Screens.width(context) * 0.02,),
                  color: Colors.white,
                  width: Screens.width(context),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
                SizedBox(
                  height: Screens.heigth(context) * 0.01,
                ),
              ],
        ),
      ),

         Align(
             alignment: Alignment.bottomCenter,
             child:  CustomSpinkitdButton(
              onTap: () async {
               validateAndCallApi();
                //callServiceLayerApi();
              },
              isLoading: isLoading,
            //  labelLoading: AppLocalizations.of(context)!.signing,
              label: 'Save',
            ),
           )
            ],
          ),
      // ),
    );
  }
bool isLoading = false;
    void validateAndCallApi(){
                    if (HeaderOrderCreationState.bpCode == '') {
                    const snackBar = SnackBar(
                      duration: Duration(seconds: 5),
                      backgroundColor: Colors.red,
                      content: Text(
                        'Please Choose Business Partner!!...',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (ContentOrderCreationState. itemsDetails.isEmpty) {
                    const snackBar = SnackBar(
                      duration: Duration(seconds: 5),
                      backgroundColor: Colors.red,
                      content: Text(
                        'Please Add Items!!...',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                   else{
                     setState(()=> isLoading = true);
          SalesOrderPostAPi.cardCodePost = HeaderOrderCreationState.bpCode;
          SalesOrderPostAPi.docLineQout =   ContentOrderCreationState. itemsDetails;   
           SalesOrderPostAPi.docDate =  HeaderOrderCreationState.currentDateTime.toString();
          SalesOrderPostAPi.dueDate = HeaderOrderCreationState.currentDateTime.toString();
          SalesOrderPostAPi.remarks =  HeaderOrderCreationState.mycontroller[1].text;
               SalesOrderPostAPi.getGlobalData(CreateOrderDetailsState.latitude!,CreateOrderDetailsState.longitude!).then((value) {
                 if(value.statusCode=='201' ||value.statusCode=='204'  ){

                   setState(()=> isLoading = false);
                     const snackBar = SnackBar(
                      duration: Duration(seconds: 5),
                      backgroundColor: Colors.green,
                      content: Text(
                        'Orders Created Successfully!!...',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                   // nullallValues();
                     Get.offAllNamed<dynamic>(FurneyRoutes.salesorder);
                 }
                 else{
                    setState(()=> isLoading = false);
                     final snackBar = SnackBar(
                      duration: const Duration(seconds: 5),
                      backgroundColor: Colors.red,
                      content: Text(
                        '${value.error!.message!.value}!!..',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                 }
               });
    }
  }
  
}
