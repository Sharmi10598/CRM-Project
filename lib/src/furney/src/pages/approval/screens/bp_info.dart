// ignore_for_file: avoid_redundant_argument_values, avoid_unnecessary_containers, require_trailing_commas, prefer_single_quotes, prefer_if_elements_to_conditional_expressions, prefer_is_empty, unnecessary_lambdas, prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/customer_bp/customer_details_api.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/customer_bp/new_customer_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/widget/address_contacts.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/widget/general.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/widget/transaction.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';
import 'package:url_launcher/url_launcher.dart';

class BPInfo extends StatefulWidget {
  const BPInfo({required this.title, Key? key}) : super(key: key);
  final String title;

  @override
  BPInfoState createState() => BPInfoState();
}

class BPInfoState extends State<BPInfo> {
  static String? cardName;
  static String? cardCode;
  static String? curentBalance;
  static String? slpName;
  static String? paymentTerms;
  //static List<CustomerDetailsValue> data=[];
  static int index = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool getdata1 = false;
  bool getdata2 = false;
  @override
  void initState() {
    super.initState();
    GeneralState.cardCode = cardCode;
    GeneralState.acntBalance = curentBalance;
    GeneralState.slpName = slpName;
    GeneralState.paymentTerms = paymentTerms;
   
    CustomerDetailsAPi.getGlobalData().then((value) {
       log("CustomerDetailsAPi.length: " +
       value.contactEmployees!.length.toString());
      if (value.contactEmployees!.length > 0) {
        log("contactEmployees: " + value.contactEmployees![0].name.toString());
      }
      setcutomerValue(value);
    });
  }

