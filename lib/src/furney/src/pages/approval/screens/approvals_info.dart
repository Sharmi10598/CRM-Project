// ignore_for_file: prefer_single_quotes, sort_child_properties_last, avoid_print, prefer_interpolation_to_compose_strings, unnecessary_null_comparison, unnecessary_lambdas, invariant_booleans, require_trailing_commas, prefer_const_constructors, prefer_if_elements_to_conditional_expressions

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/approvals_api/approvals_details_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/approvals_api/approvals_patch_api.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/approvals_modal/approvals_details.modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/approvals.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/item_details_approvals.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class ApprovalsInfo extends StatefulWidget {
  const ApprovalsInfo({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  ApprovalsInfoState createState() => ApprovalsInfoState();
}

class ApprovalsInfoState extends State<ApprovalsInfo> {
  static bool iscomeFromRejectORApproved = false;
  static bool isCameFormHome=false;
  static String? docTypeName;
  ApprovalDetailsValue? approvalDetailsValue;
  List<DocumentApprovalValue> documentApprovalValue = [];
  @override
  void initState() {
    super.initState();
      print("url: "+ApprovalsDetailsAPi.url);
    ApprovalsDetailsAPi.getGlobalData().then((value) {
      if (value != null) {
        setState(() {
          print("cardName: " + value.cardName.toString());
          // value.Customervalue![0].salesPersonCode!.toStringAsFixed(0);
          //print(value.nextLink);
          // valuesReturn(value.approvalsvalue![0].ObjType.toString());
          approvalDetailsValue = value;
          documentApprovalValue = value.documentLines!;
        });
      } else if (value.error != null) {
        final snackBar = SnackBar(
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          content: Text(
            '${value.error}!!..',
            style: const TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    final now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("are you sure");
    if(isCameFormHome==true &&  completed==true){
       Get.offAllNamed<dynamic>(FurneyRoutes.home);
      return Future.value(true);
    }
      return Future.value(true);
    }
       if(isCameFormHome==true){
       Get.offAllNamed<dynamic>(FurneyRoutes.home);
      return Future.value(true);
    }
      return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return
    //  WillPopScope(
    //   onWillPop: onbackpress,
    //   child: 
      Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        appBar: appBar(context, _scaffoldKey, widget.title),
        drawer: drawer(context),
        body: approvalDetailsValue == null
            ? Center(
                child: SpinKitThreeBounce(
                  size: Screens.heigth(context) * 0.06,
                  color: theme.primaryColor,
                ),
              )
            : SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: Screens.width(context) * 0.02,
                      right: Screens.width(context) * 0.02,
                      top: Screens.heigth(context) * 0.01,
                      bottom: Screens.width(context) * 0.001),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //scrollview
                      SizedBox(
                        width: Screens.width(context),
                        height: Screens.heigth(context) * 0.788,
                        child: SingleChildScrollView(
                          //scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Get.toNamed<dynamic>(
                                  //     FurneyRoutes.draftDetails);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Doc.type",
                                        style: TextStyles.boldPC1(context)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: Screens.width(context) * 0.83,
                                          // color: Colors.blue,
                                          child: Text(
                                            "$docTypeName based on draft no. ${approvalDetailsValue!.docNum}", //${approvalDetailsValue!.DocNum}
                                            style:TextStyles.bodytextBlack1(context),
                                          ),
                                        ),
                                        // Container(
                                        //   child: Icon(
                                        //     Icons.navigate_next_outlined,
                                        //     color: theme.primaryColor,
                                        //     size:
                                        //         Screens.heigth(context) * 0.06,
                                        //   ),
                                        // )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Screens.heigth(context) * 0.01,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Template",
                                    style: TextStyles.boldPC1(context),
                                  ),
                                  SizedBox(
                                    width: Screens.width(context) * 0.83,
                                    // color: Colors.blue,
                                    child: Text(
                                      "Sales Doc",
                                      style: TextStyles.bodytextBlack1(context),
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
                                    "Remarks",
                                    style: TextStyles.boldPC1(context),
                                  ),
                                  SizedBox(
                                    width: Screens.width(context) * 0.83,
                                    // color: Colors.blue,
                                    child: Text(
                                      " ",
                                      style: TextStyles.bodytextBlack1(context),
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
                                    "BP Code",
                                    style: TextStyles.boldPC1(context),
                                  ),
                                  SizedBox(
                                    width: Screens.width(context) * 0.83,
                                    // color: Colors.blue,
                                    child: Text(
                                      "${approvalDetailsValue!.cardCode}",
                                      style:TextStyles.bodytextBlack1(context),
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
                                    "BP Name",
                                    style: TextStyles.boldPC1(context),
                                  ),
                                  SizedBox(
                                    width: Screens.width(context) * 0.83,
                                    // color: Colors.blue,
                                    child: Text(
                                      "${approvalDetailsValue!.cardName}",
                                      style: TextStyles.bodytextBlack1(context),
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
                                    "Date",
                                    style: TextStyles.boldPC1(context),
                                  ),
                                  SizedBox(
                                    width: Screens.width(context) * 0.83,
                                    // color: Colors.blue,
                                    child: Text(
                                      "${approvalDetailsValue!.docDate}",
                                      style: TextStyles.bodytextBlack1(context),
                                    ),
                                  ),
                                ],
                              ),
                              //  SizedBox(height: Screens.heigth(context) * 0.01, ),
                              //    Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Text(
                              //       "Discount",
                              //       style: GoogleFonts.poppins(
                              //           fontSize: Screens.heigth(context) * 0.018,
                              //           color: theme.primaryColor,
                              //           fontWeight:FontWeight.bold),
                              //     ),
                              //     Container(
                              //       width: Screens.width(context) * 0.83,
                              //       // color: Colors.blue,
                              //       child: Text(
                              //         "23.00%",
                              //         style: GoogleFonts.poppins(
                              //             fontSize: Screens.heigth(context) * 0.02,
                              //             color: Colors.black),
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
                                    "Tax",
                                    style: TextStyles.boldPC1(context),
                                  ),
                                  SizedBox(
                                    width: Screens.width(context) * 0.83,
                                    // color: Colors.blue,
                                    child: Text(
                                     // " ${approvalDetailsValue!.vatSum}",
                                      TextStyles.splitValues('${approvalDetailsValue!.vatSum}'),
                                      style: TextStyles.bodytextBlack1(context),
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
                                    "Total",
                                    style: TextStyles.boldPC1(context),
                                  ),
                                  SizedBox(
                                    width: Screens.width(context) * 0.83,
                                    // color: Colors.blue,
                                    child: Text(
                                     // "${approvalDetailsValue!.docTotal}",
                                      TextStyles.splitValues('${approvalDetailsValue!.docTotal}'),
                                      style: TextStyles.bodytextBlack1(context),
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
                                    "Line Details",
                                    style: TextStyles.boldPC1(context),
                                  ),
                                  SizedBox(
                                    width: Screens.width(context) * 0.83,
                                    // color: Colors.blue,
                                    child: Text(
                                      " ${documentApprovalValue.length} Rows",
                                      style:TextStyles.bodytextBlack1(context),
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(height: Screens.heigth(context) * 0.01, ),
                              Divider(
                                thickness: 1.5,
                              ),
                              LimitedBox(
                               //   width: Screens.width(context),
                                  //color: Colors.red,
                                  maxHeight: Screens.heigth(context) * 0.6,
                                  //  child: Expanded(
                                  child: Column(
                                     mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: ListView.builder(
                                           shrinkWrap: true,
                                            itemCount: documentApprovalValue.length,
                                            itemBuilder: (c, i) {
                                              return GestureDetector(
                                                onTap: () {
                                                  DetailsPageState.index = i;
                                                  print(DetailsPageState.index);
                                                  DetailsPageState
                                                          .documentApprovalValue =
                                                      documentApprovalValue;
                                                  Get.toNamed<dynamic>(
                                                      FurneyRoutes.details);
                                                },
                                                child: Container(
                                                    color: Colors.transparent,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "${i + 1}:",
                                                          style:TextStyles.boldPC1(context),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                              width: Screens.width(
                                                                      context) *
                                                                  0.83,
                                                              // color: Colors.blue,
                                                              child: Text(
                                                                "${documentApprovalValue[i].itemCode}\n${documentApprovalValue[i].itemDescription} (${documentApprovalValue[i].quantity})",
                                                                style:TextStyles.bodytextBlack1(context),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Icon(
                                                                Icons
                                                                    .navigate_next_outlined,
                                                                color: theme
                                                                    .primaryColor,
                                                                size: Screens.heigth(
                                                                        context) *
                                                                    0.06,
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    )),
                                              );
                                            }),
                                      ),
                                    ],
                                  )
                                  //),
                                  )
                            ],
                          ),
                        ),
                      ),
                      //button
                 iscomeFromRejectORApproved==false?     Row(
                        children: [
                          SizedBox(
                            //  color: Colors.green,
                            height: Screens.heigth(context) * 0.075,
                            width: Screens.width(context) * 0.478,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  btnColor = false;
                                  successString = 'Approved';
                                });
                                ApprovalsPatchAPi.status = 'ardApproved';
                                showCustomerDialog();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.done),
                                  Text(
                                    "Accept",
                                    style: TextStyles.whiteText(context),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)), backgroundColor: Colors.green,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.075,
                            width: Screens.width(context) * 0.478,
                            //  color: Colors.red,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  btnColor = true;
                                  successString = 'Not Approved';
                                });
                                ApprovalsPatchAPi.status = 'ardNotApproved';
                                showCustomerDialog();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.close),
                                  Text(
                                    "Reject",
                                    style: TextStyles.whiteText(context),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)), backgroundColor: Colors.red,
                              ),
                            ),
                          )
                        ],
                      ):SizedBox()
                    ],
                  ),
                ),
              ),
    //  ),
    );
  }
