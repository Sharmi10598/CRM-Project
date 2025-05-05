// ignore_for_file: file_names, unnecessary_lambdas, prefer_single_quotes, prefer_const_constructors, unawaited_futures, unnecessary_statements, unnecessary_parenthesis, prefer_final_locals, omit_local_variable_types, avoid_redundant_argument_values, prefer_if_elements_to_conditional_expressions

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/streamDataApi/streamDataapi.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_oder/sales_orderdetails_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesOrderEdit/Screens/ContentEdit.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesOrderEdit/Screens/EditOrder.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesOrderEdit/Screens/HederEdit.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/creation/content_order_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/screens/SalesQutDetails.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sign_in/widgets/custom_elevatedBtn.dart';

import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class HeaderOrders extends StatefulWidget {
  HeaderOrders({Key? key, this.salValue}) : super(key: key);
  SalesOrderDetailsValue? salValue;
  @override
  HeaderOrderstState createState() => HeaderOrderstState();
}

class HeaderOrderstState extends State<HeaderOrders> {
  static String? docNO;
  static String? cusName;
  static String? contactPerson; //no
  static String? currency;
  static String? salesEmployee; //no
  static String? customerRefNo; //no
  static String? status;
  static String? postingDate; //no
  static String? validUntill; //no
  static String? documentDate;
  static String? remarks; //no
  static double? totalBeforeDisc; //no
  static double? discnt; //no
  static String? tax;
  static String? total;
  static String? orderDate; //no
  static String? order_Type; //no
  static String? GP_Approval;
  static String? received_Time;
  static List<DocumentSalesOrdeValue>? documentLines = [];

  setHeaderValues() {
    double taxX = 0;
    double totalx = 0;
    double taxRate = 0;

    totalBeforeDisc = 0;
    discnt = 0;
    for (int i = 0; i < documentLines!.length; i++) {
      if (documentLines![i].TaxCode == 'O1') {
        if (GetValues.countryCode!.toLowerCase().trim() == 'tanzania') {
          taxRate = 18;
        } else {
          taxRate = 16;
        }
      } else {
        taxRate = 0;
      }
      log('documentLines![i].discountPercent::${documentLines![i].discountPercent}');
      documentLines![i].basic =
          (documentLines![i].UnitPrice! * documentLines![i].Quantity!);
      documentLines![i].discount =
          (documentLines![i].basic! * documentLines![i].discountPercent! / 100);

      totalBeforeDisc = totalBeforeDisc! +
          (documentLines![i].UnitPrice! * documentLines![i].Quantity!);
      log('totalBeforeDisctotalBeforeDisc::$totalBeforeDisc');
      // discnt = discnt! +
      //     ((documentLines![i].UnitPrice! * documentLines![i].Quantity!) -
      //         (documentLines![i].LineTotal!));
      documentLines![i].taxable =
          documentLines![i].basic! - documentLines![i].discount!;

      documentLines![i].taxValue = documentLines![i].taxable! * taxRate / 100;

      totalx = totalx +
          ((documentLines![i].basic! - documentLines![i].discount!) +
              documentLines![i].taxValue!);
      taxX = taxX + documentLines![i].taxValue!;
      discnt = discnt! + documentLines![i].discount!;
      log('totalxtotalx::$totalx');
      log('totalTXtotalTX::$taxX');
    }
    tax = taxX.toString();
    total = totalx.toString();
  }

  void seperateNumber() {
    final formatter = NumberFormat('###,000'); //('#,##,000')
    print(formatter.format(12000000));
  }

