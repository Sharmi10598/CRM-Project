// ignore_for_file: prefer_const_constructors, unawaited_futures

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/CustomerStatementApi/customerStatementApi.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/customer_bp/new_customer_modal.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/salesperson_modal/salesPerson_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sign_in/widgets/custom_elevatedBtn.dart';
import 'package:url_launcher/url_launcher.dart';

class General extends StatefulWidget {
   const General({Key? key,}) : super(key: key);
  
  @override
  GeneralState createState() => GeneralState();
}

class GeneralState extends State<General> {
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  static CustomerDetailsValue? customerDetailsValue;
  static List<SalesPersonValue>? salesPersonModal =[];
  static int index = 0;
  static String? acntBalance;
  static String? slpName;
  static String? paymentTerms;
  static String? cardCode;
  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return Container(padding: EdgeInsets.symmetric(horizontal: Screens.width(context)*0.02 ),
      width: Screens.width(context),
      height: Screens.heigth(context) * 0.3,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                   SizedBox(height: Screens.heigth(context) * 0.01, ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                            //    AppLocalizations.of(context)!.docNo,
                              'Acct Balance',
                                style:TextStyles.boldPC1(context),
                              ),
                              SizedBox(
                                width: Screens.width(context) * 0.83,
                                // color: Colors.blue,
                                child: Text(
                               // '$acntBalance',// "4,789,949.15 \$",
                                TextStyles.splitValues('$acntBalance'),
                                  style:TextStyles.headlineBlack1(context),
                                ),
                              ),
                            ],
                          ),
               SizedBox(height: Screens.heigth(context) * 0.01, ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                            //    AppLocalizations.of(context)!.docNo,
                              'Credit Limit',
                                style: TextStyles.boldPC1(context),
                              ),
                              SizedBox(
                                width: Screens.width(context) * 0.83,
                                // color: Colors.blue,
                                child: Text(
                            // '${customerDetailsValue!.creditLimit}',//  "0.00 \$",
                             TextStyles.splitValues('${customerDetailsValue!.creditLimit}'),
                                  style:TextStyles.headlineBlack1(context),
                                ),
                              ),
                            ],
                          ),
                SizedBox(height: Screens.heigth(context) * 0.01, ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                            //    AppLocalizations.of(context)!.docNo,
                              'Sales Employee',
                                style: TextStyles.boldPC1(context),
                              ),
                              SizedBox(
                                width: Screens.width(context) * 0.83,
                                // color: Colors.blue,
                                child: Text(
                                 '$slpName',
                                  style: TextStyles.headlineBlack1(context),
                                ),
                              ),
                            ],
                          ),
                SizedBox(height: Screens.heigth(context) * 0.01, ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                            //    AppLocalizations.of(context)!.docNo,
                              'Payment Terms',
                                style: TextStyles.boldPC1(context),
                              ),
                              SizedBox(
                                width: Screens.width(context) * 0.83,
                                // color: Colors.blue,
                                child: Text(
                                 '$paymentTerms',
                                  style: TextStyles.headlineBlack1(context),
                                ),
                              ),
                            ],
                          ),
                     SizedBox(height: Screens.heigth(context) * 0.01, ),
                      GestureDetector(
                                  onTap: (){
                                  // Get.toNamed<dynamic>(FurneyRoutes.regularSalesPrice);
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Price List',
                                        style:TextStyles.boldPC1(context),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: Screens.width(context) * 0.83,
                                            // color: Colors.blue,
                                            child: Text(
                                            customerDetailsValue!.priceListNum.toString() ,// "Regular Sales Price",
                                              style:TextStyles.headlineBlack1(context),
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
                     SizedBox(height: Screens.heigth(context) * 0.01, ),
                      GestureDetector(
                                  onTap: (){
                                    if(customerDetailsValue!.phone1==''){
                                        const snackBar = SnackBar(
              duration:  Duration(seconds: 5),
              backgroundColor: Colors.red,
              content: Text(
                'There is no phone number to call !!..',
                style: TextStyle(color: Colors.white),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }else{
                                      makecall('${customerDetailsValue!.phone1}');
                                    }
                                  //  makecall('${customerDetailsValue!.phone1}');
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Telephone',
                                        style:TextStyles.boldPC1(context),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: Screens.width(context) * 0.83,
                                            // color: Colors.blue,
                                            child: Text(
                                            
                                        '${customerDetailsValue!.phone1}',// customerDetailsValue[index].cardCode.toString(),
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
                     SizedBox(height: Screens.heigth(context) * 0.01, ),
                      GestureDetector(
                                  onTap: (){
                                mailto('https://mail.google.com/mail/u/0/#inbox?compose=new');
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Email',
                                        style: TextStyles.boldPC1(context),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: Screens.width(context) * 0.83,
                                            // color: Colors.blue,
                                            child: Text(
                                            '${customerDetailsValue!.emailAddress}',// "info@maxi-teq.sap.com",
                                              style:TextStyles.headlineBlack1(context),
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
                     SizedBox(height: Screens.heigth(context) * 0.01, ),
                      GestureDetector(
                                  onTap: (){
                               //  launchInWebViewWithJavaScript("https://mail.google.com");
                               launchInBrowser('https://google.com');
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Web Site',
                                        style: TextStyles.boldPC1(context),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: Screens.width(context) * 0.83,
                                            // color: Colors.blue,
                                            child: Text(
                                        '${customerDetailsValue!.website}',//    "WWW.maxi-teq.sap.com",
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
                  SizedBox(height: Screens.heigth(context) * 0.01, ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                            //    AppLocalizations.of(context)!.docNo,
                              'Remarks',
                                style: TextStyles.boldPC1(context),
                              ),
                              SizedBox(
                                width: Screens.width(context) * 0.83,
                                // color: Colors.blue,
                                child: Text(
                                  customerDetailsValue!.notes.toString(),
                                  style: TextStyles.headlineBlack1(context),
                                ),
                              ),
                            ],
                          ),
                 SizedBox(height: Screens.heigth(context) * 0.01, ),
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
                          //         style: TextStyles.boldPC1(context),
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
                                      mycontroller[1].clear();
                                      mycontroller[2].clear();
                                     bottomSheet(theme);
                                    
                              },
                              isLoading: isLoading,
                              //  labelLoading: AppLocalizations.of(context)!.signing,
                              label: 'View customer statement',
                            ),
                             SizedBox(
                              height: Screens.heigth(context)*0.03,
                            ),
              ],
            ),
             Visibility(
            visible:isScreenLoad,
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
    );
  }
  bool isLoading = false;
  bool isScreenLoad = false;
  List<GlobalKey<FormState>> formkey =
      List.generate(3, (i) => GlobalKey<FormState>());
  void bottomSheet(ThemeData theme) {
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
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Stack(
                              children: [
                                SizedBox(
                                  child: TextFormField(
                                    onTap: () {
                                      showDate(context);
                                    },
                                    readOnly: true,
                                    controller: mycontroller[1],
                                    onChanged: (val) {},
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'ENTER FROM DATE';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(fontSize: 15),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10,),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      labelText: 'Choose from date',
                                      labelStyle:
                                          TextStyles.bodytextBlack1(context),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: Screens.heigth(context) * 0.01,
                                    left: Screens.width(context) * 0.8,
                                    child: InkWell(
                                      onTap: () {
                                        showDate(context);
                                      },
                                      child: Icon(Icons.calendar_today_outlined,
                                          color: theme.primaryColor,
                                          size: Screens.width(context) * 0.08,),
                                    ),),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Stack(
                              children: [
                                SizedBox(
                                  child: TextFormField(
                                    onTap: () {
                                      showToDate(context);
                                    },
                                    readOnly: true,
                                    controller: mycontroller[2],
                                    onChanged: (val) {},
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'ENTER TO DATE';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(fontSize: 15),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10,),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          // ignore: prefer_const_constructors
                                          Radius.circular(10),
                                        ),
                                      ),
                                      labelText: 'Choose to date',
                                      labelStyle:
                                          TextStyles.bodytextBlack1(context),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: Screens.heigth(context) * 0.01,
                                    left: Screens.width(context) * 0.8,
                                    child: InkWell(
                                      onTap: () {
                                        showToDate(context);
                                      },
                                      child: Icon(Icons.calendar_today_outlined,
                                          color: theme.primaryColor,
                                          size: Screens.width(context) * 0.08,),
                                    ),),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),), backgroundColor: theme.primaryColor,
                                  ),
                                  onPressed: callApi,
                                  child: Text(
                                    'Search',
                                    style: TextStyles.whiteText(context),
                                  ),),
                            ),
                           
                          ],
                        ),
                      ),
                    ),
                  ),),
            ),);
  }
   Future<void> callApi()async {
    if(formkey[0].currentState!.validate()){
      setState(() {
      isScreenLoad = true;
    //  isLoading = true;
      });
      
      CustomerStatementApi.getGlobalData(cardCode, apiFromDate, apiToDate).then((value){
        if(value == 200){
             setState(() {
      isScreenLoad = false;
      //isLoading = false;
      });
        }else{
  setState(() {
      isScreenLoad = false;
    //  isLoading = false;
      });
      showSnackBar('Try again!!..');
        }
     });
    Navigator.pop(context);
    }
  }

   String apiFromDate = '';
  String apiToDate = '';

  void showSnackBar(String msg){
    final sn = SnackBar(content:Text(msg,
    style: TextStyle(color: Colors.white),
    ),backgroundColor: Colors.red,);
    ScaffoldMessenger.maybeOf(context)!.showSnackBar(sn);
  }

  void showDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        mycontroller[1].text = value.toString();
        final date = DateTime.parse(mycontroller[1].text);
        mycontroller[1].text = '';
        mycontroller[1].text =
            "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().padLeft(2, '0')}";
        apiFromDate =
            "${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}";
        // SalesOnDayAPi.fromDate = apidate;
        // print(SalesOnDayAPi.fromDate);
      });
    });
  }

  void showToDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        mycontroller[2].text = value.toString();
        final date = DateTime.parse(mycontroller[2].text);
        mycontroller[2].text = '';
        mycontroller[2].text =
            "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().padLeft(2, '0')}";
        apiToDate =
            "${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}";
        // GetFollowupApi.fromDate = apidate;
        //  print(mycontroller[2].text);
      });
    });
  }

 
    Future<void> makecall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'exception $url';
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
      throw 'exception $url';
    }
  }

  Future<void> openMap(double latitude, double longitude) async {
    final googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

}
