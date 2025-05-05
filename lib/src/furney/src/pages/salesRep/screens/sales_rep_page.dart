import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/salesRep_Api/sales_rep_api.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/sales_rep_modal/sales_rep_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class SalesRep extends StatefulWidget {
  const SalesRep({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  SalesRepState createState() => SalesRepState();
}

class SalesRepState extends State<SalesRep> {
  List<SalesRepData> salesRepData = [];
  List<SalesRepData> salesRepDataFilter = [];
  @override
  void initState() {
    super.initState();
    SalesRepAPi.getGlobalData().then((val) {
      if (val.salesrepData != null) {
        // print("quantityOnStock: "+val.value![0].quantityOnStock.toString());
        salesRepData = val.salesrepData!;
        salesRepDataFilter = salesRepData;
        loadingScrn = false;
      } else if (val.salesrepData == null) {
        // print("error: "+val.error.toString());
        loadingScrn = false;
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            '${val.message}!!..',
            style: const TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.pop(context);
        });
      }
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loadingScrn = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[200],
      appBar: appBar(context, _scaffoldKey, widget.title),
      drawer:
          // GetValues.userRoll == '3' ? drawer2(context) :
          drawer(context),
      body: loadingScrn == true
          ? Center(
              child: SpinKitThreeBounce(
                size: Screens.heigth(context) * 0.06,
                color: theme.primaryColor,
              ),
            )
          : SafeArea(
              child: Column(
                children: [
                  Container(
                    height: Screens.heigth(context) * 0.06,
                    decoration: BoxDecoration(
                      color: theme.hintColor.withOpacity(.05),
                      borderRadius: BorderRadius.circular(Const.radius),
                    ),
                    child: TextField(
                      //  controller: mycontroller[0],
                      autocorrect: false,
                      style: theme.textTheme.bodyMedium,
                      onChanged: (v) {
                        setState(() {
                          salesRepDataFilter = salesRepData
                              .where(
                                (e) =>
                                    e.employeName!
                                        .toLowerCase()
                                        .contains(v.toLowerCase()) ||
                                    e.email
                                        .toString()
                                        .toLowerCase()
                                        .contains(v.toLowerCase()),
                              )
                              .toList();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search for Sales Rep',
                        hintStyle: TextStyles.bodytextBlack1(context),
                        // AppLocalizations.of(context)!
                        //     .search_sales_quot,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            final focus = FocusScope.of(context);
                            if (!focus.hasPrimaryFocus) {
                              focus.unfocus();
                            }
                          }, //
                          color: theme.primaryColor,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 5,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: salesRepDataFilter.length,
                      itemBuilder: (c, i) {
                        return Card(
                          child: Container(
                            // color: Colors.grey[200],
                            padding: EdgeInsets.symmetric(
                              vertical: Screens.heigth(context) * 0.01,
                              horizontal: Screens.width(context) * 0.02,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: Screens.width(context) * 0.7,
                                      // color: Colors.amber,
                                      child: Text(
                                        '${salesRepDataFilter[i].employeName}',
                                        style: TextStyles.boldPC1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Screens.width(context) * 0.7,
                                      // color: Colors.amber,
                                      child: Text(
                                        '${salesRepDataFilter[i].roll}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                        //TextStyles.bodytextBlack1(context)
                                      ),
                                    ),
                                    SizedBox(
                                      width: Screens.width(context) * 0.7,
                                      //  color: Colors.amber,
                                      child: Text(
                                        '${salesRepDataFilter[i].email}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Screens.width(context) * 0.7,
                                      //  color: Colors.amber,
                                      child: Text(
                                        '${salesRepDataFilter[i].phone}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.topRight,
                                      width: Screens.width(context) * 0.2,
                                      // color: Colors.amber,
                                      child: Text(
                                        '${salesRepDataFilter[i].branch}',
                                        style:
                                            TextStyles.headlineBlack1(context),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      width: Screens.width(context) * 0.2,
                                      //  color: Colors.amber,
                                      child: Icon(
                                        Icons.chevron_right_outlined,
                                        color: theme.primaryColor,
                                        size: Screens.width(context) * 0.1,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
