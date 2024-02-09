// ignore_for_file: prefer_const_constructors, require_trailing_commas, prefer_if_elements_to_conditional_expressions, prefer_single_quotes, prefer_final_locals, omit_local_variable_types, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/contact_person_api/contact_person_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/post_order_api/checkOrderORDraft/draftSaveApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/post_order_api/checkOrderORDraft/orderordraft.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/post_order_api/getCreaditDays/getBalanceCreditLimit.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/post_order_api/getCreaditDays/getCreaditDaysApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/post_order_api/getCreaditDays/postMaxCommit.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/post_order_api/post_sales_order_api.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/contact_person_modal/contact_person_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/widget/logistic_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/customers/screens/customer_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/screens/create_order.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/creation/content_order_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/creation/logistics_orders_creation.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:uuid/uuid.dart';

import '../../../../Modal/service_layer_modal/sales_oder/sales_orderdetails_modal.dart';

class HeaderOrderCreation extends StatefulWidget {
  const HeaderOrderCreation({Key? key}) : super(key: key);

  @override
  HeaderOrderCreationState createState() => HeaderOrderCreationState();
}

class HeaderOrderCreationState extends State<HeaderOrderCreation> {
  static String bpName = ''; //
  static String bpCode = '';
  static String currentACbalance = '';
  static String ordersBal = '';

  static String paymentTerms = '';

  ///
  static String docNo = '0'; //
  static String contactPerson = ''; //
  static String currency = 'TZS'; //
  static String status = 'open'; //
  static String? salesEmp; //
  static double totalBeforeDiscount = 0; //
  static double discount = 0;
  static double discountpercent = 0;
  static double tax = 0;
  static double total = 0;
  static List<AddItem>? documentLines = [];

  static List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  static String? currentDateTime;

  static PageController pageController = PageController();
  int pageChanged = 0;
  static String isHaveAdvance = '';
  static bool isCameFromqutation = false;

  //
  List<ContactEmployeValue> contactValue = [];
  List<ContactEmployeValue> filtercontactValue = [];
  void callapi() {
    ContactPersonsAPi.getGlobalData().then((value) {
      if (value.deliveryModaleValue!.isNotEmpty) {
        setState(() {
          contactValue = value.deliveryModaleValue!;
          filtercontactValue = contactValue;
          LogisticPageState.shipto = value.ShipToDefault.toString();
          LogisticPageState.billto = value.BilltoDefault.toString();
        });
      } else {}
    });
  }

  setHeaderValue() {
    double netvalue = 0;
    double basictotal = 0;
    totalBeforeDiscount = 0;
    total = 0;
    tax = 0;
    discount = 0;
    for (int i = 0; i < documentLines!.length; i++) {
      basictotal =
          basictotal + (documentLines![i].price! * documentLines![i].qty!);

      totalBeforeDiscount = totalBeforeDiscount +
          (documentLines![i].price! * documentLines![i].qty!);

      discount = discount +
          ((documentLines![i].price! * documentLines![i].qty!) *
              (documentLines![i].discounpercent! / 100));

      // (documentLines![i].lineTotal!));
      tax = tax + documentLines![i].tax!;
      netvalue = (basictotal - discount) + tax;
      total = netvalue;
      //
    }
  }