  void setcutomerValue(CustomerDetailsValue value) {
    AddressContactsState.customerDetailsValue = value;
    GeneralState.customerDetailsValue = value;
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        getdata1 = true;
      });
    });
  }
  // void  setsalesPersonValue(SalesPersonModal value){
  //     setState(() {
  //          print(value.salesPersonvalue![0].slpName);
  //          GeneralState.salesPersonModal = value.salesPersonvalue;

  //           Future.delayed(Duration(seconds: 1),(){
  //          getdata2=true;
  //           });
  //       });
  // }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(context, _scaffoldKey, widget.title),
      drawer: drawer(context),
      backgroundColor: Colors.grey[200],
      body:
          // GeneralState.customerDetailsValue ==null &&  GeneralState.salesPersonModal!.isEmpty?
          getdata1 == false
              ? Center(
                  child: SpinKitThreeBounce(
                    size: Screens.heigth(context) * 0.06,
                    color: theme.primaryColor,
                  ),
                )
              : SafeArea(
                  child: DefaultTabController(
                    length: 3,
                    initialIndex: 0,
                    child: SizedBox(
                      width: Screens.width(context),
                      height: Screens.heigth(context),
                      // color: Colors.amber,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // DefaultTabController(
                            //   length: 3,
                            //   initialIndex: 0,
                            //   child:
                            Row(
                              //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(width: Screens.width(context) * 0.1),
                                SizedBox(
                                  width: Screens.width(context) * 0.3,

                                  ///color: Colors.blueGrey,
                                  child: Icon(
                                    Icons.account_circle,
                                    size: Screens.heigth(context) * 0.1,
                                    color: theme.primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: Screens.width(context) * 0.5,
                                  // color: Colors.green,
                                  child: Text(
                                    "$cardName\n$cardCode", // "${data[index].cardName.toString()}\n${data[index].cardCode}",
                                    //"Maxi-Teq C20000 Custmer",
                                    style: TextStyles.boldBlock1(context),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: Screens.heigth(context) * 0.01),
                            TabBar(
                              labelStyle: TextStyles.bodytextBlack2(context),
                              indicator: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Const.space5),
                                border: Border.all(color: theme.primaryColor),
                                color: theme.primaryColor,
                              ),
                              labelColor: theme.colorScheme.background,
                              unselectedLabelColor: theme.primaryColor,
                              tabs: [
                                Tab(
                                    text:
                                        AppLocalizations.of(context)!.general),
                                Tab(
                                    text: AppLocalizations.of(context)!
                                        .addcontact),
                                Tab(
                                    text: AppLocalizations.of(context)!
                                        .transactions),
                              ],
                            ),
                            // ),
                            SizedBox(height: Screens.heigth(context) * 0.01),
                            SizedBox(
                              width: Screens.width(context),
                              height: Screens.heigth(context) * 0.71,
                              child: const TabBarView(children: [
                                General(),
                                AddressContacts(),
                                Transactions()
                              ]),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }

  Future<void> makecall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "exception $url";
    }
  }

  Future<void> launchInWebViewWithJavaScript(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> mailto(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "exception $url";
    }
  }

  Future<void> openMap(double latitude, double longitude) async {
    final googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}

  // data.length==0?Center(
  //                child:  SpinKitThreeBounce(
  //                     size: Screens.heigth(context)*0.06,
  //                     color:theme.primaryColor,
  //                   ),
  //              ):  Container(padding: EdgeInsets.symmetric(horizontal: Screens.width(context)*0.02 ),
  //     width: Screens.width(context),
  //     height: Screens.heigth(context) * 0.3,
  //     color: Colors.white,
  //     child: SingleChildScrollView(
  //       child: Column(
  //          crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //              SizedBox(height: Screens.heigth(context) * 0.01, ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                       //    AppLocalizations.of(context)!.docNo,
  //                         "Acct Balance",
  //                           style: GoogleFonts.poppins(
  //                               fontSize: Screens.heigth(context) * 0.018,
  //                               color: theme.primaryColor),
  //                         ),
  //                         Container(
  //                           width: Screens.width(context) * 0.83,
  //                           // color: Colors.blue,
  //                           child: Text(
  //                             "4,789,949.15 \$",
  //                             style: GoogleFonts.poppins(
  //                                 fontSize: Screens.heigth(context) * 0.02,
  //                                 color: Colors.black),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //          SizedBox(height: Screens.heigth(context) * 0.01, ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                       //    AppLocalizations.of(context)!.docNo,
  //                         "Credit Limit",
  //                           style: GoogleFonts.poppins(
  //                               fontSize: Screens.heigth(context) * 0.018,
  //                               color: theme.primaryColor),
  //                         ),
  //                         Container(
  //                           width: Screens.width(context) * 0.83,
  //                           // color: Colors.blue,
  //                           child: Text(
  //                             "0.00 \$",
  //                             style: GoogleFonts.poppins(
  //                                 fontSize: Screens.heigth(context) * 0.02,
  //                                 color: Colors.black),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //            SizedBox(height: Screens.heigth(context) * 0.01, ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                       //    AppLocalizations.of(context)!.docNo,
  //                         "Acct Balance",
  //                           style: GoogleFonts.poppins(
  //                               fontSize: Screens.heigth(context) * 0.018,
  //                               color: theme.primaryColor),
  //                         ),
  //                         Container(
  //                           width: Screens.width(context) * 0.83,
  //                           // color: Colors.blue,
  //                           child: Text(
  //                             "4,789,949.15 \$",
  //                             style: GoogleFonts.poppins(
  //                                 fontSize: Screens.heigth(context) * 0.02,
  //                                 color: Colors.black),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //           SizedBox(height: Screens.heigth(context) * 0.01, ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                       //    AppLocalizations.of(context)!.docNo,
  //                         "Sales Employee",
  //                           style: GoogleFonts.poppins(
  //                               fontSize: Screens.heigth(context) * 0.018,
  //                               color: theme.primaryColor),
  //                         ),
  //                         Container(
  //                           width: Screens.width(context) * 0.83,
  //                           // color: Colors.blue,
  //                           child: Text(
  //                             "Tom Mobile",
  //                             style: GoogleFonts.poppins(
  //                                 fontSize: Screens.heigth(context) * 0.02,
  //                                 color: Colors.black),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //           SizedBox(height: Screens.heigth(context) * 0.01, ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                       //    AppLocalizations.of(context)!.docNo,
  //                         "Payment Terms",
  //                           style: GoogleFonts.poppins(
  //                               fontSize: Screens.heigth(context) * 0.018,
  //                               color: theme.primaryColor),
  //                         ),
  //                         Container(
  //                           width: Screens.width(context) * 0.83,
  //                           // color: Colors.blue,
  //                           child: Text(
  //                             "2P10Net30",
  //                             style: GoogleFonts.poppins(
  //                                 fontSize: Screens.heigth(context) * 0.02,
  //                                 color: Colors.black),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                SizedBox(height: Screens.heigth(context) * 0.01, ),
  //                 GestureDetector(
  //                             onTap: (){
  //                              Get.toNamed<dynamic>(FurneyRoutes.regularSalesPrice);
  //                             },
  //                             child: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Text(
  //                                   "Price List",
  //                                   style: GoogleFonts.poppins(
  //                                       fontSize: Screens.heigth(context) * 0.018,
  //                                       color: theme.primaryColor),
  //                                 ),
  //                                 Row(
  //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Container(
  //                                       width: Screens.width(context) * 0.83,
  //                                       // color: Colors.blue,
  //                                       child: Text(
  //                                         "Regular Sales Price",
  //                                         style: GoogleFonts.poppins(
  //                                             fontSize: Screens.heigth(context) * 0.02,
  //                                             color: Colors.black),
  //                                       ),
  //                                     ),
  //                                     Container(
  //                                       child: Icon(
  //                                         Icons.navigate_next_outlined,
  //                                         color: theme.primaryColor,
  //                                         size: Screens.heigth(context) * 0.06,
  //                                       ),
  //                                     )
  //                                   ],
  //                                 )
  //                               ],
  //                             ),
  //                           ),
  //                SizedBox(height: Screens.heigth(context) * 0.01, ),
  //                 GestureDetector(
  //                             onTap: (){
  //                              makecall("tel:555-0110");
  //                             },
  //                             child: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Text(
  //                                   "Telephone",
  //                                   style: GoogleFonts.poppins(
  //                                       fontSize: Screens.heigth(context) * 0.018,
  //                                       color: theme.primaryColor),
  //                                 ),
  //                                 Row(
  //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Container(
  //                                       width: Screens.width(context) * 0.83,
  //                                       // color: Colors.blue,
  //                                       child: Text(
  //                                        // "555-0110",
  //                                         data[0].cardCode.toString(),
  //                                         style: GoogleFonts.poppins(
  //                                             fontSize: Screens.heigth(context) * 0.02,
  //                                             color: Colors.black),
  //                                       ),
  //                                     ),
  //                                     Container(
  //                                       child: Icon(
  //                                         Icons.navigate_next_outlined,
  //                                         color: theme.primaryColor,
  //                                         size: Screens.heigth(context) * 0.06,
  //                                       ),
  //                                     )
  //                                   ],
  //                                 )
  //                               ],
  //                             ),
  //                           ),   
  //                SizedBox(height: Screens.heigth(context) * 0.01, ),
  //                 GestureDetector(
  //                             onTap: (){
  //                           mailto("https://mail.google.com/mail/u/0/#inbox?compose=new");
  //                             },
  //                             child: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Text(
  //                                   "Email",
  //                                   style: GoogleFonts.poppins(
  //                                       fontSize: Screens.heigth(context) * 0.018,
  //                                       color: theme.primaryColor),
  //                                 ),
  //                                 Row(
  //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Container(
  //                                       width: Screens.width(context) * 0.83,
  //                                       // color: Colors.blue,
  //                                       child: Text(
  //                                         "info@maxi-teq.sap.com",
  //                                         style: GoogleFonts.poppins(
  //                                             fontSize: Screens.heigth(context) * 0.02,
  //                                             color: Colors.black),
  //                                       ),
  //                                     ),
  //                                     Container(
  //                                       child: Icon(
  //                                         Icons.navigate_next_outlined,
  //                                         color: theme.primaryColor,
  //                                         size: Screens.heigth(context) * 0.06,
  //                                       ),
  //                                     )
  //                                   ],
  //                                 )
  //                               ],
  //                             ),
  //                           ), 
  //                SizedBox(height: Screens.heigth(context) * 0.01, ),
  //                 GestureDetector(
  //                             onTap: (){
  //                          //  launchInWebViewWithJavaScript("https://mail.google.com");
  //                          launchInBrowser("https://google.com");
  //                             },
  //                             child: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Text(
  //                                   "Web Site",
  //                                   style: GoogleFonts.poppins(
  //                                       fontSize: Screens.heigth(context) * 0.018,
  //                                       color: theme.primaryColor),
  //                                 ),
  //                                 Row(
  //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Container(
  //                                       width: Screens.width(context) * 0.83,
  //                                       // color: Colors.blue,
  //                                       child: Text(
  //                                         "WWW.maxi-teq.sap.com",
  //                                         style: GoogleFonts.poppins(
  //                                             fontSize: Screens.heigth(context) * 0.02,
  //                                             color: Colors.black),
  //                                       ),
  //                                     ),
  //                                     Container(
  //                                       child: Icon(
  //                                         Icons.navigate_next_outlined,
  //                                         color: theme.primaryColor,
  //                                         size: Screens.heigth(context) * 0.06,
  //                                       ),
  //                                     )
  //                                   ],
  //                                 )
  //                               ],
  //                             ),
  //                           ),              
  //             SizedBox(height: Screens.heigth(context) * 0.01, ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                       //    AppLocalizations.of(context)!.docNo,
  //                         "Remarks",
  //                           style: GoogleFonts.poppins(
  //                               fontSize: Screens.heigth(context) * 0.018,
  //                               color: theme.primaryColor),
  //                         ),
  //                         Container(
  //                           width: Screens.width(context) * 0.83,
  //                           // color: Colors.blue,
  //                           child: Text(
  //                             "",
  //                             style: GoogleFonts.poppins(
  //                                 fontSize: Screens.heigth(context) * 0.02,
  //                                 color: Colors.black),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //            SizedBox(height: Screens.heigth(context) * 0.01, ),
  //                     GestureDetector(
  //                         onTap: (){
  //                                 Get.toNamed<dynamic>(FurneyRoutes.attachments);
  //                             },
  //                       child: Center(
  //                         child: Row(
  //                           crossAxisAlignment: CrossAxisAlignment.center,
  //                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                           children: [
  //                             SizedBox(width: Screens.width(context)*0.3,),
  //                             Text(
  //                             "Attachments",
  //                             style: GoogleFonts.poppins(
  //                                 fontSize: Screens.heigth(context) * 0.02,
  //                                 color: Colors.black),
  //                           ),
  //                           SizedBox(width: Screens.width(context)*0.25,),
  //                             Container(
  //                                       child: Icon(
  //                                         Icons.navigate_next_outlined,
  //                                         color: theme.primaryColor,
  //                                         size: Screens.heigth(context) * 0.06,
  //                                       ),
  //                                     )
  //                           ],
  //                         ),
  //                       ),
  //                     )
  //         ],
  //       ),
  //     ),
  //   ),