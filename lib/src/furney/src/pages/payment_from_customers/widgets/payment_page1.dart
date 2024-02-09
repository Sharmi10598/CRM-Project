import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:ultimate_bundle/src/furney/src/Api/customer_bp/customer_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/customer_bp/customer_api.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/customer_bp/new_customer_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';

class PageOne extends StatefulWidget {
  const PageOne({ Key? key }) : super(key: key);

  @override
  PageOneState createState() => PageOneState();
}

class PageOneState extends State<PageOne> {
   List<CustomerDetailsValue> customerData = [];
  List<CustomerDetailsValue> customerDataFilter = [];
   String? custName;
   bool check = false;

    @override
  void initState() {
    super.initState();
    // print("alert dialog");
    GetCustomerAPi.getGlobalData().then((value) {
      setState(() {
        // customerData = value.value!;
        // customerDataFilter = customerData;
        print('leng...${customerData.length}');
        // print("cardcode: " + customerData[0].cardCode.toString());
        // print("cardname: " + customerData[1].cardCode.toString());
      });
    });
    //  method();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return customerData.isEmpty?Center(child: SpinKitThreeBounce(
                          size: Screens.heigth(context)*0.06,
                          color:theme.primaryColor,
                        ),):
     GestureDetector(
              onTap: () {
              final focus = FocusScope.of(context);
              if (!focus.hasPrimaryFocus) {
                focus.unfocus();
              }
            },
              child: Container(
                color: Colors.transparent,
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
                               //  Get.toNamed<dynamic>(FurneyRoutes.bpinfo);
                               print('object');
                               showCustomerDialog();
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
                                            color: theme.primaryColor,),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: Screens.width(context) * 0.83,
                                            // color: Colors.blue,
                                            child: Text(
                                             '$custName',
                                              style: GoogleFonts.poppins(
                                                  fontSize: Screens.heigth(context) * 0.02,
                                                  color: Colors.black,),
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
                                  color: theme.primaryColor,),
                            ),
                            SizedBox(
                              width: Screens.width(context) * 0.83,
                              // color: Colors.blue,
                              child: Text(
                                'docno',
                                style: GoogleFonts.poppins(
                                    fontSize: Screens.heigth(context) * 0.02,
                                    color: Colors.black,),
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
                                  color: theme.primaryColor,),
                            ),
                            SizedBox(
                              width: Screens.width(context) * 0.83,
                              // color: Colors.blue,
                              child: Text(
                                'posno',
                                style: GoogleFonts.poppins(
                                    fontSize: Screens.heigth(context) * 0.02,
                                    color: Colors.black,),
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
                                  color: theme.primaryColor,),
                            ),
                            SizedBox(
                              width: Screens.width(context) * 0.83,
                              // color: Colors.blue,
                              child: Text(
                                'docno',
                                style: GoogleFonts.poppins(
                                    fontSize: Screens.heigth(context) * 0.02,
                                    color: Colors.black,),
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
                                  color: theme.primaryColor,),
                            ),
                            SizedBox(
                              width: Screens.width(context) * 0.83,
                              // color: Colors.blue,
                              child: Text(
                                'docno',
                                style: GoogleFonts.poppins(
                                    fontSize: Screens.heigth(context) * 0.02,
                                    color: Colors.black,),
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
                                  color: theme.primaryColor,),
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
                                        color: theme.primaryColor,),
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
                                          color: theme.primaryColor,),
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
                                          color: theme.primaryColor,),
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
                                                color: Colors.black,),
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
                                          color: theme.primaryColor,),
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
                                                color: Colors.black,),
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
                                          color: theme.primaryColor,),
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
                                                color: Colors.black,),
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
                                          color: theme.primaryColor,),
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
                                                color: Colors.black,),
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
                                          color: theme.primaryColor,),
                                          ),
                                        ),
                                        Container(
                                          child:  Text(
                                           '1231 ',
                                            style: GoogleFonts.poppins(
                                                fontSize: Screens.heigth(context) * 0.02,
                                                color: Colors.black,),
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
                                          color: theme.primaryColor,),
                                          ),
                                        ),
                                        Container(
                                          child:  Text(
                                           '0 ',
                                            style: GoogleFonts.poppins(
                                                fontSize: Screens.heigth(context) * 0.02,
                                                color: Colors.black,),
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
            );
  }
 void showCustomerDialog(){
   showDialog<dynamic>(
  context: context,
  builder: (context) {
   // String contentText = "Content of Dialog";
    return StatefulBuilder(builder: (context, setState) {
         final theme = Theme.of(context);
        return AlertDialog(
      //    title: Text("Title of Dialog"),
     content: SizedBox(
        //  color: Colors.black12,
        height: Screens.heigth(context) * 0.4,
        width: Screens.width(context) * 0.8,
        child: 
        // customerData.length == 0
        //     ? Center(child: CircularProgressIndicator())
        //     :
             Column(
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
                       //   customerDataFilter = customerData
                              // .where((e) =>
                              //     (e)
                              //         .cardName!
                              //         .toLowerCase()
                              //         .contains(v.toLowerCase()) ||
                              //     (e)
                              //         .cardCode!
                              //         .toLowerCase()
                              //         .contains(v.toLowerCase()))
                              // .toList();
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
                  Expanded(
                    child: ListView.builder(
                      itemCount: customerDataFilter.length,
                      itemBuilder: (BuildContext context, int i) {
                        return
                            //  Card(
                            //    elevation: 8,
                            //   child:
                            InkWell(
                          onTap: () {
                          //  print('object');
                            // setState(() {
                            // //  PaymentCustomerState.custName = customerDataFilter[i].cardName.toString();
                            //   custName = customerDataFilter[i].cardName.toString();
                            // });
                            mapvalue(i);
                            // Navigator.pop(context);
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
                                   '',//   customerDataFilter[i].cardName.toString(),
                                      style: GoogleFonts.poppins(
                                        color: Colors.black54,
                                        fontSize: Screens.width(context) * 0.04,
                                        //  fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        //width: Screens.width(context)*0.55,
                                        //  color: Colors.greenAccent,
                                        child: Text(
                                          // customerDataFilter[i]
                                          //     .cardCode
                                          //     .toString(),
                                          '',//
                                          style: GoogleFonts.poppins(
                                            color: Colors.red[200],
                                            fontSize:
                                                Screens.width(context) * 0.035,

                                            ///  fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
      
        );
      },
    );
  },
);
 }
 void  mapvalue(int i){
   setState(() {
     // custName = customerDataFilter[i].cardName.toString();
   });
   Navigator.pop(context);
 }
}