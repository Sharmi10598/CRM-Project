// ignore_for_file: use_key_in_widget_constructors, avoid_unused_constructor_parameters, prefer_const_literals_to_create_immutables, prefer_const_constructors, require_trailing_commas, prefer_single_quotes, prefer_interpolation_to_compose_strings, avoid_void_async, prefer_final_locals, omit_local_variable_types, cascade_invocations, unnecessary_lambdas, eol_at_end_of_file, avoid_bool_literals_in_conditional_expressions, avoid_unnecessary_containers, prefer_if_elements_to_conditional_expressions

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ultimate_bundle/SalesApp/Api/FileUploadApi/FileUploadApi.dart';
import 'package:ultimate_bundle/SalesApp/Pages/Checkout/CheckOutPage.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/helpers/uikit_model.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/CustomerGropApi/CustomerGropApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/CustomerGropApi/CustomerSeriesApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/CustomerGropApi/GroupApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/CustomerGropApi/TeritoryApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/customer_bp/CreatecustPostApi.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/customer_bp/GroupCustModel.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/customer_bp/PamentGroupModel.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/customer_bp/SeriesModel.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/customer_bp/TeriTeriModel.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class CustomerCreatePage extends StatefulWidget {
  const CustomerCreatePage({required this.title, Key? key});
  final String title;
  @override
  State<CustomerCreatePage> createState() => _CustomerCreatePageState();
}

