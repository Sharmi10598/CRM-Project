// ignore: file_names
// ignore_for_file: file_names, prefer_interpolation_to_compose_strings, require_trailing_commas, prefer_const_constructors, unnecessary_new, omit_local_variable_types, noop_primitive_operations, prefer_single_quotes, non_constant_identifier_names, avoid_print, avoid_unnecessary_containers, prefer_if_elements_to_conditional_expressions

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/items_api/items_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/items_api/mainsubApi/mainGroup.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/items_api/mainsubApi/subGroup.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_quotations_api/post_api/post_sales_quot.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/special%20discount%20api/specialDiscountApi.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/item_modal/item_modal.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/item_modal/mainsubModal/mainModal.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/item_modal/mainsubModal/subModal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/widget/logistic_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/screens/create_quot.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/creation/header_creation.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:uuid/uuid.dart';

class ContentCreation extends StatefulWidget {
  const ContentCreation({Key? key}) : super(key: key);

  @override
  ContentCreationState createState() => ContentCreationState();
}

class ContentCreationState extends State<ContentCreation> {
  PageController pageController = PageController();
  static List<AddItem> itemsDetails = [];
  static int itemlen = 0;
  int pageChanged = 0;
  //
  List<ItemValue> itemValue = [];
  List<ItemValue> filteritemValue = [];
  ScrollController scrollController = ScrollController();
  int lenthofList = 0;
  int minuslength = 0;
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  //
  List<MainModalValue> mainValueValue = [];
  List<SubModalValue> subValueValue = [];
  @override
  void initState() {
    MainGroupAPi.getGlobalData().then((value) {
      if (mounted) {
        setState(() {
          print(value.itemValueValue![0].code);
          mainValueValue = value.itemValueValue!;
        });
      }
    });

    SubGroupAPi.getGlobalData().then((value) {
      if (mounted) {
        setState(() {
          value.itemValueValue![0].code;
          subValueValue = value.itemValueValue!;
        });
      }
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (mycontroller[0].text.isEmpty) {
          if (ItemsAPi.nextUrl != 'null') {
            getmoredata();
          }
        }
      }
    });
  }

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
        if (val.itemValueValue!.isNotEmpty) {
          for (int i = 0; i < lenthofList; i++) {
            filteritemValue.add(ItemValue(
                itemCode: val.itemValueValue![i].itemCode,
                itemName: val.itemValueValue![i].itemName,
                odataetag: val.itemValueValue![i].odataetag,
                salesUnit: val.itemValueValue![i].salesUnit,
                itemPrices: val.itemValueValue![i].itemPrices,
                U_Pack_Size: val.itemValueValue![i].U_Pack_Size,
                U_Tins_Per_Box: val.itemValueValue![i].U_Tins_Per_Box,
                salesperCode: GetValues.slpCode));
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

  double? price;
  int? qty;
  static String? carcode;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            pageChanged = index;
          });
          print(pageChanged);
        },
        children: [
          listItems(context, theme),
          //  ItemsDetails(title: 'Item Details',),
          addItems(context, theme)
        ],
      ),
    );
  }

  bool loadItems = false;
  bool loadItemValues = false;
  Stack listItems(BuildContext context, ThemeData theme) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: visibleBtn,
              child: Padding(
                padding: EdgeInsets.only(
                  left: Screens.width(context) * 0.02,
                  right: Screens.width(context) * 0.02,
                ),
                child: SizedBox(
                  width: Screens.width(context),
                  height: Screens.heigth(context) * 0.05,
                  child: ElevatedButton(
                      onPressed: () {
                        if (HeaderCreationState.bpName != '') {
                          pageController.animateToPage(++pageChanged,
                              duration: Duration(milliseconds: 250),
                              curve: Curves.bounceIn);
                          CreateDetailsState.contentAddItems = true;
                        } else {
                          const snackBar = SnackBar(
                            duration: Duration(seconds: 5),
                            backgroundColor: Colors.red,
                            content: Text(
                              'Choose Bussiness Partner First!!..',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: theme.primaryColor,
                      ),
                      child: Icon(Icons.add)),
                ),
              ),
            ),
            SizedBox(
              height: Screens.heigth(context) * 0.01,
            ),
            Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.only(
                      left: Screens.width(context) * 0.02,
                      right: Screens.width(context) * 0.02,
                    ),
                    itemCount: itemsDetails.length,
                    itemBuilder: (c, i) {
                      return Card(
                        child: Container(
                          padding: EdgeInsets.only(
                            left: Screens.width(context) * 0.02,
                            right: Screens.width(context) * 0.02,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                //color: Colors.greenAccent,
                                width: Screens.width(context) * 0.7,
                                child: Text(
                                  itemsDetails[i]
                                      .itemCode, //'${quotDataFilter[i].DocNum}',
                                  style: TextStyles.bodytextBlack1(context),
                                ),
                              ),
                              SizedBox(
                                height: Screens.heigth(context) * 0.005,
                              ),
                              SizedBox(
                                //color: Colors.greenAccent,
                                width: Screens.width(context) * 0.7,
                                child: Text(
                                  itemsDetails[i]
                                      .itemName, //'${quotDataFilter[i].DocNum}',
                                  style: TextStyles.bodytextBlack1(context),
                                ),
                              ),
                              SizedBox(
                                height: Screens.heigth(context) * 0.005,
                              ),
                              SizedBox(
                                //   color: Colors.blueGrey,
                                width: Screens.width(context) * 0.9,
                                child: Row(
                                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.25,
                                      child: Text(
                                        'Price', //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.05,
                                      child: Text(
                                        ':', //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      // color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.55,
                                      child: Text(
                                        // '${itemsDetails[i].price}', //'${quotDataFilter[i].DocNum}',
                                        TextStyles.splitValues(
                                            '${itemsDetails[i].price}'),
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Screens.heigth(context) * 0.005,
                              ),
                              SizedBox(
                                //   color: Colors.blueGrey,
                                width: Screens.width(context) * 0.9,
                                child: Row(
                                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.25,
                                      child: Text(
                                        'Qty', //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.05,
                                      child: Text(
                                        ':', //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.55,
                                      child: Text(
                                        '${itemsDetails[i].qty}', //'${quotDataFilter[i].DocNum}',
                                        //  TextStyles.splitValues('$total'),
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Screens.heigth(context) * 0.005,
                              ),
                              SizedBox(
                                //   color: Colors.blueGrey,
                                width: Screens.width(context) * 0.9,
                                child: Row(
                                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.25,
                                      child: Text(
                                        'Discount %', //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.05,
                                      child: Text(
                                        ':', //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.55,
                                      child: Text(
                                        itemsDetails[i].discounpercent! <= 0.0
                                            ? "000.00"
                                            : TextStyles.splitValues(
                                                    '${itemsDetails[i].discounpercent!}')
                                                .replaceAll(
                                                    new RegExp('^0+(?=.)'), ''),
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                //   color: Colors.blueGrey,
                                width: Screens.width(context) * 0.9,
                                child: Row(
                                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.25,
                                      child: Text(
                                        'Value AF Disc', //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.05,
                                      child: Text(
                                        ':', //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.55,
                                      child: Text(
                                        itemsDetails[i].valueAF == null
                                            ? "000.00"
                                            : TextStyles.splitValues(
                                                '${itemsDetails[i].valueAF}'),
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                //   color: Colors.blueGrey,
                                width: Screens.width(context) * 0.9,
                                child: Row(
                                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.25,
                                      child: Text(
                                        'Total', //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.05,
                                      child: Text(
                                        ':', //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.55,
                                      child: Text(
                                        //  '${itemsDetails[i].total! - itemsDetails[i].discount!}',
                                        TextStyles.splitValues(
                                            '${itemsDetails[i].total!}'), //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Container(
                                  //   alignment: Alignment.bottomRight,
                                  //   // color: Colors.greenAccent,
                                  //   //  width: Screens.width(context) * 0.18,
                                  //   child: Row(
                                  //     children: [
                                  //       InkWell(
                                  //         onTap: () {},
                                  //         child: Container(
                                  //           padding: EdgeInsets.all(
                                  //               Screens.width(context) * 0.01),
                                  //           decoration: BoxDecoration(
                                  //               shape: BoxShape.circle,
                                  //               color: theme.primaryColor),
                                  //           child: Icon(
                                  //             Icons.add,
                                  //             size: Screens.width(context) * 0.05,
                                  //             color: Colors.white,
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       SizedBox(
                                  //         width: Screens.width(context) * 0.02,
                                  //       ),
                                  //       InkWell(
                                  //         onTap: () {},
                                  //         child: Container(
                                  //           padding: EdgeInsets.all(
                                  //               Screens.width(context) * 0.01),
                                  //           decoration: BoxDecoration(
                                  //               shape: BoxShape.circle,
                                  //               color: theme.primaryColor),
                                  //           child: Icon(
                                  //             Icons.remove,
                                  //             size: Screens.width(context) * 0.05,
                                  //             color: Colors.white,
                                  //           ),
                                  //         ),
                                  //       )
                                  //     ],
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   width: Screens.width(context) * 0.04,
                                  // ),
                                  InkWell(
                                    onTap: () {
                                      log("taxSelectedtaxSelectedXX11:::${taxSelected}");

                                      mycontroller[4].text = itemsDetails[i]
                                          .price!
                                          .toStringAsFixed(2);
                                      mycontroller[5].text =
                                          itemsDetails[i].qty!.toString();

                                      mycontroller[6].text = itemsDetails[i]
                                          .discounpercent!
                                          .toStringAsFixed(2);
                                      valueChossed = itemsDetails[i]
                                              .valuechoosed
                                              .toString()
                                              .isEmpty
                                          ? "0.0"
                                          : itemsDetails[i].valuechoosed;

                                      taxSelected = double.parse(
                                          itemsDetails[i].taxPer.toString());
                                      // log("taxSelected: " +
                                      //     itemsDetails[i].taxPer!.toString());
                                      // // taxSelected = itemsDetails[i].tax!;
                                      // log("discper: " +
                                      //     itemsDetails[i]
                                      //         .discounpercent!
                                      //         .toStringAsFixed(2)
                                      //         .toString());
                                      // log("taxxx per::" +
                                      //     itemsDetails[i]
                                      //         .taxPer!
                                      //         .toDouble()
                                      //         .toString());
                                      // log("taxxx" +
                                      //     itemsDetails[i]
                                      //         .tax!
                                      //         .toDouble()
                                      //         .toString());
                                      // log("valuechoss" +
                                      //     itemsDetails[i]
                                      //         .valuechoosed
                                      //         .toString());

                                      showBottomSheetUpdate(i, theme);
                                    },
                                    child: Container(
                                      alignment: Alignment.bottomRight,
                                      // color: Colors.greenAccent,
                                      // width: Screens.width(context) * 0.1,
                                      child: Icon(
                                        Icons.mode_edit_outline_outlined,
                                        color: theme.primaryColor,
                                        size: Screens.width(context) * 0.065,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Screens.width(context) * 0.04,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        grandtotal = 0.00;
                                        discount = 0.00;
                                        itemsDetails.removeAt(i);
                                        sumofTotal();
                                        itemlen = itemsDetails.length;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.bottomRight,
                                      // color: Colors.greenAccent,
                                      // width: Screens.width(context) * 0.1,
                                      child: Icon(
                                        Icons.delete_outline_sharp,
                                        color: theme.primaryColor,
                                        size: Screens.width(context) * 0.065,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }))
          ],
        ),
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: CustomSpinkitdButton(
        //     onTap: () async {
        //       ValidateAndCallApi();
        //       //callServiceLayerApi();
        //     },
        //     isLoading: isLoading,
        //     //  labelLoading: AppLocalizations.of(context)!.signing,
        //     label: 'Save',
        //   ),
        // )
      ],
    );
  }

  bool isLoading = false;
  void ValidateAndCallApi() {
    if (carcode == null) {
      const snackBar = SnackBar(
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        content: Text(
          'Please Choose Business Partner!!...',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (itemsDetails.isEmpty) {
      const snackBar = SnackBar(
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        content: Text(
          'Please Add Items!!...',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      setState(() => isLoading = true);
      SalesQuotPostAPi.cardCodePost = carcode;
      SalesQuotPostAPi.docLineQout = itemsDetails;
      SalesQuotPostAPi.docDate = HeaderCreationState.currentDateTime.toString();
      SalesQuotPostAPi.dueDate = HeaderCreationState.currentDateTime.toString();
      SalesQuotPostAPi.remarks = HeaderCreationState.mycontroller[1].text;
      final uuid = Uuid();
      String? uuidg = uuid.v1();
      SalesQuotPostAPi.deviceTransID = uuid.v1();

      SalesQuotPostAPi.method();
      SalesQuotPostAPi.getGlobalData().then((value) {
        if (value.statusCode! >= 200 && value.statusCode! <= 210) {
          setState(() => isLoading = false);
          print(value.statusCode);
          const snackBar = SnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.green,
            content: Text(
              'Quotation Created Successfully!!...',
              style: TextStyle(color: Colors.white),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Get.offAllNamed<dynamic>(FurneyRoutes.newSalesQuot);
        } else {
          setState(() => isLoading = false);
          print(value.statusCode);
          final snackBar = SnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red,
            content: Text(
              '${value.error!.message!.value}!!..',
              style: TextStyle(color: Colors.white),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    }
  }

  Stack addItems(BuildContext context, ThemeData theme) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: Screens.width(context) * 0.02,
              right: Screens.width(context) * 0.02,
              top: Screens.heigth(context) * 0.01,
              bottom: Screens.width(context) * 0.01),
          child: loadItemValues == true
              ? Center(
                  child: SpinKitThreeBounce(
                    size: Screens.heigth(context) * 0.06,
                    color: theme.primaryColor,
                  ),
                )
              : Stack(
                  children: [
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: [
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
                                      .where((e) =>
                                          e.itemName!
                                              .toLowerCase()
                                              .contains(v.toLowerCase()) ||
                                          e.itemCode!
                                              .toLowerCase()
                                              .contains(v.toLowerCase()))
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
                                    error = false;
                                    mycontroller[7].text = '';
                                    mycontroller[8].text = '';

                                    bottomSheetMainSubGroup(theme);
                                    //  ItemsAPi.searchData = mycontroller[0].text;
                                    // setState(() {
                                    //   itemValue.clear();
                                    //   filteritemValue.clear();
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
                          Positioned(
                              left: Screens.width(context) * 0.8,
                              child: IconButton(
                                  onPressed: () {
                                    pageController.animateToPage(--pageChanged,
                                        duration: Duration(milliseconds: 250),
                                        curve: Curves.bounceIn);
                                    CreateDetailsState.contentAddItems = false;

                                    Get.toNamed<dynamic>(
                                        FurneyRoutes.creationDetails);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: theme.primaryColor,
                                    size: Screens.width(context) * 0.08,
                                  )))
                        ]),
                        SizedBox(
                          width: Screens.width(context),
                          height: Screens.heigth(context) * 0.72,
                          child: ListView.builder(
                              controller: scrollController,
                              itemCount: filteritemValue.length,
                              itemBuilder: (context, i) {
                                if (i == filteritemValue.length - 1) {
                                  if (mycontroller[0].text.isEmpty) {
                                    if (ItemsAPi.nextUrl != 'null') {
                                      print("1111111");
                                      return SpinKitThreeBounce(
                                        size: Screens.width(context) * 0.06,
                                        color: theme.primaryColor,
                                      );
                                    }
                                  }
                                }
                                return Card(
                                    elevation: 8,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          loadingscrn = true;
                                        });
                                        SpecialDiscountAPi.cardCode =
                                            HeaderCreationState.bpCode;
                                        SpecialDiscountAPi.itemCode =
                                            filteritemValue[i].itemCode;
                                        // print(SpecialDiscountAPi.cardCode);
                                        //  print(SpecialDiscountAPi.itemCode);
                                        SpecialDiscountAPi.getGlobalData()
                                            .then((value) {
                                          if (value.specialValue!.isNotEmpty) {
                                            setState(() {
                                              loadingscrn = false;
                                            });
                                            // print(value.specialValue![0].Price);
                                            mycontroller[1].text = value
                                                        .specialValue![0]
                                                        .Price! >
                                                    0
                                                ? value.specialValue![0].Price
                                                    .toString()
                                                : filteritemValue[i]
                                                            .itemPrices![0]
                                                            .PriceList ==
                                                        1
                                                    ? filteritemValue[i]
                                                        .itemPrices![0]
                                                        .price
                                                        .toString()
                                                    : "";
                                            mycontroller[2].text = '';
                                            valueChossed = null;
                                            showBottomSheetInsert(i, theme);
                                            mycontroller[3].text = value
                                                        .specialValue![0]
                                                        .discount! >
                                                    0
                                                ? value
                                                    .specialValue![0].discount
                                                    .toString()
                                                : '';
                                            CreateDetailsState.contentAddItems =
                                                false;
                                          } else if (value
                                              .specialValue!.isEmpty) {
                                            setState(() {
                                              loadingscrn = false;
                                            });
                                            mycontroller[1].text =
                                                filteritemValue[i]
                                                            .itemPrices![0]
                                                            .PriceList ==
                                                        1
                                                    ? filteritemValue[i]
                                                        .itemPrices![0]
                                                        .price
                                                        .toString()
                                                    : "";
                                            mycontroller[2].text = '';
                                            mycontroller[3].text = '';
                                            valueChossed = null;
                                            showBottomSheetInsert(i, theme);
                                            CreateDetailsState.contentAddItems =
                                                false;
                                          }
                                        });
                                        // mycontroller[1].text=filteritemValue[i].itemPrices![0].PriceList==1?filteritemValue[i].itemPrices![0].price.toString():"";
                                        //  mycontroller[2].text='';
                                        //   mycontroller[3].text='';
                                        //   valueChossed=null;

                                        // showBottomSheetInsert(i,theme);

                                        // CreateDetailsState.contentAddItems = false;
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                Screens.heigth(context) * 0.01,
                                            horizontal:
                                                Screens.width(context) * 0.02),
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
                                                  width:
                                                      Screens.width(context) *
                                                          0.7,
                                                  child: Text(
                                                    '${filteritemValue[i].itemCode}', //'${quotDataFilter[i].DocNum}',
                                                    style: TextStyles.boldPC1(
                                                        context),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      Screens.heigth(context) *
                                                          0.01,
                                                ),
                                                SizedBox(
                                                  //   color: Colors.blue,
                                                  width:
                                                      Screens.width(context) *
                                                          0.7,
                                                  child: Text(
                                                    '${filteritemValue[i].itemName}', //'${quotDataFilter[i].cardName}',
                                                    style: TextStyles
                                                        .headlineBlack1(
                                                            context),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Container(
                                              child: Icon(
                                                Icons.chevron_right_outlined,
                                                color: theme.primaryColor,
                                                size: Screens.width(context) *
                                                    0.1,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                              }),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: loadingscrn,
                      child: Container(
                        width: Screens.width(context),
                        height: Screens.heigth(context),
                        color: Colors.white60,
                        child: Center(
                          child: SpinKitThreeBounce(
                            size: Screens.heigth(context) * 0.06,
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ),
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: CustomSpinkitdButton(
        //     onTap: () async {
        //       ValidateAndCallApi();
        //       //callServiceLayerApi();
        //     },
        //     isLoading: isLoading,
        //     //  labelLoading: AppLocalizations.of(context)!.signing,
        //     label: 'Save',
        //   ),
        // )
      ],
    );
  }

  bool loadingscrn = false;
  void bottomSheetMainSubGroup(ThemeData theme) {
    //nznznz

    showModalBottomSheet<dynamic>(
        isDismissible: false,
        isScrollControlled: true,
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Form(
                    key: formkey[0],
                    child: Container(
                      child: Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: error,
                              child: Text(
                                "Please Give Main Group!..",
                                style: GoogleFonts.poppins(
                                  color: Colors.red,
                                  fontSize: Screens.width(context) * 0.03,
                                  // fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Container(
                              width: Screens.width(context),
                              padding:
                                  EdgeInsets.only(top: 1, left: 10, right: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButton(
                                hint: Text(
                                  "Select Main Group: ",
                                  style: TextStyles.headlineBlack1(context),
                                ),
                                value: valueSelectedMain,
                                //dropdownColor:Colors.green,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                isExpanded: true,
                                onChanged: (val) {
                                  setState(() {
                                    valueSelectedMain = val.toString();
                                    print(valueSelectedMain);
                                  });
                                },
                                items: mainValueValue.map((e) {
                                  return DropdownMenuItem(
                                      value: "${e.code}",
                                      child: Text(
                                        '${e.name}',
                                        style:
                                            TextStyles.headlineBlack1(context),
                                      ));
                                }).toList(),
                              ),
                            ),
                            SizedBox(
                              height: Screens.heigth(context) * 0.01,
                            ),
                            Visibility(
                              visible: error,
                              child: Text(
                                "Please Give Sub Group!..",
                                style: GoogleFonts.poppins(
                                  color: Colors.red,
                                  fontSize: Screens.width(context) * 0.03,
                                  // fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Container(
                              width: Screens.width(context),
                              padding:
                                  EdgeInsets.only(top: 1, left: 10, right: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButton(
                                hint: Text(
                                  "Select Sub Group: ",
                                  style: TextStyles.headlineBlack1(context),
                                ),
                                value: valueSelectedSub,
                                //dropdownColor:Colors.green,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                isExpanded: true,
                                onChanged: (val) {
                                  setState(() {
                                    valueSelectedSub = val.toString();
                                    print(valueSelectedSub.toString());
                                  });
                                },
                                items: subValueValue.map((e) {
                                  return DropdownMenuItem(
                                      value: "${e.code}",
                                      child: Text(
                                        e.name.toString(),
                                        style:
                                            TextStyles.headlineBlack1(context),
                                      ));
                                }).toList(),
                              ),
                            ),
                            SizedBox(
                              height: Screens.heigth(context) * 0.01,
                            ),
                            Visibility(
                              visible: error,
                              child: Text(
                                "Please Give Search Value!..",
                                style: GoogleFonts.poppins(
                                  color: Colors.red,
                                  fontSize: Screens.width(context) * 0.03,
                                  // fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            SizedBox(
                              child: new TextFormField(
                                controller: mycontroller[7],
                                onChanged: (val) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "ENTER QUANTITY";
                                  }
                                  return null;
                                },
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(05),
                                    ),
                                  ),
                                  // labelText: "Search!!..",
                                  hintText: "Search!!..",
                                  hintStyle: TextStyles.bodytextBlack1(context),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Screens.heigth(context) * 0.01,
                            ),
                            SizedBox(
                              child: new TextFormField(
                                controller: mycontroller[8],
                                onChanged: (val) {},
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(05),
                                    ),
                                  ),
                                  hintText: "Enter pack..",
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
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: theme.primaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text(
                                      "cancel",
                                      style: TextStyles.whiteText(context),
                                    )),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: theme.primaryColor,
                                    ),
                                    onPressed: () {
                                      setState(valuesAdd);
                                    },
                                    child: Text(
                                      "Search",
                                      style: TextStyles.whiteText(context),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ));
  }

  void errorMsg() {
    setState(() {
      error = true;
    });
  }

  bool error = false;
  void valuesAdd() {
    setState(() {
      ItemsAPi.mainGroup = valueSelectedMain;
      ItemsAPi.subGroup = valueSelectedSub;
      ItemsAPi.searchData = mycontroller[7].text;
      loadItemValues = true;
      Navigator.pop(context);
      ItemsAPi.getGlobalData(mycontroller[8].text).then((value) {
        setState(() {
          if (value.itemValueValue!.isNotEmpty) {
            print(value.itemValueValue![0].itemName);
            itemValue = value.itemValueValue!;
            filteritemValue = itemValue;
            ItemsAPi.nextUrl = value.nextLink;
            loadItemValues = false;
            //  print( value.nextLink);
            //  print( ItemsAPi.nextUrl);
            lenthofList = filteritemValue.length;
          } else if (value.itemValueValue!.isEmpty) {
            loadItemValues = false;
            const snackBar = SnackBar(
              duration: Duration(seconds: 5),
              backgroundColor: Colors.red,
              content: Text(
                'No Data!!..',
                style: TextStyle(color: Colors.white),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        });
      });
    });
  }

  String? valueSelectedMain;
  String? valueSelectedSub;
  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    final DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("are you sureeeeeeeeeeeeeeeee");
      //  Get.offAllNamed<dynamic>(FurneyRoutes.salesQuotes);
      pageController.animateToPage(--pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
      CreateDetailsState.contentAddItems = false;
      return Future.value(true);
    }
    pageController.animateToPage(--pageChanged,
        duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
    CreateDetailsState.contentAddItems = false;
    return Future.value(false);
  }

  bool visibleBtn = true;
  List<GlobalKey<FormState>> formkey =
      List.generate(3, (i) => GlobalKey<FormState>());
  void showBottomSheetInsert(int i, ThemeData theme) {
    //nznznz

    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Form(
                    key: formkey[0],
                    child: Container(
                      child: Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              child: new TextFormField(
                                controller: mycontroller[1],
                                onChanged: (val) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "ENTER UNIT PRICE";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  labelText: "unit price",
                                  labelStyle:
                                      TextStyles.bodytextBlack1(context),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),

                            SizedBox(
                              child: new TextFormField(
                                controller: mycontroller[2],
                                onChanged: (val) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "ENTER QUANTITY";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  labelText: "quantity",
                                  labelStyle:
                                      TextStyles.bodytextBlack1(context),
                                ),
                              ),
                            ),
                            //  ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              child: new TextFormField(
                                readOnly: true,
                                controller: mycontroller[3],
                                onChanged: (val) {},
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "ENTER DISCOUNT";
                                //   }else if(value.isNotEmpty){
                                //       double dis =double.parse(value);
                                //       if(dis>100){
                                //         return "DISCOUNT MORE THAN 100";
                                //       }
                                //   }
                                //   return null;
                                // },
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  labelText: "Discount",
                                  labelStyle:
                                      TextStyles.bodytextBlack1(context),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: Screens.width(context),
                              padding:
                                  EdgeInsets.only(top: 1, left: 10, right: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)),
                              child: GetValues.countryCode!.toLowerCase() ==
                                      'tanzania'
                                  ? DropdownButton(
                                      hint: Text(
                                        "Select Tax: ",
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                      value: valueChossed,
                                      //dropdownColor:Colors.green,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 30,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      isExpanded: true,
                                      onChanged: (val) {
                                        setState(() {
                                          if (val == 'O0 - 0 % Output VAT') {
                                            valueChosedReason = '0';
                                            taxCode = 'O0';
                                            taxSelected = double.parse(
                                                valueChosedReason.toString());
                                          } else if (val ==
                                              'O1 - 18 % Output VAT') {
                                            valueChosedReason = '18';
                                            taxCode = 'O1';
                                            taxSelected = double.parse(
                                                valueChosedReason.toString());
                                          } else if (val ==
                                              'O3 - Exempted Output VAT') {
                                            taxCode = 'O3';
                                            valueChosedReason = '0';
                                            taxSelected = double.parse(
                                                valueChosedReason.toString());
                                          } else if (val ==
                                              'X0 - Exempt Output') {
                                            valueChosedReason = '0';
                                            taxCode = 'X0';
                                            taxSelected = double.parse(
                                                valueChosedReason.toString());
                                          }

                                          valueChossed = val.toString();

                                          print(val.toString());
                                          print("valavalaa11: .........." +
                                              valueChosedReason.toString());
                                          print("taxSelected11: .........." +
                                              taxSelected.toString());
                                          print("taxCode11: .........." +
                                              taxCode.toString());
                                        });
                                      },
                                      items: taxData2.map((e) {
                                        return DropdownMenuItem(
                                            value: "${e['name']}",
                                            child: Text(
                                              e['name'].toString(),
                                              style: TextStyles.headlineBlack1(
                                                  context),
                                            ));
                                      }).toList(),
                                    )
                                  : DropdownButton(
                                      hint: Text(
                                        "Select Tax: ",
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                      value: valueChossed,
                                      //dropdownColor:Colors.green,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 30,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      isExpanded: true,
                                      onChanged: (val) {
                                        setState(() {
                                          if (val == 'O0 - 0 % Output VAT') {
                                            valueChosedReason = '0';
                                            taxCode = 'O0';
                                            taxSelected = double.parse(
                                                valueChosedReason.toString());
                                          } else if (val ==
                                              'O1 - 16 % Output VAT') {
                                            valueChosedReason = '16';
                                            taxCode = 'O1';
                                            taxSelected = double.parse(
                                                valueChosedReason.toString());
                                          } else if (val ==
                                              'O3 - Exempted Output VAT') {
                                            taxCode = 'O3';
                                            valueChosedReason = '0';
                                            taxSelected = double.parse(
                                                valueChosedReason.toString());
                                          } else if (val ==
                                              'X0 - Exempt Output') {
                                            valueChosedReason = '0';
                                            taxCode = 'X0';
                                            taxSelected = double.parse(
                                                valueChosedReason.toString());
                                          }

                                          valueChossed = val.toString();

                                          print(val.toString());
                                          print("valavalaa22: .........." +
                                              valueChosedReason.toString());
                                          print("taxSelected22: .........." +
                                              taxSelected.toString());
                                          print("taxCode22: .........." +
                                              taxCode.toString());
                                        });
                                      },
                                      items: taxData3.map((e) {
                                        return DropdownMenuItem(
                                            value: "${e['name']}",
                                            child: Text(
                                              e['name'].toString(),
                                              style: TextStyles.headlineBlack1(
                                                  context),
                                            ));
                                      }).toList(),
                                    ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: theme.primaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text(
                                      "cancel",
                                      style: TextStyles.whiteText(context),
                                    )),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: theme.primaryColor,
                                    ),
                                    onPressed: () {
                                      validation4Alert(context, i);
                                    },
                                    child: Text(
                                      "ok",
                                      style: TextStyles.whiteText(context),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ));
  }

  String? valueChossed;
  void showBottomSheetUpdate(int i, ThemeData theme) {
    //nznznz

    showModalBottomSheet<dynamic>(
        isDismissible: false,
        isScrollControlled: true,
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Form(
                    key: formkey[1],
                    child: Container(
                      child: Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              child: new TextFormField(
                                controller: mycontroller[4],
                                onChanged: (val) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "ENTER UNIT PRICE";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  labelText: "unit price",
                                  labelStyle:
                                      TextStyles.bodytextBlack1(context),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),

                            SizedBox(
                              child: new TextFormField(
                                controller: mycontroller[5],
                                onChanged: (val) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "ENTER QUANTITY";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  labelText: "quantity",
                                  labelStyle:
                                      TextStyles.bodytextBlack1(context),
                                ),
                              ),
                            ),
                            //  ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: Screens.width(context),
                              padding:
                                  EdgeInsets.only(top: 1, left: 10, right: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)),
                              child: GetValues.countryCode!.toLowerCase() ==
                                      'tanzania'
                                  ? DropdownButton(
                                      hint: Text(
                                        "Select Tax: ",
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                      value: valueChossed,
                                      //dropdownColor:Colors.green,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 30,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      isExpanded: true,
                                      onChanged: (val) {
                                        setState(() {
                                          if (val == 'O0 - 0 % Output VAT') {
                                            valueChosedReason = '0';
                                            taxCode = 'O0';
                                            taxSelected = double.parse(
                                                valueChosedReason.toString());
                                          } else if (val ==
                                              'O1 - 18 % Output VAT') {
                                            valueChosedReason = '18';
                                            taxCode = 'O1';
                                            taxSelected = double.parse(
                                                valueChosedReason.toString());
                                          } else if (val ==
                                              'O3 - Exempted Output VAT') {
                                            taxCode = 'O3';
                                            valueChosedReason = '0';
                                            taxSelected = double.parse(
                                                valueChosedReason.toString());
                                          } else if (val ==
                                              'X0 - Exempt Output') {
                                            valueChosedReason = '0';
                                            taxCode = 'X0';
                                            taxSelected = double.parse(
                                                valueChosedReason.toString());
                                          }

                                          valueChossed = val.toString();

                                          print(val.toString());
                                          print("valavalaa: .........." +
                                              valueChosedReason.toString());
                                          print("taxSelected: .........." +
                                              taxSelected.toString());
                                          print("taxCode: .........." +
                                              taxCode.toString());
                                        });
                                      },
                                      items: taxData2.map((e) {
                                        return DropdownMenuItem(
                                            value: "${e['name']}",
                                            child: Text(
                                              e['name'].toString(),
                                              style: TextStyles.headlineBlack1(
                                                  context),
                                            ));
                                      }).toList(),
                                    )
                                  : DropdownButton(
                                      hint: Text(
                                        "Select Tax: ",
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                      value: valueChossed,
                                      //dropdownColor:Colors.green,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 30,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      isExpanded: true,
                                      onChanged: (val) {
                                        setState(() {
                                          if (val == 'O0 - 0 % Output VAT') {
                                            valueChosedReason = '0';
                                            taxCode = 'O0';
                                            taxSelected = double.parse(
                                                valueChosedReason.toString());
                                          } else if (val ==
                                              'O1 - 16 % Output VAT') {
                                            valueChosedReason = '16';
                                            taxCode = 'O1';
                                            taxSelected = double.parse(
                                                valueChosedReason.toString());
                                          } else if (val ==
                                              'O3 - Exempted Output VAT') {
                                            taxCode = 'O3';
                                            valueChosedReason = '0';
                                            taxSelected = double.parse(
                                                valueChosedReason.toString());
                                          } else if (val ==
                                              'X0 - Exempt Output') {
                                            valueChosedReason = '0';
                                            taxCode = 'X0';
                                            taxSelected = double.parse(
                                                valueChosedReason.toString());
                                          }

                                          valueChossed = val.toString();

                                          print(val.toString());
                                          print("valavalaa: .........." +
                                              valueChosedReason.toString());
                                          print("taxSelected: .........." +
                                              taxSelected.toString());
                                          print("taxCode: .........." +
                                              taxCode.toString());
                                        });
                                      },
                                      items: taxData3.map((e) {
                                        return DropdownMenuItem(
                                            value: "${e['name']}",
                                            child: Text(
                                              e['name'].toString(),
                                              style: TextStyles.headlineBlack1(
                                                  context),
                                            ));
                                      }).toList(),
                                    ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    backgroundColor: theme.primaryColor,
                                  ),
                                  child: Text(
                                    "cancel",
                                    style: TextStyles.whiteText(context),
                                  ),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: theme.primaryColor,
                                    ),
                                    onPressed: () {
                                      log("taxSelectedtaxSelectedXX22:::${taxSelected}");

                                      validation4AlertUpdate(context, i);
                                    },
                                    child: Text(
                                      "Update",
                                      style: TextStyles.whiteText(context),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ));
  }

  List<Map<String, String>> taxData2 = [
    {"name": 'O0 - 0 % Output VAT'},
    {"name": "O1 - 18 % Output VAT"},
    {"name": "O3 - Exempted Output VAT"},
    {"name": "X0 - Exempt Output"},
  ];
  List<Map<String, String>> taxData3 = [
    {"name": 'O0 - 0 % Output VAT'},
    {"name": "O1 - 16 % Output VAT"},
    {"name": "O3 - Exempted Output VAT"},
    {"name": "X0 - Exempt Output"},
  ];

  String? valueChosedReason;
  String? taxCode;
  double taxSelected = 0;
  Future validation4Alert(BuildContext context, int i) async {
    if (formkey[0].currentState!.validate()) {
      final FocusScopeNode focus = FocusScope.of(context);
      if (!focus.hasPrimaryFocus) {
        focus.unfocus();
      }
      final double price = double.parse(mycontroller[1].text);
      final int qty = int.parse(mycontroller[2].text);
      final double discountper =
          double.parse(mycontroller[3].text == '' ? '0' : mycontroller[3].text);
      final double discount = (price * qty) * discountper / 100;
      final double taxper = taxSelected;
      final double tax = ((qty * price) - discount) * taxper / 100;

      double total = (price * qty) - discount;
      log("total1::::" + total.toString());
      total = total + tax;
      log("total2::::" + total.toString());
      int carton2 = 0;
      if (filteritemValue[i].U_Pack_Size! < 10 &&
          filteritemValue[i].U_Tins_Per_Box! > 0) {
        carton2 = qty ~/ filteritemValue[i].U_Tins_Per_Box!;
        print("cartooooooone" + carton2.toString());
        print("cartooooooone" + carton2.toInt().toString());
      }
      // double valueAF = (qty * price) - discount;
      itemsDetails.add(AddItem(
          itemCode: filteritemValue[i].itemCode.toString(),
          itemName: filteritemValue[i].itemName.toString(),
          discount: discount,
          price: price,
          qty: qty,
          total: total,
          tax: tax,
          valuechoosed: valueChossed,
          taxCode: taxCode.toString(),
          discounpercent: discountper,
          carton: carton2,
          valueAF: (price * qty) - discount,
          U_Pack_Size: filteritemValue[i].U_Pack_Size,
          U_Tins_Per_Box: filteritemValue[i].U_Tins_Per_Box,
          taxPer: taxper,
          salesPersonCode: filteritemValue[i].salesperCode));
      itemlen = itemsDetails.length;
      print('lenthList: ' + itemsDetails.length.toString());
      await pageController.animateToPage(--pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
      Navigator.pop(context);
      sumofTotal();
    }
  }

  double grandtotal = 0;
  double discount = 0;
  void sumofTotal() {
    double basictotalx = 0;
    double discount = 0;
    double tax = 0;
    setState(() {
      log("taxtaxtaxtotal:::${itemsDetails[0].taxPer}");
      if (itemsDetails.isNotEmpty) {
        for (int i = 0; i < itemsDetails.length; i++) {
          // basictotalx = basictotalx + itemsDetails[i].total!.toDouble();
          // discount = discount + itemsDetails[i].discount!.toDouble();
          // tax = tax + itemsDetails[i].tax!.toDouble();
          basictotalx = basictotalx +
              (itemsDetails[i].price!.toDouble() *
                  itemsDetails[i].qty!.toDouble());
          discount = discount +
              ((itemsDetails[i].price!.toDouble() *
                      itemsDetails[i].qty!.toDouble()) *
                  (itemsDetails[i].discounpercent! / 100));
          tax = tax + itemsDetails[i].tax!.toDouble();
        }
        print("basictotalx: " + basictotalx.toString());

        //total over

        // for (int i = 0; i < itemsDetails.length; i++) {

        // }
        HeaderCreationState.discount = discount;
        HeaderCreationState.tax = tax;
        HeaderCreationState.total = (basictotalx - discount) + tax;
        HeaderCreationState.totalBeforeDiscount = basictotalx;
      } else {
        setState(() {
          discount = 0.00;
          grandtotal = 0.00;
          tax = 0.00;
          basictotalx = 0;
          HeaderCreationState.total = (basictotalx - discount) + tax;
          HeaderCreationState.discount = discount;
          HeaderCreationState.tax = tax;
          HeaderCreationState.totalBeforeDiscount = basictotalx;
        });
      }
    });
  }

  Future validation4AlertUpdate(BuildContext context, int i) async {
    if (formkey[1].currentState!.validate()) {
      final double discperc = double.parse(mycontroller[6].text);
      // if(discperc <=100.00){
      final FocusScopeNode focus = FocusScope.of(context);
      if (!focus.hasPrimaryFocus) {
        focus.unfocus();
      }
      final double price = double.parse(mycontroller[4].text);
      final int qty = int.parse(mycontroller[5].text);
      final double discountper = double.parse(mycontroller[6].text);
      final double discount = (price * qty) * discountper / 100;

      final double taxper = taxSelected;
      log('taxSelectedtaxSelected:::${taxSelected}');
      final double tax = ((qty * price) - discount) * taxper / 100;
      final double total = (price * qty) - discount + tax;
      log('totaltotaltotal::${total}');
      final double valueAfdisc = (qty * price) - discount;
      int carton2 = 0;
      itemsDetails[i].price = price;
      itemsDetails[i].qty = qty;
      itemsDetails[i].discount = discount;
      itemsDetails[i].total = total;
      itemsDetails[i].tax = tax;
      itemsDetails[i].taxPer = taxper;

      itemsDetails[i].taxCode = taxCode.toString();
      itemsDetails[i].valuechoosed = valueChossed.toString();
      itemsDetails[i].discounpercent = discountper;
      itemsDetails[i].valueAF = valueAfdisc;
      if (itemsDetails[i].U_Pack_Size! < 10 &&
          itemsDetails[i].U_Tins_Per_Box! > 0) {
        carton2 = qty ~/ itemsDetails[i].U_Tins_Per_Box!;
        print("cartooooooone" + carton2.toString());
        print("cartooooooone" + carton2.toInt().toString());
      }
      itemsDetails[i].carton = carton2;
      Navigator.pop(context);
      sumofTotal();
      //   }
      // else{
      //    const snackBar = SnackBar(
      //                 duration: Duration(seconds: 5),
      //                 backgroundColor: Colors.red,
      //                 content: Text(
      //                   'Discount more than 100% !!..',
      //                   style: TextStyle(color: Colors.white),
      //                 ),
      //               );
      //               ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // }
    }
  }
}

class AddItem {
  String itemName;
  String itemCode;
  double? price;
  int? qty;
  double? discount;
  double? total;
  double? tax;
  double? taxPer;
  String? valuechoosed;
  String? taxCode;
  String? salesPersonCode;
  double? discounpercent;
  String? shipToCode;
  double? valueAF;
  int? carton;
  int? lineNo;
  double? U_Pack_Size;
  int? U_Tins_Per_Box;
  AddItem(
      {required this.itemCode,
      required this.salesPersonCode,
      required this.itemName,
      required this.price,
      required this.discount,
      required this.qty,
      required this.total,
      required this.tax,
      required this.valuechoosed,
      required this.taxCode,
      required this.discounpercent,
      required this.taxPer,
      this.shipToCode,
      this.valueAF,
      this.lineNo,
      this.carton,
      this.U_Pack_Size,
      this.U_Tins_Per_Box});

  Map<String, dynamic> tojson() {
    Map<String, String> map = {
      "ItemCode": itemCode,
      "ItemDescription": itemName,
      "DiscountPercent": discounpercent.toString(),
      "TaxCode": taxCode.toString(),
      "Quantity": qty.toString(),
      "UnitPrice": price.toString(),
      "Currency": GetValues.currency.toString(),
      "ShipToCode": LogisticPageState.shipto.toString(),
      "SalesPersonCode": GetValues.slpCode.toString(),
      "valueAF": valueAF.toString(),
      // "WarehouseCode": GetValues.branch.toString(),
    };
    return map;
  }
}
