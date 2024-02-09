// ignore: file_names
// ignore_for_file: file_names, prefer_interpolation_to_compose_strings, require_trailing_commas, prefer_const_constructors, unnecessary_new, omit_local_variable_types, noop_primitive_operations, prefer_single_quotes, unnecessary_statements, prefer_is_empty, unnecessary_lambdas, unawaited_futures, unnecessary_parenthesis, unnecessary_string_interpolations, prefer_final_locals, prefer_conditional_assignment

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
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/GetDiscountApi/GetDiscountApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/post_order_api/SOLogin/soPatchApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/post_order_api/checkOrderORDraft/draftSaveApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/post_order_api/checkOrderORDraft/orderordraft.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/post_order_api/getCreaditDays/getBalanceCreditLimit.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/post_order_api/getCreaditDays/getCreaditDaysApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/post_order_api/getCreaditDays/postMaxCommit.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/post_order_api/post_sales_order_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/special%20discount%20api/specialDiscountApi.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/item_modal/item_modal.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/item_modal/mainsubModal/mainModal.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/item_modal/mainsubModal/subModal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesOrderEdit/Screens/HederEdit.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesOrderEdit/Screens/LogisticOrderEdit.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/screens/create_order.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/creation/content_order_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/screens/create_quot.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:uuid/uuid.dart';

class ContentOrderEdit extends StatefulWidget {
  const ContentOrderEdit({Key? key}) : super(key: key);

  @override
  ContentOrderEditState createState() => ContentOrderEditState();
}

