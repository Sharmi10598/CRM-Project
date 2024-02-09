import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:ultimate_bundle/src/furney/src/Api/customer_bp/customer_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/customer_bp/customer_api.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/customer_bp/new_customer_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class PaymentCustomer extends StatefulWidget {
  const PaymentCustomer({ required this.title, Key? key }) : super(key: key);
  final String title;
  @override
  PaymentCustomerState createState() => PaymentCustomerState();
}

class PaymentCustomerState extends State<PaymentCustomer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<CustomerDetailsValue> customerData = [];
  List<CustomerDetailsValue> customerDataFilter = [];
  ScrollController scrollController = ScrollController();
  List<String>? datta;
  int length=0;
  @override
  void initState() {
    super.initState();
    datta = List.generate(10, (i) => 'item: ${i+1}');
    scrollController.addListener(() { 
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        getmoredata();
      }
    });
    
    GetCustomerAPi.getGlobalData().then((value) {
      setState(() {
        // customerData = value.value!;
        // customerDataFilter = customerData;
        print('leng...${customerData.length}');
        //  print("nextLink: " + value.nextLink .toString());
        // print("cardname: " + customerData[1].cardCode.toString());
      });
    });
  }

  @override
  void dispose(){
    super.dispose();
      scrollController.dispose();
  }
   void getmoredata(){
      Future.delayed(const Duration(seconds: 2), () {
      for(var i=length; i< length+10; i++){
       print('add');

       setState(() {
         datta!.add('item: ${i+1}');
         print('len data: ${datta!.length}');
       });
     }
      length = datta!.length;
    });
     setState(() {
      length = datta!.length;
      print('len: $length');
    });
   }
  bool custNameClicked = false;
  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawer(context),
      appBar: appBar(context, _scaffoldKey, widget.title),
      resizeToAvoidBottomInset: true,
      body: customerData.isEmpty? Center(
            child:  SpinKitThreeBounce(
                          size: Screens.heigth(context)*0.06,
                          color:theme.primaryColor,
                        ),
          ): SafeArea(
        child: PageView(
          children: [
         GestureDetector(
              onTap: () {
              final focus = FocusScope.of(context);
              if (!focus.hasPrimaryFocus) {
                focus.unfocus();
              }

              setState(() {
                 custNameClicked = false;
              });
            },
              child: Stack(
                children: [
                  Container(
                    color: custNameClicked == true? Colors.black54:Colors.white,
                    padding: EdgeInsets.symmetric(
                    horizontal: Screens.width(context)*0.02,
                    vertical: Screens.heigth(context)*0.02,),
                  width: Screens.width(context),
                  height: Screens.heigth(context),
          //  color: Colors.amber,
                  child: SingleChildScrollView(
                    
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                             SizedBox(height: Screens.heigth(context) * 0.01, ),
                                 GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        custNameClicked = true;
                                      });
                                   //  Get.toNamed<dynamic>(FurneyRoutes.bpinfo);
                                //   print("object");
                                 //  showCustomerDialog();
                                   //MyDialog();
            //                    showDialog<dynamic>(
            // context: context,
            // builder: (_) {
            //   return MyDialog();
            // });
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                           'Customer Name',
                                            style: GoogleFonts.poppins(
                                                fontSize: Screens.heigth(context) * 0.018,
                                                color: theme.primaryColor,
                                                fontWeight: FontWeight.bold,),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: Screens.width(context) * 0.83,
                                                // color: Colors.blue,
                                                child: Text(
                                                 'custName',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: Screens.heigth(context) * 0.02,
                                                      color: Colors.black54,),
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
                                  ),
                           
                            SizedBox(height: Screens.heigth(context) * 0.01, ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                 'Document No',
                                 // "Doc No.",
                                  style: GoogleFonts.poppins(
                                      fontSize: Screens.heigth(context) * 0.018,
                                      color: theme.primaryColor,
                                      fontWeight: FontWeight.bold,),
                                ),
                                SizedBox(
                                  width: Screens.width(context) * 0.83,
                                  // color: Colors.blue,
                                  child: Text(
                                    'docno',
                                    style: GoogleFonts.poppins(
                                        fontSize: Screens.heigth(context) * 0.02,
                                        color: Colors.black54,),
                                  ),
                                ),
                              ],
                            ),
                           SizedBox(height: Screens.heigth(context) * 0.01, ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                 'Posting Date',
                                 // "Doc No.",
                                  style: GoogleFonts.poppins(
                                      fontSize: Screens.heigth(context) * 0.018,
                                      color: theme.primaryColor,
                                      fontWeight: FontWeight.bold,),
                                ),
                                SizedBox(
                                  width: Screens.width(context) * 0.83,
                                  // color: Colors.blue,
                                  child: Text(
                                    'posno',
                                    style: GoogleFonts.poppins(
                                        fontSize: Screens.heigth(context) * 0.02,
                                        color: Colors.black54,),
                                  ),
                                ),
                              ],
                            ),
                             SizedBox(height: Screens.heigth(context) * 0.01, ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                 'Due Date',
                                 // "Doc No.",
                                  style: GoogleFonts.poppins(
                                      fontSize: Screens.heigth(context) * 0.018,
                                      color: theme.primaryColor,
                                      fontWeight: FontWeight.bold,),
                                ),
                                SizedBox(
                                  width: Screens.width(context) * 0.83,
                                  // color: Colors.blue,
                                  child: Text(
                                    'docno',
                                    style: GoogleFonts.poppins(
                                        fontSize: Screens.heigth(context) * 0.02,
                                        color: Colors.black54,),
                                  ),
                                ),
                              ],
                            ),
                             SizedBox(height: Screens.heigth(context) * 0.01, ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                 'Document Date',
                                 // "Doc No.",
                                  style: GoogleFonts.poppins(
                                      fontSize: Screens.heigth(context) * 0.018,
                                      color: theme.primaryColor,
                                      fontWeight: FontWeight.bold,),
                                ),
                                SizedBox(
                                  width: Screens.width(context) * 0.83,
                                  // color: Colors.blue,
                                  child: Text(
                                    'docno',
                                    style: GoogleFonts.poppins(
                                        fontSize: Screens.heigth(context) * 0.02,
                                        color: Colors.black54,),
                                  ),
                                ),
                              ],
                            ),
                              SizedBox(height: Screens.heigth(context) * 0.01, ),
                            
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                  Text(
                                 'Remarks',
                                 // "Doc No.",
                                  style: GoogleFonts.poppins(
                                      fontSize: Screens.heigth(context) * 0.018,
                                      color: theme.primaryColor,
                                      fontWeight: FontWeight.bold,),
                                ),
                                 SizedBox(height: Screens.heigth(context) * 0.01, ),
                                 TextField(
                                   maxLines: 3,
                                    keyboardType: TextInputType.multiline,
                                    decoration:  InputDecoration(
                                                  contentPadding: const EdgeInsets.symmetric(
                                                      vertical: 10, horizontal: 10,),

                                                  //check
                                                  labelText: '',
                                                  labelStyle: TextStyle(
                                                    color:theme.primaryColor,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(5),
                                                    borderSide:
                                                        const BorderSide(color: Colors.green),
                                                  ),
                                                
                                                ),
                                 ),
                               ],
                             ),     
                            SizedBox(height: Screens.heigth(context) * 0.01, ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                                  SizedBox(
                                    width: Screens.width(context)*0.37,
                                    height: Screens.heigth(context)*0.06,
                                //    color: Colors.green,
                                    child: Row(
                                      children: [
                                        Text(
                                 'On Account',
                                 // "Doc No.",
                                        style: GoogleFonts.poppins(
                                            fontSize: Screens.heigth(context) * 0.018,
                                            color: theme.primaryColor,
                                            fontWeight: FontWeight.bold,),
                                ),
                                Theme(
                                              data: ThemeData(
                                                  unselectedWidgetColor:
                                                      theme.primaryColor,),
                                              child: Checkbox(
                                                  value: check,
                                                  activeColor:
                                                     theme.primaryColor,
                                                  // checkColor: Colors.greenAccent,
                                                  onChanged: (val) {
                                                    setState(() {
                                                       check = val!;
                                                      // comekids = "Y";
                                                    });
                                                  },),),
                                      ],
                                    ),
                                  ),

                                   Visibility(
                                     visible: check,
                                     child: SizedBox(
                                        width: Screens.width(context)*0.58,
                                      height: Screens.heigth(context)*0.06,
                                //     color: Colors.blue,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                 'Account',
                                 // "Doc No.",
                                          style: GoogleFonts.poppins(
                                              fontSize: Screens.heigth(context) * 0.018,
                                              color: theme.primaryColor,
                                              fontWeight: FontWeight.bold,),
                                ),
                              SizedBox(
                                height: Screens.heigth(context)*0.05,
                                width:Screens.width(context) *0.4,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10,),
                                            labelText: '',
                                            labelStyle: const TextStyle(
                                              color:Colors.red,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide:
                                                  const BorderSide(color: Colors.green),
                                            ),
                                          ),
                                ),
                              )
                                        ],
                                      ),
                                  ),
                                   ),
                                          
                                         
                                        ],
                                      ),   
                          SizedBox(height: Screens.heigth(context) * 0.01, ),  
                            GestureDetector(
                                    onTap: (){
                                   //  Get.toNamed<dynamic>(FurneyRoutes.bpinfo);
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                         'Adjustment Info',
                                          style: GoogleFonts.poppins(
                                              fontSize: Screens.heigth(context) * 0.018,
                                              color: theme.primaryColor,
                                              fontWeight: FontWeight.bold,),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                              //               SizedBox(
                              //   height: Screens.heigth(context)*0.05,
                              //   width:Screens.width(context) *0.4,
                              //   child: TextFormField(
                              //     decoration: InputDecoration(
                              //               contentPadding: const EdgeInsets.symmetric(
                              //                   vertical: 10, horizontal: 10),
                              //               labelText: '',
                              //               labelStyle: const TextStyle(
                              //                 color:Colors.red,
                              //               ),
                              //               border: OutlineInputBorder(
                              //                 borderRadius: BorderRadius.circular(5),
                              //                 borderSide:
                              //                     const BorderSide(color: Colors.red),
                              //               ),
                              //             ),
                              //   ),
                              // ), 
                               SizedBox(
                                              width: Screens.width(context) * 0.83,
                                              // color: Colors.blue,
                                              child: Text(
                                               '128787',
                                                style: GoogleFonts.poppins(
                                                    fontSize: Screens.heigth(context) * 0.02,
                                                    color: Colors.black54,),
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
                                   //  Get.toNamed<dynamic>(FurneyRoutes.bpinfo);
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                         'Cash',
                                          style: GoogleFonts.poppins(
                                              fontSize: Screens.heigth(context) * 0.018,
                                              color: theme.primaryColor,
                                              fontWeight: FontWeight.bold,),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: Screens.width(context) * 0.83,
                                              // color: Colors.blue,
                                              child: Text(
                                               '128787',
                                                style: GoogleFonts.poppins(
                                                    fontSize: Screens.heigth(context) * 0.02,
                                                    color: Colors.black54,),
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
                                   //  Get.toNamed<dynamic>(FurneyRoutes.bpinfo);
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                         'Check',
                                          style: GoogleFonts.poppins(
                                              fontSize: Screens.heigth(context) * 0.018,
                                              color: theme.primaryColor,
                                              fontWeight: FontWeight.bold,),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: Screens.width(context) * 0.83,
                                              // color: Colors.blue,
                                              child: Text(
                                               'check',
                                                style: GoogleFonts.poppins(
                                                    fontSize: Screens.heigth(context) * 0.02,
                                                    color: Colors.black54,),
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
                                   //  Get.toNamed<dynamic>(FurneyRoutes.bpinfo);
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                         'Bank Transfer',
                                          style: GoogleFonts.poppins(
                                              fontSize: Screens.heigth(context) * 0.018,
                                              color: theme.primaryColor,
                                              fontWeight: FontWeight.bold,),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: Screens.width(context) * 0.83,
                                              // color: Colors.blue,
                                              child: Text(
                                               '21212',
                                                style: GoogleFonts.poppins(
                                                    fontSize: Screens.heigth(context) * 0.02,
                                                    color:Colors.black54,),
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
                         Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                             // width: Screens.width(context) * 0.83,
                                              // color: Colors.blue,
                                              child: Text(
                                               'Total: ',
                                                style: GoogleFonts.poppins(
                                              fontSize: Screens.heigth(context) * 0.018,
                                              color: theme.primaryColor,
                                              fontWeight: FontWeight.bold,),
                                              ),
                                            ),
                                            Container(
                                              child:  Text(
                                               '1231 ',
                                                style: GoogleFonts.poppins(
                                                    fontSize: Screens.heigth(context) * 0.02,
                                                    color: Colors.black54,),
                                              ),
                                            )
                                          ],
                                        ),
                       SizedBox(height: Screens.heigth(context) * 0.01, ), 
                         Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                             // width: Screens.width(context) * 0.83,
                                              // color: Colors.blue,
                                              child: Text(
                                               'Balance: ',
                                                style: GoogleFonts.poppins(
                                              fontSize: Screens.heigth(context) * 0.018,
                                              color: theme.primaryColor,
                                              fontWeight: FontWeight.bold,),
                                              ),
                                            ),
                                            Container(
                                              child:  Text(
                                               '0 ',
                                                style: GoogleFonts.poppins(
                                                    fontSize: Screens.heigth(context) * 0.02,
                                                    color: Colors.black54,),
                                              ),
                                            )
                                          ],
                                        ),

                       SizedBox(height: Screens.heigth(context) * 0.01, ), 
                       Center(
                         child: SizedBox(
                                width: Screens.width(context)*0.4,
                                height: Screens.heigth(context)*0.05,
                               
                                  child: ElevatedButton(
                                      onPressed: null,
                                      // () {
                                      //   print("hello");
                                       
                                      // },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),), backgroundColor: theme.primaryColor,
                                      ),
                                      child: const Icon(Icons.save),
                                      //    Text("Cancel",
                                      //       style: TextStyle(color: Colors.white)),
                                      ),
                                ),
                              ),
                       
                         SizedBox(height: Screens.heigth(context) * 0.01, ),
                                       
                      ],
                    ),
                  ),
          ),
              Visibility(
                visible: custNameClicked,
                child: Center(
                  child: Card(
                    shadowColor: Colors.black,
                    elevation: 9,
                    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: Screens.heigth(context)*0.02,
                        horizontal: Screens.width(context)*0.02,),
                     
                      width: Screens.width(context)*0.9,
                      height: Screens.heigth(context)*0.5,
                      child: Column(
                    children: [
                      Container(
                        height: Screens.heigth(context) * 0.06,
                        decoration: BoxDecoration(
                          color: theme.hintColor.withOpacity(.05),
                          borderRadius: BorderRadius.circular(Const.radius),
                        ),
                        child: TextField(
                          //  controller: searchController,
                          autocorrect: false,
                          style: theme.textTheme.bodyMedium,
                          onChanged: (v) {
                            setState(() {
                              // customerDataFilter = customerData
                              //     .where((e) =>
                              //         (e)
                              //             .cardName!
                              //             .toLowerCase()
                              //             .contains(v.toLowerCase()) ||
                              //         (e)
                              //             .cardCode!
                              //             .toLowerCase()
                              //             .contains(v.toLowerCase()))
                              //     .toList();
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Search for Customer',
                            // AppLocalizations.of(context)!
                            //     .search_sales_quot,
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
                      Expanded(//B1SESSION=cd7eff02-46e1-11ec-8000-000c29e6775e
                        child:
                         ListView.builder(
                          controller:scrollController,
                          itemCount: datta!.length,
                          itemBuilder: (BuildContext context, int i) {
                            if(i ==datta!.length-1 ){
                                return SpinKitThreeBounce(
                              size: Screens.width(context)*0.06,
                              color:theme.primaryColor,
                            );
                                
                            }
                            return
                                //  Card(
                                //    elevation: 8,
                                //   child:
                                InkWell(
                              onTap: () {
                                print('object');
                                setState(() {
                                //  PaymentCustomerState.custName = customerDataFilter[i].cardName.toString();
                                 // PageOneState.custName = customerDataFilter[i].cardName.toString();
                                });
                                Navigator.pop(context);
                                // BPInfoState.data = customerDataFilter;
                                // GeneralState.datas = customerDataFilter;
                                // Get.toNamed<dynamic>(FurneyRoutes.bpinfo);
                                //   print(customerDataFilter[i].cardName.toString());
                                // GeneralState.index = i;
                                // BPInfoState.index = i;
                              },
                              child: Container(
                                  // height: Screens.heigth(context)*0.1,
                                  width: Screens.width(context),
                                  color: Colors.transparent,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: Screens.width(context) * 0.52,
                                      //  color: Colors.greenAccent,
                                        child: Text(
                                          datta![i],
                                          style: GoogleFonts.poppins(
                                            color: Colors.black54,
                                            fontSize: Screens.width(context) * 0.04,
                                            //  fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                      // Column(
                                      //   crossAxisAlignment:
                                      //       CrossAxisAlignment.start,
                                      //   children: [
                                      //     Container(
                                      //       //width: Screens.width(context)*0.55,
                                      //       //  color: Colors.greenAccent,
                                      //       child: Text(
                                      //         customerDataFilter[i]
                                      //             .cardCode
                                      //             .toString(),
                                      //         style: GoogleFonts.poppins(
                                      //           color: Colors.red[200],
                                      //           fontSize:
                                      //               Screens.width(context) * 0.035,

                                      //           ///  fontWeight: FontWeight.bold
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          // top: Screens.heigth(context) * 0.005,
                                          // bottom: Screens.heigth(context) * 0.005,
                                          left: Screens.width(context) * 0.06,
                                          right: Screens.width(context) * 0.06,
                                        ),
                                        child: const Divider(
                                          thickness: 1.5,
                                        ),
                                      )
                                    ],
                                  ),),
                              //  ),
                            );
                          },
                        ),
                      )
                    ],
                ),
                    ),
                  ),
                ),
              ),
              
                ],
              ),
            ),
            Container(
            width: Screens.width(context),
            height: Screens.heigth(context),
            color: Colors.blue,
            child: const Text('Data'),
          ),
          
          ],
        ),
      ),
    );
  }
  bool check = false;
}