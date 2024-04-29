// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new, require_trailing_commas, avoid_print, prefer_if_elements_to_conditional_expressions, prefer_const_literals_to_create_immutables, noop_primitive_operations, prefer_single_quotes

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/DB/DBHelper.dart';
import 'package:ultimate_bundle/src/furney/src/DB/DBModal/CusTomerModal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/delivery/widgets/delivery_appbar.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/creation/content_order_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/creation/header_order_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/creation/logistics_orders_creation.dart';

class ClosedOrders extends StatefulWidget {
  // required this.title
  const ClosedOrders({
    Key? key,
  }) : super(key: key);
  @override
  ClosedOrdersState createState() => ClosedOrdersState();
}

class ClosedOrdersState extends State<ClosedOrders> {
  List<Documents> cusDoc = [];
  List<Documents> cusDocFilter = [];

  @override
  void initState() {
    DataBaseHelper.getCustData().then((value) {
      setState(() {
        cusDoc = value;
        cusDocFilter = cusDoc;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body:
          // salesOrderValue.isEmpty?Center(
          //         child:  SpinKitThreeBounce(
          //                       size: Screens.heigth(context)*0.06,
          //                       color:theme.primaryColor,
          //                     ),
          //       ) :
          SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Screens.heigth(context) * 0.005,
              horizontal: Screens.width(context) * 0.02),
          child: Container(
            child: Column(
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
                          cusDocFilter = cusDoc
                              .where((e) =>
                                  e.bPCode
                                      .toLowerCase()
                                      .contains(v.toLowerCase()) ||
                                  e.bPName
                                      .toLowerCase()
                                      .contains(v.toLowerCase()))
                              .toList();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search for Orders',
                        hintStyle: TextStyles.bodytextBlack1(context),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {}, //
                          color: theme.primaryColor,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 5,
                        ),
                      ),
                    ),
                  ),
                ]),
                //      salesOrderValue.isEmpty && searchLoading == true
                // ?
                // Container(
                //   //color: Colors.amber,
                //   width: Screens.width(context),
                //   height: Screens.heigth(context)*0.72,
                //   child: Center(
                //       child: Visibility(
                //         visible: spin,
                //         child: SpinKitThreeBounce(
                //           size: Screens.heigth(context) * 0.06,
                //           color: theme.primaryColor,
                //         ),
                //       ),
                //     ),
                // )
                // :
                Expanded(
                  child: ListView.builder(
                      itemCount: cusDocFilter.length,
                      itemBuilder: (context, i) {
                        return Card(
                            elevation: 8,
                            child: InkWell(
                              onTap: () {
                                setAllNull(i);
                                //  print(i);
                                print('cus id : ${cusDocFilter[i].cusID}');

                                //  Get.toNamed<dynamic>(
                                // FurneyRoutes.creationOrderDetails);
                              },
                              child: Container(
                                height: Screens.heigth(context) * 0.07,
                                width: Screens.width(context),
                                decoration: const BoxDecoration(),
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
                                          width: Screens.width(context) * 0.2,
                                          child: Text(
                                            cusDocFilter[i].bPCode,
                                            style: TextStyles.bodytextBlack1(
                                                context),
                                          ),
                                        ),
                                        SizedBox(
                                          width: Screens.width(context) * 0.01,
                                        ),
                                        SizedBox(
                                          width: Screens.width(context) * 0.4,
                                          child: Text(
                                            cusDocFilter[i].bPName,
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
                                          //   Container(
                                          //     alignment: Alignment.centerRight,
                                          //  //    color: Colors.red,
                                          //     width: Screens.width(context)*0.22,
                                          //     child: Column(
                                          //       children: [
                                          //         Text(
                                          //         // filterSalesValue[i].cancelStatus=='csYes'&&filterSalesValue[i].documentStatus=='bost_Close' ?'Cancelled'
                                          //        '${cusDoc[i].docDate}'// // :filterSalesValue[i].cancelStatus=='csNo'&&filterSalesValue[i].documentStatus=='bost_Close' ?'Closed':''
                                          //         , style: TextStyles.bodytextBlack1(context),),
                                          //         Text(
                                          //         '${cusDoc[i].}'//  '${filterSalesValue[i].DocDate}'
                                          //           ,style:TextStyles.bodytextBlack1(context),),
                                          //       ],
                                          //     ),
                                          //   ),
                                          Icon(
                                            Icons.chevron_right,
                                            size: Screens.width(context) * 0.1,
                                            color: theme.primaryColor,
                                          )
                                        ],
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
          ),
        ),
      ),
    );
  }

  Future<void> setAllNull(int i) async {
    final preff = await SharedPreferences.getInstance();
    setState(() {
      HeaderOrderCreationState.isTextFiledEnabled = false;
      HeaderOrderCreationState.bpName = cusDocFilter[i].bPName;
      HeaderOrderCreationState.bpCode = cusDocFilter[i].bPCode;
      HeaderOrderCreationState.contactPerson = '';
      HeaderOrderCreationState.isHaveAdvance = '';
      // HeaderOrderCreationState.mycontroller[2].clear();
      // HeaderCreationState.docNo='';
      HeaderOrderCreationState.salesEmp =
          preff.getString('sapUserName').toString();
      // HeaderCreationState.currency='';
      HeaderOrderCreationState.status = 'open';
      HeaderOrderCreationState.total = 0.00;
      HeaderOrderCreationState.tax = 0.00;
      HeaderOrderCreationState.discount = 0.00;
      HeaderOrderCreationState.totalBeforeDiscount = 0.00;
      HeaderOrderCreationState.mycontroller[0].text = cusDocFilter[i].cusRefNo;
      HeaderOrderCreationState.mycontroller[1].text = cusDocFilter[i].remarks;
      //content creation
      ContentOrderCreationState.itemsDetails.clear();
      ContentOrderCreationState.carcode = cusDocFilter[i].bPCode;
      //
      LogisticOrderState.valueSelectedGPApproval =
          cusDocFilter[i].gPApprovalReq;
      LogisticOrderState.valueSelectedOrder = cusDocFilter[i].selectOrderType;
      LogisticOrderState.mycontroller[0].text = cusDocFilter[i].orderRecTime;
      LogisticOrderState.mycontroller[1].text = cusDocFilter[i].orderRecDate;
      LogisticOrderState.soDats = false;
      LogisticOrderState.soLimit = false;
      SwitchBtn.siwtchTrue = true;
      LogisticOrderState.cusID = '${cusDocFilter[i].cusID}';
      setallItems(i);
    });
  }

  void setallItems(int i) {
    DataBaseHelper.getItems(
            'CustomerDetails', '${cusDocFilter[i].cusID}', 'ItemDetails')
        .then((value) {
      print(value[0].itemName);
      for (var it = 0; it < value.length; it++) {
        ContentOrderCreationState.itemsDetails.add(AddItem(
            itemCode: value[it].itemCode,
            itemName: value[it].itemName,
            price: double.parse(value[it].price),
            discount: double.parse(value[it].discount),
            qty: int.parse(value[it].qty),
            total: double.parse(value[it].total),
            tax: double.parse(value[it].tax),
            valuechoosed: null,
            discounpercent: double.parse(value[it].discounpercent),
            taxCode: value[it].taxCode,
            wareHouseCode: value[it].wareHouseCose,
            valueAFdisc: value[it].valueAFDisc,
            taxName: value[it].taxCodeName,
            taxPer: 0,
            carton: int.parse(value[it].carton.toString() == 'null'
                ? "0"
                : value[it].carton.toString())));
      }
      sumofTotal();
      Get.toNamed<dynamic>(FurneyRoutes.creationOrderDetails);
    });
  }

  void sumofTotal() {
    var basictotal = 0.00;
    var discount = 0.00;
    var tax = 0.00;
    var grandtotal = 0.00;
    setState(() {
      if (ContentOrderCreationState.itemsDetails.isNotEmpty) {
        for (var i = 0;
            i < ContentOrderCreationState.itemsDetails.length;
            i++) {
          basictotal = basictotal +
              ContentOrderCreationState.itemsDetails[i].total!.toDouble();
        }
        print("grandtotal: $basictotal");

        //total over

        for (var i = 0;
            i < ContentOrderCreationState.itemsDetails.length;
            i++) {
          discount = discount +
              ContentOrderCreationState.itemsDetails[i].discount!.toDouble();
          tax = tax + ContentOrderCreationState.itemsDetails[i].tax!.toDouble();
        }
        HeaderOrderCreationState.discount = discount;
        HeaderOrderCreationState.tax = tax;
        HeaderOrderCreationState.total = basictotal - discount + tax;
        HeaderOrderCreationState.totalBeforeDiscount = basictotal;
      } else {
        setState(() {
          discount = 0.00;
          grandtotal = 0.00;
          tax = 0.00;
          HeaderOrderCreationState.total = grandtotal;
          HeaderOrderCreationState.discount = discount;
          HeaderOrderCreationState.tax = tax;
          HeaderOrderCreationState.totalBeforeDiscount = grandtotal;
        });
      }
    });
  }
}

///select B.ItemCode, B.ItemName, B.Price ,B.Qty from CustomerDetails A inner join ItemDetails B on A.CusId=B.CusId WHERE A.CusId = 2

//select B.ItemCode, B.ItemName, B.Price ,B.Qty ,B.DisCount,B.Total,B.WareHouseCose,B.Tax,B.TaxCode,B.Discounpercent from CustomerDetails A inner join ItemDetails B on A.CusId=B.CusId WHERE A.CusId =2