class ContentOrderEditState extends State<ContentOrderEdit> {
  PageController pageController = PageController();
  static List<AddItem> itemsDetails = [];
  static List<AddItem> itemsDetails2 = [];
  static List<AddItem> itemsDetails3 = [];
  static bool isCalculated = false;
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
  @override
  void initState() {
    // isCameforapprovalsales
    print(GetValues.branch);

 if(  CreateOrderDetailsState. isCameforapprovalsales==true){
  log("GetValues.sapUserName:::::"+GetValues.sapUserName!.toString()); 
   log("GetValues   UserName:::::"+GetValues.userName!.toString()); 
setValuesToListPageapproval();
}
    if(CreateOrderDetailsState.isCameFromqutation==true &&  isCalculated == false){
     

     setValuesToListPagequotation2();
    }

    if(itemsDetails3.length>0){
  setValuesToListPageapproval();
}
    // ItemsAPi.searchData = '';
    // ItemsAPi.getGlobalData().then((value) {
    //   if (value.itemValueValue!.isNotEmpty) {
    //     print(value.itemValueValue![0].itemPrices![0].PriceList);
    //     setState(() {
    //       itemValue = value.itemValueValue!;
    //       filteritemValue = itemValue;
    //       ItemsAPi.nextUrl = value.nextLink;
    //       lenthofList = filteritemValue.length;
    //     });
    //   }
    // });
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

  Future<void> getmoredata() async{
    setState(() {
     swipeLoad = true;
    });
  await ItemsAPi.callNextLink().then((val) {
       // minuslength = -1;
        if (val.itemValueValue!.isNotEmpty) {
          for (int i = 0; i < val.itemValueValue!.length; i++) {
            filteritemValue.add(ItemValue(
                itemCode: val.itemValueValue![i].itemCode,
                itemName: val.itemValueValue![i].itemName,
                odataetag: val.itemValueValue![i].odataetag,
                salesUnit: val.itemValueValue![i].salesUnit,
                itemPrices: val.itemValueValue![i].itemPrices,
                U_Pack_Size: val.itemValueValue![i].U_Pack_Size,
                U_Tins_Per_Box: val.itemValueValue![i].U_Tins_Per_Box));
          }
      setState(() {
          swipeLoad = false;
          print('lenthofList: ' + lenthofList.toString());
          print('lennList: ' + filteritemValue.length.toString());
          print(val.nextLink);
         // minuslength = 0;
      });

        }
    });
  }

  double? price;
  int? qty;
  List<MainModalValue> mainValueValue = [];
  List<SubModalValue> subValueValue = [];
  bool loaditemPage = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      body: PageView(
        // ignore: prefer_const_constructors
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
                        if (HeaderEditOrderPageState.isTextFiledEnabled ==
                            true) {
                          if (HeaderEditOrderPageState
                              .mycontroller[2].text.isEmpty) {
                            const snackBar = SnackBar(
                              duration: Duration(seconds: 5),
                              backgroundColor: Colors.red,
                              content: Text(
                                'Enter Bussiness Partner Name First!!..',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            pageController.animateToPage(++pageChanged,
                                duration: Duration(milliseconds: 250),
                                curve: Curves.bounceIn);
                            CreateDetailsState.contentAddItems = true;
                          }
                        } else {
                          if (HeaderEditOrderPageState.bpName != '') {
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
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)), backgroundColor: theme.primaryColor,
                      ),
                      child: Icon(Icons.add)),
                ),
              ),
            ),
            SizedBox(
              height: Screens.heigth(context) * 0.01,
            ),
          // CreateOrderDetailsState.isCameFromqutation==true?
            Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.only(
                      left: Screens.width(context) * 0.02,
                      right: Screens.width(context) * 0.02,
                    ),
                    itemCount: itemsDetails.length,
                    itemBuilder: (c, i) {
                      return InkWell(
                        onTap: (){
                          log("testtt: ${itemsDetails[i].discounpercent}");
                        }
                        ,
                        child: Card(
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
                                    '${itemsDetails[i].itemCode}', //'${quotDataFilter[i].DocNum}',
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
                                    '${itemsDetails[i].itemName}', //'${quotDataFilter[i].DocNum}',
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
                                      InkWell(
                                        // onTap:(){
                                        //   print(TextStyles.splitValues('${itemsDetails[i].price!.toStringAsFixed(2)}'));
                                        // },
                                        child: SizedBox(
                                          //  color: Colors.greenAccent,
                                          width: Screens.width(context) * 0.25,
                                          child: Text(
                                            'Price', //'${quotDataFilter[i].DocNum}',
                                            style: TextStyles.bodytextBlack1(
                                                context),
                                          ),
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
                                          // '${itemsDetails[i].price}', //'${quotDataFilter[i].DocNum}',
                                          TextStyles.splitValues(
                                              '${itemsDetails[i].price!.toStringAsFixed(2)}'),
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
                                          // TextStyles.splitValues('${itemsDetails[i].qty}'),
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
                                        child: Row(
                                          children: [
                                            Text(
                                              itemsDetails[i].discounpercent! <=
                                                      0.0
                                                  ? "000.00"
                                                  : TextStyles.splitValues(
                                                          '${itemsDetails[i].discounpercent!}')
                                                      .replaceAll(
                                                          new RegExp('^0+(?=.)'),
                                                          ''),
                                              style: TextStyles.bodytextBlack1(
                                                  context),
                                            ),
                                            Text(
                                              " %",
                                              style: TextStyles.bodytextBlack1(
                                                  context),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Container(
                                //   //   color: Colors.blueGrey,
                                //   width: Screens.width(context) * 0.9,
                                //   child: Row(
                                //     //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       Container(
                                //         //  color: Colors.greenAccent,
                                //         width: Screens.width(context) * 0.25,
                                //         child: Text(
                                //           'Discount', //'${quotDataFilter[i].DocNum}',
                                //           style:
                                //               TextStyles.bodytextBlack1(context),
                                //         ),
                                //       ),
                                //       Container(
                                //         //  color: Colors.greenAccent,
                                //         width: Screens.width(context) * 0.05,
                                //         child: Text(
                                //           ':', //'${quotDataFilter[i].DocNum}',
                                //           style:
                                //               TextStyles.bodytextBlack1(context),
                                //         ),
                                //       ),
                                //       Container(
                                //         //  color: Colors.greenAccent,
                                //         width: Screens.width(context) * 0.55,
                                //         child: Text(
                                //           // '${itemsDetails[i].discount}', //'${quotDataFilter[i].DocNum}',
                                //           TextStyles.splitValues(
                                //               '${itemsDetails[i].discount}'),
                                //           style:
                                //               TextStyles.bodytextBlack1(context),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
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
                                          TextStyles.splitValues(
                                              '${itemsDetails[i].valueAFdisc!.toStringAsFixed(2)}'),
                                          // TextStyles.splitValues('${itemsDetails[i].discount}'),
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
                                          'Tax', //'${quotDataFilter[i].DocNum}',
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
                                        width: Screens.width(context) * 0.58,
                                        child: Text(
                                          // '${itemsDetails[i].total! - itemsDetails[i].discount!}', //'${quotDataFilter[i].DocNum}',
                                          '${itemsDetails[i].taxName}',
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
                                          'Tax Amount', //'${quotDataFilter[i].DocNum}',
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
                                          // '${itemsDetails[i].total! - itemsDetails[i].discount!}', //'${quotDataFilter[i].DocNum}',

                                          TextStyles.splitValues(
                                              '${itemsDetails[i].tax!.toStringAsFixed(2)}'),
                                          style:
                                              TextStyles.bodytextBlack1(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //   SizedBox(
                                //   height: Screens.heigth(context) * 0.005,
                                // ),
                                // Container(
                                //   //   color: Colors.blueGrey,
                                //   width: Screens.width(context) * 0.9,
                                //   child: Row(
                                //     //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       Container(
                                //         //  color: Colors.greenAccent,
                                //         width: Screens.width(context) * 0.25,
                                //         child: Text(
                                //           'Total', //'${quotDataFilter[i].DocNum}',
                                //           style:
                                //               TextStyles.bodytextBlack1(context),
                                //         ),
                                //       ),
                                //       Container(
                                //         //  color: Colors.greenAccent,
                                //         width: Screens.width(context) * 0.05,
                                //         child: Text(
                                //           ':', //'${quotDataFilter[i].DocNum}',
                                //           style:
                                //               TextStyles.bodytextBlack1(context),
                                //         ),
                                //       ),
                                //       Container(
                                //         //  color: Colors.greenAccent,
                                //         width: Screens.width(context) * 0.2,
                                //         child: Text(

                                //           TextStyles.splitValues(
                                //               '${itemsDetails[i].total! }'),//- itemsDetails[i].discount!
                                //           style:
                                //               TextStyles.bodytextBlack1(context),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
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
                                          'Warehouse code', //'${quotDataFilter[i].DocNum}',
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
                                        width: Screens.width(context) * 0.2,
                                        child: Text(
                                          '${itemsDetails[i].wareHouseCode}', //'${quotDataFilter[i].DocNum}',
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
                                        mycontroller[4].text = itemsDetails[i]
                                            .price!
                                            .toStringAsFixed(2);
                                        mycontroller[5].text =
                                            itemsDetails[i].qty!.toString();
                                        mycontroller[6].text = itemsDetails[i]
                                            .discounpercent!
                                            .toStringAsFixed(2);
                                        // valueChossed =
                                        //     itemsDetails[i].valuechoosed;
                                        print("valuechoosed: " +
                                            itemsDetails[i]
                                                .valuechoosed
                                                .toString());
                                        print("taxName: " +
                                            itemsDetails[i].taxName.toString());
                                        if (itemsDetails[i]
                                            .taxName
                                            .toString()
                                            .contains("18 %")) {
                                          taxSelected = 0.00;
                                          taxSelected = 18.0;
                                        }
                                        selectedtaxName =
                                            itemsDetails[i].taxName.toString();
                                        //itemsDetails[i].tax!;
                                        if (itemsDetails[i].valuechoosed !=
                                            null) {
                                          valueChossed =
                                              itemsDetails[i].valuechoosed;
                                        } else if (itemsDetails[i].taxName !=
                                            null) {
                                          valueChossed = itemsDetails[i].taxName;
                                        }
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
                        ),
                      );
                    }))
          ],
        ),
        Visibility(
          visible: loaditemPage,
          child: Container(
            color: Colors.white54,
            child: Center(
              child: SpinKitThreeBounce(
                size: Screens.heigth(context) * 0.06,
                color: theme.primaryColor,
              ),
            ),
          ),
        )
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

                                    // ItemsAPi.getGlobalData().then((value) {
                                    //       if(value.itemValueValue!.length>0){
                                    //         setState(() {
                                    //           print(value.itemValueValue![0].itemPrices![0].PriceList);
                                    //         itemValue = value.itemValueValue!;
                                    //       filteritemValue = itemValue;
                                    //       ItemsAPi.nextUrl = value.nextLink;
                                    //       lenthofList = filteritemValue.length;
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
                        Expanded(
                          // width: Screens.width(context),
                          // height: Screens.heigth(context) * 0.72,
                          child: ListView.builder(
                              controller: scrollController,
                              itemCount:swipeLoad == true?1: filteritemValue.length ,
                              itemBuilder: (context, i) {//i == filteritemValue.length - 1
                                if (swipeLoad == true) {
                                  if (mycontroller[0].text.isEmpty) {
                                    if (ItemsAPi.nextUrl != 'null') {
                                      print("1111111");
                                      return SizedBox(
                                        width: Screens.width(context),
                                        height: Screens.heigth(context)*0.9,
                                        child: Center(
                                          child: SpinKitThreeBounce(
                                            size: Screens.width(context) * 0.06,
                                            color: theme.primaryColor,
                                          ),
                                        ),
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
                                            HeaderEditOrderPageState.bpCode;
                                        SpecialDiscountAPi.itemCode =
                                            filteritemValue[i].itemCode;
                                        print("ABBBVVV:::::+${SpecialDiscountAPi.cardCode}");
                                        print(SpecialDiscountAPi.itemCode);
                                        SpecialDiscountAPi.getGlobalData()
                                            .then((value) {
                                          if (value.specialValue!.length > 0) {
                                            setState(() {
                                              loadingscrn = false;
                                            });
                                            print(value.specialValue![0].Price);
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
                                            // showModalBottomSheet<dynamic>(context: context, builder:  (_) {
                                            //                     return
                                            //                       ShowBottomSheet();
                                            //                   });
                                            mycontroller[3].text = value
                                                        .specialValue![0]
                                                        .discount! >
                                                    0
                                                ? value
                                                    .specialValue![0].discount
                                                    .toString()
                                                : '';
                                            CreateOrderDetailsState
                                                .contentAddItems = false;
                                          } else if (value
                                                  .specialValue!.length <
                                              1) {
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
                                            CreateOrderDetailsState
                                                .contentAddItems = false;
                                          }
                                        });
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
                                  hintText: "Search!!..",
                                  // "Search!!..",
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
                                          borderRadius:
                                              BorderRadius.circular(5)), backgroundColor: theme.primaryColor,
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
                                              BorderRadius.circular(5)), backgroundColor: theme.primaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        valuesAdd();
                                        // if(valueSelectedMain!=null && valueSelectedSub!=null && mycontroller[7].text.isNotEmpty ){

                                        // }else{
                                        //     errorMsg();
                                        // }
                                      });
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
  bool loadItemValues = false;

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
            print(value.nextLink);
            ItemsAPi.nextUrl = value.nextLink;
            loadItemValues = false;

            print(ItemsAPi.nextUrl);
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
  bool isLoading = false;
  static String? carcode;
  Uuid uuid = Uuid();
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
    } else if (itemsDetails.length < 1) {
      const snackBar = SnackBar(
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        content: Text(
          'Please Add Items!!...',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (HeaderEditOrderPageState.mycontroller[0].text.isEmpty) {
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Please Fill Customer Ref.No!!...',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (LogisticEditORderState.valueSelectedOrder == null) {
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Please Choose Select Order Type!!...',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (LogisticEditORderState.valueSelectedGPApproval == null) {
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Please choose GP Approval !!...',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (LogisticEditORderState.mycontroller[0].text.isEmpty) {
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Please Fill Order Received Time !!...',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (LogisticEditORderState.mycontroller[1].text.isEmpty) {
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Please Fill Order Received Date!!...',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      setState(() => isLoading = true);
     SalesOrderPatchAPi.cardCodePost = carcode;
     SalesOrderPatchAPi.cardNamePost = HeaderEditOrderPageState.bpName;
     SalesOrderPatchAPi.docLineQout = itemsDetails;
     SalesOrderPatchAPi.docDate =
          HeaderEditOrderPageState.currentDateTime.toString();
     SalesOrderPatchAPi.dueDate =
          HeaderEditOrderPageState.currentDateTime.toString();
     SalesOrderPatchAPi.remarks = HeaderEditOrderPageState.mycontroller[1].text;
     SalesOrderPatchAPi.orderDate = LogisticEditORderState.mycontroller[1].text;
     SalesOrderPatchAPi.orderType = LogisticEditORderState.valueSelectedOrder;
     SalesOrderPatchAPi.gpApproval = LogisticEditORderState.valueSelectedGPApproval;
     SalesOrderPatchAPi.orderTime = LogisticEditORderState.mycontroller[0].text;
     SalesOrderPatchAPi.custREfNo =
          HeaderEditOrderPageState.mycontroller[0].text;
     SalesOrderPatchAPi.deviceTransID = uuid.v1();
     SalesOrderPatchAPi.deviceCode = GetValues.deviceID;
      CheckOrderORDraftAPi.deviceTransID =SalesOrderPatchAPi.deviceTransID;
      CheckOrderORDraftAPi.deviceCode =SalesOrderPatchAPi.deviceCode;
      DraftSaveAPi.deviceCode =SalesOrderPatchAPi.deviceCode;
      DraftSaveAPi.deviceTransID =SalesOrderPatchAPi.deviceTransID;
      currentDate();
      // callPostApi();
      double getcreditLimit;
      GettCreditDaysAPi.cardCode = HeaderEditOrderPageState.bpCode;
      GettCreditDaysAPi.date = currentDateTime;
      GetBalanceCreditAPi.cardCode = HeaderEditOrderPageState.bpCode;
      if (HeaderEditOrderPageState.isHaveAdvance
              .toLowerCase()
              .contains("advance") ||
          HeaderEditOrderPageState.isTextFiledEnabled == false) {
        // print("objectokkkkkokkkkk");
        //  print(HeaderEditOrderPageState.isHaveAdvance.toLowerCase());
        GetBalanceCreditAPi.getGlobalData().then((value) {
          if (value.balanceCreaditValue!.isNotEmpty) {
            getcreditLimit = value.balanceCreaditValue![0].CreditLimit!;
            callSaveApi(getcreditLimit);
          } else if (value.balanceCreaditValue!.isEmpty) {
            callSaveApi(0);
          }
        });
      } else {
        print("hold");
        callPostApi();
      }
    }
  }

  void callSaveApi(double getCredit) {
    GettCreditDaysAPi.getGlobalData().then((value) {
      if (value.creaditDaysValueValue![0].CreditDays == 0) {
        GetBalanceCreditAPi.getGlobalData().then((value) {
          if (value.balanceCreaditValue!.isNotEmpty) {
            double? balance = value.balanceCreaditValue![0].Balance;

            double? creditLimit = value.balanceCreaditValue![0].CreditLimit;

            print("Bala: $balance");
            print("creditLimit: $creditLimit");
            double ans =
                creditLimit! - balance! - HeaderEditOrderPageState.total;
            print("assssaasasa: $ans");
            if (ans < 0) {
              PostMaxCommitAPi.cardCodePost = HeaderEditOrderPageState.bpCode;
              PostMaxCommitAPi.value = "${100.00 + getCredit}";
              PostMaxCommitAPi.getGlobalData().then((value) {
                callPostApi();
                //SalesOrderPatchAPi.method();
              });
            } else {
              callPostApi();
              //SalesOrderPatchAPi.method();
            }
          } else {
            callPostApi();
          }
        });
      } else if (value.creaditDaysValueValue![0].CreditDays! > 0) {
        PostMaxCommitAPi.cardCodePost = HeaderEditOrderPageState.bpCode;
        PostMaxCommitAPi.value = "${50.00 + getCredit}";
        PostMaxCommitAPi.getGlobalData().then((value) {});
        callPostApi();
        //  SalesOrderPatchAPi.method();
      }
    });
  }

  String? currentDateTime;
  void currentDate() {
    DateTime now = DateTime.now();
    setState(() {
      String val =
          "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
      currentDateTime = val;
      print(currentDateTime);
    });
  }

  String? currentDateTime2;
  void currentDate2() {
    DateTime now = DateTime.now();
    setState(() {
      String val =
          "${now.year.toString()}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}";
      currentDateTime2 = val;
      print(currentDateTime2);
    });
  }

  void callPostApi() {
    //SalesOrderPatchAPi.getGlobalData().then((value) {
    //   if (value.statusCode == '201' || value.statusCode == '204') {
    //     checkORderORDraft();
    //   } else {
    //     setState(() => isLoading = false);
    //     // print(value.statusCode);
    //     final snackBar = SnackBar(
    //       duration: Duration(seconds: 5),
    //       backgroundColor: Colors.red,
    //       content: Text(
    //         '${value.error!.message!.value}!!..', //
    //         style: TextStyle(color: Colors.white),
    //       ),
    //     );
    //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //   }
    // });
  }

  void nullallValues() {
    carcode = null;
  }

  void checkORderORDraft() {
    CheckOrderORDraftAPi.urlss();
    CheckOrderORDraftAPi.getGlobalData().then((value) {
      if (value.orderORDraftValue!.length > 0) {
        showDetailBox('Order Created Successfully !!..');
      } else if (value.orderORDraftValue!.length < 1) {
        callDraftApi();
      }
    });
  }

  void callDraftApi() {
    DraftSaveAPi.urlss();
    DraftSaveAPi.getGlobalData().then((value) {
      if (value.orderORDraftValue!.length > 0) {
        showDetailBox('Orders needs approval hence saved as draft !!..');
      } else {
        showDetailBox('Order Not Successfull Please Try Again !!..');
      }
    });
  }

  void showDetailBox(String msg) {
    //print("object");
    showDialog<dynamic>(
      context: context,
      builder: (context) {
        // String contentText = "Content of Dialog";
        return StatefulBuilder(
          builder: (context, setState) {
            final theme = Theme.of(context);
            return AlertDialog(
              //    title: Text("Title of Dialog"),
              content: SizedBox(
                //  color: Colors.black12,
                // height: Screens.heigth(context) * 0.4,
                width: Screens.width(context) * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "$msg",
                      style: TextStyles.headlineBlack1(context),
                    ),
                    SizedBox(
                      height: Screens.heigth(context) * 0.02,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() => isLoading = false);
                          Get.offAllNamed<dynamic>(FurneyRoutes.newSalesOrders);
                          //  Navigator.pop(context);
                        },
                        child: Text(
                          'ok',
                          style: TextStyles.whiteText(context),
                        ))
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();
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
valueChossed = null;
    showModalBottomSheet<dynamic>(
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
                                onEditingComplete: () {
                                  print("onEditingComplete");
                                  setState(() {
                                    loadingscrn = true;
                                  });
                                  Future.delayed(Duration(seconds: 2), () {
                                    setState(() {
                                      loadingscrn = false;
                                    });
                                  });
                                },
                                // onFieldSubmitted:(v){
                                //    print("onFieldSubmitted");
                                // },
                                // onSaved: (v){
                                //    print("onSaved");
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
                                //   } else if (value.isNotEmpty) {
                                //     double dis = double.parse(value);
                                //     if (dis > 100) {
                                //       return "DISCOUNT MORE THAN 100";
                                //     }
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
                              child: DropdownButton(
                                hint: Text(
                                  "Select Tax: ",
                                  style: TextStyles.bodytextBlack1(context),
                                ),
                                value: valueChossed,
                                //dropdownColor:Colors.green,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                isExpanded: true,
                                onChanged: (val) {
                                  print(val);
                                  setState(() {
                                    if (val == 'O0 - 0 % Output VAT') {
                                      selectedtaxName = 'O0 - 0 % Output VAT';
                                      valueChosedReason = '0';
                                      taxCode = 'O0';
                                      taxSelected = 0.00;
                                      taxSelected = double.parse(
                                          valueChosedReason.toString());
                                    } else if (val == 'O1 - 18 % Output VAT') {
                                      selectedtaxName = 'O1 - 18 % Output VAT';
                                      valueChosedReason = '18';
                                      taxCode = 'O1';
                                      taxSelected = 0.00;
                                      taxSelected = double.parse(
                                          valueChosedReason.toString());
                                    } else if (val ==
                                        'O3 - Exempted Output VAT') {
                                      selectedtaxName =
                                          'O3 - Exempted Output VAT';
                                      taxCode = 'O3';
                                      valueChosedReason = '0';
                                      taxSelected = 0.00;
                                      taxSelected = double.parse(
                                          valueChosedReason.toString());
                                    } else if (val == 'X0 - Exempt Output') {
                                      selectedtaxName = 'X0 - Exempt Output';
                                      valueChosedReason = '0';
                                      taxCode = 'X0';
                                      taxSelected = 0.00;
                                      taxSelected = double.parse(
                                          valueChosedReason.toString());
                                    }

                                    if('null'==val.toString()){
                                      valueChossed = null;
                                    }else{
                                      valueChossed = val.toString();
                                    }
                                    
                                  });
                                },
                                items: taxData2.map((e) {
                                  return DropdownMenuItem(
                                      value: "${e['name']}",
                                      child: Text(
                                        e['name'].toString(),
                                        style:
                                            TextStyles.headlineBlack1(context),
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
                                              BorderRadius.circular(5)), backgroundColor: theme.primaryColor,
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
                                              BorderRadius.circular(5)), backgroundColor: theme.primaryColor,
                                    ),
                                    onPressed: () {
                                      validation4Insert(context, i);
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
  String? selectedtaxName = "O0 - 0 % Output VAT";
  void showBottomSheetUpdate(int i, ThemeData theme) {
    //nznznz

    showModalBottomSheet<dynamic>(
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
                                readOnly: true,
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
                            SizedBox(
                              child: new TextFormField(
                                readOnly: true,
                                controller: mycontroller[6],
                                onChanged: (val) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "ENTER DISCOUNT";
                                  } else if (value.isNotEmpty) {
                                    double dis = double.parse(value);
                                    if (dis > 100) {
                                      return "DISCOUNT MORE THAN 100";
                                    }
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
                                  labelText: "Discount",
                                  labelStyle:
                                      TextStyles.bodytextBlack1(context),
                                ),
                              ),
                            ),
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
                              child: DropdownButton(
                                hint: Text(
                                  "Select Tax: ",
                                  style: TextStyles.bodytextBlack1(context),
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
                                      selectedtaxName = 'O0 - 0 % Output VAT';
                                      valueChosedReason = '0';
                                      taxCode = 'O0';
                                      taxSelected = 0.00;
                                      taxSelected = double.parse(
                                          valueChosedReason.toString());
                                    } else if (val == 'O1 - 18 % Output VAT') {
                                      selectedtaxName = 'O1 - 18 % Output VAT';
                                      valueChosedReason = '18';
                                      taxCode = 'O1';

                                      taxSelected = 0.00;
                                      taxSelected = double.parse(
                                          valueChosedReason.toString());
                                    } else if (val ==
                                        'O3 - Exempted Output VAT') {
                                      selectedtaxName =
                                          'O3 - Exempted Output VAT';
                                      taxCode = 'O3';
                                      valueChosedReason = '0';
                                      taxSelected = 0.00;
                                      taxSelected = double.parse(
                                          valueChosedReason.toString());
                                    } else if (val == 'X0 - Exempt Output') {
                                      selectedtaxName = 'X0 - Exempt Output';
                                      valueChosedReason = '0';
                                      taxCode = 'X0';
                                      taxSelected = double.parse(
                                          valueChosedReason.toString());
                                    }
                                    if('null'==  val.toString()){
                                      valueChossed = null;
                                    }else{
                                        valueChossed = val.toString();
                                    }
                                    
                                  });
                                },
                                items: taxData2.map((e) {
                                  return DropdownMenuItem(
                                      value: "${e['name']}",
                                      child: Text(
                                        e['name'].toString(),
                                        style:
                                            TextStyles.headlineBlack1(context),
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
                                              BorderRadius.circular(5)), backgroundColor: theme.primaryColor,
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
                                              BorderRadius.circular(5)), backgroundColor: theme.primaryColor,
                                    ),
                                    onPressed: () {
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
  String? valueChosedReason = '0';
  double taxSelected = 0;

  Future validation4Insert(BuildContext context, int i) async {
    if(valueChossed == null){
      valueChossed = 'O0 - 0 % Output VAT';
    }
   
    if (formkey[0].currentState!.validate()) {
       Navigator.pop(context);
    setState(() {
      loadingscrn = true;
    });
      FocusScopeNode focus = FocusScope.of(context);
      if (!focus.hasPrimaryFocus) {
        focus.unfocus();
      }
      currentDate2();
      DiscountAPi.getGlobalData(
              HeaderEditOrderPageState.bpCode,
              SpecialDiscountAPi.itemCode!,
              mycontroller[2].text,
              currentDateTime2!)
          .then((value) {
        if (value.error == null &&
            value.exception == null &&
            value.price != null &&
            value.discount != null) {
          print("priceeeee");
          print(
              "value.discount!.toStringAsFixed(2) ${value.discount!.toStringAsFixed(2)}");
          mycontroller[1].text = value.price != 0.0
              ? value.price!.toStringAsFixed(2)
              : mycontroller[1].text;
          mycontroller[3].text = value.discount!.toStringAsFixed(2);
          setValuesToListPage(i);

          // value.price
        } else if (value.error != null &&
            value.exception == null &&
            value.price == null &&
            value.discount == null) {
          print("erroreeeee");
        } else if (value.error == null &&
            value.exception != null &&
            value.price == null &&
            value.discount == null) {
          print("exceptionsssssssssss");
        }
      });

      // Navigator.pop(context);
    }
  }

  void quotationforsale(){
    setValuesToListPagequotation2();
  }
void setValuesToListPageapproval() {
   
  itemsDetails.clear();
  for(int i=0;i<itemsDetails3.length; i++){
      double price = itemsDetails3[i].price!;
    int qty = itemsDetails3[i].qty!;
    double discountper = itemsDetails3[i].discounpercent!;
    double discount = (price * qty) * discountper / 100;
    double taxper = itemsDetails3[i].taxPer!;

    double taxs = ((qty * price) - discount)* taxper / 100;
  
    double total = (qty * price)- discount; //- discount) + taxs
    total=total+taxs;

    double bfd = (qty * price); 


    int carton1 = 0;
    print("tax: " + taxs.toStringAsFixed(0));
    // if (filteritemValue[i].U_Pack_Size! < 10 &&
    //     filteritemValue[i].U_Tins_Per_Box! > 0) {
    //   carton1 = (qty / filteritemValue[i].U_Tins_Per_Box!).toInt();
    //   // print("cartooooooone"+carton1.toString());
    //   // print("cartooooooone"+carton1.toInt().toString());
    // }

    double valueAFdisc1 = (qty * price) - discount;
    itemsDetails.add(AddItem(
        itemCode: itemsDetails3[i].itemCode.toString(),
        itemName: itemsDetails3[i].itemName.toString(),
        discount: discount,
        price: price,
        qty: qty,
        total: total,
        tax: taxs,
        valueBFdisc: bfd,
        valuechoosed: valueChossed,
        taxCode: taxCode.toString(),
        discounpercent: discountper.toDouble(),
        wareHouseCode: itemsDetails3[i].wareHouseCode,
        taxName: itemsDetails3[i].taxName,
        carton: carton1,
        U_Pack_Size: itemsDetails3[i].U_Pack_Size??0.0,
        U_Tins_Per_Box: itemsDetails3[i].U_Tins_Per_Box??0,
        valueAFdisc: valueAFdisc1,
        taxPer: taxper,
         basedocentry:itemsDetails3[i].basedocentry ,
         baseline:itemsDetails3[i].baseline,
        BaseType: itemsDetails3[i].BaseType
                ));
  

  
    // pageController.animateToPage(--pageChanged,
    //     duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
    sumofTotal();
    setState(() {
      // CreateOrderDetailsState.isCameFromqutation=false;
      loadingscrn = false;
    });
    }
    itemsDetails;
    itemsDetails3.clear();
  }

void setValuesToListPagequotation2() {
   
  itemsDetails.clear();
  for(int i=0;i<itemsDetails2.length; i++){
      double price = itemsDetails2[i].price!;
    int qty = itemsDetails2[i].qty!;
    double discountper = itemsDetails2[i].discounpercent!;
    double discount = (price * qty) * discountper / 100;
    double taxvalue = itemsDetails2[i].tax!;

   // double taxs = ((qty * price) - discount)* taxper / 100;
  
    double total = (qty * price)- discount; //- discount) + taxs
    total=total+taxvalue;

    double bfd = (qty * price); 


    int carton1 = 0;
    print("tax: " + taxvalue.toStringAsFixed(0));
    // if (filteritemValue[i].U_Pack_Size! < 10 &&
    //     filteritemValue[i].U_Tins_Per_Box! > 0) {
    //   carton1 = (qty / filteritemValue[i].U_Tins_Per_Box!).toInt();
    //   // print("cartooooooone"+carton1.toString());
    //   // print("cartooooooone"+carton1.toInt().toString());
    // }

    double valueAFdisc1 = (qty * price) - discount;
    itemsDetails.add(AddItem(
        itemCode: itemsDetails2[i].itemCode.toString(),
        itemName: itemsDetails2[i].itemName.toString(),
        discount: discount,
        price: price,
        qty: qty,
        total: total,
        tax: taxvalue,
        valueBFdisc: bfd,
        valuechoosed: valueChossed,
        taxCode: itemsDetails2[i].taxCode,
        discounpercent: discountper.toDouble(),
        wareHouseCode: itemsDetails2[i].wareHouseCode,
        taxName: getTaxNane(itemsDetails2[i].taxCode.toString()),
        carton: carton1,
        U_Pack_Size: itemsDetails2[i].U_Pack_Size??0.0,
        U_Tins_Per_Box: itemsDetails2[i].U_Tins_Per_Box??0,
        valueAFdisc: valueAFdisc1,
        taxPer: itemsDetails2[i].taxPer,
        basedocentry:itemsDetails2[i].basedocentry ,
        baseline:itemsDetails2[i].baseline 
         ));
  

  
    // pageController.animateToPage(--pageChanged,
    //     duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
  
    setState(() {
      // CreateOrderDetailsState.isCameFromqutation=false;
      loadingscrn = false;
    });
    }
        isCalculated = true;
      sumofTotal();
  }

 String getTaxNane(String code){
  String res = '';
  switch (code) {
     case "O0":
     res =  'O0 - 0 % Output VAT';
     break;

     case "O1":
     res =  'O1 - 18 % Output VAT';
     break;

     case "O3":
     res =  'O3 - Exempted Output VAT';
     break;

     case "0":
     res =  'X0 - Exempt Output';
     break;

     case "null":
     res =  'O0 - 0 % Output VAT';
     break;
  }
    return res;
  }


  void setValuesToListPage(int i) {
    double price = double.parse(mycontroller[1].text);
    int qty = int.parse(mycontroller[2].text);
    double discountper =
        double.parse(mycontroller[3].text == '' ? "0" : mycontroller[3].text);
    double discount = (price * qty) * discountper / 100;
    double taxper = taxSelected;

    double taxs = ((qty * price) - discount)* taxper / 100;
    print("qty*price "+(qty * price).toString());
    print("qty*price- discount: "+(qty * price- discount).toString());
    print("qty*price- discount* taxper / 100 : "+((qty * price- discount)* taxper / 100).toString());
    double total = (qty * price)- discount; //- discount) + taxs
    total=total+taxs;

    double bfd = (qty * price); 


    int carton1 = 0;
    print("tax: " + taxs.toStringAsFixed(0));
    if (filteritemValue[i].U_Pack_Size! < 10 &&
        filteritemValue[i].U_Tins_Per_Box! > 0) {
      carton1 = qty ~/ filteritemValue[i].U_Tins_Per_Box!;
      // print("cartooooooone"+carton1.toString());
      // print("cartooooooone"+carton1.toInt().toString());
    }

    double valueAFdisc1 = (qty * price) - discount;
    itemsDetails.add(AddItem(
        itemCode: filteritemValue[i].itemCode.toString(),
        itemName: filteritemValue[i].itemName.toString(),
        discount: discount,
        price: price,
        qty: qty,
        total: total,
        tax: taxs,
        valueBFdisc: bfd,
        valuechoosed: valueChossed,
        taxCode: taxCode.toString(),
        discounpercent: discountper.toDouble(),
        wareHouseCode: GetValues.branch,
        taxName: selectedtaxName,
        carton: carton1,
        U_Pack_Size: filteritemValue[i].U_Pack_Size,
        U_Tins_Per_Box: filteritemValue[i].U_Tins_Per_Box,
        valueAFdisc: valueAFdisc1,
        taxPer: taxper));
    pageController.animateToPage(--pageChanged,
        duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
    sumofTotal();
    setState(() {
      loadingscrn = false;
    });
  }

  String? taxCode ='O0';
  double grandtotal = 0;
  double discount = 0;


  void sumofTotal() {
    double basictotal = 0;
    double discount = 0;
    double tax = 0;
    double bfd = 0;
    setState(() {
      if (itemsDetails.isNotEmpty) {
        for (int i = 0; i < itemsDetails.length; i++) {
          basictotal = basictotal + itemsDetails[i].total!.toDouble();
          discount = discount + itemsDetails[i].discount!.toDouble();
          tax = tax + itemsDetails[i].tax!.toDouble();
          bfd = bfd + itemsDetails[i].valueBFdisc!.toDouble();
        }
        print("basictotal: " + basictotal.toString());

        //total over
        HeaderEditOrderPageState.discount = discount;
        HeaderEditOrderPageState.tax = tax;
        HeaderEditOrderPageState.total = basictotal ;
        HeaderEditOrderPageState.totalBeforeDiscount = bfd;
      } else {
        setState(() {
          discount = 0.00;
          grandtotal = 0.00;
          tax = 0.00;
          HeaderEditOrderPageState.total = grandtotal;
          HeaderEditOrderPageState.discount = discount;
          HeaderEditOrderPageState.tax = tax;
          HeaderEditOrderPageState.totalBeforeDiscount = grandtotal;
        });
      }
    });
  }

  Future validation4AlertUpdate(BuildContext context, int i) async {
  
    if (formkey[1].currentState!.validate()) {
      FocusScopeNode focus = FocusScope.of(context);
      if (!focus.hasPrimaryFocus) {
        focus.unfocus();
      }
      currentDate2();
        Navigator.pop(context);
    setState(() {
      loaditemPage = true;
    });
      SpecialDiscountAPi.itemCode =itemsDetails[i].itemCode;
      DiscountAPi.getGlobalData(
              HeaderEditOrderPageState.bpCode,
              SpecialDiscountAPi.itemCode!,
              mycontroller[5].text,
              currentDateTime2!)
          .then((value) {
        if (value.error == null &&
            value.exception == null &&
            value.price != null &&
            value.discount != null) {
          print("priceeeee");
          print(
              "value.discount!.toStringAsFixed(2) ${value.discount!.toStringAsFixed(2)}");
          mycontroller[4].text = value.price != 0.0
              ? value.price!.toStringAsFixed(2)
              : mycontroller[4].text;
          mycontroller[6].text = value.discount!.toStringAsFixed(2);
          updateValuesToListPage(i);

          // value.price
        } else if (value.error != null &&
            value.exception == null &&
            value.price == null &&
            value.discount == null) {
          print("erroreeeee");
        } else if (value.error == null &&
            value.exception != null &&
            value.price == null &&
            value.discount == null) {
          print("exceptionsssssssssss");
        }
      });
    }
  }

  void updateValuesToListPage(int i) {
    double prices = double.parse(mycontroller[4].text);
    int qtys = int.parse(mycontroller[5].text);
    double discountpers = double.parse(mycontroller[6].text);
    double discounts = (prices * qtys) * discountpers / 100;
    double taxper = taxSelected;
    double taxs = ((qtys * prices) - discounts) * taxper / 100;
    double totals = (qtys * prices); //- discounts) + taxs
    double valueAFDisc = qtys * prices - discounts;
    int carton2 = 0;
    itemsDetails[i].price = prices;
    itemsDetails[i].qty = qtys;
    itemsDetails[i].discount = discounts;
    itemsDetails[i].total = totals;
    // itemsDetails[i].tax = taxper; change to down line because if we update the tax its show percentage not show amount
    itemsDetails[i].tax = taxs;
    itemsDetails[i].taxCode = taxCode.toString();
    itemsDetails[i].taxName = selectedtaxName;
    itemsDetails[i].valuechoosed = valueChossed.toString();
    itemsDetails[i].discounpercent = discountpers.toDouble(); //selectedtaxName
    itemsDetails[i].valueAFdisc = valueAFDisc;
          itemsDetails[i].taxPer=taxper;

    if (itemsDetails[i].U_Pack_Size! < 10 &&
        itemsDetails[i].U_Tins_Per_Box! > 0) {
      carton2 = qtys ~/ itemsDetails[i].U_Tins_Per_Box!;
      print("cartooooooone" + carton2.toString());
      print("cartooooooone" + carton2.toInt().toString());
    }
    itemsDetails[i].carton = carton2;
    sumofTotal();
    setState(() {
      loaditemPage = false;
    });
  }
}