class _CustomerCreatePageState extends State<CustomerCreatePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<TextEditingController> mycontroller =
      List.generate(25, (i) => TextEditingController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? codeValue;
  String? seriesValue;
  String? teriteriValue;
  String? paygrpValue;

  bool seriesValuebool = true;

  List<GroupCustData> groupcData = [];
  List<SeriesModelData> seriesData = [];
  List<GetTeriteriData> teriteritData = [];
  List<GetPayGrpData>? paygroupData = [];

  @override
  void initState() {
    super.initState();
    getGroup();
  }

  bool groCustLoad = false;
  String errormsg = '';
  bool samesAsBill = false;
  bool loadingBtn = false;

  void getGroup() async {
    groCustLoad = true;
    errormsg = '';
    mycontroller[15].text = GetValues.slpCode!;
    setState(() {});
    await GetCustomerGrpAPi.getGlobalData().then((value) {
      //  groCustLoad = false;

      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.groupcustData != null) {
          groupcData = value.groupcustData!;
          errormsg = '';
          setState(() {});
        } else {
          errormsg = value.message!;
          setState(() {});
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        errormsg = value.message!;
        setState(() {});
      } else {
        errormsg = value.message!;
        setState(() {});
      }
    });

    await GetSeriesApiAPi.getGlobalData().then((value) {
      //  groCustLoad = false;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.groupcustData != null) {
          seriesData = value.groupcustData!;
          errormsg = '';
          setState(() {});
        } else {
          errormsg = value.message!;
          setState(() {});
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        errormsg = value.message!;
        setState(() {});
      } else {
        errormsg = value.message!;
        setState(() {});
      }
    });

    await GetTeriteriAPi.getGlobalData().then((value) {
      // groCustLoad = false;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.groupcustData != null) {
          teriteritData = value.groupcustData!;
          errormsg = '';
          setState(() {});
        } else {
          errormsg = value.message!;
          setState(() {});
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        errormsg = value.message!;
        setState(() {});
      } else {
        errormsg = value.message!;
        setState(() {});
      }
    });

    await GetPaymentGroupAPi.getGlobalData().then((value) {
      groCustLoad = false;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.groupcustData != null) {
          paygroupData = value.groupcustData;
          errormsg = '';
          setState(() {});
        } else {
          errormsg = value.message!;
          setState(() {});
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        errormsg = value.message!;
        setState(() {});
      } else {
        errormsg = value.message!;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      drawer:
          // GetValues.userRoll == '3' ? drawer2(context) :
          drawer(context),
      appBar: appBar(context, _scaffoldKey, widget.title),
      body: (groCustLoad == true && errormsg.isEmpty && groupcData.isEmpty)
          ? Center(child: CircularProgressIndicator())
          : (groCustLoad == false && errormsg.isNotEmpty && groupcData.isEmpty)
              ? Center(child: Text(errormsg))
              : Container(
                  width: Screens.width(context),
                  height: Screens.heigth(context),
                  padding: EdgeInsets.only(
                    top: Screens.heigth(context) * 0.01,
                    left: Screens.width(context) * 0.02,
                    right: Screens.width(context) * 0.02,
                    bottom: Screens.heigth(context) * 0.01,
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 20),
                            // height: Screens.heigth(context) * 0.08,
                            width: Screens.width(context),
                            color: Colors.grey[200],
                            //decoration: ,
                            child: DropdownButtonFormField<String>(
                                validator: (value) =>
                                    value == null ? 'Required*' : null,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                                icon: Icon(Icons.arrow_drop_down),
                                value: seriesValue,
                                items: seriesData.map((e) {
                                  return DropdownMenuItem(
                                      // ignore: unnecessary_brace_in_string_interps
                                      value: "${e.Series}",
                                      child: Container(
                                          // height: Screens.bodyheight(context)*0.1,
                                          child:
                                              Text(e.SeriesName.toString())));
                                }).toList(),
                                hint: Text("Select series",
                                    style: theme.textTheme.bodyLarge
                                        ?.copyWith(color: theme.primaryColor)),
                                onChanged: (String? value) {
                                  setState(() {
                                    seriesValue = value;
                                    log('seriesValue $seriesValue');
                                    if (seriesValue.toString().toLowerCase() ==
                                        '218') {
                                      log('seriesValue $seriesValue');
                                      seriesValuebool = false;
                                    } else {
                                      seriesValuebool = true;
                                    }
                                    // print("sleect code: " +
                                    //     seriesValue.toString());
                                  });
                                }),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),
                          Container(
                            child: TextField(
                              controller: mycontroller[0],
                              readOnly: seriesValuebool,
                              decoration: InputDecoration(
                                  hintText: 'CardCode',
                                  filled: true,
                                  fillColor:
                                      theme.primaryColor.withOpacity(0.15),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.2, horizontal: 10),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),
                          Container(
                            child: TextFormField(
                              controller: mycontroller[1],
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return '*Required';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: 'CardName',
                                  filled: true,
                                  fillColor:
                                      theme.primaryColor.withOpacity(0.15),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.2, horizontal: 10),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 20),
                            // height: Screens.heigth(context) * 0.08,
                            width: Screens.width(context),
                            color: Colors.grey[200],
                            //decoration: ,
                            child: DropdownButtonFormField<String>(
                                validator: (value) =>
                                    value == null ? 'Required*' : null,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                                icon: Icon(Icons.arrow_drop_down),
                                value: codeValue,
                                items: groupcData.map((e) {
                                  return DropdownMenuItem(
                                      // ignore: unnecessary_brace_in_string_interps
                                      value: "${e.GroupCode}",
                                      child: Container(
                                          // height: Screens.bodyheight(context)*0.1,
                                          child: Text(e.GroupName.toString())));
                                }).toList(),
                                hint: Text("Select Group",
                                    style: theme.textTheme.bodyLarge
                                        ?.copyWith(color: theme.primaryColor)),
                                onChanged: (String? value) {
                                  setState(() {
                                    codeValue = value;
                                    // print(
                                    //     "sleect code: " + codeValue.toString());
                                  });
                                }),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),
                          Container(
                            child: TextFormField(
                              controller: mycontroller[2],
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return '*Required';
                                }
                                return null;
                              },
                              //maxLines: 4,
                              decoration: InputDecoration(
                                  hintText: 'Bill Address 1',
                                  filled: true,
                                  fillColor:
                                      theme.primaryColor.withOpacity(0.15),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.2, horizontal: 10),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),

                          Container(
                            child: TextFormField(
                              controller: mycontroller[3],
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return '*Required';
                                }
                                return null;
                              },
                              // maxLines: 4,
                              decoration: InputDecoration(
                                  hintText: 'Bill address 2',
                                  filled: true,
                                  fillColor:
                                      theme.primaryColor.withOpacity(0.15),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.2, horizontal: 10),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),

                          Container(
                            child: TextFormField(
                              controller: mycontroller[4],
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return '*Required';
                                }
                                return null;
                              },
                              // maxLines: 4,
                              decoration: InputDecoration(
                                  hintText: 'Bill address 3',
                                  filled: true,
                                  fillColor:
                                      theme.primaryColor.withOpacity(0.15),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.2, horizontal: 10),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),
                          Container(
                            child: TextFormField(
                              controller: mycontroller[5],
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return '*Required';
                                }
                                return null;
                              },
                              // maxLines: 4,
                              decoration: InputDecoration(
                                  hintText: 'City',
                                  filled: true,
                                  fillColor:
                                      theme.primaryColor.withOpacity(0.15),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.2, horizontal: 10),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),
                          Container(
                            child: TextFormField(
                              controller: mycontroller[6],
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return '*Required';
                                }
                                return null;
                              },
                              // maxLines: 4,
                              decoration: InputDecoration(
                                  hintText: 'Zipcode',
                                  filled: true,
                                  fillColor:
                                      theme.primaryColor.withOpacity(0.15),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.2, horizontal: 10),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),
                          Row(
                            children: [
                              Text(
                                "Same as Billing Adress",
                              ),
                              Checkbox(
                                  value: samesAsBill,
                                  onChanged: (val) {
                                    setState(() {
                                      samesAsBill = !samesAsBill;
                                      if (samesAsBill == true) {
                                        mycontroller[7].text =
                                            mycontroller[2].text;
                                        mycontroller[8].text =
                                            mycontroller[3].text;
                                        mycontroller[9].text =
                                            mycontroller[4].text;
                                        mycontroller[10].text =
                                            mycontroller[5].text;
                                        mycontroller[11].text =
                                            mycontroller[6].text;
                                      } else {
                                        mycontroller[7].clear();
                                        mycontroller[8].clear();
                                        mycontroller[9].clear();
                                        mycontroller[10].clear();
                                        mycontroller[11].clear();
                                      }
                                    });
                                  }),
                            ],
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),
                          Container(
                            child: TextFormField(
                              controller: mycontroller[7],
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return '*Required';
                                }
                                return null;
                              },
                              //maxLines: 4,
                              decoration: InputDecoration(
                                  hintText: 'Ship Address 1',
                                  filled: true,
                                  fillColor:
                                      theme.primaryColor.withOpacity(0.15),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.2, horizontal: 10),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),

                          Container(
                            child: TextFormField(
                              controller: mycontroller[8],
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return '*Required';
                                }
                                return null;
                              },
                              // maxLines: 4,
                              decoration: InputDecoration(
                                  hintText: 'Ship address 2',
                                  filled: true,
                                  fillColor:
                                      theme.primaryColor.withOpacity(0.15),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.2, horizontal: 10),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),
                          Container(
                            child: TextFormField(
                              controller: mycontroller[9],
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return '*Required';
                                }
                                return null;
                              },
                              // maxLines: 4,
                              decoration: InputDecoration(
                                  hintText: 'Ship address 3',
                                  filled: true,
                                  fillColor:
                                      theme.primaryColor.withOpacity(0.15),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.2, horizontal: 10),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),
                          Container(
                            child: TextFormField(
                              controller: mycontroller[10],
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return '*Required';
                                }
                                return null;
                              },
                              // maxLines: 4,
                              decoration: InputDecoration(
                                  hintText: 'Ship city',
                                  filled: true,
                                  fillColor:
                                      theme.primaryColor.withOpacity(0.15),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.2, horizontal: 10),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),
                          Container(
                            child: TextFormField(
                              controller: mycontroller[11],
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return '*Required';
                                }
                                return null;
                              },
                              // maxLines: 4,
                              decoration: InputDecoration(
                                  hintText: 'Zipcode',
                                  filled: true,
                                  fillColor:
                                      theme.primaryColor.withOpacity(0.15),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.2, horizontal: 10),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),
                          Container(
                            child: TextFormField(
                              controller: mycontroller[12],
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return '*Required';
                                }
                                return null;
                              },
                              // maxLines: 4,
                              decoration: InputDecoration(
                                  hintText: 'Tin',
                                  filled: true,
                                  fillColor:
                                      theme.primaryColor.withOpacity(0.15),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.2, horizontal: 10),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),
                          Container(
                            child: TextFormField(
                              controller: mycontroller[13],
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return '*Required';
                                }
                                return null;
                              },
                              // maxLines: 4,
                              decoration: InputDecoration(
                                  hintText: 'Vat',
                                  filled: true,
                                  fillColor:
                                      theme.primaryColor.withOpacity(0.15),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.2, horizontal: 10),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          // attachment

                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),
                          SizedBox(
                            width: Screens.width(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Screens.width(context) * 0.3,
                                  child: Text("Select Tin File"),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectattachment();
                                          fileValidation = false;
                                        });
                                      },
                                      child: Container(
                                          padding: EdgeInsets.only(
                                            top: Screens.heigth(context) * 0.02,
                                            left: Screens.width(context) * 0.02,
                                            right:
                                                Screens.width(context) * 0.02,
                                            bottom:
                                                Screens.heigth(context) * 0.02,
                                          ),
                                          color: Colors.white,
                                          width: Screens.width(context) * 0.2,
                                          child: Icon(Icons.photo)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          tinFiles == null
                              ? SizedBox()
                              : ListView.builder(
                                  itemCount: 1,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (BuildContext context, int i) {
                                    if (tinFiles!.path
                                        .split('/')
                                        .last
                                        .contains("png")) {
                                      return Container(
                                          child: Column(children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  decoration: BoxDecoration(),
                                                  width:
                                                      Screens.width(context) *
                                                          0.09,
                                                  height:
                                                      Screens.heigth(context) *
                                                          0.06,
                                                  child: Center(
                                                      child: Image.asset(
                                                          "assets/CRM/img.jpg"))),
                                              Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(),
                                                  width:
                                                      Screens.width(context) *
                                                          0.6,
                                                  // height: Screens.padingHeight(context) * 0.06,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    tinFiles!.path
                                                        .split('/')
                                                        .last,
                                                    // overflow: TextOverflow.ellipsis,
                                                  )),
                                              SizedBox(
                                                  width:
                                                      Screens.width(context) *
                                                          0.1,
                                                  height:
                                                      Screens.heigth(context) *
                                                          0.06,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          tinFiles = null;
                                                        });
                                                      },
                                                      icon: Icon(
                                                        Icons.cancel_rounded,
                                                        color: Colors.grey,
                                                      )))
                                            ])
                                      ])
                                          // )
                                          );
                                    } else if (tinFiles!.path
                                        .split('/')
                                        .last
                                        .contains("jp")) {
                                      return Container(
                                          child: Column(children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  decoration: BoxDecoration(),
                                                  width:
                                                      Screens.width(context) *
                                                          0.09,
                                                  height:
                                                      Screens.heigth(context) *
                                                          0.06,
                                                  child: Center(
                                                      child: Image.asset(
                                                          "assets/CRM/img.jpg"))),
                                              Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(),
                                                  width:
                                                      Screens.width(context) *
                                                          0.6,
                                                  // height: Screens.padingHeight(context) * 0.06,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    tinFiles!.path
                                                        .split('/')
                                                        .last,
                                                  )),
                                              SizedBox(
                                                  width:
                                                      Screens.width(context) *
                                                          0.1,
                                                  height:
                                                      Screens.heigth(context) *
                                                          0.06,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          tinFiles = null;
                                                        });
                                                      },
                                                      icon: Icon(
                                                        Icons.cancel_rounded,
                                                        color: Colors.grey,
                                                      )))
                                            ])
                                      ])
                                          // )
                                          );
                                    } else if (tinFiles!.path
                                        .split('/')
                                        .last
                                        .contains("pdf")) {
                                      return Container(
                                          child: Column(children: [
                                        SizedBox(
                                          height:
                                              Screens.heigth(context) * 0.01,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(),
                                                width: Screens.width(context) *
                                                    0.09,
                                                height:
                                                    Screens.heigth(context) *
                                                        0.06,
                                                child: Center(
                                                    child: Image.asset(
                                                        "assets/CRM/PDFimg.png")),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(),
                                                  width:
                                                      Screens.width(context) *
                                                          0.6,
                                                  // height: Screens.padingHeight(context) * 0.06,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    tinFiles!.path
                                                        .split('/')
                                                        .last,
                                                  )),
                                              SizedBox(
                                                  width:
                                                      Screens.width(context) *
                                                          0.1,
                                                  height:
                                                      Screens.heigth(context) *
                                                          0.06,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          tinFiles = null;
                                                        });
                                                      },
                                                      icon: Icon(
                                                        Icons.cancel_rounded,
                                                        color: Colors.grey,
                                                      )))
                                            ])
                                      ]));
                                    } else if (tinFiles!.path
                                        .split('/')
                                        .last
                                        .contains("xlsx")) {
                                      return Container(
                                          child: Column(children: [
                                        SizedBox(
                                          height:
                                              Screens.heigth(context) * 0.01,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  decoration: BoxDecoration(),
                                                  width:
                                                      Screens.width(context) *
                                                          0.09,
                                                  height:
                                                      Screens.heigth(context) *
                                                          0.06,
                                                  child: Center(
                                                      child: Image.asset(
                                                          "assets/CRM/xls.png"))),
                                              Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(),
                                                  width:
                                                      Screens.width(context) *
                                                          0.6,
                                                  // height: Screens.padingHeight(context) * 0.06,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    tinFiles!.path
                                                        .split('/')
                                                        .last,
                                                  )),
                                              SizedBox(
                                                  width:
                                                      Screens.width(context) *
                                                          0.1,
                                                  height:
                                                      Screens.heigth(context) *
                                                          0.06,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          tinFiles = null;
                                                        });
                                                      },
                                                      icon: Icon(
                                                        Icons.cancel_rounded,
                                                        color: Colors.grey,
                                                      )))
                                            ])
                                      ])
                                          // )
                                          );
                                    }
                                    return Container(
                                        child: Column(children: [
                                      SizedBox(
                                        height: Screens.heigth(context) * 0.01,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(),
                                                width: Screens.width(context) *
                                                    0.09,
                                                height:
                                                    Screens.heigth(context) *
                                                        0.06,
                                                child: Center(
                                                    child: Image.asset(
                                                        "assets/CRM/txt.png"))),
                                            Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(),
                                                width: Screens.width(context) *
                                                    0.6,
                                                // height: Screens.padingHeight(context) * 0.06,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  tinFiles!.path
                                                      .split('/')
                                                      .last,
                                                )),
                                            SizedBox(
                                                width: Screens.width(context) *
                                                    0.1,
                                                height:
                                                    Screens.heigth(context) *
                                                        0.06,
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        tinFiles = null;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.grey,
                                                    )))
                                          ])
                                    ]));
                                  }),

                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),
                          SizedBox(
                            width: Screens.width(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Screens.width(context) * 0.3,
                                  child: Text("Select Vat File"),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectVatattachment();
                                          fileValidation = false;
                                        });
                                      },
                                      child: Container(
                                          padding: EdgeInsets.only(
                                            top: Screens.heigth(context) * 0.02,
                                            left: Screens.width(context) * 0.02,
                                            right:
                                                Screens.width(context) * 0.02,
                                            bottom:
                                                Screens.heigth(context) * 0.02,
                                          ),
                                          color: Colors.white,
                                          width: Screens.width(context) * 0.2,
                                          child: Icon(Icons.photo)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          vatFiles == null
                              ? SizedBox()
                              : ListView.builder(
                                  itemCount: 1,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (BuildContext context, int i) {
                                    if (vatFiles!.path
                                        .split('/')
                                        .last
                                        .contains("png")) {
                                      return Container(
                                          child: Column(children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  decoration: BoxDecoration(),
                                                  width:
                                                      Screens.width(context) *
                                                          0.09,
                                                  height:
                                                      Screens.heigth(context) *
                                                          0.06,
                                                  child: Center(
                                                      child: Image.asset(
                                                          "assets/CRM/img.jpg"))),
                                              Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(),
                                                  width:
                                                      Screens.width(context) *
                                                          0.6,
                                                  // height: Screens.padingHeight(context) * 0.06,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    vatFiles!.path
                                                        .split('/')
                                                        .last,
                                                    // overflow: TextOverflow.ellipsis,
                                                  )),
                                              SizedBox(
                                                  width:
                                                      Screens.width(context) *
                                                          0.1,
                                                  height:
                                                      Screens.heigth(context) *
                                                          0.06,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          vatFiles = null;
                                                        });
                                                      },
                                                      icon: Icon(
                                                        Icons.cancel_rounded,
                                                        color: Colors.grey,
                                                      )))
                                            ])
                                      ])
                                          // )
                                          );
                                    } else if (vatFiles!.path
                                        .split('/')
                                        .last
                                        .contains("jp")) {
                                      return Container(
                                          child: Column(children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  decoration: BoxDecoration(),
                                                  width:
                                                      Screens.width(context) *
                                                          0.09,
                                                  height:
                                                      Screens.heigth(context) *
                                                          0.06,
                                                  child: Center(
                                                      child: Image.asset(
                                                          "assets/CRM/img.jpg"))),
                                              Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(),
                                                  width:
                                                      Screens.width(context) *
                                                          0.6,
                                                  // height: Screens.padingHeight(context) * 0.06,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    vatFiles!.path
                                                        .split('/')
                                                        .last,
                                                  )),
                                              SizedBox(
                                                  width:
                                                      Screens.width(context) *
                                                          0.1,
                                                  height:
                                                      Screens.heigth(context) *
                                                          0.06,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          vatFiles = null;
                                                        });
                                                      },
                                                      icon: Icon(
                                                        Icons.cancel_rounded,
                                                        color: Colors.grey,
                                                      )))
                                            ])
                                      ])
                                          // )
                                          );
                                    } else if (vatFiles!.path
                                        .split('/')
                                        .last
                                        .contains("pdf")) {
                                      return Container(
                                          child: Column(children: [
                                        SizedBox(
                                          height:
                                              Screens.heigth(context) * 0.01,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(),
                                                width: Screens.width(context) *
                                                    0.09,
                                                height:
                                                    Screens.heigth(context) *
                                                        0.06,
                                                child: Center(
                                                    child: Image.asset(
                                                        "assets/CRM/PDFimg.png")),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(),
                                                  width:
                                                      Screens.width(context) *
                                                          0.6,
                                                  // height: Screens.padingHeight(context) * 0.06,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    vatFiles!.path
                                                        .split('/')
                                                        .last,
                                                  )),
                                              SizedBox(
                                                  width:
                                                      Screens.width(context) *
                                                          0.1,
                                                  height:
                                                      Screens.heigth(context) *
                                                          0.06,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          vatFiles = null;
                                                        });
                                                      },
                                                      icon: Icon(
                                                        Icons.cancel_rounded,
                                                        color: Colors.grey,
                                                      )))
                                            ])
                                      ]));
                                    } else if (vatFiles!.path
                                        .split('/')
                                        .last
                                        .contains("xlsx")) {
                                      return Container(
                                          child: Column(children: [
                                        SizedBox(
                                          height:
                                              Screens.heigth(context) * 0.01,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  decoration: BoxDecoration(),
                                                  width:
                                                      Screens.width(context) *
                                                          0.09,
                                                  height:
                                                      Screens.heigth(context) *
                                                          0.06,
                                                  child: Center(
                                                      child: Image.asset(
                                                          "assets/CRM/xls.png"))),
                                              Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(),
                                                  width:
                                                      Screens.width(context) *
                                                          0.6,
                                                  // height: Screens.padingHeight(context) * 0.06,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    vatFiles!.path
                                                        .split('/')
                                                        .last,
                                                  )),
                                              SizedBox(
                                                  width:
                                                      Screens.width(context) *
                                                          0.1,
                                                  height:
                                                      Screens.heigth(context) *
                                                          0.06,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          vatFiles = null;
                                                        });
                                                      },
                                                      icon: Icon(
                                                        Icons.cancel_rounded,
                                                        color: Colors.grey,
                                                      )))
                                            ])
                                      ])
                                          // )
                                          );
                                    }
                                    return Container(
                                        child: Column(children: [
                                      SizedBox(
                                        height: Screens.heigth(context) * 0.01,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(),
                                                width: Screens.width(context) *
                                                    0.09,
                                                height:
                                                    Screens.heigth(context) *
                                                        0.06,
                                                child: Center(
                                                    child: Image.asset(
                                                        "assets/CRM/txt.png"))),
                                            Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(),
                                                width: Screens.width(context) *
                                                    0.6,
                                                // height: Screens.padingHeight(context) * 0.06,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  vatFiles!.path
                                                      .split('/')
                                                      .last,
                                                )),
                                            SizedBox(
                                                width: Screens.width(context) *
                                                    0.1,
                                                height:
                                                    Screens.heigth(context) *
                                                        0.06,
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        vatFiles = null;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.grey,
                                                    )))
                                          ])
                                    ]));
                                  }),
                          //),
                          Visibility(
                              visible: fileValidation!,
                              child: Text(
                                "Please Choose Tin and Vat File..",
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.red),
                              )),

                          //
                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 20),
                            // height: Screens.heigth(context) * 0.08,
                            width: Screens.width(context),
                            color: Colors.grey[200],

                            child: DropdownButtonFormField<String>(
                                validator: (value) =>
                                    value == null ? 'Required*' : null,
                                decoration: InputDecoration(
                                  // border: OutlineInputBorder(),
                                  // contentPadding: EdgeInsets.symmetric(
                                  //     vertical: 0.2, horizontal: 10),
                                  // fillColor:
                                  //     theme.primaryColor.withOpacity(0.15),
                                  // filled: true,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                                icon: Icon(Icons.arrow_drop_down),
                                value: teriteriValue,
                                items: teriteritData.map((e) {
                                  return DropdownMenuItem(
                                      // ignore: unnecessary_brace_in_string_interps
                                      value: "${e.teriID}",
                                      child: Container(
                                          // height: Screens.bodyheight(context)*0.1,
                                          child: Text(e.descript.toString())));
                                }).toList(),
                                hint: Text("Territory",
                                    style: theme.textTheme.bodyLarge
                                        ?.copyWith(color: theme.primaryColor)),
                                onChanged: (String? value) {
                                  setState(() {
                                    teriteriValue = value;
                                    // print("teriteriValue: " +
                                    //     teriteriValue.toString());
                                  });
                                }),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),
                          Container(
                            child: TextFormField(
                              keyboardType: TextInputType.number,

                              controller: mycontroller[14],
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return '*Required';
                                }
                                return null;
                              },
                              // maxLines: 4,
                              decoration: InputDecoration(
                                  hintText: 'Mobile no',
                                  filled: true,
                                  fillColor:
                                      theme.primaryColor.withOpacity(0.15),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.2, horizontal: 10),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),
                          Container(
                            child: TextFormField(
                              controller: mycontroller[15],
                              // maxLines: 4,
                              readOnly: true,
                              decoration: InputDecoration(
                                  hintText: 'Sales Emp  Code',
                                  filled: true,
                                  fillColor:
                                      theme.primaryColor.withOpacity(0.15),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.2, horizontal: 10),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),
                          Container(
                            child: TextFormField(
                              controller: mycontroller[16],
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return '*Required';
                                }
                                return null;
                              },
                              // maxLines: 4,
                              decoration: InputDecoration(
                                  hintText: 'Contact Person',
                                  filled: true,
                                  fillColor:
                                      theme.primaryColor.withOpacity(0.15),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.2, horizontal: 10),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 20),
                            // height: Screens.heigth(context) * 0.08,
                            width: Screens.width(context),
                            color: Colors.grey[200],

                            child: DropdownButtonFormField<String>(
                                validator: (value) =>
                                    value == null ? 'Required*' : null,
                                decoration: InputDecoration(
                                  // border: OutlineInputBorder(),
                                  // contentPadding: EdgeInsets.symmetric(
                                  //     vertical: 0.2, horizontal: 10),
                                  // fillColor:
                                  //     theme.primaryColor.withOpacity(0.15),
                                  // filled: true,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                                icon: Icon(Icons.arrow_drop_down),
                                isExpanded: true,
                                value: paygrpValue,
                                items: paygroupData!.map((e) {
                                  return DropdownMenuItem(
                                      // ignore: unnecessary_brace_in_string_interps
                                      value: "${e.groupNum}",
                                      child: Container(
                                          // height: Screens.bodyheight(context)*0.1,
                                          child:
                                              Text(e.pymntGroup.toString())));
                                }).toList(),
                                hint: Text("Payment terms",
                                    style: theme.textTheme.bodyLarge
                                        ?.copyWith(color: theme.primaryColor)),
                                onChanged: (String? value) {
                                  setState(() {
                                    paygrpValue = value;
                                    // print("paygrpValue: " +
                                    //     paygrpValue.toString());
                                  });
                                }),
                          ),
                          //    Container(
                          //   child: TextFormField(
                          //     controller: mycontroller[11],
                          //     // maxLines: 4,
                          //     decoration: InputDecoration(
                          //       hintText: 'Payment terms',
                          //       filled: true,
                          //       fillColor: theme.primaryColor.withOpacity(0.15),
                          //       contentPadding: EdgeInsets.symmetric(
                          //         vertical: 0.2,horizontal: 10
                          //       ),
                          //      border: OutlineInputBorder()
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),
                          Container(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: mycontroller[17],
                              // maxLines: 4,

                              onEditingComplete: () {
                                mycontroller[17].text = TextStyles.splitValues(
                                    mycontroller[17].text);
                              },

                              decoration: InputDecoration(
                                  hintText: 'Credit Limit',
                                  filled: true,
                                  fillColor:
                                      theme.primaryColor.withOpacity(0.15),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.2, horizontal: 10),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),
                          Container(
                            child: TextFormField(
                              onTap: () {
                                mycontroller[17].text = TextStyles.splitValues(
                                    mycontroller[17].text);
                              },
                              controller: mycontroller[18],
                              maxLines: 4,
                              decoration: InputDecoration(
                                  hintText: 'Remarks',
                                  filled: true,
                                  fillColor:
                                      theme.primaryColor.withOpacity(0.15),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.2, horizontal: 10),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(
                            height: Screens.heigth(context) * 0.02,
                          ),
                          SizedBox(
                            //  height: Screens.heigth(context)*0.10,
                            width: Screens.width(context),
                            child: ElevatedButton(
                                onPressed: loadingBtn == false
                                    ? () {
                                        if (tinFiles == null ||
                                            vatFiles == null) {
                                          setState(() {
                                            fileValidation = true;
                                          });
                                        } else {
                                          setState(() {
                                            fileValidation = false;
                                          });
                                        }

                                        if (formKey.currentState!.validate() &
                                            (tinFiles != null &&
                                                vatFiles != null)) {
                                          callPostApi();
                                        }
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(),
                                    backgroundColor: theme.primaryColor),
                                child: loadingBtn == false
                                    ? Text(
                                        "Add",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      )
                                    : SizedBox(
                                        width: Screens.width(context) * 0.05,
                                        height: Screens.heigth(context) * 0.03,
                                        child: CircularProgressIndicator(),
                                      )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

  // files
  bool? fileValidation = false;
  File? tinFiles;
  File? vatFiles;

  FilePickerResult? result;
  List<FilesData> filedata = [];
  //  filesz = [];
  void selectattachment() async {
    result = await FilePicker.platform.pickFiles();

    if (result != null) {
      //filedata.clear();
      List<File> filesz = result!.paths.map((path) => File(path!)).toList();
      // print(tinFiles);

      for (int i = 0; i < filesz.length; i++) {
        setState(() {
          tinFiles = filesz[i];
          // List<int> intdata = filesz[i].readAsBytesSync();
          // filedata.add(FilesData(
          //     fileBytes: base64Encode(intdata),
          //     fileName: tinFiles!.path.split('/').last));
        });
      }
    }
  }

  void selectVatattachment() async {
    result = await FilePicker.platform.pickFiles();

    if (result != null) {
      //filedata.clear();
      List<File> filesz = result!.paths.map((path) => File(path!)).toList();
      for (int i = 0; i < filesz.length; i++) {
        setState(() {
          vatFiles = filesz[i];
          // List<int> intdata = filesz[i].readAsBytesSync();
          // filedata.add(FilesData(
          //     fileBytes: base64Encode(intdata),
          //     fileName: tinFiles!.path.split('/').last));
        });
      }
    }
  }

  void showtoast() {
    Fluttertoast.showToast(
        msg: "More than Four Document Not Allowed..",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14);
  }

  Future<void> addFiles() async {
    filedata.clear();
    List<int> intdata = tinFiles!.readAsBytesSync();
    filedata.add(FilesData(
        fileBytes: base64Encode(intdata),
        fileName: tinFiles!.path.split('/').last));
    List<int> intdata2 = vatFiles!.readAsBytesSync();
    filedata.add(FilesData(
        fileBytes: base64Encode(intdata2),
        fileName: vatFiles!.path.split('/').last));
  }

  Configuration config = Configuration();
  void callPostApi() async {
    loadingBtn = true;
    setState(() {});
    await addFiles();
    NewCutomerModel newCutomerModel = NewCutomerModel();

    for (int i = 0; i < filedata.length; i++) {
      await FilePostApi.getFilePostData(
              filedata[i].fileBytes, filedata[i].fileName)
          .then((value) {
        setState(() {
          if (value.stCode! >= 200 && value.stCode! <= 210) {
            setState(() {
              log("Api PAth $i: " + value.filepath.toString());
              if (i == 0) {
                newCutomerModel.tincer = value.filepath;
              } else if (i == 1) {
                newCutomerModel.vatcer = value.filepath;
              }
            });
          } else if (value.stCode! >= 400 && value.stCode! <= 410) {
            setState(() {});
          } else {
            setState(() {
              // fileException.add(value.exception!);
            });
          }
        });
      });
    }

    newCutomerModel.cardCode =
        mycontroller[0].text.isEmpty ? null : mycontroller[0].text;
    newCutomerModel.cardName = mycontroller[1].text;
    newCutomerModel.grupCode = codeValue == null ? null : int.parse(codeValue!);
    newCutomerModel.AdditionalID = mycontroller[12].text;
    newCutomerModel.FederalTaxID = mycontroller[13].text;
    newCutomerModel.Cellular = mycontroller[14].text;
    newCutomerModel.SalesPersonCode =
        mycontroller[15].text.isEmpty ? null : int.parse(mycontroller[15].text);
    newCutomerModel.ContactPerson = mycontroller[16].text;
    newCutomerModel.CreditLimit = mycontroller[17].text.isEmpty
        ? null
        : int.parse(
            mycontroller[17].text.replaceAll(",", "").replaceAll(".", ""));
    newCutomerModel.Notes = mycontroller[18].text;
    newCutomerModel.Series =
        seriesValue == null ? null : int.parse(seriesValue!);
    newCutomerModel.Territory =
        teriteriValue == null ? null : int.parse(teriteriValue!);
    newCutomerModel.PayTermsGrpCod =
        paygrpValue == null ? null : int.parse(paygrpValue!);
    newCutomerModel.newModel = [
      NewCutomeAdrsModel(
        AddressName: mycontroller[1].text,
        AddressName2: mycontroller[3].text,
        AddressName3: mycontroller[4].text,
        AddressType: 'bo_BillTo',
        City: mycontroller[5].text,
        Country: '',
        State: '',
        Street: mycontroller[2].text,
        ZipCode: mycontroller[6].text,
      ),
      NewCutomeAdrsModel(
        AddressName: mycontroller[1].text,
        AddressName2: mycontroller[8].text,
        AddressName3: mycontroller[9].text,
        AddressType: 'bo_ShipTo',
        City: mycontroller[10].text,
        Country: '',
        State: '',
        Street: mycontroller[7].text,
        ZipCode: mycontroller[11].text,
      ),
    ];

    newCutomerModel.contEmp = [ContactEmployees(name: mycontroller[16].text)];

    await PostCustCreateAPi.getGlobalData(newCutomerModel).then((value) {
      loadingBtn = false;
      setState(() {});
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        config.showDialogSucessB("Customer Successfully created..!!", "Sucess");
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        config.showDialog("${value.ErrorMsg!.message!.Value}..!!", "Failed");
      } else {
        config.showDialog("Something went wrong try agian..!!", "Sucess");
      }
    });
  }
}
