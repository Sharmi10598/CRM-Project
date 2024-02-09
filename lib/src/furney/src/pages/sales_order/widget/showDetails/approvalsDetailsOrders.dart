// ignore_for_file: prefer_single_quotes, sort_child_properties_last, avoid_print, prefer_interpolation_to_compose_strings, unnecessary_null_comparison, unnecessary_lambdas, invariant_booleans, file_names, prefer_const_constructors, prefer_if_elements_to_conditional_expressions, unnecessary_string_interpolations, sized_box_for_whitespace, require_trailing_commas, unawaited_futures, prefer_final_locals, omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/approvals_api/approval_QTOR_post_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/approvals_api/approvals_details_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/approvals_api/approvals_patch_api.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/approvals_modal/approvals_details.modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesOrderEdit/Screens/ContentEdit.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesOrderEdit/Screens/EditOrder.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesOrderEdit/Screens/HederEdit.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/approvals.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/item_details_approvals.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/creation/content_order_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/screens/SalesQutDetails.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sign_in/widgets/custom_elevatedBtn.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class ApprovalsDetailsOrders extends StatefulWidget {
  const ApprovalsDetailsOrders({required this.title, Key? key})
      : super(key: key);
  final String title;
  @override
  ApprovalsDetailsOrdersState createState() => ApprovalsDetailsOrdersState();
}

