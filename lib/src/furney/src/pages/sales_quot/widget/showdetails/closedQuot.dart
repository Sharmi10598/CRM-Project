// ignore_for_file: file_names, prefer_const_constructors, require_trailing_commas, prefer_single_quotes, duplicate_ignore, unnecessary_new, prefer_if_elements_to_conditional_expressions

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_quotations_api/salesQuotCancelledApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_quotations_api/salesQuot_details_api.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_quot/salesQuotCancelModal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/delivery/widgets/delivery_appbar.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/screens/sales_quot_details.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/creation/content_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/creation/header_creation.dart';

class ClosedQuot extends StatefulWidget {
  // required this.title
  const ClosedQuot({
    Key? key,
  }) : super(key: key);
  // final String title;
  @override
  ClosedQuotState createState() => ClosedQuotState();
}

class ClosedQuotState extends State<ClosedQuot> {
  List<SalesQuotCancelValue> salesQuotValue = [];
  List<SalesQuotCancelValue> filterSalesValue = [];
  ScrollController scrollController = ScrollController();
  int lenthofList = 0;
  @override
  void initState() {
    // SalesQuotCancelAPi.getGlobalData().then((value) {
    //   if(value.salesQuotcancelValue!.isNotEmpty){
    //     if(mounted){
    //       setState(() {
    //       print(value.salesQuotcancelValue![0].cardName);
    //     salesQuotValue = value.salesQuotcancelValue!;
    //     filterSalesValue = salesQuotValue;
    //      lenthofList = filterSalesValue.length;
    //      SalesQuotCancelAPi.nextUrl = value.nextLink;
    //       });
    //     }
    //   }

    // });

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (nextLink != null) {
          print("object222");
          getmoredata();
        }
      }
    });
  }

  void getmoredata() {
    SalesQuotCancelAPi.callNextLink().then((val) {
      setState(() {
        if (val.salesQuotcancelValue!.isNotEmpty) {
          for (var i = 0; i < lenthofList; i++) {
            filterSalesValue.add(SalesQuotCancelValue(
                DocDate: val.salesQuotcancelValue![i].DocDate,
                cardCode: val.salesQuotcancelValue![i].cardCode,
                cardName: val.salesQuotcancelValue![i].cardName,
                docEntry: val.salesQuotcancelValue![i].docEntry,
                DocNum: val.salesQuotcancelValue![i].DocNum,
                cancelStatus: val.salesQuotcancelValue![i].cancelStatus,
                documentStatus: val.salesQuotcancelValue![i].documentStatus));
          }
          print('lenthofList: $lenthofList');
          print('lennList: ${filterSalesValue.length}');
          print(val.nextLink);
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body:
          // salesQuotValue.isEmpty?Center(
          //         child:  SpinKitThreeBounce(
          //                       size: Screens.heigth(context)*0.06,
          //                       color:theme.primaryColor,
          //                     ),
          //       ) :
          SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Screens.heigth(context) * 0.005,
              horizontal: Screens.width(context) * 0.02),
          child: Container(
            child: Column(
              children: [
                Stack(children: [
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
                          filterSalesValue = salesQuotValue
                              .where((e) =>
                                  e.cardName!
                                      .toLowerCase()
                                      .contains(v.toLowerCase()) ||
                                  e.cardCode!
                                      .toLowerCase()
                                      .contains(v.toLowerCase()))
                              .toList();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search for Quotations',
                        hintStyle: TextStyles.bodytextBlack1(context),
                        // AppLocalizations.of(context)!
                        //     .search_sales_quot,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
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
                            mycontroller[1].text = "";
                            mycontroller[2].text = "";
                            mycontroller[3].text = "";
                            showSheetSearch(theme, context);
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
                  Positioned(
                      left: Screens.width(context) * 0.8,
                      child: IconButton(
                          onPressed: () {
                            //print("object");
                            setAllNull();
                            Get.toNamed<dynamic>(FurneyRoutes.creationDetails);
                          },
                          icon: Icon(
                            Icons.add,
                            color: theme.primaryColor,
                            size: Screens.width(context) * 0.08,
                          )))
                ]),
                salesQuotValue.isEmpty && searchLoading == true
                    ? SizedBox(
                        //color: Colors.amber,
                        width: Screens.width(context),
                        height: Screens.heigth(context) * 0.72,
                        child: Center(
                          child: Visibility(
                            visible: spin,
                            child: SpinKitThreeBounce(
                              size: Screens.heigth(context) * 0.06,
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                            controller: scrollController,
                            itemCount: filterSalesValue
                                .length, //dataSocialMedia.length,
                            itemBuilder: (context, i) {
                              // if(i ==filterSalesValue.length-1 ){
                              //   if(mycontroller[0].text.isEmpty){
                              //     print("1111111");
                              //             return SpinKitThreeBounce(
                              //           size: Screens.width(context)*0.06,
                              //           color:theme.primaryColor,
                              //         );
                              //   }
                              //         }
                              return Card(
                                  elevation: 8,
                                  child: InkWell(
                                    onTap: () {
                                      SalesOuotDetailsAPi.docEntry =
                                          filterSalesValue[i]
                                              .docEntry
                                              .toString();
                                      print(SalesOuotDetailsAPi.docEntry);
                                      SalesQtDetailsState.status =
                                          filterSalesValue[i].cancelStatus ==
                                                      'csYes' &&
                                                  filterSalesValue[i]
                                                          .documentStatus ==
                                                      'bost_Close'
                                              ? 'Cancelled'
                                              : filterSalesValue[i]
                                                              .cancelStatus ==
                                                          'csNo' &&
                                                      filterSalesValue[i]
                                                              .documentStatus ==
                                                          'bost_Close'
                                                  ? 'Closed'
                                                  : '';
                                      Get.toNamed<dynamic>(
                                          FurneyRoutes.salesquotdetails);
                                    },
                                    child: Container(
                                      height: Screens.heigth(context) * 0.07,
                                      width: Screens.width(context),
                                      decoration: const BoxDecoration(
                                          // color:Colors.green,
                                          // borderRadius: BorderRadius.circular(Const.radius),
                                          // border: Border.all(color: Colors.black)
                                          ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            //row 1
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: Screens.width(context) *
                                                    0.02,
                                                height: double.infinity,
                                                color: theme.primaryColor,
                                              ),
                                              SizedBox(
                                                width: Screens.width(context) *
                                                    0.01,
                                              ),
                                              SizedBox(
                                                //   color: Colors.greenAccent,
                                                width: Screens.width(context) *
                                                    0.2,
                                                child: Text(
                                                  '${filterSalesValue[i].DocNum}',
                                                  style:
                                                      TextStyles.bodytextBlack1(
                                                          context),
                                                ),
                                              ),
                                              SizedBox(
                                                width: Screens.width(context) *
                                                    0.01,
                                              ),
                                              SizedBox(
                                                //   color: Colors.blue,
                                                width: Screens.width(context) *
                                                    0.4,
                                                child: Text(
                                                  '${filterSalesValue[i].cardName}',
                                                  style:
                                                      TextStyles.bodytextBlack1(
                                                          context),
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: Screens.width(context) *
                                                    0.02),
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
                                                        filterSalesValue[i]
                                                                        .cancelStatus ==
                                                                    'csYes' &&
                                                                filterSalesValue[
                                                                            i]
                                                                        .documentStatus ==
                                                                    'bost_Close'
                                                            ? 'Cancelled'
                                                            : filterSalesValue[i]
                                                                            .cancelStatus ==
                                                                        'csNo' &&
                                                                    filterSalesValue[i]
                                                                            .documentStatus ==
                                                                        'bost_Close'
                                                                ? 'Closed'
                                                                : '',
                                                        style: TextStyles
                                                            .bodytextBlack1(
                                                                context),
                                                      ),
                                                      Text(
                                                        '${filterSalesValue[i].DocDate}',
                                                        style: TextStyles
                                                            .bodytextBlack1(
                                                                context),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.chevron_right,
                                                  color: theme.primaryColor,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                            }),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> setAllNull() async {
    final preff = await SharedPreferences.getInstance();
    HeaderCreationState.bpName = '';
    HeaderCreationState.bpCode = '';
    HeaderCreationState.contactPerson = '';
    // HeaderCreationState.docNo='';
    HeaderCreationState.salesEmp = preff.getString('sapUserName').toString();
    // HeaderCreationState.currency='';
    HeaderCreationState.status = '';
    HeaderCreationState.discount = 0.00;
    HeaderCreationState.totalBeforeDiscount = 0.00;
    HeaderCreationState.total = 0.00;
    HeaderCreationState.tax = 0.00;
    //content creation
    ContentCreationState.itemsDetails.clear();
    ContentCreationState.carcode = null;

    SwitchBtn.siwtchTrue = true;
  }

  List<GlobalKey<FormState>> formkey =
      List.generate(3, (i) => GlobalKey<FormState>());
  void showSheetSearch(ThemeData theme, BuildContext context) {
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Stack(
                              children: [
                                SizedBox(
                                  child: new TextFormField(
                                    onTap: () {
                                      showDate(context);
                                    },
                                    readOnly: true,
                                    controller: mycontroller[1],
                                    onChanged: (val) {},
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "ENTER FROM DATE";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(fontSize: 15),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      labelText: "Choose from date",
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
                                          size: Screens.width(context) * 0.08),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),

                            Stack(
                              children: [
                                SizedBox(
                                  child: new TextFormField(
                                    onTap: () {
                                      showToDate(context);
                                    },
                                    readOnly: true,
                                    controller: mycontroller[2],
                                    onChanged: (val) {},
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "ENTER TO DATE";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(fontSize: 15),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      labelText: "Choose to date",
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
                                          size: Screens.width(context) * 0.08),
                                    )),
                              ],
                            ),
                            //  ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              child: new TextFormField(
                                controller: mycontroller[3],
                                onChanged: (val) {},
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "ENTER DISCOUNT";
                                //   }else if(value.isNotEmpty){
                                //       double dis =double.parse(value);
                                //       if(dis>100){
                                //         return "DISCOUNT MORE THAN 100";
                                //       }
                                //   }
                                //   return null;
                                // },
                                // keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      // ignore: prefer_const_constructors
                                      Radius.circular(10),
                                    ),
                                  ),
                                  labelText: "Customer name",
                                  labelStyle:
                                      TextStyles.bodytextBlack1(context),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    backgroundColor: theme.primaryColor,
                                  ),
                                  child: Text(
                                    "cancel",
                                    style: TextStyles.whiteText(context),
                                  ),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: theme.primaryColor,
                                    ),
                                    onPressed: validateSearch,
                                    child: Text(
                                      "Search",
                                      style: TextStyles.whiteText(context),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ));
  }

  bool searchLoading = false;
  bool spin = false;
  String? nextLink;
  void validateSearch() {
    if (formkey[0].currentState!.validate()) {
      Navigator.pop(context);
      setState(() {
        salesQuotValue.clear();
        searchLoading = true;
        spin = true;
      });
      SalesQuotCancelAPi.fromDate = mycontroller[1].text;
      SalesQuotCancelAPi.toDate = mycontroller[2].text;
      SalesQuotCancelAPi.searchValue = mycontroller[3].text;
      SalesQuotCancelAPi.getGlobalData().then((value) {
        if (value.salesQuotcancelValue!.isNotEmpty) {
          setState(() {
            salesQuotValue = value.salesQuotcancelValue!;
            filterSalesValue = salesQuotValue;
            print("quotDataFilter: ${filterSalesValue.length}");
            lenthofList = filterSalesValue.length;
            if (value.nextLink != 'null') {
              nextLink = value.nextLink;
              SalesQuotCancelAPi.nextUrl = value.nextLink;
              print("nextLink:: ${value.nextLink}");
            }
            searchLoading = false;
            spin = false;
          });
        } else if (value.salesQuotcancelValue!.isEmpty) {
          setState(() {
            searchLoading = false;
            spin = false;
          });
          final snackBar = SnackBar(
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.red,
            content: Text(
              'No Closed quotations!!..',
              style: const TextStyle(color: Colors.white),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    }
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
        mycontroller[1].text = "";
        mycontroller[1].text =
            "${date.year.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
        // String apidate =
        //     "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
        // GetFollowupApi.fromDate = apidate;
        print(mycontroller[1].text);
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
        mycontroller[2].text = "";
        mycontroller[2].text =
            "${date.year.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
        // String apidate =
        //     "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
        // GetFollowupApi.fromDate = apidate;
        print(mycontroller[2].text);
      });
    });
  }
}
