// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, unnecessary_const, use_named_constants, require_trailing_commas, omit_local_variable_types, prefer_is_empty, avoid_unnecessary_containers, prefer_single_quotes, avoid_print, prefer_if_elements_to_conditional_expressions, unawaited_futures, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ultimate_bundle/SalesApp/Model/SelectionCustModel.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
//import 'package:ultimate_bundle/src/furney/src/Api/customer_bp/customer_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/customer_bp/customer_api.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/customer_bp/NewCustomerModel2.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class SelectCustomerPage extends StatefulWidget {
  const SelectCustomerPage({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  CustomerPageState createState() => CustomerPageState();
}

class CustomerPageState extends State<SelectCustomerPage> {
  static String selectedCustomerCode = '';
  static String selectedCustomerName = '';

  static bool isCameFromCreation = false;
  static bool isCameFromCreationOrder = false;
  static bool isCameFromAgeingReport = false;

  List<NewCustomerData> customerData = [];
  List<NewCustomerData> customerDataFilter = [];

  bool spin = true;
  bool searchLoading = false;

  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  String? slpcode;
  @override
  void initState() {
    super.initState();
    callApi();
  }

  Future<void> callApi() async {
    final preff = await SharedPreferences.getInstance();
    setState(() {
      GetCustomerAPi.slpCode = preff.getString('SlpCode');
    });
    GetCustomerAPi.getGlobalData().then((value) {
      if (value.CustomerData != null) {
        if (value.CustomerData!.length > 0) {
          print("Customervalue!.length: " +
              value.CustomerData!.length.toString());
          setState(() {
            customerData = value.CustomerData!;
            customerDataFilter = customerData;
          });
        }
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
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.pop(context);
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer:
          //  GetValues.userRoll == '3' ? drawer2(context) :
          drawer(context),
      appBar: appBar(context, _scaffoldKey, widget.title),
      body: customerData.isEmpty && searchLoading == false
          ? Center(
              child: SpinKitThreeBounce(
                size: Screens.heigth(context) * 0.06,
                color: theme.primaryColor,
              ),
            )
          : Column(
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
                        customerDataFilter = customerData
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
                      hintText: 'Search for Customer',
                      hintStyle: TextStyles.bodytextBlack1(context),
                      // AppLocalizations.of(context)!
                      //     .search_sales_quot,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          final FocusScopeNode focus = FocusScope.of(context);
                          if (!focus.hasPrimaryFocus) {
                            focus.unfocus();
                          }
                          // GetCustomerAPi.searchValue = mycontroller[0].text;
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
                customerData.length == 0 && searchLoading == true
                    ? SizedBox(
                        width: Screens.width(context),
                        height: Screens.heigth(context) * 0.8,
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
                          itemCount: customerDataFilter.length,
                          itemBuilder: (BuildContext context, int i) {
                            return InkWell(
                              onTap: () {
                                final FocusScopeNode focus =
                                    FocusScope.of(context);
                                if (!focus.hasPrimaryFocus) {
                                  focus.unfocus();
                                }
                                log('choose customer::${customerDataFilter[i].cardCode}');
                                SelectedCustModel.CustomerCode =
                                    customerDataFilter[i].cardCode;
                                SelectedCustModel.CustomerName =
                                    customerDataFilter[i].cardName;
                                SelectedCustModel.billAddress =
                                    customerDataFilter[i].BilltoDefault;
                                SelectedCustModel.shipAddress =
                                    customerDataFilter[i].ShipToDefault;
                                Get.back<dynamic>();
                              },
                              child: Container(
                                  width: Screens.width(context),
                                  padding: const EdgeInsets.only(),
                                  decoration: const BoxDecoration(),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: Screens.width(context) * 0.2,
                                            decoration: BoxDecoration(),
                                            child: Icon(
                                              Icons.account_box_outlined,
                                              color: theme.primaryColor,
                                              size:
                                                  Screens.width(context) * 0.1,
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text(
                                                  customerDataFilter[i]
                                                      .cardCode
                                                      .toString(),
                                                  style: TextStyles.boldPC1(
                                                      context),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        Screens.width(context) *
                                                            0.52,
                                                    child: Text(
                                                      customerDataFilter[i]
                                                          .cardName
                                                          .toString(),
                                                      style: TextStyles
                                                          .headlineBlack1(
                                                              context),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width: Screens.width(
                                                              context) *
                                                          0.05),
                                                  Container(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    width:
                                                        Screens.width(context) *
                                                            0.2,
                                                    child: Text(
                                                      TextStyles.splitValues(
                                                          '${customerDataFilter[i].currentAccountBalance}'),
                                                      style: TextStyles
                                                          .headlineBlack1(
                                                              context),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: Screens.width(context) * 0.06,
                                          right: Screens.width(context) * 0.06,
                                        ),
                                        child: Divider(
                                          thickness: 1.5,
                                        ),
                                      )
                                    ],
                                  )),
                            );
                          },
                        ),
                      )
              ],
            ),
    );
  }
}