class ApprovalsDetailsOrdersState extends State<ApprovalsDetailsOrders> {
  static String? valueSelectedOrder2;
  static String? valueSelectedGPApproval2;
  static String? orderrecTime;
  static bool isCameFormHome = false;
  static bool isCameFormSalesORder = false;
  static String? docTypeName;
  ApprovalDetailsValue? approvalDetailsValue;
  List<DocumentApprovalValue> documentApprovalValue = [];
  String docEntry = '';
  String docDueDate = '';
  @override
  void initState() {
    super.initState();
    ApprovalsDetailsAPi.getGlobalData().then((value) {
      if (value != null) {
        setState(() {
          print("cardName: " + value.docEntry.toString());
          print("DocDueDate: " + value.docDueDate.toString());
          docEntry = value.docEntry.toString();
          docDueDate = value.docDueDate.toString();
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
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("are you sure");
      Get.toNamed<dynamic>(FurneyRoutes.newSalesOrders);
      return Future.value(false);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
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
                      bottom: Screens.width(context) * 0.01),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //scrollview
                        Container(
                          //color:Colors.red,
                          width: Screens.width(context),
                          // height: isCameFormSalesORder == false
                              //  ? Screens.heigth(context) * 0.81
                          //     : Screens.heigth(context) * 0.86,
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
                                      Text(
                                        "Doc.type",
                                        style: TextStyles.boldPC1(context),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: Screens.width(context) * 0.83,
                                            // color: Colors.blue,
                                            child: Text(
                                              "$docTypeName based on draft no. ${approvalDetailsValue!.docNum}", //${approvalDetailsValue!.DocNum}
                                              style: TextStyles.headlineBlack1(
                                                  context),
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
                                    Container(
                                      width: Screens.width(context) * 0.83,
                                      // color: Colors.blue,
                                      child: Text(
                                        "Sales Doc",
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
                                      "Remarks",
                                      style: TextStyles.boldPC1(context),
                                    ),
                                    Container(
                                      width: Screens.width(context) * 0.83,
                                      // color: Colors.blue,
                                      child: Text(
                                        " ",
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
                                      "BP Code",
                                      style: TextStyles.boldPC1(context),
                                    ),
                                    Container(
                                      width: Screens.width(context) * 0.83,
                                      // color: Colors.blue,
                                      child: Text(
                                        "${approvalDetailsValue!.cardCode}",
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
                                      "BP Name",
                                      style: TextStyles.boldPC1(context),
                                    ),
                                    Container(
                                      width: Screens.width(context) * 0.83,
                                      child: Text(
                                        "${approvalDetailsValue!.cardName}",
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
                                      "Date",
                                      style: TextStyles.boldPC1(context),
                                    ),
                                    Container(
                                      width: Screens.width(context) * 0.83,
                                      // color: Colors.blue,
                                      child: Text(
                                        "${approvalDetailsValue!.docDate}",
                                        style: TextStyles.headlineBlack1(context),
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
                  
                                ///
                                SizedBox(
                                  height: Screens.heigth(context) * 0.01,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      // AppLocalizations.of(context)!.docNo,
                                      "Order Type",
                                      style: TextStyles.boldPC1(context),
                                    ),
                                    Container(
                                      width: Screens.width(context) * 0.83,
                                      // color: Colors.blue,
                                      child: Text(
                                        "${approvalDetailsValue!.uOrderType}",
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
                                      "GP Approval",
                                      style: TextStyles.boldPC1(context),
                                    ),
                                    Container(
                                      width: Screens.width(context) * 0.83,
                                      // color: Colors.blue,
                                      child: Text(
                                        "${approvalDetailsValue!.uGpApproval}",
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
                                      "Received Time",
                                      style: TextStyles.boldPC1(context),
                                    ),
                                    Container(
                                      width: Screens.width(context) * 0.83,
                                      // color: Colors.blue,
                                      child: Text(
                                        "${approvalDetailsValue!.uReceivedTime}",
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
                                      "Order Date",
                                      style: TextStyles.boldPC1(context),
                                    ),
                                    Container(
                                      width: Screens.width(context) * 0.83,
                                      // color: Colors.blue,
                                      child: Text(
                                        "${approvalDetailsValue!.uOrderDate}",
                                        style: TextStyles.headlineBlack1(context),
                                      ),
                                    ),
                                  ],
                                ),
                  
                                ///
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Tax",
                                      style: TextStyles.boldPC1(context),
                                    ),
                                    Container(
                                      width: Screens.width(context) * 0.83,
                                      // color: Colors.blue,
                                      child: Text(
                                        //" ${approvalDetailsValue!.vatSum}",
                                        TextStyles.splitValues(
                                            '${approvalDetailsValue!.vatSum}'),
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
                                      "Total",
                                      style: TextStyles.boldPC1(context),
                                    ),
                                    Container(
                                      width: Screens.width(context) * 0.83,
                                      // color: Colors.blue,
                                      child: Text(
                                        //  "${approvalDetailsValue!.docTotal}",
                                        TextStyles.splitValues(
                                            '${approvalDetailsValue!.docTotal}'),
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
                                      "Line Details",
                                      style: TextStyles.boldPC1(context),
                                    ),
                                    Container(
                                      width: Screens.width(context) * 0.83,
                                      // color: Colors.blue,
                                      child: Text(
                                        " ${documentApprovalValue.length} Rows",
                                        style: TextStyles.headlineBlack1(context),
                                      ),
                                    ),
                                  ],
                                ),
                                // SizedBox(height: Screens.heigth(context) * 0.01, ),
                                Divider(
                                  thickness: 1.5,
                                ),
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        documentApprovalValue.length,
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
                                                  CrossAxisAlignment
                                                      .start,
                                              children: [
                                                Text(
                                                  "${i + 1}:",
                                                  style: TextStyles
                                                      .boldPC1(context),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: Screens.width(
                                                              context) *
                                                          0.83,
                                                      // color: Colors.blue,
                                                      child: Text(
                                                        "${documentApprovalValue[i].itemCode}\n${documentApprovalValue[i].itemDescription} (${documentApprovalValue[i].quantity})",
                                                        style: TextStyles
                                                            .headlineBlack1(
                                                                context),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Icon(
                                                        Icons
                                                            .navigate_next_outlined,
                                                        color: theme
                                                            .primaryColor,
                                                        size: Screens
                                                                .heigth(
                                                                    context) *
                                                            0.06,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            )),
                                      );
                                    })
                              ],
                            ),
                          ),
                        ),
                        //button
                       isCameFormSalesORder == false
                            ?
                        Column(
                          children: [
                            // Container(
                            //         // width: Screens.width(context),
                            //         height: Screens.heigth(context) * 0.06,
                            //         //color: Colors.green,
                            //         child: CustomSpinkitdButton(
                            //           onTap: () async {
                            //              CreateOrderDetailsState.isCameforapprovalsales =true;
                            //              LogisticOrderState.approvedocentry=approvalDetailsValue!.docEntry.toString();
                            //               log("LLLLLLLLLLLLLLLLLLLLLLLL:::::::::"+approvalDetailsValue!.U_Order_Type.toString());
                            //               log("LLLLLLLLLLLLLLLLLLLLLLLL:::::::::"+approvalDetailsValue!.U_GP_Approval.toString());
                                         
                            //              if(approvalDetailsValue!.U_Order_Type! =="Select"){
                            //              LogisticOrderState.valueSelectedOrder2 = "0";
                            //              } 
                            //              if(approvalDetailsValue!.U_Order_Type! =="Normal"){
                            //              LogisticOrderState.valueSelectedOrder2 = "1";
                            //              } 
                            //              if(approvalDetailsValue!.U_Order_Type! =="Depot transfer"){
                            //              LogisticOrderState.valueSelectedOrder2 = "2";
                            //              } 
                            //              if(approvalDetailsValue!.U_Order_Type! =="Root Sale"){
                            //              LogisticOrderState.valueSelectedOrder2 = "3";
                            //              } 
                            //              if(approvalDetailsValue!.U_Order_Type! =="Project sale"){
                            //              LogisticOrderState.valueSelectedOrder2 = "4";
                            //              } 
                            //              if(approvalDetailsValue!.U_Order_Type! =="Special Order"){
                            //              LogisticOrderState.valueSelectedOrder2 = "5";
                            //              } 
                                        
                            //               if(approvalDetailsValue!.U_GP_Approval! == "NO"){
                            //              LogisticOrderState. valueSelectedGPApproval2 = "0";
                            //              } 
                            //               if(approvalDetailsValue!.U_GP_Approval! == "Yes"){
                            //              LogisticOrderState. valueSelectedGPApproval2 = "1";
                            //              } 
                                        
                            //             // LogisticOrderState. valueSelectedOrder2 =null;
                            //             //  LogisticOrderState. valueSelectedGPApproval2=null;
                            //             //  LogisticOrderState.   orderrecTime="";
                            //             HeaderOrderCreationState.bpCode =
                            //           approvalDetailsValue!.cardCode!; //;;
                            //       HeaderOrderCreationState.bpName =
                            //           approvalDetailsValue!.cardName!;
                            //       HeaderOrderCreationState.docNo =
                            //           approvalDetailsValue!.DocNum!.toString();
                            //           HeaderOrderCreationState.    salesEmp=GetValues.userName;
                            //           HeaderOrderCreationState.tax=approvalDetailsValue!.vatSum!;
                            //           HeaderOrderCreationState.total=approvalDetailsValue!.docTotal!;
                            //           // approvalDetailsValue!.DocDate
                            //           //  ;
                            //           // LogisticOrderState. valueSelectedGPApproval2 = "0";
                            //            LogisticOrderState. orderrecTime = approvalDetailsValue!.U_Received_Time!;
                            //           ContentOrderCreationState.itemsDetails3
                            //           .clear();
                            //           for(int i=0;i<documentApprovalValue.length;i++){

                            //             ContentOrderCreationState.itemsDetails3.add(AddItem(
                            //               itemCode: documentApprovalValue[i].ItemCode!, 
                            //               itemName: documentApprovalValue[i].ItemDescription!, 
                            //               price: documentApprovalValue[i].Price, 
                            //               discount: 0.00, 
                            //               qty:int.parse(documentApprovalValue[
                            //                         i]
                            //                     .Quantity!
                            //                     .toStringAsFixed(0)), 
                            //               total:  documentApprovalValue[i].total, 
                            //               tax: documentApprovalValue[i]
                            //                     .TaxTotal, 
                            //               valuechoosed: "", 
                            //               discounpercent: 0.0, 
                            //               taxCode: documentApprovalValue[
                            //                         i]
                            //                     .TaxCode, 
                            //               taxPer: documentApprovalValue[
                            //                         i]
                            //                     .TaxTotal, 
                            //               wareHouseCode: documentApprovalValue[i]
                            //                         .warehouseCode, 
                            //               taxName: ""
                            //               ));

                            //           }


                            //         Get.toNamed<dynamic>(
                            //           FurneyRoutes.creationOrderDetails);
                            //           },
                            //           isLoading: isLoading,
                            //           //  labelLoading: AppLocalizations.of(context)!.signing,
                            //           label: 'Edit',
                            //         ),
                            //       ),
                          SizedBox(
                                height: Screens.heigth(context)*0.005,
                              ),
                         Container(
                                // width: Screens.width(context),
                                height: Screens.heigth(context) * 0.06,
                                //color: Colors.green,
                                child: CustomSpinkitdButton(
                                  onTap: () async {
                                    callServiceLayerApi();
                                  },
                                  isLoading: isLoading,
                                  //  labelLoading: AppLocalizations.of(context)!.signing,
                                  label: 'Save',
                                ),
                              ),


                               SizedBox(
                                height: Screens.heigth(context)*0.005,
                              ),
                        //  Container(
                        //         // width: Screens.width(context),
                        //         height: Screens.heigth(context) * 0.06,
                        //         //color: Colors.green,
                        //         child: CustomSpinkitdButton(
                        //           onTap: () async {
                        //            gotoSalesOrderEditPage();
                        //           },
                        //           isLoading: isLoading,
                        //           //  labelLoading: AppLocalizations.of(context)!.signing,
                        //           label: 'Edit',
                        //         ),
                        //       ),

                             
                          ],
                        )
                              
                            : SizedBox(
                                height: 2,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );

    
  }

   void gotoSalesOrderEditPage() async{
    setValue();
    Get.to(()=>EditORderDetails(
      title: "Order Edit", 
      DocEntry:  approvalDetailsValue!.docEntry!,
       isAproved: true,));
  }

    void setValue(){
   setState(() {
                            final totaldiscnt =  approvalDetailsValue!.totalDiscount!;
                            final vatsum =  approvalDetailsValue!.vatSum !;
                            final totalbeforeDiscount =  approvalDetailsValue!.docTotal!-(totaldiscnt+vatsum);
                           HeaderEditOrderPageState.docNo = approvalDetailsValue!.docNum .toString();  
                           HeaderEditOrderPageState.bpName =   approvalDetailsValue!.cardName. toString();
                         HeaderEditOrderPageState.bpCode =  approvalDetailsValue!.cardCode.toString();
                           HeaderEditOrderPageState.currency =   approvalDetailsValue!.docCurrency.toString();//
                          HeaderEditOrderPageState.currentDateTime =   approvalDetailsValue!.docDate.toString();
                         HeaderEditOrderPageState.salesEmp = GetValues.slpCode;
                            //approvalDetailsValue!. .toString();// map sales emp
                           HeaderEditOrderPageState.totalBeforeDiscount = totalbeforeDiscount;
                            HeaderEditOrderPageState.discount =  approvalDetailsValue!.totalDiscount!.toDouble();
                            HeaderEditOrderPageState.tax =  approvalDetailsValue!.vatSum!;
                            HeaderEditOrderPageState.total =  approvalDetailsValue!.docTotal!;
            //cn
            ContentOrderCreationState state = ContentOrderCreationState();
            SalesDetailsQuotState sate2 = SalesDetailsQuotState();
             ContentOrderEditState.itemsDetails3.clear();
            for(int i=0; i< documentApprovalValue.length; i++){
                ContentOrderEditState.itemsDetails3.add(
              AddItem(
                 itemCode:documentApprovalValue[i].itemCode!,
                  itemName: documentApprovalValue[i].itemDescription!, 
                 price:  documentApprovalValue[i].price,
                 discount: 0, //
                 qty: int.parse(documentApprovalValue[i].quantity!.toStringAsFixed(0)),
                 total: documentApprovalValue[i].lineTotal, 
                 tax:  documentApprovalValue[i].taxTotal,
                 valuechoosed:  state.getTaxNane(documentApprovalValue[i].taxCode!.toString()),
                 discounpercent:  documentApprovalValue[i].discountPercent, 
                 taxCode:  documentApprovalValue[i].taxCode.toString(), 
                 taxPer: sate2.caluclateTaxpercent(documentApprovalValue[i].lineTotal!,
                  documentApprovalValue[i].taxTotal!), // val.documentLines![i].
                 wareHouseCode:  documentApprovalValue[i].warehouseCode,
                 taxName: state.getTaxNane(documentApprovalValue[i].taxCode!.toString()),
                 basedocentry: documentApprovalValue[i].baseEntry.toString(),
                 baseline: documentApprovalValue[i].baseLine.toString(),
                 BaseType: double.parse(documentApprovalValue[i].baseType.toString())
                  )//val.documentLines![i].
             );
            }
  });}

  double getDiscount (double discountPercent, double unitPrice,double qty){

   double discount = (unitPrice * qty) * ( discountPercent / 100);
  return discount;
   }



  void callServiceLayerApi() {
    if (mounted) {
      setState(() {
        isLoading = true;
        ApprovalsQuotPostAPi.docEntry = docEntry;
        ApprovalsQuotPostAPi.docDueDate = docDueDate;
        ApprovalsQuotPostAPi.orderDate = approvalDetailsValue!.uOrderDate;
        ApprovalsQuotPostAPi.orderTime = approvalDetailsValue!.uReceivedTime;
        ApprovalsQuotPostAPi.orderType = approvalDetailsValue!.uOrderType;
        ApprovalsQuotPostAPi.custREfNo = approvalDetailsValue!.numAtCard;
        ApprovalsQuotPostAPi.gpApproval = approvalDetailsValue!.uGpApproval;
        // print(' ApprovalsQuotPostAPi.docEntry: '+ ApprovalsQuotPostAPi.docEntry.toString());
        // print(' ApprovalsQuotPostAPi.docEntry: '+ ApprovalsQuotPostAPi.docDueDate .toString());
        ApprovalsQuotPostAPi.getGlobalData().then((value) {
          if (value.statusCode == '201' || value.statusCode == '204') {
            isLoading = true;
            const snackBar = SnackBar(
              duration: Duration(seconds: 5),
              backgroundColor: Colors.green,
              content: Text(
                'Orders Created Successfully!!...',
                style: TextStyle(color: Colors.white),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Get.offAllNamed<dynamic>(FurneyRoutes.newSalesOrders);
          } else if (value.statusCode == '400' || value.statusCode == '404') {
            setState(() {
              isLoading = false;
            });
            // print(value.statusCode);
            // print(value.statusCode+" asasasasasas");
            //print(value.erorrs!.message!.Value);

            final snackBar = SnackBar(
              duration: Duration(seconds: 5),
              backgroundColor: Colors.red,
              content: Text(
                '${value.erorrs!.message!.Value}',
                style: TextStyle(color: Colors.white),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        });
      });
    }
  }

  bool isLoading = false;
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
              content: Container(
                  //  color: Colors.black12,

                  width: Screens.width(context) * 0.8,
                  child: Form(
                    key: formkey[0],
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
                                        borderRadius:
                                            BorderRadius.circular(10)), backgroundColor: btnColor == false
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
    ).whenComplete(() {
      if (isCameFormHome == true && completed == true) {
        Get.offAllNamed<dynamic>(FurneyRoutes.home);
        completed = false;
        isCameFormHome = false;
      } else {
        if (completed == false) {
          Future.delayed(const Duration(seconds: 4), () {
            Navigator.pop(context);
          });
        } else if (completed == true) {
          Get.offAllNamed<dynamic>(FurneyRoutes.approvals);
          completed = false;
        }
      }
    });
  }

  bool completed = false;
  bool btnColor = false;
  void validateAlertBox() {
    if (formkey[0].currentState!.validate()) {
      final focus = FocusScope.of(context);
      if (!focus.hasPrimaryFocus) {
        focus.unfocus();
      }
      ApprovalsPatchAPi.remarks = mycontroller[0].text;
      print(ApprovalsPatchAPi.approvalID);
      print(ApprovalsPatchAPi.remarks);
      print(ApprovalsPatchAPi.status);

      ApprovalsPatchAPi.getGlobalData().then((value) {
        //   print("rescode: " + value.Value.toString());
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
        } else if (value.Value == '204') {
          mycontroller[0].text = '';
          completed = true;
          ApprovalsState.backBtnreload = true;
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
                style: TextStyle(color: Colors.white),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (successString == 'Not Approved') {
            final snackBar = SnackBar(
              duration: Duration(seconds: 3),
              backgroundColor: Colors.red,
              content: Text(
                'Approval successfully $successString',
                style: TextStyle(color: Colors.white),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
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