// ignore_for_file: file_names, prefer_const_constructors, unnecessary_lambdas, avoid_print, unawaited_futures, invariant_booleans
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/approvals_api/approvals_details_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_order/approvalOrdersApi/DyApproval.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_oder/approvals_order_modal/approvals_order_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/showDetails/approvalsDetailsOrders.dart';

class ApprovalsOrdersDetails extends StatefulWidget {
  const ApprovalsOrdersDetails({
    Key? key,
  }) : super(key: key);
  @override
  ApprovalsOrdersDetailsState createState() => ApprovalsOrdersDetailsState();
}

class ApprovalsOrdersDetailsState extends State<ApprovalsOrdersDetails> {
  List<ApprovalsOrdersValue> approvalsOrdersValues = [];
  List<ApprovalsOrdersValue> filterapprovals = [];
  @override
  void initState() {}

  @override
  void dispose() {
    super.dispose();
  }

  bool isLoading = false;
  bool isApprovalLengthnull = true;
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: isLoading == true
          ? Center(
              child: SpinKitThreeBounce(
                size: Screens.heigth(context) * 0.06,
                color: theme.primaryColor,
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: Screens.width(context) * 0.02,
                    right: Screens.width(context) * 0.02,
                    top: Screens.heigth(context) * 0.01,
                    // bottom: Screens.width(context) * 0.01
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: Screens.heigth(context) * 0.06,
                            decoration: BoxDecoration(
                              color: theme.hintColor.withOpacity(.05),
                              borderRadius: BorderRadius.circular(Const.radius),
                            ),
                            child: TextField(
                              controller: mycontroller[0],
                              autocorrect: false,
                              style: theme.textTheme.bodyMedium,
                              onChanged: (v) {
                                setState(() {
                                  filterapprovals = approvalsOrdersValues
                                      .where(
                                        (e) =>
                                            e.cardName!
                                                .toLowerCase()
                                                .contains(v.toLowerCase()) ||
                                            e.cardCode!
                                                .toLowerCase()
                                                .contains(v.toLowerCase()),
                                      )
                                      .toList();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Search for Approvals',
                                hintStyle: TextStyles.bodytextBlack1(context),
                                // AppLocalizations.of(context)!
                                //     .search_sales_quot,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                prefixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () {
                                    bottomSheet(theme);
                                    //    SalesQuotAPi.searchValue = mycontroller[0].text;
                                    // setState(() {
                                    //   quotData.clear();
                                    //   quotDataFilter.clear();
                                    //   });

                                    //   SalesQuotAPi.searchData().then((value) {
                                    //         if(value.salesQuotValue!=null){
                                    //           setState(() {
                                    //             print(value.salesQuotValue![0].docEntry);
                                    //             quotData = value.salesQuotValue!;
                                    //             quotDataFilter =quotData;
                                    //           });
                                    //         }
                                    //   });
                                  }, //
                                  color: theme.primaryColor,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 5,
                                ),
                              ),
                            ),
                          ),
                          //  Positioned(
                          //     left: Screens.width(context)*0.8,
                          //     child: IconButton(onPressed: (){
                          //       //print("object");

                          //       // Get.toNamed<dynamic>(FurneyRoutes.creationDetails);
                          //     }, icon: Icon(Icons.add,
                          //     color: theme.primaryColor,
                          //     size: Screens.width(context)*0.08,
                          //     )))
                        ],
                      ),

                      SizedBox(
                        //width: Screens.width(context),
                        //  maxHeight: Screens.heigth(context)*0.67,
                        height: Screens.heigth(context) * 0.72,
                        //color: Colors.red,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: filterapprovals.length,
                                itemBuilder: (c, i) {
                                  return InkWell(
                                    onTap: () {
                                      ApprovalsDetailsOrdersState
                                          .docTypeName = filterapprovals[i]
                                              .ObjType
                                              .toString()
                                              .contains('13')
                                          ? 'A/R Invoice'
                                          : filterapprovals[i]
                                                  .ObjType
                                                  .toString()
                                                  .contains('23')
                                              ? 'Sales Quotation'
                                              : filterapprovals[i]
                                                      .ObjType
                                                      .toString()
                                                      .contains('17')
                                                  ? 'Sales Order'
                                                  : filterapprovals[i]
                                                          .ObjType
                                                          .toString()
                                                          .contains('14')
                                                      ? 'Sales Return'
                                                      : filterapprovals[i]
                                                              .ObjType
                                                              .toString()
                                                              .contains('15')
                                                          ? 'Deliveries'
                                                          : '';
                                      ApprovalsDetailsAPi.draftEntry =
                                          filterapprovals[i]
                                              .docEntry
                                              .toString();
                                      ApprovalsDetailsOrdersState
                                          .isCameFormSalesORder = false;
                                      Get.toNamed<dynamic>(
                                        FurneyRoutes
                                            .approvalsDetailsSalesOrders,
                                      );
                                    },
                                    child: Card(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              Screens.width(context) * 0.01,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              //row 1
                                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                // Container(
                                                //   width: Screens.width(context)*0.01,
                                                //  height: double.infinity,
                                                //   color: Colors.blue,
                                                // ),
                                                //SizedBox(width: Screens.width(context)*0.01,),
                                                SizedBox(
                                                  ///  color: Colors.greenAccent,
                                                  width:
                                                      Screens.width(context) *
                                                          0.2,
                                                  child: Text(
                                                    '${filterapprovals[i].cardCode}',
                                                    style: TextStyles
                                                        .bodytextBlack1(
                                                      context,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      Screens.width(context) *
                                                          0.01,
                                                ),
                                                SizedBox(
                                                  //   color: Colors.blue,
                                                  width:
                                                      Screens.width(context) *
                                                          0.4,
                                                  child: Text(
                                                    '${filterapprovals[i].cardName}',
                                                    style: TextStyles
                                                        .bodytextBlack1(
                                                      context,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: Screens.width(context) *
                                                    0.02,
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    //    color: Colors.red,
                                                    width:
                                                        Screens.width(context) *
                                                            0.22,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          '${filterapprovals[i].docEntry}',
                                                          style: TextStyles
                                                              .bodytextBlack1(
                                                            context,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${filterapprovals[i].DocDate}',
                                                          style: TextStyles
                                                              .bodytextBlack1(
                                                            context,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.chevron_right,
                                                    color: theme.primaryColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      //     Container(
                      //    // width: Screens.width(context),
                      //     height: Screens.heigth(context)*0.06,
                      //     //color: Colors.green,
                      //     child: CustomSpinkitdButton(
                      //   onTap: () async {
                      //     //callServiceLayerApi();
                      //   },
                      //   isLoading: isLoading,
                      // //  labelLoading: AppLocalizations.of(context)!.signing,
                      //   label: 'Save',
                      // ),
                      //   ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  void bottomSheet(ThemeData theme) {
    //nznznz
    mycontroller[4].clear();
    mycontroller[3].clear();
    showModalBottomSheet<dynamic>(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Form(
            key: formkey,
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
                          controller: mycontroller[3],
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
                              vertical: 10,
                              horizontal: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            labelText: 'Choose from date',
                            labelStyle: TextStyles.bodytextBlack1(context),
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
                          child: Icon(
                            Icons.calendar_today_outlined,
                            color: theme.primaryColor,
                            size: Screens.width(context) * 0.08,
                          ),
                        ),
                      ),
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
                          controller: mycontroller[4],
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
                              vertical: 10,
                              horizontal: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            labelText: 'Choose to date',
                            labelStyle: TextStyles.bodytextBlack1(context),
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
                          child: Icon(
                            Icons.calendar_today_outlined,
                            color: theme.primaryColor,
                            size: Screens.width(context) * 0.08,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: theme.primaryColor,
                      ),
                      onPressed: () {
                        clickedSearch();
                      },
                      child: Text(
                        'Search',
                        style: TextStyles.whiteText(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String apiFromDate = '';
  String apiToDate = '';

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
        mycontroller[3].text = value.toString();
        final date = DateTime.parse(mycontroller[3].text);
        mycontroller[3].text = '';
        mycontroller[3].text =
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
        mycontroller[4].text = value.toString();
        final date = DateTime.parse(mycontroller[4].text);
        mycontroller[4].text = '';
        mycontroller[4].text =
            "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().padLeft(2, '0')}";
        apiToDate =
            "${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}";
        // GetFollowupApi.fromDate = apidate;
        //  print(mycontroller[2].text);
      });
    });
  }

  Future<void> clickedSearch() async {
    if (formkey.currentState!.validate()) {
      Navigator.pop(context);
      setState(() => isLoading = true);
      await GetDyApprovalAPi.getGlobalData(apiFromDate, apiToDate)
          .then((value) {
        setState(() => isLoading = false);
        if (value.statusCode! >= 200 && value.statusCode! <= 210) {
          if (value.approvedData != null) {
            setState(() {
              print(value.approvedData![0].cardName);
              approvalsOrdersValues = value.approvedData!;
              filterapprovals = approvalsOrdersValues;
              isApprovalLengthnull = false;
            });
          } else if (value.approvedData == null) {
            setState(() {
              isApprovalLengthnull = false;
            });
            const snackBar = SnackBar(
              duration: Duration(seconds: 5),
              backgroundColor: Colors.red,
              content: Text(
                'There is no Approved to show!!..',
                style: TextStyle(color: Colors.white),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            //    Future.delayed(const Duration(seconds: 5),(){
            //    Navigator.pop(context);
            // });
          }
        } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
          const snackBar = SnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red,
            content: Text(
              'There is no Approved to show!!..',
              style: TextStyle(color: Colors.white),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          const snackBar = SnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red,
            content: Text(
              'There is no Approved to show!!..',
              style: TextStyle(color: Colors.white),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    }
  }
}
