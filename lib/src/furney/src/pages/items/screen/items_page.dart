// ignore_for_file: noop_primitive_operations, omit_local_variable_types, prefer_interpolation_to_compose_strings, prefer_is_empty

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/items_api/items_api.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/item_modal/item_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/creation/content_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/creation/header_creation.dart';

import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class ItemsDetails extends StatefulWidget {
  const ItemsDetails({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  ItemsDetailsState createState() => ItemsDetailsState();
}

class ItemsDetailsState extends State<ItemsDetails> {
  List<ItemValue> itemValue = [];
  List<ItemValue> filteritemValue = [];
  ScrollController scrollController = ScrollController();
  int lenthofList = 0;
  int minuslength = 0;
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  @override
  void initState() {
    ItemsAPi.getGlobalData('').then((value) {
      if (value.itemValueValue!.length > 0) {
        print(value.itemValueValue![0].itemName);
        setState(() {
          itemValue = value.itemValueValue!;
          filteritemValue = itemValue;
          ItemsAPi.nextUrl = value.nextLink;
          lenthofList = filteritemValue.length;
        });
      }
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (mycontroller[0].text.isEmpty) {
          getmoredata();
        }
      }
    });
  }

  List<AddQuotItem> additem = [];
  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  bool swipeLoad = false;
  void getmoredata() {
    ItemsAPi.callNextLink().then((val) {
      setState(() {
        swipeLoad = true;
        minuslength = -1;
        if (val.itemValueValue!.length > 0) {
          for (int i = 0; i < lenthofList; i++) {
            filteritemValue.add(
              ItemValue(
                itemCode: val.itemValueValue![i].itemCode,
                itemName: val.itemValueValue![i].itemName,
                odataetag: val.itemValueValue![i].odataetag,
                salesUnit: val.itemValueValue![i].salesUnit,
                itemPrices: val.itemValueValue![i].itemPrices,
                U_Pack_Size: val.itemValueValue![i].U_Pack_Size,
                U_Tins_Per_Box: val.itemValueValue![i].U_Tins_Per_Box,
                salesperCode: GetValues.slpCode,
              ),
            );
          }
          swipeLoad = false;
          print('lenthofList: ' + lenthofList.toString());
          print('lennList: ' + filteritemValue.length.toString());
          print(val.nextLink);
          minuslength = 0;
        }
      });
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    final DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      print('are you sure');
      //   Get.offAllNamed<dynamic>(FurneyRoutes.home);
      return Future.value(true);
    }
    //  Get.offAllNamed<dynamic>(FurneyRoutes.home);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didpop) {
        if (didpop) return;
        log('bbbbbbbb');
        onbackpress();
      },
      child: Scaffold(
        // backgroundColor: Colors.grey[200],
        // key: _scaffoldKey,
        //   drawer:
        // GetValues.userRoll == '3' ? drawer2(context) : drawer(context),
        // appBar: appBar(context, _scaffoldKey, widget.title),
        //  ),

        body: itemValue.isEmpty
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
                                  filteritemValue = itemValue
                                      .where(
                                        (e) =>
                                            e.itemName!
                                                .toLowerCase()
                                                .contains(v.toLowerCase()) ||
                                            e.itemCode!
                                                .toLowerCase()
                                                .contains(v.toLowerCase()),
                                      )
                                      .toList();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Search for Items',
                                // AppLocalizations.of(context)!
                                //     .search_sales_quot,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                prefixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () {
                                    // SalesQuotAPi.searchValue = mycontroller[0].text;
                                    setState(() {
                                      // quotData.clear();
                                      // quotDataFilter.clear();
                                    });

                                    // SalesQuotAPi.searchData().then((value) {
                                    //       if(value.salesQuotValue!=null){
                                    //         setState(() {
                                    //           print(value.salesQuotValue![0].docEntry);
                                    //           // quotData = value.salesQuotValue!;
                                    //           // quotDataFilter =quotData;
                                    //         });
                                    //       }
                                    // });
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
                          //  Positioned(
                          //     left: Screens.width(context)*0.8,
                          //     child: IconButton(onPressed: (){
                          //       //print("object");
                          //       setAllNull();
                          //        Get.toNamed<dynamic>(FurneyRoutes.creationDetails);
                          //     }, icon: Icon(Icons.add,
                          //     color: theme.primaryColor,
                          //     size: Screens.width(context)*0.08,
                          //     )))
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: filteritemValue.length,
                          itemBuilder: (context, i) {
                            if (i == filteritemValue.length - 1) {
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
                                  // additem.add(AddItem(
                                  //   itemCode: filteritemValue[i].itemCode.toString(),
                                  //   itemName: filteritemValue[i].itemName.toString()
                                  // ));
                                  ContentCreationState.itemsDetails = additem;
                                  Get.toNamed<dynamic>(
                                    FurneyRoutes.creationDetails,
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Screens.heigth(context) * 0.01,
                                    horizontal: Screens.width(context) * 0.02,
                                  ),
                                  // height: Screens.heigth(context)*0.07,
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
                                      Column(
                                        //row 1
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            //color: Colors.greenAccent,
                                            width: Screens.width(context) * 0.7,
                                            child: Text(
                                              '${filteritemValue[i].itemCode}', //'${quotDataFilter[i].DocNum}',
                                              style: GoogleFonts.poppins(
                                                color: theme.primaryColor,
                                                fontSize:
                                                    Screens.width(context) *
                                                        0.035,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                Screens.heigth(context) * 0.01,
                                          ),
                                          SizedBox(
                                            //   color: Colors.blue,
                                            width: Screens.width(context) * 0.7,
                                            child: Text(
                                              '${filteritemValue[i].itemName}', //'${quotDataFilter[i].cardName}',
                                              style: GoogleFonts.poppins(
                                                color: Colors.black54,
                                                fontSize:
                                                    Screens.width(context) *
                                                        0.035,
                                                //  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.chevron_right_outlined,
                                          color: theme.primaryColor,
                                          size: Screens.width(context) * 0.1,
                                        ),
                                      ),
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
      ),
    );
  }

  void setAllNull() {
    HeaderCreationState.bpName = '';
    HeaderCreationState.bpCode = '';
    HeaderCreationState.contactPerson = '';
    HeaderCreationState.docNo = '';
    HeaderCreationState.salesEmp = '';

    HeaderCreationState.status = '';
    // HeaderCreationState.total=0.00;
    // HeaderCreationState.tax=0.00;
  }
}