  static bool isTextFiledEnabled = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setHeaderValue();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body:
          // PageView(
          //   physics: const NeverScrollableScrollPhysics(),
          //   controller: pageController,
          // onPageChanged: (index) {
          //   setState(() {
          //     pageChanged = index;
          //     ContactPersonState.pageChanged2 = pageChanged;
          //   });
          // },
          //   children: [
          Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Screens.width(context) * 0.02),
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
                              "$docNo",
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
                            "Business Partner Code",
                            style: TextStyles.boldPC1(context),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              "$bpCode",
                              style: TextStyles.headlineBlack1(context),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Screens.heigth(context) * 0.01,
                      ),
                      SizedBox(
                        height: Screens.heigth(context) * 0.01,
                      ),

                      GestureDetector(
                        onTap: () {
                          if (CreateOrderDetailsState.isCameFromqutation ==
                              false) {
                            CustomerPageState.isCameFromCreationOrder = true;
                            Get.toNamed<dynamic>(FurneyRoutes.customerpage);
                          } else {
                            null;
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Business Partner Name",
                              style: TextStyles.boldPC1(context),
                            ),
                            isTextFiledEnabled == false
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Screens.width(context) * 0.83,
                                        // color: Colors.blue,
                                        child: Text(
                                          "$bpName",
                                          style: TextStyles.headlineBlack1(
                                              context),
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.navigate_next_outlined,
                                          color: theme.primaryColor,
                                          size: Screens.heigth(context) * 0.06,
                                        ),
                                      )
                                    ],
                                  )
                                : Container(
                                    // width: Screens.width(context) * 0.83,
                                    // color: Colors.blue,
                                    child: SizedBox(
                                      //   height: 50,

                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Enter Business Partner Name";
                                          }

                                          return null;
                                        },
                                        // onEditingComplete: (){
                                        //   bpName =  mycontroller[2].text;
                                        //   print("bpname: "+bpName);
                                        // },
                                        // onFieldSubmitted: (v){
                                        //    bpName =  mycontroller[2].text;
                                        //    print("bpname: "+bpName);
                                        // },
                                        onChanged: (v) {
                                          bpName = mycontroller[2].text;
                                          print("bpname: $bpName");
                                        },
                                        controller: mycontroller[2],
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide:
                                                BorderSide(color: Colors.green),
                                          ),
                                        ),
                                        cursorColor: theme.primaryColor,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Screens.heigth(context) * 0.01,
                      ),
                      // GestureDetector(
                      //             onTap: (){
                      //             print(bpCode);
                      //             print(bpName);
                      //             ContactPersonsAPi.cardCode = bpCode;
                      //     //         pageController.animateToPage(++pageChanged,
                      //     // duration: Duration(milliseconds: 250),
                      //     // curve: Curves.bounceIn);
                      //     // callapi();
                      //             Get.toNamed<dynamic>(FurneyRoutes.contactpersons);
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
                      //      SizedBox(height: Screens.heigth(context) * 0.01, ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // AppLocalizations.of(context)!.docNo,
                            "Currency",
                            style: TextStyles.boldPC1(context),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              "$currency",
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
                            "Sales Employee",
                            style: TextStyles.boldPC1(context),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              "$salesEmp",
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
                            "Customer Ref.No",
                            style: TextStyles.boldPC1(context),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.005,
                          ),
                          Container(
                            // width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: SizedBox(
                              //   height: 50,

                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Customer Ref.No";
                                  }

                                  return null;
                                },
                                controller: mycontroller[0],
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(color: Colors.green),
                                  ),
                                ),
                                cursorColor: theme.primaryColor,
                              ),
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
                      horizontal: Screens.width(context) * 0.02),
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
                            "Status",
                            style: TextStyles.boldPC1(context),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              "$status",
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
                            "Posting Date",
                            style: TextStyles.boldPC1(context),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              "$currentDateTime",
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
                            "Valid until",
                            style: TextStyles.boldPC1(context),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              "$currentDateTime",
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
                            "Document Date",
                            style: TextStyles.boldPC1(context),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              "$currentDateTime",
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
                            "Remarks",
                            style: TextStyles.boldPC1(context),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.005,
                          ),
                          Container(
                            // color: Colors.blue,
                            child: SizedBox(
                              //   height: 50,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "ENTER ADDRESS";
                                  }

                                  return null;
                                },
                                maxLines: 4,
                                controller: mycontroller[1],
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(color: Colors.green),
                                  ),
                                ),
                                cursorColor: theme.primaryColor,
                              ),
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
                      horizontal: Screens.width(context) * 0.02),
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
                            "Total Before Discount",
                            style: TextStyles.boldPC1(context),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              // "${totalBeforeDiscount.toStringAsFixed(2)}",
                              TextStyles.splitValues(
                                  '${totalBeforeDiscount.toStringAsFixed(2)}'),
                              style: TextStyles.headlineBlack1(context),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Screens.heigth(context) * 0.01,
                      ),
                      //      Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           // AppLocalizations.of(context)!.docNo,
                      //           "Discount %",
                      //           style: GoogleFonts.poppins(
                      //               fontSize: Screens.heigth(context) * 0.018,
                      //               color: theme.primaryColor),
                      //         ),
                      //         Container(
                      //           width: Screens.width(context) * 0.83,
                      //           // color: Colors.blue,
                      //           child: Text(
                      //                "${discountpercent}",
                      //             style: GoogleFonts.poppins(
                      //                 fontSize: Screens.heigth(context) * 0.02,
                      //                 color: Colors.black),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      // SizedBox(height: Screens.heigth(context) * 0.01, ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // AppLocalizations.of(context)!.docNo,
                            "Discount",
                            style: TextStyles.boldPC1(context),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              //"${discount.toStringAsFixed(2)}",
                              TextStyles.splitValues(
                                  '${discount.toStringAsFixed(2)}'),
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
                            "Tax",
                            style: TextStyles.boldPC1(context),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              /// "${tax.toStringAsFixed(2)}",
                              TextStyles.splitValues(
                                  '${tax.toStringAsFixed(2)}'),
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
                            "Total",
                            style: TextStyles.boldPC1(context),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              // "${total.toStringAsFixed(2)}",
                              TextStyles.splitValues(
                                  '${total.toStringAsFixed(2)}'),
                              style: TextStyles.headlineBlack1(context),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Screens.heigth(context) * 0.08,
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
                    ],
                  ),
                )
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: CustomSpinkitdButton(
          //     onTap: () async {
          //       validateAndCallApi();
          //       //callServiceLayerApi();
          //     },
          //     isLoading: isLoading,
          //     //  labelLoading: AppLocalizations.of(context)!.signing,
          //     label: 'Save',
          //   ),
          // )
        ],
      ),
    );
  }

  bool isLoading = false;
  Uuid uuid = Uuid();
  void validateAndCallApi() {
    if (bpCode == '') {
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Please Choose Business Partner!!...',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (ContentOrderCreationState.itemsDetails.isEmpty) {
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Please Add Items!!...',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (mycontroller[0].text.isEmpty) {
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Please Fill Customer Ref.No!!...',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (LogisticOrderState.valueSelectedOrder == null) {
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Please Choose Select Order Type!!...',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (LogisticOrderState.valueSelectedGPApproval == null) {
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Please choose GP Approval !!...',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (LogisticOrderState.mycontroller[0].text.isEmpty) {
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Please Fill Order Received Time !!...',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (LogisticOrderState.mycontroller[1].text.isEmpty) {
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
      SalesOrderPostAPi.cardCodePost = bpCode;
      SalesOrderPostAPi.cardNamePost = bpName;
      SalesOrderPostAPi.docLineQout = ContentOrderCreationState.itemsDetails;
      SalesOrderPostAPi.docDate = currentDateTime.toString();
      SalesOrderPostAPi.dueDate = currentDateTime.toString();
      SalesOrderPostAPi.remarks = mycontroller[1].text;
      SalesOrderPostAPi.orderDate = LogisticOrderState.mycontroller[1].text;
      SalesOrderPostAPi.orderType = LogisticOrderState.valueSelectedOrder;
      SalesOrderPostAPi.gpApproval = LogisticOrderState.valueSelectedGPApproval;
      SalesOrderPostAPi.orderTime = LogisticOrderState.mycontroller[0].text;
      SalesOrderPostAPi.custREfNo = mycontroller[0].text;
      // print( "remarks: "+  SalesOrderPostAPi.remarks.toString());
      SalesOrderPostAPi.deviceTransID = uuid.v1();
      SalesOrderPostAPi.deviceCode = GetValues.deviceID;
      CheckOrderORDraftAPi.deviceTransID = SalesOrderPostAPi.deviceTransID;
      CheckOrderORDraftAPi.deviceCode = SalesOrderPostAPi.deviceCode;
      DraftSaveAPi.deviceCode = SalesOrderPostAPi.deviceCode;
      DraftSaveAPi.deviceTransID = SalesOrderPostAPi.deviceTransID;
      currentDate();
      double getcreditLimit;
      GettCreditDaysAPi.cardCode = bpCode;
      GettCreditDaysAPi.date = currentDateTime2;
      GetBalanceCreditAPi.cardCode = bpCode;
      if (HeaderOrderCreationState.isHaveAdvance
              .toLowerCase()
              .contains("advance") ||
          HeaderOrderCreationState.isTextFiledEnabled == false) {
        // print("objectokkkkkokkkkk");
        //  print(HeaderOrderCreationState.isHaveAdvance.toLowerCase());
        GetBalanceCreditAPi.getGlobalData().then((value) {
          if (value.balanceCreaditValue!.isNotEmpty) {
            getcreditLimit = value.balanceCreaditValue![0].CreditLimit!;
            callSaveApi(getcreditLimit);
          } else if (value.balanceCreaditValue!.isEmpty) {
            callSaveApi(0);
          }
        });
      } else {
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
            double ans = creditLimit! - balance! - total;
            print("assssaasasa: $ans");
            if (ans < 0) {
              PostMaxCommitAPi.cardCodePost = bpCode;
              PostMaxCommitAPi.value = "${100.00 + getCredit}";
              PostMaxCommitAPi.getGlobalData().then((value) {
                callPostApi();
                //  SalesOrderPostAPi.method();
              });
            } else {
              callPostApi();
              // SalesOrderPostAPi.method();
            }
          } else {
            callPostApi();
          }
        });
      } else if (value.creaditDaysValueValue![0].CreditDays! > 0) {
        PostMaxCommitAPi.cardCodePost = bpCode;
        PostMaxCommitAPi.value = "${50.00 + getCredit}";
        PostMaxCommitAPi.getGlobalData().then((value) {});
        callPostApi();
        // SalesOrderPostAPi.method();
      }
    });
  }

  String? currentDateTime2;
  void currentDate() {
    DateTime now = DateTime.now();
    setState(() {
      String val =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
      currentDateTime2 = val;
      print(currentDateTime2);
    });
  }

  void callPostApi() {
    // SalesOrderPostAPi.getGlobalData().then((value) {
    //   if (value.statusCode == '201' || value.statusCode == '204') {
    //     checkORderORDraft();
    //   } else {
    //     setState(() => isLoading = false);
    //     final snackBar = SnackBar(
    //       duration: Duration(seconds: 5),
    //       backgroundColor: Colors.red,
    //       content: Text(
    //         '${value.error!.message!.value}!!..',
    //         style: TextStyle(color: Colors.white),
    //       ),
    //     );
    //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //   }
    // });
  }

  void nullallValues() {
    bpCode = '';
    ContentOrderCreationState.itemsDetails.clear();
  }

  void checkORderORDraft() {
    CheckOrderORDraftAPi.urlss();
    CheckOrderORDraftAPi.getGlobalData().then((value) {
      if (value.orderORDraftValue!.isNotEmpty) {
        showDetailBox('Order Created Successfully !!..');
      } else if (value.orderORDraftValue!.isEmpty) {
        callDraftApi();
      }
    });
  }

  void callDraftApi() {
    DraftSaveAPi.urlss();
    DraftSaveAPi.getGlobalData().then((value) {
      if (value.orderORDraftValue!.isNotEmpty) {
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
}
