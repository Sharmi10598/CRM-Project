// ignore_for_file: prefer_const_constructors, require_trailing_commas, prefer_if_elements_to_conditional_expressions, unnecessary_lambdas, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/contact_person_api/contact_person_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_quotations_api/post_api/post_sales_quot.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/contact_person_modal/contact_person_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/widget/logistic_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/customers/screens/customer_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/creation/content_creation.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:uuid/uuid.dart';

class HeaderCreation extends StatefulWidget {
  const HeaderCreation({Key? key}) : super(key: key);

  @override
  HeaderCreationState createState() => HeaderCreationState();
}

class HeaderCreationState extends State<HeaderCreation> {
  static String bpName = ''; //
  static String bpCode = '';
  static String currentACbalance = ''; //
  static String ordersBal = '';

  ///
  static String docNo = '0'; //
  static String contactPerson = ''; //
  // static String currency = 'TZS'; //
  static String status = 'open'; //
  static String salesEmp = ''; //
  static double totalBeforeDiscount = 0; //
  static double discount = 0;
  static double discountpercent = 0;
  static double tax = 0;
  static double total = 0;
  static List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  static String? currentDateTime;
  static PageController pageController = PageController();
  int pageChanged = 0;

  //
  List<ContactEmployeValue> contactValue = [];
  List<ContactEmployeValue> filtercontactValue = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // mycontroller = List.generate(15, (i) => TextEditingController());
  }

  void callapi() {
    ContactPersonsAPi.getGlobalData().then((value) {
      if (value.deliveryModaleValue!.length > 0) {
        setState(() {
          contactValue = value.deliveryModaleValue!;
          filtercontactValue = contactValue;
          LogisticPageState.shipto = value.ShipToDefault.toString();
          LogisticPageState.billto = value.BilltoDefault.toString();
        });
      }
    });
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
                              docNo,
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
                          CustomerPageState.isCameFromCreation = true;
                          Get.toNamed<dynamic>(FurneyRoutes.customerpage);
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
                                    bpName,
                                    style: TextStyles.headlineBlack1(context),
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
                            'Currency',
                            style: TextStyles.boldPC1(context),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              GetValues.currency.toString(),
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
                              salesEmp,
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
                                    return 'ENTER ADDRESS';
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
                            'Status',
                            style: TextStyles.boldPC1(context),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              status,
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
                              '$currentDateTime',
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
                              '$currentDateTime',
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
                              '$currentDateTime',
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
                            height: Screens.heigth(context) * 0.005,
                          ),
                          Container(
                            // color: Colors.blue,
                            child: SizedBox(
                              //   height: 50,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'ENTER ADDRESS';
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
                            'Total Before Discount',
                            style: TextStyles.boldPC1(context),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              //"${totalBeforeDiscount.toStringAsFixed(2)}",
                              TextStyles.splitValues(
                                  totalBeforeDiscount.toStringAsFixed(2)),
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
                            'Discount',
                            style: TextStyles.boldPC1(context),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              // "${discount.toStringAsFixed(2)}",
                              TextStyles.splitValues(
                                  discount.toStringAsFixed(2)),
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
                              //"${tax.toStringAsFixed(2)}",
                              TextStyles.splitValues(tax.toStringAsFixed(2)),
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
                              //  "${total.toStringAsFixed(2)}",
                              TextStyles.splitValues(total.toStringAsFixed(2)),
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
          //   child:CustomSpinkitdButton(
          //     onTap: () async {
          //      validateAndCallApi();
          //       //callServiceLayerApi();
          //     },
          //     isLoading: isLoading,
          //   //  labelLoading: AppLocalizations.of(context)!.signing,
          //     label: 'Save',
          //   ),
          // )
        ],
      ),
    );
  }

  bool isLoading = false;
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
    } else if (ContentCreationState.itemsDetails.length < 1) {
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Please Add Items!!...',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final uuid = Uuid();
      String? uuidg = uuid.v1();
      setState(() => isLoading = true);
      SalesQuotPostAPi.cardCodePost = bpCode;
      SalesQuotPostAPi.docLineQout = ContentCreationState.itemsDetails;
      SalesQuotPostAPi.docDate = currentDateTime.toString();
      SalesQuotPostAPi.dueDate = currentDateTime.toString();
      SalesQuotPostAPi.remarks = mycontroller[1].text;
      print('remarks: ${SalesQuotPostAPi.remarks}');
      SalesQuotPostAPi.deviceTransID = uuid.v1();
      SalesQuotPostAPi.method();
      SalesQuotPostAPi.getGlobalData().then((value) {
        if (value.statusCode == '201' || value.statusCode == '204') {
          setState(() => isLoading = false);
          const snackBar = SnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.green,
            content: Text(
              'Quotation Created Successfully!!...',
              style: TextStyle(color: Colors.white),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Get.offAllNamed<dynamic>(FurneyRoutes.salesQuotes);
        } else {
          setState(() => isLoading = false);
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
}