List<GlobalKey<FormState>> formkey =
      List.generate(3, (i) => GlobalKey<FormState>());
  String? successString;
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  void showCustomerDialog() {
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

                  width: Screens.width(context) * 0.8,
                  child: Form(
                    key:formkey[0] ,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Remarks: ',
                          style: GoogleFonts.poppins(
                              fontSize: Screens.heigth(context) * 0.018,
                              color: theme.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Remarks field is mandatory";
                                      }

                                      return null;
                                    },
                          controller: mycontroller[0],
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),

                            //check
                            labelText: '',
                            labelStyle: TextStyle(
                              color: theme.primaryColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Screens.heigth(context) * 0.01,
                        ),
                        Center(
                          child: SizedBox(
                              width: Screens.width(context) * 0.2,
                              height: Screens.heigth(context) * 0.04,
                              child: ElevatedButton(
                                  onPressed: () {
                                   validateAlertBox();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)), backgroundColor: btnColor == false
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  child: Icon(Icons.done))),
                        )
                      ],
                    ),
                  )),
            );
          },
        );
      },
    )
    .whenComplete(() {
      if(isCameFormHome==true && completed==true){
            Get.offAllNamed<dynamic>(FurneyRoutes.home);
            completed=false;
            isCameFormHome=false;
      }else{
              if(completed == false){
 Future.delayed(const Duration(seconds: 4),(){
         Navigator.pop(context);
      });
      }
      else if(completed == true){
           Get.offAllNamed<dynamic>(FurneyRoutes.approvals);
            completed=false;
      }
      }
  
    });
  }
   bool completed = false;
  bool btnColor = false;
  void  validateAlertBox(){
    if (formkey[0].currentState!.validate()) {
       final focus = FocusScope.of(context);
                          if (!focus.hasPrimaryFocus) {
                            focus.unfocus();
                          }
       ApprovalsPatchAPi.remarks =
                                        mycontroller[0].text;
                                    print(  ApprovalsPatchAPi.approvalID);
                                    print(ApprovalsPatchAPi.remarks);
                                     print(ApprovalsPatchAPi.status);

                                    ApprovalsPatchAPi.getGlobalData()
                                        .then((value) {
                                  if (value.Value == "400") {
          mycontroller[0].text = '400';
          completed = false;
          Navigator.pop(context);
          final snackBar = SnackBar(
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red,
            content: Text(
              'Restart the app !!....',
              style: TextStyle(color: Colors.white),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } 
                                   else if(value.Value=='204'){
                                       mycontroller[0].text = '';
                                         completed = true;
                                        ApprovalsState. backBtnreload =true;
                                        Navigator.pop(context);
                                        // print("did: " +
                                        //     value.errorPatch!.message!.Value!
                                                //.toString());
                                        if (successString == 'Approved') {
                                        
                                          final snackBar = SnackBar(
                                            duration: Duration(seconds: 3),
                                            backgroundColor: Colors.green,
                                            content: Text(
                                              'Approval successfully $successString',
                                              style:
                                                  TextStyle(color: Colors.white),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                               
                                        } else if (successString ==
                                            'Not Approved') {
                                           
                                          final snackBar = SnackBar(
                                            duration: Duration(seconds: 3),
                                            backgroundColor: Colors.red,
                                            content: Text(
                                              'Approval successfully $successString',
                                              style:
                                                  TextStyle(color: Colors.white),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                   }
                                   }                                  
                                    });
                                    }
  }
}
  // else{
                                    //    mycontroller[0].text = '';
                                    //    completed = true;
                                    //   Navigator.pop(context);
                                    //   // print("did: " +
                                    //   //     value.errorPatch!.message!.Value!
                                    //           //.toString());
                                    //   if (successString == 'Approved') {
                                      
                                    //     final snackBar = SnackBar(
                                    //       duration: Duration(seconds: 3),
                                    //       backgroundColor: Colors.green,
                                    //       content: Text(
                                    //         'successfully $successString',
                                    //         style:
                                    //             TextStyle(color: Colors.white),
                                    //       ),
                                    //     );
                                    //     ScaffoldMessenger.of(context)
                                    //         .showSnackBar(snackBar);
                                             
                                    //   } else if (successString ==
                                    //       'Not Approved') {
                                         
                                    //     final snackBar = SnackBar(
                                    //       duration: Duration(seconds: 3),
                                    //       backgroundColor: Colors.red,
                                    //       content: Text(
                                    //         'successfully $successString',
                                    //         style:
                                    //             TextStyle(color: Colors.white),
                                    //       ),
                                    //     );
                                    //     ScaffoldMessenger.of(context)
                                    //         .showSnackBar(snackBar);
                                    //   }
                                    // }