  @override
  void initState() {
    super.initState();
    setHeaderValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body:
          // Padding(
          //  padding: EdgeInsets.only(top:Screens.heigth(context)*0.01,),//left: Screens.width(context)*0.01,right: Screens.width(context)*0.01,
          // child:
          SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Screens.width(context) * 0.02,
              ),
              color: Colors.white,
              width: Screens.width(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.docNo,
                        // "Doc No.",
                        style: TextStyles.boldPC1(context),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          '$docNO',
                          style: TextStyles.headlineBlack1(context),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  GestureDetector(
                    onTap: () {
                      //  Get.toNamed<dynamic>(FurneyRoutes.bpinfo);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Business Partner',
                          style: TextStyles.boldPC1(context),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.83,
                              // color: Colors.blue,
                              child: Text(
                                '$cusName',
                                style: TextStyles.headlineBlack1(context),
                              ),
                            ),
                            // Container(
                            //   child: Icon(
                            //     Icons.navigate_next_outlined,
                            //     color: theme.primaryColor,
                            //     size: Screens.heigth(context) * 0.06,
                            //   ),
                            // )
                          ],
                        ),
                      ],
                    ),
                  ),
                  //             SizedBox(height: Screens.heigth(context) * 0.01, ),
                  // GestureDetector(
                  //             onTap: (){
                  //             Get.toNamed<dynamic>(FurneyRoutes.contactInfo);
                  //             },
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text(
                  //                   "Contact Person",
                  //                   style: GoogleFonts.poppins(
                  //                       fontSize: Screens.heigth(context) * 0.018,
                  //                       color: theme.primaryColor),
                  //                 ),
                  //                 Row(
                  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Container(
                  //                       width: Screens.width(context) * 0.83,
                  //                       // color: Colors.blue,
                  //                       child: Text(
                  //                         "$contactPerson",
                  //                         style: GoogleFonts.poppins(
                  //                             fontSize: Screens.heigth(context) * 0.02,
                  //                             color: Colors.black),
                  //                       ),
                  //                     ),
                  //                     Container(
                  //                       child: Icon(
                  //                         Icons.navigate_next_outlined,
                  //                         color: theme.primaryColor,
                  //                         size: Screens.heigth(context) * 0.06,
                  //                       ),
                  //                     )
                  //                   ],
                  //                 )
                  //               ],
                  //             ),
                  //           ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Currency',
                        style: TextStyles.boldPC1(context),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          '$currency',
                          style: TextStyles.headlineBlack1(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Sales Employee',
                        style: TextStyles.boldPC1(context),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          '$salesEmployee',
                          style: TextStyles.headlineBlack1(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Customer Ref.No',
                        style: TextStyles.boldPC1(context),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          '$customerRefNo',
                          style: TextStyles.headlineBlack1(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Screens.heigth(context) * 0.01,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Screens.width(context) * 0.02,
              ),
              color: Colors.white,
              width: Screens.width(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Status',
                        style: TextStyles.boldPC1(context),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          '$status',
                          style: TextStyles.headlineBlack1(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Order Type',
                        style: TextStyles.boldPC1(context),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          '$order_Type',
                          style: TextStyles.headlineBlack1(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'GP Approval',
                        style: TextStyles.boldPC1(context),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          '$GP_Approval',
                          style: TextStyles.headlineBlack1(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Received Time',
                        style: TextStyles.boldPC1(context),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          '$received_Time',
                          style: TextStyles.headlineBlack1(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Order Date',
                        style: TextStyles.boldPC1(context),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          '$orderDate',
                          style: TextStyles.headlineBlack1(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Posting Date',
                        style: TextStyles.boldPC1(context),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          '$postingDate',
                          style: TextStyles.headlineBlack1(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Valid until',
                        style: TextStyles.boldPC1(context),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          '$validUntill',
                          style: TextStyles.headlineBlack1(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Document Date',
                        style: TextStyles.boldPC1(context),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          '$documentDate',
                          style: TextStyles.headlineBlack1(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Remarks',
                        style: TextStyles.boldPC1(context),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          '$remarks',
                          style: TextStyles.headlineBlack1(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Screens.heigth(context) * 0.01,
            ),
            Container(
              color: Colors.white,
              width: Screens.width(context),
              padding: EdgeInsets.symmetric(
                horizontal: Screens.width(context) * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          seperateNumber();
                          //  String val =  TextStyles.splitValues("0.0");
                          //  print("valalalaa: "+val);
                        },
                        child: Text(
                          // AppLocalizations.of(context)!.docNo,
                          'Total Before Discount',
                          style: TextStyles.boldPC1(context),
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          TextStyles.splitValues(
                            totalBeforeDisc!.toStringAsFixed(2),
                          ),
                          //  "$totalBeforeDisc",//11,492.75 \$
                          style: TextStyles.headlineBlack1(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       // AppLocalizations.of(context)!.docNo,
                  //       'Discount %',
                  //       style: TextStyles.boldPC1(context),
                  //     ),
                  //     SizedBox(
                  //       width: Screens.width(context) * 0.83,
                  //       // color: Colors.blue,
                  //       child: Text(
                  //         '${documentLines![0].discountPercent}',
                  //         //  TextStyles.splitValues('${documentLines![0].discountPercent}!'),
                  //         style: TextStyles.headlineBlack1(context),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Discount',
                        style: TextStyles.boldPC1(context),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          // "$discnt",
                          TextStyles.splitValues(
                            discnt!.toStringAsFixed(2),
                          ),
                          style: TextStyles.headlineBlack1(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Tax',
                        style: TextStyles.boldPC1(context),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          // '$Tax',
                          TextStyles.splitValues('$tax'),
                          style: TextStyles.headlineBlack1(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.docNo,
                        'Total',
                        style: TextStyles.boldPC1(context),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.83,
                        // color: Colors.blue,
                        child: Text(
                          // "$total",
                          TextStyles.splitValues('$total'),
                          style: TextStyles.headlineBlack1(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  // GestureDetector(
                  //     onTap: (){
                  //             Get.toNamed<dynamic>(FurneyRoutes.attachments);
                  //         },
                  //   child: Center(
                  //     child: Row(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         SizedBox(width: Screens.width(context)*0.3,),
                  //         Text(
                  //         "Attachments",
                  //         style: GoogleFonts.poppins(
                  //             fontSize: Screens.heigth(context) * 0.02,
                  //             color: Colors.black),
                  //       ),
                  //       SizedBox(width: Screens.width(context)*0.25,),
                  //         Container(
                  //                   child: Icon(
                  //                     Icons.navigate_next_outlined,
                  //                     color: theme.primaryColor,
                  //                     size: Screens.heigth(context) * 0.06,
                  //                   ),
                  //                 )
                  //       ],
                  //     ),
                  //   ),
                  // )
                  CustomSpinkitdButton(
                    onTap: () async {
                      callShowPdf();
                    },
                    isLoading: isLoading,
                    //  labelLoading: AppLocalizations.of(context)!.signing,
                    label: 'Show PDF',
                  ),
                  // SizedBox(height: 10,),
                  //     HeaderOrderstState.status.toString().toLowerCase() == 'open' ?

                  //       CustomSpinkitdButton(
                  //   onTap: () async {
                  //   gotoSalesORderEdit(widget.salValue!);

                  //   },
                  //   isLoading: false,
                  //   label: 'Edit',
                  // ):SizedBox(),

                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }

  bool isLoading = false;

  void callShowPdf() {
    setState(() => isLoading = true);
    // Future.delayed(Duration(seconds: 3),(){
    //     setState(() => isLoading = false);
    // });
    StreamDataAPi.getGlobalData().then((value) {
      print('status::$value');
      if (value == 200) {
        setState(() => isLoading = false);
      } else if (value == 400) {
        print('status$value');
      } else if (value == 500) {
        print('status$value');
      }
    });
  }

  Future<void> gotoSalesORderEdit(SalesOrderDetailsValue val) async {
    setValue(val);
    Get.to(
      () => EditORderDetails(
        title: "Order Edit",
        docEntry: val.docEntry!,
        isAproved: false,
      ),
    );
  }

  void setValue(SalesOrderDetailsValue val) {
    setState(() {
      final totaldiscnt = val.totalDiscount!;
      final vatsum = val.vatSum!;
      final totalbeforeDiscount = val.docTotal! - (totaldiscnt + vatsum);
      HeaderEditOrderPageState.docNo = val.DocNum.toString();
      HeaderEditOrderPageState.bpName = val.cardName.toString();
      HeaderEditOrderPageState.bpCode = val.cardCode.toString();
      // HeaderEditOrderPageState.currency = val.DocCurrency.toString(); //
      // HeaderEditOrderPageState.status = status;
      HeaderEditOrderPageState.currentDateTime = val.DocDate.toString();
      //HeaderEditOrderPageState.documentLines =  val.documentLines;//
      HeaderEditOrderPageState.salesEmp = val.salesPersonCode.toString();
      // HeaderEditOrderPageState.customerRefNo = val.numAtCard.toString();
      // HeaderEditOrderPageState.postingDate = val.taxDate.toString();
      // HeaderEditOrderPageState.validUntill = val.docDueDate .toString();
      // HeaderEditOrderPageState.remarks = val.comments=='null'?'': val.comments.toString();
      HeaderEditOrderPageState.totalBeforeDiscount = totalbeforeDiscount;
      HeaderEditOrderPageState.discount = val.totalDiscount!;

      // HeaderEditOrderPageState.GP_Approval = val.U_GP_Approval.toString();
      // HeaderEditOrderPageState.OrderDate = val.U_OrderDate;
      // HeaderEditOrderPageState.Order_Type = val.U_Order_Type;
      // HeaderEditOrderPageState.Received_Time = val.U_Received_Time;
      // // HeaderDeliveryState.discntpercent = val.documentLines;
      // HeaderEditOrderPageState.tax = val.vatSum .toString();
      // HeaderEditOrderPageState.total = val.docTotal!.toStringAsFixed(2);

      HeaderEditOrderPageState.tax = val.vatSum!;
      HeaderEditOrderPageState.total = val.docTotal!;
      //cn
      ContentOrderCreationState state = ContentOrderCreationState();
      SalesDetailsQuotState sate2 = SalesDetailsQuotState();
      ContentOrderEditState.itemsDetails3.clear();
      for (int i = 0; i < val.documentLines!.length; i++) {
        ContentOrderEditState.itemsDetails3.add(
          AddOrderItem(
            itemCode: val.documentLines![i].ItemCode!,
            itemName: val.documentLines![i].ItemDescription!,
            price: val.documentLines![i].UnitPrice,
            discount: 0, //
            qty: int.parse(val.documentLines![i].Quantity!.toStringAsFixed(0)),
            total: val.documentLines![i].LineTotal,
            tax: val.documentLines![i].TaxTotal,
            valuechoosed: state.getTaxNane(val.documentLines![i].TaxCode!),
            discounpercent: val.documentLines![i].discountPercent,
            taxCode: val.documentLines![i].TaxCode,
            taxPer: sate2.caluclateTaxpercent(
              val.documentLines![i].LineTotal!,
              val.documentLines![i].TaxTotal!,
            ), // val.documentLines![i].
            wareHouseCode: val.documentLines![i].warehouseCode,
            taxName: state.getTaxNane(val.documentLines![i].TaxCode!),
          ), //val.documentLines![i].
        );
      }

      //log
      //LogisticEditORderState.addressdata = val.addressExtension;
    });
  }

  double getDiscount(double discountPercent, double unitPrice, double qty) {
    double discount = (unitPrice * qty) * (discountPercent / 100);
    return discount;
  }
}
