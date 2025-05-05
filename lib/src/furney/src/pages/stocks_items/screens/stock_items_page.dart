// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, unnecessary_const, prefer_is_empty, omit_local_variable_types

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
// import 'package:ultimate_bundle/src/furney/src/Api/Stock_Item_Api/stock_api.dart';
// import 'package:ultimate_bundle/src/furney/src/Api/Stock_Item_Api/stock_warehouse_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/Stock_Item_Api/stock_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/Stock_Item_Api/stock_warehouse_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/items_api/mainsubApi/mainGroup.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/items_api/mainsubApi/subGroup.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/item_modal/mainsubModal/mainModal.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/item_modal/mainsubModal/subModal.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/stock_item_modal.dart/stock_item_modal.dart';
//import 'package:ultimate_bundle/src/furney/src/Modal/customer_bp/new_customer_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/stocks_items/screens/stock_warehouse_page.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class StockItem extends StatefulWidget {
  const StockItem({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  StockItemState createState() => StockItemState();
}

class StockItemState extends State<StockItem> {
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  List<StockValue> stock = [];
  List<StockValue> stockFilter = [];
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    setState(CallGetGroupAPi);
    log('stockFilterstockFilter:::${stockFilter.length}');
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  CallGetGroupAPi() {
    setState(() {
      MainGroupAPi.getGlobalData().then((value) {
        if (mounted) {
          setState(() {
            mainValueValue = value.itemValueValue!;
          });
        }
      });

      SubGroupAPi.getGlobalData().then((value) {
        if (mounted) {
          setState(() {
            // value.itemValueValue![0].code;
            subValueValue = value.itemValueValue!;
          });
        }
      });

      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          if (mycontroller[0].text.isEmpty) {
            if (StockItemAPi.nextLink != 'null') {
              getmoredata();
            }
          }
        }
      });
    });
  }

  bool swipeLoad = false;
  void getmoredata() {
    StockItemAPi.callNextLink().then((val) {
      setState(() {
        swipeLoad = true;
        if (val.value!.isNotEmpty) {
          for (int i = 0; i < lenthofList; i++) {
            stockFilter.add(
              StockValue(
                itemCode: val.value![i].itemCode,
                itemName: val.value![i].itemName,
                quantityOnStock: val.value![i].quantityOnStock,
              ),
            );
          }
          swipeLoad = false;
        }
      });
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      drawer:
          // GetValues.userRoll == '3' ? drawer2(context) :
          drawer(context),
      key: _scaffoldKey,
      appBar: appBar(context, _scaffoldKey, widget.title),
      body: loadItemValues == true
          ? Center(
              child: SpinKitThreeBounce(
                size: Screens.heigth(context) * 0.06,
                color: theme.primaryColor,
              ),
            )
          : Column(
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
                        stockFilter = stock
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
                      hintText: 'Filter for Items',
                      hintStyle: TextStyles.bodytextBlack1(context),
                      // AppLocalizations.of(context)!
                      //     .search_sales_quot,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.filter_alt_rounded),
                        onPressed: () {
                          valueSelectedMain = null;
                          valueSelectedSub = null;
                          mycontroller[1].text = '';
                          mycontroller[8].text = '';
                          // setState(() {
                          error = false;
                          //  });

                          bottomSheetMainSubGroup(theme);
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
                if (erromsg.isNotEmpty)
                  SizedBox(
                    height: Screens.heigth(context) * 0.7,
                    child: const Center(child: Text('No data found..!!')),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: stockFilter.length,
                      itemBuilder: (BuildContext context, int i) {
                        if (i == stockFilter.length - 1) {
                          if (mycontroller[0].text.isEmpty) {
                            if (StockItemAPi.nextLink != 'null') {
                              // print('1111111');
                              return SpinKitThreeBounce(
                                size: Screens.width(context) * 0.06,
                                color: theme.primaryColor,
                              );
                            }
                          }
                        }
                        return
                            // Card(
                            //child:
                            InkWell(
                          onTap: () {
                            //   print('object');
                            //   BPInfoState.data = customerDataFilter;
                            //   GeneralState.datas = customerDataFilter;

                            StockWarehouseAPi.itemcode =
                                stockFilter[i].itemCode.toString();
                            StockWarehouseState.itemCode =
                                stockFilter[i].itemCode.toString();
                            StockWarehouseState.itemName =
                                stockFilter[i].itemName.toString();
                            StockWarehouseState.qty =
                                stockFilter[i].quantityOnStock.toString();
                            Get.toNamed<dynamic>(
                              FurneyRoutes.stockWarehouse,
                            );
                            //   // print("iiii: "+i.toString());
                            //   GeneralState.index = i;
                            //   BPInfoState.index = i;
                          },
                          child: Container(
                            // height: Screens.heigth(context)*0.1,
                            width: Screens.width(context),
                            decoration: const BoxDecoration(
                                // color:Colors.green,
                                // borderRadius: BorderRadius.circular(Const.radius),
                                // border: Border( bottom: BorderSide(color: Colors.grey),)
                                ),
                            padding: EdgeInsets.only(
                              top: Screens.heigth(context) * 0.005,
                              bottom: Screens.heigth(context) * 0.005,
                              left: Screens.width(context) * 0.04,
                              right: Screens.width(context) * 0.04,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    //       Container(
                                    //   width: Screens.width(context)*0.2,
                                    //   //color: Colors.redAccent,
                                    //   decoration: BoxDecoration(

                                    //   ),
                                    //   child: Icon(Icons.list_alt,
                                    //   color: Colors.red[400],
                                    //   size: Screens.width(context)*0.1,
                                    //   ),
                                    // ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: Screens.width(context) * 0.9,
                                          //    color: Colors.greenAccent,
                                          child: Text(
                                            stockFilter[i].itemCode.toString(),
                                            style: TextStyles.boldPC1(context),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width:
                                                  Screens.width(context) * 0.7,
                                              //    color: Colors.greenAccent,
                                              child: Text(
                                                stockFilter[i]
                                                    .itemName
                                                    .toString(),
                                                style:
                                                    TextStyles.headlineBlack1(
                                                  context,
                                                ),
                                              ),
                                            ),
                                            //                SizedBox(width: Screens.width(context) * 0.05),
                                            //         Container(
                                            //           alignment: Alignment.bottomRight,
                                            //    width: Screens.width(context)*0.2,
                                            // //   color: Colors.redAccent,
                                            //     child: Text(stockFilter[i].quantityOnStock.toString(),
                                            //     style: TextStyles.headlineBlack1(context),
                                            //     ),
                                            //   ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Divider(
                                  thickness: 1.5,
                                ),
                              ],
                            ),
                          ),
                          //    ),
                        );
                      },
                    ),
                  ),
              ],
            ),
    );
  }

  List<GlobalKey<FormState>> formkey =
      List.generate(3, (i) => GlobalKey<FormState>());
  List<MainModalValue> mainValueValue = [];
  List<SubModalValue> subValueValue = [];
  void bottomSheetMainSubGroup(ThemeData theme) {
    //nznznz

    showModalBottomSheet<dynamic>(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Form(
            key: formkey[0],
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: error,
                    child: Text(
                      'Please Give Main Group!..',
                      style: GoogleFonts.poppins(
                        color: Colors.red,
                        fontSize: Screens.width(context) * 0.03,
                        // fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    width: Screens.width(context),
                    padding: const EdgeInsets.only(top: 1, left: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButton(
                      hint: Text(
                        'Select Main Group: ',
                        style: TextStyles.headlineBlack1(context),
                      ),
                      value: valueSelectedMain,
                      dropdownColor: Colors.white,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 30,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      isExpanded: true,
                      onChanged: (val) {
                        setState(() {
                          valueSelectedMain = val.toString();
                          print(valueSelectedMain);
                        });
                      },
                      items: mainValueValue.map((e) {
                        return DropdownMenuItem(
                          value: '${e.code}',
                          child: Text(
                            '${e.name}',
                            style: TextStyles.headlineBlack1(context),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Visibility(
                    visible: error,
                    child: Text(
                      'Please Give Sub Group!..',
                      style: TextStyles.headlineBlack1(context),
                    ),
                  ),
                  Container(
                    width: Screens.width(context),
                    padding: const EdgeInsets.only(top: 1, left: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButton(
                      dropdownColor: Colors.white,

                      hint: Text(
                        'Select Sub Group: ',
                        style: TextStyles.headlineBlack1(context),
                      ),
                      value: valueSelectedSub,
                      //dropdownColor:Colors.green,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 30,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      isExpanded: true,
                      onChanged: (val) {
                        setState(() {
                          valueSelectedSub = val.toString();
                          print(valueSelectedSub);
                        });
                      },
                      items: subValueValue.map((e) {
                        return DropdownMenuItem(
                          value: '${e.code}',
                          child: Text(
                            e.name.toString(),
                            style: TextStyles.headlineBlack1(context),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Visibility(
                    visible: error,
                    child: Text(
                      'Please Give Search Value!..',
                      style: GoogleFonts.poppins(
                        color: Colors.red,
                        fontSize: Screens.width(context) * 0.03,
                        // fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  SizedBox(
                    child: TextFormField(
                      controller: mycontroller[1],
                      onChanged: (val) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'ENTER QUANTITY';
                        }
                        return null;
                      },
                      style: const TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(05),
                          ),
                        ),
                        hintText: 'Search!!..',
                        hintStyle: TextStyles.bodytextBlack1(context),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  SizedBox(
                    child: TextFormField(
                      controller: mycontroller[8],
                      onChanged: (val) {},
                      style: const TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(05),
                          ),
                        ),
                        hintText: 'Enter pack..',
                        // "Search!!..",
                        hintStyle: TextStyles.bodytextBlack1(context),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: theme.primaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        child: Text(
                          'cancel',
                          style: TextStyles.whiteText(context),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: theme.primaryColor,
                        ),
                        onPressed: () {
                          setState(valuesAdd);
                        },
                        child: Text(
                          'Search',
                          style: TextStyles.whiteText(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String erromsg = '';
  bool error = false;
  void errorMsg() {
    setState(() {
      error = true;
    });
  }

  bool loadItemValues = false;
  void valuesAdd() {
    setState(() {
      StockItemAPi.mainGrp = valueSelectedMain;
      StockItemAPi.subGrp = valueSelectedSub;

      StockItemAPi.searchData = mycontroller[1].text;
      StockItemAPi.pack = mycontroller[8].text;
      loadItemValues = true;
      stockFilter = [];
      erromsg = '';
      Navigator.pop(context);
      StockItemAPi.getGlobalData().then((value) {
        if (value.value!.isNotEmpty) {
          setState(() {
            print(value.value![0].itemName);
            stock = value.value!;
            stockFilter = stock;
            log('value.nextURl:::' + value.nextURl.toString());
            StockItemAPi.nextLink = value.nextURl;
            loadItemValues = false;
            print('nextLink: ' + StockItemAPi.nextLink.toString());
            lenthofList = stockFilter.length;
          });
        } else {
          setState(() {
            loadItemValues = false;
            erromsg = 'No Data..!!';
          });
        }
      });
    });
    loadItemValues = false;
  }

  int lenthofList = 0;
  String? valueSelectedMain;
  String? valueSelectedSub;
}
