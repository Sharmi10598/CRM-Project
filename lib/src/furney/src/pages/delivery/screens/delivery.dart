// ignore_for_file: prefer_interpolation_to_compose_strings, noop_primitive_operations, omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/delivery_api/delivery_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/delivery_api/delivery_details_api.dart';
//import 'package:ultimate_bundle/src/furney/src/Api/sales_order/sales_order_api.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/delivery_modal/delivery_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  DeliveryPageState createState() => DeliveryPageState();
}

class DeliveryPageState extends State<DeliveryPage> {
  List<DeliveryModaleValue> deliveryValue = [];
  List<DeliveryModaleValue> deliveryValueFilter = [];
  ScrollController scrollController = ScrollController();
  int lenthofList = 0;
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  @override
  void initState() {
    super.initState();
    //  GetValues.isAtive[0]=false;
    //   GetValues.isAtive[1]=true;
    DeliveryAPi.getGlobalData().then((val) {
      if (val.deliveryModaleValue != null) {
        // print(val.deliveryModaleValue ![0].cardName);
        // print('cardCode: '+val.deliveryModaleValue![0].cardCode .toString());
        // print('cardName: '+val.deliveryModaleValue![0].cardName .toString());
        // print('cardCode: '+val.deliveryModaleValue![1].cardCode .toString());
        // print('cardName: '+val.deliveryModaleValue![1].cardName .toString());
        setState(() {
          deliveryValue = val.deliveryModaleValue!;
          deliveryValueFilter = deliveryValue;
          lenthofList = deliveryValueFilter.length;
          DeliveryAPi.nextUrl = val.nextLink;
          //   print('deliveryValueFilter2:'+deliveryValueFilter.length.toString());
        });
      } else if (val.error != null) {
        final snackBar = SnackBar(
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          content: Text(
            '${val.error}!!..',
            style: const TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (mycontroller[0].text.isEmpty) {
          getmoredata();
        }
      }
      // else if (scrollController.position.pixels !=
      //     scrollController.position.maxScrollExtent) {
      //   print("heelllllloo");
      // }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  bool swipeLoad = false;
  void getmoredata() {
    DeliveryAPi.callNextLink().then((val) {
      setState(() {
        swipeLoad = true;
        if (val.deliveryModaleValue != null) {
          print(
              'deliveryValueFilter3:' + deliveryValueFilter.length.toString());
          for (int i = 0; i < lenthofList; i++) {
            deliveryValueFilter.add(
              DeliveryModaleValue(
                DocDate: val.deliveryModaleValue![i].DocDate,
                cardCode: val.deliveryModaleValue![i].cardCode,
                cardName: val.deliveryModaleValue![i].cardName,
                docEntry: val.deliveryModaleValue![i].docEntry,
                DocNum: val.deliveryModaleValue![i].DocNum,
              ),
            );
          }
          swipeLoad = false;
          print('lenthofList: ' + lenthofList.toString());
          print('filterList: ' + deliveryValueFilter.length.toString());
          print(val.nextLink);
        }
      });
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawer(context),
      appBar: appBar(context, _scaffoldKey, widget.title),
      //  ),
      body: deliveryValue.isEmpty
          ? Center(
              child: SpinKitThreeBounce(
                size: Screens.heigth(context) * 0.06,
                color: theme.primaryColor,
              ),
            )
          : SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: Screens.width(context) * 0.02,
                  right: Screens.width(context) * 0.02,
                  top: Screens.heigth(context) * 0.01,
                  bottom: Screens.width(context) * 0.01,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: Screens.heigth(context) * 0.06,
                          decoration: BoxDecoration(
                            color: theme.hintColor.withOpacity(.05),
                            borderRadius: BorderRadius.circular(Const.radius),
                          ),
                          child: TextField(
                            controller: mycontroller[0],
                            autocorrect: false,
                            style: theme.textTheme.bodyMedium,
                            onChanged: (v) {
                              setState(() {
                                deliveryValueFilter = deliveryValue
                                    .where(
                                      (e) =>
                                          e.cardName!
                                              .toLowerCase()
                                              .contains(v.toLowerCase()) ||
                                          e.cardCode!
                                              .toLowerCase()
                                              .contains(v.toLowerCase()),
                                    )
                                    .toList();
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Search for Delivery',
                              hintStyle: TextStyles.bodytextBlack1(context),
                              // AppLocalizations.of(context)!
                              //     .search_sales_quot,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              prefixIcon: IconButton(
                                icon: const Icon(Icons.search),
                                onPressed: () {
                                  DeliveryAPi.searchValue =
                                      mycontroller[0].text;
                                  setState(() {
                                    deliveryValue.clear();
                                    deliveryValueFilter.clear();
                                  });

                                  DeliveryAPi.searchData().then((value) {
                                    if (value.deliveryModaleValue != null) {
                                      setState(() {
                                        deliveryValue =
                                            value.deliveryModaleValue!;
                                        deliveryValueFilter = deliveryValue;
                                      });
                                    }
                                  });
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
                        // Positioned(
                        //   left: Screens.width(context)*0.8,
                        //   child: IconButton(onPressed: (){
                        //     //print("object");
                        //   }, icon: Icon(Icons.add,
                        //   color: theme.primaryColor,
                        //   size: Screens.width(context)*0.08,
                        //   )))
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: deliveryValueFilter
                            .length, //dataSocialMedia.length,
                        itemBuilder: (context, i) {
                          //i ==deliveryValueFilter.length-1
                          if (i == deliveryValueFilter.length - 1) {
                            if (mycontroller[0].text.isEmpty) {
                              print('1111111');
                              return SpinKitThreeBounce(
                                size: Screens.width(context) * 0.06,
                                color: theme.primaryColor,
                              );
                            }
                          }
                          return Card(
                            elevation: 8,
                            child: InkWell(
                              onTap: () {
                                DeliveryDetailsAPi.docEntry =
                                    deliveryValueFilter[i].docEntry.toString();
                                Get.toNamed<dynamic>(
                                    FurneyRoutes.deliveyDetails);
                              },
                              child: Container(
                                height: Screens.heigth(context) * 0.07,
                                width: Screens.width(context),
                                decoration: const BoxDecoration(
                                    // color:Colors.green,
                                    // borderRadius: BorderRadius.circular(Const.radius),
                                    // border: Border.all(color: Colors.black)
                                    ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      //row 1
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: Screens.width(context) * 0.02,
                                          height: double.infinity,
                                          color: theme.primaryColor,
                                        ),
                                        SizedBox(
                                          width: Screens.width(context) * 0.01,
                                        ),
                                        SizedBox(
                                          //   color: Colors.greenAccent,
                                          width: Screens.width(context) * 0.2,
                                          child: Text(
                                            '${deliveryValueFilter[i].DocNum}',
                                            style: TextStyles.bodytextBlack1(
                                                context),
                                          ),
                                        ),
                                        SizedBox(
                                          width: Screens.width(context) * 0.01,
                                        ),
                                        SizedBox(
                                          //   color: Colors.blue,
                                          width: Screens.width(context) * 0.4,
                                          child: Text(
                                            '${deliveryValueFilter[i].cardName}',
                                            style: TextStyles.bodytextBlack1(
                                                context),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: Screens.width(context) * 0.02),
                                      child: Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            // color: Colors.red,
                                            width:
                                                Screens.width(context) * 0.22,
                                            child:
                                                // Column(
                                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                                //   children: [
                                                //     Text(salesOrderFilter[i].CancelStatus=='csNo'&&salesOrderFilter[i].DocumentStatus=='bost_Open' ?'Open'
                                                //     :salesOrderFilter[i].CancelStatus=='csYes'&&salesOrderFilter[i].DocumentStatus=='bost_Close' ?'Cancelled'
                                                //     :salesOrderFilter[i].CancelStatus=='csNo'&&salesOrderFilter[i].DocumentStatus=='bost_Close' ?'Closed':'null', style: GoogleFonts.poppins(
                                                //   color: Colors.black54,
                                                //   fontSize: Screens.width(context) * 0.035,
                                                //   //  fontWeight: FontWeight.bold
                                                // ),),
                                                Text(
                                              '${deliveryValueFilter[i].DocDate}',
                                              style: TextStyles.bodytextBlack1(
                                                  context),
                                            ),
                                            //   ],
                                            // ),
                                          ),
                                          Icon(
                                            Icons.chevron_right,
                                            color: theme.primaryColor,
                                          )
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
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
