// ignore_for_file: require_trailing_commas, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_quotations_api/salesQuot_details_api.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_quot/salesQuot_details_moda.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/widget/approval_app_bar.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/account_quot.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/content_quot.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/header_qut.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/logistic_quot.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class SalesQtDetails extends StatefulWidget {
  const SalesQtDetails({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  SalesQtDetailsState createState() => SalesQtDetailsState();
}

class SalesQtDetailsState extends State<SalesQtDetails> {
  @override
  void initState() {
    super.initState();
    SalesOuotDetailsAPi.getGlobalData().then((val) {
      if (val.cardCode != null) {
        print('cardName ${val.cardName}');
        setHeaderValue(val);
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
  void setHeaderValue(SalesQuotDetailsValue val) {
    setState(() {
      checkvaValueFetched = val.DocNum.toString();
      final totaldiscnt = val.totalDiscount!;
      final vatsum = val.vatSum!;
      HeaderQuotState.docNO = val.DocNum.toString();
      HeaderQuotState.cusName = val.cardName.toString();
      HeaderQuotState.currency = val.DocCurrency.toString(); //
      HeaderQuotState.status = status;
      HeaderQuotState.documentDate = val.DocDate.toString();
      HeaderQuotState.documentLines = val.documentLines; //
      HeaderQuotState.salesEmployee = val.salesPersonCode.toString();
      HeaderQuotState.customerRefNo = val.numAtCard.toString();
      HeaderQuotState.postingDate = val.taxDate.toString();
      HeaderQuotState.validUntill = val.docDueDate.toString();
      HeaderQuotState.remarks =
          val.comments == 'null' ? '' : val.comments.toString();
      HeaderQuotState.totalBeforeDisc =
          (val.docTotal! - (totaldiscnt + vatsum)).toString();
      HeaderQuotState.discnt = val.totalDiscount.toString();
      // HeaderDeliveryState.discntpercent = val.documentLines;
      HeaderQuotState.Tax = val.vatSum.toString();
      HeaderQuotState.total = val.docTotal.toString();
      //cn
      ContentQuotState.documentLines = val.documentLines;
      //log
      LogisticQuotState.addressdata = val.addressExtension;
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
            drawer: drawer(context),
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
                drawer: drawer(context),
                body: Padding(
                  padding: EdgeInsets.only(
                    top: Screens.heigth(context) * 0.01,
                  ), //left: Screens.width(context)*0.02,right: Screens.width(context)*0.02,bottom: Screens.heigth(context)*0.01
                  child: TabBarView(
                      //  physics: const ScrollPhysics(parent: ),
                      children: [
                        const HeaderQuot(),
                        const ContentQuot(),
                        const LogisticQuot(),
                        const AccountingQuot()
                      ]),
                )),
          );
  }
}
