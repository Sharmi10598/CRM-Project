// ignore_for_file: require_trailing_commas, prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names, avoid_print, prefer_single_quotes, prefer_interpolation_to_compose_strings, noop_primitive_operations, omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/delivery_api/delivery_details_api.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/delivery_modal/delivery_details_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/delivery/widgets/content_delivery.dart';
import 'package:ultimate_bundle/src/furney/src/pages/delivery/widgets/delivery_appbar.dart';
import 'package:ultimate_bundle/src/furney/src/pages/delivery/widgets/header_delivery.dart';
import 'package:ultimate_bundle/src/furney/src/pages/delivery/widgets/logistics_delivery.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class DeliveryDetails extends StatefulWidget {
  const DeliveryDetails({ required this.title, Key? key }) : super(key: key);
   final String title;
  @override
  DeliveryDetailsState createState() => DeliveryDetailsState();
}

class DeliveryDetailsState extends State<DeliveryDetails> {
  
   @override
   void initState() {
    super.initState();
    DeliveryDetailsAPi.getGlobalData().then((val) {
      if(val.cardCode !=null){
          print("cardName "+val.cardName.toString());
       setHeaderValue( val);
      }else if(val.error != null){
        final snackBar = SnackBar(
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
          content: Text(
            "${val.error}!!..",
            style: const TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
       
    });
    
  }
String? checkvaValueFetched;
  void setHeaderValue(DeliveryDetailsValue val){
   setState(() {
     checkvaValueFetched =  val.DocNum .toString();
      final double totaldiscnt = val.totalDiscount!.toDouble();
                            final double vatsum = val.vatSum !.toDouble();
                           HeaderDeliveryState.docNO = val.DocNum .toString();  
                           HeaderDeliveryState.cusName =  val.cardName. toString();
                           HeaderDeliveryState.currency =  val.DocCurrency.toString();//
                          HeaderDeliveryState.status = val.DocumentStatus=='bost_Open'?'Open':''.toString();
                          HeaderDeliveryState.documentDate =  val.DocDate.toString();
                           HeaderDeliveryState.documentLines =  val.documentLines;//
                            HeaderDeliveryState.salesEmployee =val.salesPersonCode.toString();
                            HeaderDeliveryState.customerRefNo = val.numAtCard.toString();
                            HeaderDeliveryState.postingDate = val.taxDate.toString();
                            HeaderDeliveryState.validUntill = val.docDueDate .toString();
                            HeaderDeliveryState.remarks = val.comments=='null'?'': val.comments.toString();
                            HeaderDeliveryState.totalBeforeDisc = (val.docTotal!-(totaldiscnt+vatsum)).toString();
                            HeaderDeliveryState.discnt = val.totalDiscount .toString();
                            // HeaderDeliveryState.discntpercent = val.documentLines;
                            HeaderDeliveryState.Tax = val.vatSum .toString();
                            HeaderDeliveryState.total = val.docTotal.toString();
            //cn
             ContentDeliveryState.documentLines =val.documentLines;
             //log
              LogisticDeliveryState.addressdata = val.addressExtension;
   });
   
   }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return checkvaValueFetched == null?Scaffold(
        key:_scaffoldKey ,
        backgroundColor: Colors.grey[200],
        appBar: appBar(context,_scaffoldKey,widget.title),
        drawer: drawer(context),
      body: Center(
              child:  SpinKitThreeBounce(
                            size: Screens.heigth(context)*0.06,
                            color:theme.primaryColor,
                          ),
            ),
    )
    :    
    DefaultTabController(
      length: 3,
      child: Scaffold(
        key:_scaffoldKey ,
        backgroundColor: Colors.grey[200],
        appBar: deliveryAppBar(context,_scaffoldKey,widget.title),
        drawer: drawer(context),
        body:Padding(
          padding: EdgeInsets.only(top:Screens.heigth(context)*0.01,),//left: Screens.width(context)*0.02,right: Screens.width(context)*0.02,bottom: Screens.heigth(context)*0.01
          child: TabBarView(
          //  physics: const ScrollPhysics(parent: ),
            children: [
           const HeaderDelivery(),
           const ContentDelivery(),
           const LogisticDelivery(),
            //const LogisticDelivery(),
          ]),
        )
      ),
    );
  }
}