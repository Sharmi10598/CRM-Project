// ignore_for_file: prefer_single_quotes, sort_child_properties_last, avoid_print, prefer_interpolation_to_compose_strings, unnecessary_null_comparison, unnecessary_lambdas, invariant_booleans, file_names, prefer_final_locals, omit_local_variable_types, unnecessary_parenthesis, prefer_const_constructors, unawaited_futures, require_trailing_commas, prefer_if_elements_to_conditional_expressions, sized_box_for_whitespace, join_return_with_assignment, avoid_bool_literals_in_conditional_expressions

import 'dart:developer';

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/salequotereportapi/salequotereportapi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/SalesQutApiNew/SalesQutDetails.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/approvals_api/approval_QTOR_post_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/approvals_api/approvals_patch_api.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/approvals_modal/approvals_details.modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/PDF/invoicemodel.dart';
import 'package:ultimate_bundle/src/furney/src/pages/PDF/pdfinvoiceapi.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesQuotEdit/screens/edit_quot.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesQuotEdit/widget/creation/contentEdit_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesQuotEdit/widget/creation/headerEdit_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/approvals.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/item_details_approvals.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/screens/create_order.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/creation/content_order_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/creation/header_order_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/creation/logistics_orders_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/showPdf/ShowPdf.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sign_in/widgets/custom_elevatedBtn.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class SalesDetailsQuot extends StatefulWidget {
  const SalesDetailsQuot({
    // required this.title,
    Key? key,
    // this.docentry
  }) : super(key: key);
  // final String title;
  // final String? docentry;

  @override
  SalesDetailsQuotState createState() => SalesDetailsQuotState();
}

class SalesDetailsQuotState extends State<SalesDetailsQuot> {
  static bool isCameFormHome = false;
  static String? docTypeName;
  static String? docEntryforSO;

  static bool isclosedocument = false;
  static bool isclosedocument2 = false;

  static ApprovalDetailsValue? approvalDetailsValue;

