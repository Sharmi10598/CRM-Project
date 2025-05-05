// ignore_for_file: require_trailing_commas, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/salesOrder_details_api.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_oder/sales_orderdetails_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/widget/approval_app_bar.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/HeaderOrder.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/Logistics_order.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/content_order.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/account_quot.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class SalesOrderDetails extends StatefulWidget {
  const SalesOrderDetails({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  SalesOrderDetailsState createState() => SalesOrderDetailsState();
}

class SalesOrderDetailsState extends State<SalesOrderDetails> {
  SalesOrderDetailsValue? valdata;
  @override
  void initState() {
    super.initState();
    SalesOderDetailsAPi.getGlobalData().then((val) {
      if (val.cardCode != null) {
        valdata = val;
        setHeaderValue(valdata!);
      } else if (val.error != null) {
        final snackBar = SnackBar(
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
          content: Text(
            '${val.error}!!..',
            style: const TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  static String? status;
  String? checkvaValueFetched;
  void setHeaderValue(SalesOrderDetailsValue val) {
    setState(() {
      val.CancelStatus;
      checkvaValueFetched = val.DocNum.toString();
      // final totaldiscnt = val.totalDiscount!;
      // final vatsum = val.vatSum!;
      // final totalbeforeDiscount = val.docTotal! - (totaldiscnt + vatsum);

      HeaderOrderstState.docNO = val.DocNum.toString();
      HeaderOrderstState.cusName = val.cardName.toString();
      HeaderOrderstState.currency = val.DocCurrency.toString(); //
      HeaderOrderstState.status = status;
      HeaderOrderstState.documentDate = val.DocDate.toString();
      HeaderOrderstState.documentLines = val.documentLines; //
      HeaderOrderstState.salesEmployee = val.salesPersonCode.toString();
      HeaderOrderstState.customerRefNo = val.numAtCard.toString();
      HeaderOrderstState.postingDate = val.taxDate.toString();
      HeaderOrderstState.validUntill = val.docDueDate.toString();
      HeaderOrderstState.remarks =
          val.comments == 'null' ? '' : val.comments.toString();
      // HeaderOrderstState.totalBeforeDisc =
      //     totalbeforeDiscount.toStringAsFixed(2);
      // HeaderOrderstState.discnt = val.totalDiscount.toString();
      HeaderOrderstState.GP_Approval = val.U_GP_Approval.toString();
      HeaderOrderstState.orderDate = val.U_OrderDate;
      HeaderOrderstState.order_Type = val.U_Order_Type;
      HeaderOrderstState.received_Time = val.U_Received_Time;
      // HeaderDeliveryState.discntpercent = val.documentLines;
      HeaderOrderstState.tax = val.vatSum.toString();
      HeaderOrderstState.total = val.docTotal!.toStringAsFixed(2);

      //cn
      ContentOrderState.documentLines = val.documentLines;
      //log
      LogisticOrderState.addressdata = val.addressExtension;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return checkvaValueFetched == null
        ? Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.grey[200],
            appBar: appBar(context, _scaffoldKey, widget.title),
            drawer:
                // GetValues.userRoll == '3' ? drawer2(context) :
                drawer(context),
            body: Center(
              child: SpinKitThreeBounce(
                size: Screens.heigth(context) * 0.06,
                color: theme.primaryColor,
              ),
            ),
          )
        : DefaultTabController(
            length: 4,
            child: Scaffold(
                key: _scaffoldKey,
                backgroundColor: Colors.grey[200],
                appBar: approvalAppBar(context, _scaffoldKey, widget.title),
                drawer:
                    // GetValues.userRoll == '3'
                    //     ? drawer2(context)
                    // :
                    drawer(context),
                body: Padding(
                  padding: EdgeInsets.only(
                    top: Screens.heigth(context) * 0.01,
                  ), //left: Screens.width(context)*0.02,right: Screens.width(context)*0.02,bottom: Screens.heigth(context)*0.01
                  child: TabBarView(
                      //  physics: const ScrollPhysics(parent: ),
                      children: [
                        HeaderOrders(
                          salValue: valdata,
                        ),
                        const ContentOrder(),
                        const LogisticOrder(),
                        const AccountingQuot()
                      ]),
                )),
          );
  }
}