  List<DocumentApprovalValue> getdocumentApprovalValuee = [];
  static String? basedocentry;
  String docEntry = '';
  String docDueDate = '';
  @override
  void initState() {
    super.initState();
    SalesDetailsQtAPi.getGlobalData(basedocentry).then((value) {
      getdocumentApprovalValuee = [];
      approvalDetailsValue = null;
      if (value != null) {
        setState(() {
          print("cardName: " + value.cardName.toString());
          docEntry = value.docEntry.toString();
          docDueDate = value.docDueDate.toString();
          approvalDetailsValue = value;
          getdocumentApprovalValuee = value.documentLines!;
          // HeaderEditCreationState.totalBeforeDiscount = 0;
          // HeaderEditCreationState.discount = 0;
          // HeaderEditCreationState.tax = 0;
          // HeaderEditCreationState.total = 0;
          // double basictotal = 0;
          // double discVal = 0;
          // double taxVal = 0;
          // double taxable = 0;
          // double netvalue = 0;
          // for (int ik = 0; ik < documentApprovalValue.length; ik++) {
          //   basictotal = documentApprovalValue[ik].Quantity! *
          //       documentApprovalValue[ik].Price!;

          //   discVal =
          //       basictotal * documentApprovalValue[ik].discountPercent! / 100;
          //   taxable = basictotal - discVal;
          //   taxVal = taxable *
          //       double.parse(documentApprovalValue[ik].TaxCode!) /
          //       100;
          //   netvalue = (basictotal - discVal) + taxVal;
          // }
          // HeaderEditCreationState.totalBeforeDiscount =
          //     HeaderEditCreationState.totalBeforeDiscount + basictotal;
          // HeaderEditCreationState.discount =
          //     HeaderEditCreationState.discount + discVal;
          // HeaderEditCreationState.tax = HeaderEditCreationState.tax + taxVal;
          // HeaderEditCreationState.total =
          //     HeaderEditCreationState.total + netvalue;
          // log("documentApprovalValue::::${documentApprovalValue.length}");
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
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("are you sure");
      Get.toNamed<dynamic>(FurneyRoutes.newSalesQuot);
      return Future.value(false);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return
        // WillPopScope(
        //   onWillPop: onbackpress,
        //   child:
        Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: appBar(context, _scaffoldKey, "Sales Quot"),
      drawer: drawer(context),
      body: approvalDetailsValue == null
          ? Center(
              child: SpinKitThreeBounce(
                size: Screens.heigth(context) * 0.06,
                color: theme.primaryColor,
              ),
            )
          : Container(
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
                      // color: Colors.amber,
                      width: Screens.width(context),
                      //    height: Screens.heigth(context) * 0.75,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {},
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
                                        style:
                                            TextStyles.headlineBlack1(context),
                                            
                                      ),
                                    ),
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
                                // color: Colors.blue,
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
                              Container(
                                width: Screens.width(context) * 0.83,
                                child: Text(
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
                                child: Text(
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
                                child: Text(
                                  " ${getdocumentApprovalValuee.length} Rows",
                                  style: TextStyles.headlineBlack1(context),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1.5,
                          ),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: getdocumentApprovalValuee.length,
                              itemBuilder: (c, i) {
                                return GestureDetector(
                                  onTap: () {
                                    DetailsPageState.index = i;
                                    log("DetailsPageState.index::${DetailsPageState.index}");
                                    DetailsPageState.documentApprovalValue =
                                        getdocumentApprovalValuee;

                                    Get.toNamed<dynamic>(FurneyRoutes.details);
                                  },
                                  child: Container(
                                      color: Colors.transparent,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${i + 1}:",
                                            style: TextStyles.boldPC1(context),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: Screens.width(context) *
                                                    0.83,
                                                // color: Colors.blue,
                                                child: Text(
                                                  "${getdocumentApprovalValuee[i].itemCode}\n${getdocumentApprovalValuee[i].itemDescription} (${getdocumentApprovalValuee[i].quantity})",
                                                  style:
                                                      TextStyles.headlineBlack1(
                                                          context),
                                                ),
                                              ),
                                              Container(
                                                child: Icon(
                                                  Icons.navigate_next_outlined,
                                                  color: theme.primaryColor,
                                                  size:
                                                      Screens.heigth(context) *
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
                    SizedBox(
                      height: Screens.heigth(context) * 0.005,
                    ),
                    Container(
                      height: Screens.heigth(context) * 0.06,
                      child: CustomSpinkitdButton(
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });

                          salequoteReportApi.getGlobalData(
                              approvalDetailsValue!.docEntry.toString());
                          // callSalesOrderInfoApiForPDF();
                          // callServiceLayerApi();
                        },
                        isLoading: isLoading,
                        label: 'Convert to pdf',
                      ),
                    ),
                    SizedBox(
                      height: Screens.heigth(context) * 0.005,
                    ),
                    isclosedocument == true
                        ? SizedBox()
                        : Container(
                            height: Screens.heigth(context) * 0.06,
                            child: CustomSpinkitdButton(
                              onTap: () async {
                                CreateOrderDetailsState.isCameFromqutation =
                                    true;
                                HeaderOrderCreationState.bpCode =
                                    approvalDetailsValue!.cardCode!; //;;
                                HeaderOrderCreationState.bpName =
                                    approvalDetailsValue!.cardName!;
                                HeaderOrderCreationState.docNo =
                                    approvalDetailsValue!.docNum!.toString();
                                HeaderOrderCreationState.salesEmp =
                                    GetValues.userName;
                                ContentOrderCreationState.itemsDetails2.clear();
                                for (int i = 0;
                                    i < getdocumentApprovalValuee.length;
                                    i++) {
                                  double taxxTotal =
                                      getdocumentApprovalValuee[i].taxTotal !=
                                              null
                                          ? getdocumentApprovalValuee[i]
                                              .taxTotal!
                                          : 0;

                                  ContentOrderCreationState.itemsDetails2.add(
                                      AddItem(
                                          itemCode: getdocumentApprovalValuee[i]
                                              .itemCode!,
                                          itemName: getdocumentApprovalValuee[i]
                                              .itemDescription!,
                                          price: getdocumentApprovalValuee[i]
                                              .unitPrice,
                                              lineTotal:getdocumentApprovalValuee[i].lineTotal ,
                                          unitPrice:
                                              getdocumentApprovalValuee[i]
                                                  .unitPrice,
                                          discount: 0,
                                          qty: int.parse(
                                              getdocumentApprovalValuee[i]
                                                  .quantity!
                                                  .toStringAsFixed(0)),
                                          total: getdocumentApprovalValuee[i]
                                              .total,
                                          tax: taxxTotal,
                                          // getdocumentApprovalValuee[i]
                                          //     .taxTotal,
                                          valuechoosed: "",
                                          discounpercent: 0,
                                          taxCode: getdocumentApprovalValuee[i]
                                                      .taxCode ==
                                                  null
                                              ? isTaxApplied(
                                                  getdocumentApprovalValuee[i]
                                                      .lineTotal!,
                                                  taxxTotal
                                                  // getdocumentApprovalValuee[i]
                                                  //     .taxTotal!
                                                  )
                                              : getdocumentApprovalValuee[i]
                                                  .taxCode!
                                                  .toString(),
                                          taxPer: caluclateTaxpercent(
                                              getdocumentApprovalValuee[i]
                                                  .lineTotal!,
                                              taxxTotal
                                              // getdocumentApprovalValuee[i]
                                              //     .taxTotal!
                                              ),
                                          wareHouseCode: GetValues.branch.toString(),
                                          // documentApprovalValue[i]
                                          //     .warehouseCode,
                                          taxName: "",
                                          baseline: getdocumentApprovalValuee[i].lineNum.toString(),
                                          basedocentry: docEntryforSO));
                                }
                                HeaderOrderCreationState.mycontroller[0].text =
                                    "";
                                HeaderOrderCreationState.documentLines =
                                    ContentOrderCreationState.itemsDetails2;
                                LogisticOrderState.valueSelectedOrder = null;
                                LogisticOrderState.valueSelectedGPApproval =
                                    null;
                                LogisticOrderState.mycontroller[0].text = "";
                                LogisticOrderState.mycontroller[1].text = "";
                                Get.toNamed<dynamic>(
                                    FurneyRoutes.creationOrderDetails);
                                // callServiceLayerApi();
                              },
                              isLoading: isLoading,
                              label: 'Convert to Sales order',
                            ),
                          ),

                    isclosedocument2 == true
                        ? SizedBox()
                        : Column(
                            children: [
                              SizedBox(
                                height: Screens.heigth(context) * 0.005,
                              ),
                              Container(
                                height: Screens.heigth(context) * 0.06,
                                child: CustomSpinkitdButton(
                                  onTap: () async {
                                    ContentEditCreationState
                                        .isCameFromqutation = true;
                                    HeaderEditCreationState.currentDateTime =
                                        approvalDetailsValue!.docDate!; //;;
                                    HeaderEditCreationState.bpCode =
                                        approvalDetailsValue!.cardCode!; //;;
                                    HeaderEditCreationState.bpName =
                                        approvalDetailsValue!.cardName!;
                                    HeaderEditCreationState.docNo =
                                        approvalDetailsValue!.docNum!
                                            .toString();
                                    HeaderEditCreationState.salesEmp =
                                        GetValues.userName!;
                                    ContentEditCreationState.contentitemsDetails
                                        .clear();

                                    HeaderEditCreationState
                                        .mycontroller[0].text = "";
                                    // valueChossed
                                    // LogisticEditPageState.valueSelectedOrder =
                                    //     null;
                                    // LogisticEditPageState
                                    //     .valueSelectedGPApproval = null;
                                    // LogisticEditPageState.mycontroller[0].text =
                                    //     "";
                                    // LogisticEditPageState.mycontroller[1].text =
                                    //     "";
                                    // Get.toNamed<dynamic>(
                                    //     FurneyRoutes.editSalesQuot);
                                    // callServiceLayerApi();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditDetails(
                                                getdocumentApprovalValue:
                                                    getdocumentApprovalValuee,
                                                docentry: approvalDetailsValue!
                                                    .docEntry!,
                                                title: 'Edit Quotation',
                                              )),
                                    );
                                  },
                                  isLoading: isLoading,
                                  label: 'Edit',
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
      // ),
    );
  }

  double caluclateTaxpercent(double total, double tax) {
    double res = 0;
    res = tax / total * 100;
    return res;
  }

  String isTaxApplied(double total, double tax) {
    double res = 0;
    String isaval = "";
    res = tax / total * 100;
    isaval = res == 18 ? "O1" : "null";

    return isaval;
  }

  void callServiceLayerApi() {
    if (mounted) {
      setState(() {
        isLoading = true;
        ApprovalsQuotPostAPi.docEntry = docEntry;
        ApprovalsQuotPostAPi.docDueDate = docDueDate;
        print(' ApprovalsQuotPostAPi.docEntry: ' +
            ApprovalsQuotPostAPi.docEntry.toString());
        print(' ApprovalsQuotPostAPi.docEntry: ' +
            ApprovalsQuotPostAPi.docDueDate.toString());
        ApprovalsQuotPostAPi.getGlobalData().then((value) {
          if (value.statusCode == '201' || value.statusCode == '204') {
            isLoading = true;
            const snackBar = SnackBar(
              duration: Duration(seconds: 5),
              backgroundColor: Colors.green,
              content: Text(
                'Quotation Created Successfully!!...',
                style: TextStyle(color: Colors.white),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Get.offAllNamed<dynamic>(FurneyRoutes.newSalesQuot);
          } else {
            isLoading = false;
            print(value.statusCode);
            const snackBar = SnackBar(
              duration: Duration(seconds: 5),
              backgroundColor: Colors.red,
              content: Text(
                'Restart the app or contact the admin!!..',
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
                                            BorderRadius.circular(10)),
                                    backgroundColor: btnColor == false
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
      FocusScopeNode focus = FocusScope.of(context);
      if (!focus.hasPrimaryFocus) {
        focus.unfocus();
      }
      ApprovalsPatchAPi.remarks = mycontroller[0].text;
      print(ApprovalsPatchAPi.approvalID);
      print(ApprovalsPatchAPi.remarks);
      print(ApprovalsPatchAPi.status);

      ApprovalsPatchAPi.getGlobalData().then((value) {
        if (value.Value == "400") {
          mycontroller[0].text = '400';
          completed = false;
          Navigator.pop(context);
          const snackBar = SnackBar(
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
          // //     value.errorPatch!.message!.Value!
          // .toString());
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

  double? grandTotalpdf;
  dynamic callSalesOrderInfoApiForPDF(
      // preff
      ) async {
    List<InvoiceItem> itemss = [];
    for (int i = 0; i < getdocumentApprovalValuee.length; i++) {
      itemss.add(InvoiceItem(
        descripton: getdocumentApprovalValuee[i].itemDescription.toString(),
        quantity: getdocumentApprovalValuee[i].quantity.toString(),
        slNo: "${i + 1}",
        price: getdocumentApprovalValuee[i].price.toString(),
        total: getdocumentApprovalValuee[i].total.toString(),
      ));
    }
    int length = getdocumentApprovalValuee.length;
    if (length > 0) {
      setState(//hitpdf
          () {
        PdfInvoiceApi.height = length + 19;
      });
    }

    if (getdocumentApprovalValuee.isNotEmpty) {
      var ab = (getdocumentApprovalValuee.map((i) => i.lineTotal));
      // print(
      //     ab);
      setState(//hitpdf
          () {
        // var grandsum = ab.map(var.parse).toList();
        grandTotalpdf = ab.reduce((a, b) => a! + b!); //for adding array items
        print("answer total: " + grandTotalpdf.toString());
      });
    }

    final invoice = Invoice(
        headerinfo: InvoiceHeader(
          companyName: "Insigmia LTD",
          // area: value.data![0].city.toString(),
          // gstNo: value.data![0].branchGst.toString(),
          // mobile: value.data![0].mobile.toString(),
          // pincode: value.data![0].pin.toString(),
          // salesOrder: docEntrypost.toString(),
          // address: value.data![0].block.toString(),
        ),
        items: itemss.toList(),
        invoiceCash: InvoiceCash(
          cash: getdocumentApprovalValuee[0].price.toString(),
          // cod: value.data![0].codAmt.toStringAsFixed(2),
          // credit: value.data![0].creditAmt.toStringAsFixed(2),
          // exchange: value.data![0].exchangeAmt.toStringAsFixed(2),
          // finance: value.data![0].financeamt.toStringAsFixed(2),
          // advance: value.data![0].advanceamt.toStringAsFixed(2),
          // discountamt: "",
          salesEmployee: GetValues.userName.toString(),
          total: grandTotalpdf!.toStringAsFixed(2),
          // remarks: value.data![0].remark.toString(),
          upiAmnt: "",
          // deliverydate: value.data![0].deliveryDate.toString(),
          // deliveryTime: value.data![0].deliveryTime.toString(),
        ),
        invoiceMiddle: InvoiceMiddle(
          customerName: approvalDetailsValue!.cardName!,
          warehouseCode: getdocumentApprovalValuee[0].warehouseCode.toString(),
        ));

    // final pdfFile = await PdfInvoiceApi.generate(invoice); //CITY ADRESS
    final pdfFile = await PdfInvoiceApi.generate(invoice);

    // PdfApi.openFile(
    //     pdfFile);
    //  File file = new File.fromUri(Uri.parse(pdfFile.toString()));

    PDFDocument doc = await PDFDocument.fromFile(pdfFile);
    ShowPdfs.document = doc;
    ShowPdfs.notstream = false;
    ShowPdfs.title = pdfFile.path;
    Get.toNamed<void>(FurneyRoutes.showpdf)!.then((value) {
      ShowPdfs.notstream = true;
    });
    // pdfFile.
    // doc.
    // ShowPdfs.document = doc;
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => ShowPdf()));
  }
}
