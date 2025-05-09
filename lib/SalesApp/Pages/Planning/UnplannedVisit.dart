import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_bundle/SalesApp/Api/CreateCustomer/CreateCustomer.dart';
import 'package:ultimate_bundle/SalesApp/Api/GetAvailableCardCode/GetCardCode.dart';
import 'package:ultimate_bundle/SalesApp/Api/PuposeVisitApi/PurposeVisitApi.dart';
import 'package:ultimate_bundle/SalesApp/Api/VisitCreatePostApi/PursVisitPostApi.dart';
import 'package:ultimate_bundle/SalesApp/Api/VisitCreatePostApi/UnplannedPostVisitapi.dart';
import 'package:ultimate_bundle/SalesApp/Model/GetAvailCardCode/GetAvailCardCode.dart';
import 'package:ultimate_bundle/SalesApp/Model/PurposeVisitModel.dart/PurposeVisitModel.dart';
import 'package:ultimate_bundle/SalesApp/Model/SelectionCustModel.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/uikit_model.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/SalesAppBar.dart';

class UnplannedVisitPage extends StatefulWidget {
  const UnplannedVisitPage({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  State<UnplannedVisitPage> createState() => UnplannedVisitPageState();
}

class UnplannedVisitPageState extends State<UnplannedVisitPage> {
  static String date = '';
  @override
  void initState() {
    super.initState();
    callVisitApi();
  }

  Configuration config = Configuration();

  List<PurposeVisitData>? purposeVisitData = [];
  bool loadinapi = true;
  String apiError = '';
  Future<void> callVisitApi() async {
    loadinapi = true;
    await GetPurposeVisitAPi.getGlobalData().then((value) {
      loadinapi = false;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.purposeData != null) {
          purposeVisitData = value.purposeData;
        } else {
          apiError = value.message!;
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        apiError = value.error!;
      } else {
        apiError = value.error!;
      }
      setState(() {});
    });
  }

  TimeOfDay _timeOfDay = const TimeOfDay(hour: 18, minute: 30);
  String? codeValue;
  Future<void> showTime() async {
    await showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      _timeOfDay = value!;

      mycontroller[2].text = _timeOfDay.format(context);
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<TextEditingController> mycontroller =
      List.generate(10, (i) => TextEditingController());
  List<GlobalKey<FormState>> formkey =
      List.generate(3, (i) => GlobalKey<FormState>());
  String? sctdCardCode;
  bool loadingBtn = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      drawer:
          // GetValues.userRoll == '3' ? drawer2(context) :
          drawer(context),
      appBar: salesappBar(context, _scaffoldKey, widget.title),
      body: loadinapi == true && apiError.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : loadinapi == true && apiError.isEmpty
              ? Center(
                  child: Text(apiError),
                )
              : Container(
                  width: Screens.width(context),
                  height: Screens.heigth(context),
                  padding: EdgeInsets.only(
                    left: Screens.width(context) * 0.03,
                    right: Screens.width(context) * 0.03,
                    top: Screens.heigth(context) * 0.03,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Form(
                          key: formkey[0],
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: Screens.width(context) * 0.01,
                                  right: Screens.width(context) * 0.01,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      date,
                                      style:
                                          theme.textTheme.bodyLarge!.copyWith(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '-',
                                      style:
                                          theme.textTheme.bodyLarge!.copyWith(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      'New Unplanned Visit',
                                      style:
                                          theme.textTheme.bodyLarge!.copyWith(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Screens.heigth(context) * 0.02,
                              ),
                              InkWell(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 20,
                                  ),
                                  width: Screens.width(context),
                                  color: Colors.grey[200],
                                  child: TextFormField(
                                    onTap: () {
                                      Get.toNamed<void>(
                                        FurneyRoutes.selectionCustomer,
                                      )!
                                          .then((value) {
                                        mycontroller[4].text =
                                            '''${SelectedCustModel.CustomerCode}''';
                                        sctdCardCode =
                                            SelectedCustModel.CustomerCode;
                                        mycontroller[0].text =
                                            '''${SelectedCustModel.CustomerName}''';
                                        setState(() {});
                                      });
                                    },
                                    //maulik
                                    // pwd 1234

                                    readOnly: true,
                                    controller: mycontroller[4],
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintText: 'Card Code',
                                      hintStyle:
                                          theme.textTheme.bodyLarge!.copyWith(
                                        color: theme.primaryColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Screens.heigth(context) * 0.02,
                              ),
                              InkWell(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 20,
                                  ),
                                  width: Screens.width(context),
                                  color: Colors.grey[200],
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    onChanged: (value) {
                                      mycontroller[0].text =
                                          value.toUpperCase();
                                    },
                                    onTap: () {
                                      //       Get.toNamed<void>(FurneyRoutes.selectionCustomer)!.then((value) {
                                      //       mycontroller[0].text =
                                      //       '''${SelectedCustModel.CustomerCode}''';//\n${SelectedCustModel.CustomerName}
                                      //  sctdCardCode = SelectedCustModel.CustomerCode;
                                      //       setState(() { });
                                      //       });
                                    },
                                    controller: mycontroller[0],
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Required';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintText: 'Lead Name',
                                      hintStyle:
                                          theme.textTheme.bodyLarge!.copyWith(
                                        color: theme.primaryColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Screens.heigth(context) * 0.01,
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 20,
                                ),
                                height: Screens.heigth(context) * 0.10,
                                width: Screens.width(context),
                                color: Colors.grey[200],
                                child: SizedBox.expand(
                                  child: DropdownButtonFormField<String>(
                                    dropdownColor: Colors.white,
                                    isExpanded: true,
                                    validator: (value) =>
                                        value == null ? 'Required' : null,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                    icon: const Icon(Icons.arrow_drop_down),
                                    value: codeValue,
                                    items: purposeVisitData!.map((e) {
                                      return DropdownMenuItem(
                                        value: '${e.Code}',
                                        child: SizedBox(
                                          width: Screens.width(context),
                                          // height: Screens.bodyheight(context)*0.1,
                                          child: Text(
                                            '${e.Name}',
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    hint: Text(
                                      'Select Purpose of Visit',
                                      style:
                                          theme.textTheme.bodyLarge?.copyWith(
                                        color: theme.primaryColor,
                                      ),
                                    ),
                                    onChanged: (String? value) {
                                      setState(() {
                                        codeValue = value;
                                        // print(
                                        //   'sleect code: $codeValue',
                                        // );
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Screens.heigth(context) * 0.01,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 20,
                                ),
                                height: Screens.heigth(context) * 0.10,
                                width: Screens.width(context),
                                color: Colors.grey[200],
                                child: TextFormField(
                                  onTap: () {
                                    showDate(context);
                                  },
                                  controller: mycontroller[1],
                                  maxLines: 4,
                                  readOnly: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Required';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintText: 'Visit Planned Date',
                                    hintStyle:
                                        theme.textTheme.bodyLarge!.copyWith(
                                      color: theme.primaryColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Screens.heigth(context) * 0.01,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 20,
                                ),
                                height: Screens.heigth(context) * 0.10,
                                width: Screens.width(context),
                                color: Colors.grey[200],
                                child: SizedBox.expand(
                                  child: TextFormField(
                                    onTap: showTime,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Required';
                                      }
                                      return null;
                                    },
                                    controller: mycontroller[2],
                                    // maxLength: 10,
                                    maxLines: 4,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintText: 'Visit Planned Time',
                                      hintStyle:
                                          theme.textTheme.bodyLarge!.copyWith(
                                        color: theme.primaryColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Screens.heigth(context) * 0.01,
                              ),
                              Container(
                                // alignment: Alignment.bottomRight,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 20,
                                ),
                                //   height: Screens.heigth(context) * 0.10,
                                width: Screens.width(context),
                                color: Colors.grey[200],
                                child: TextFormField(
                                  controller: mycontroller[3],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Required';
                                    }
                                    return null;
                                  },
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintText: 'Planned Details of Visit',
                                    hintStyle:
                                        theme.textTheme.bodyLarge!.copyWith(
                                      color: theme.primaryColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Screens.heigth(context) * 0.01,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          //  height: Screens.heigth(context)*0.10,
                          width: Screens.width(context),
                          child: ElevatedButton(
                            onPressed: loadingBtn == false
                                ? () {
                                    if (mycontroller[3].text.length <= 100) {
                                      validatebtn();
                                    } else {
                                      showDialog(
                                        'Details field must be 100 characters you entered more than that..!!',
                                        'Alert',
                                      );
                                    }
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                              backgroundColor: theme.primaryColor,
                            ),
                            child: loadingBtn == false
                                ? const Text(
                                    'Create Unplanned Visit',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  )
                                : SizedBox(
                                    width: Screens.width(context) * 0.05,
                                    height: Screens.heigth(context) * 0.03,
                                    child: const CircularProgressIndicator(),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  // for Date
  String selectedDate = '';
  String selectedDateFrApi = '';

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
        selectedDate = value.toString();
        final date = DateTime.parse(selectedDate);
        selectedDate = '';
        mycontroller[1].text =
            "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().padLeft(2, '0')}";
        selectedDateFrApi =
            "${date.year.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      });
    });
  }

  Future<void> validatebtn() async {
    if (formkey[0].currentState!.validate()) {
      // callPostApi();
      if (sctdCardCode != null) {
        loadingBtn = true;
        setState(() {});
        await callPostApiForExistCst();
      } else {
        loadingBtn = true;
        setState(() {});
        await getCardCode().then((value) {
          log('Numberer : $value');
          createCustomer(value);
        });
      }
    }
  }

  Future<dynamic> createCustomer(String cardCode) async {
    var newcus = NewCutomerCrtModel();
    newcus.cardCode = cardCode;
    newcus.cardName = mycontroller[0].text;
    newcus.cardType = 'cLid';
    await CustCreateAPi.getGlobalData(newcus).then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        await callPostApi(cardCode);
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        loadingBtn = false;
        setState(() {});
        apiError = value.error!;
        showDialog('${value.ErrorMsg!.message!.Value}', 'Alert');
      } else {
        loadingBtn = false;
        setState(() {});
        apiError = value.error!;
        showDialog('Something went wrong try agin...!!', 'Alert');
      }
    });
  }

  List<GetAvailCardCodeData> availCCd = [];
  Future<String> getCardCode() async {
    var availCode = '';
    await GetAvaCardCodeAPi.getGlobalData().then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.activitiesData != null) {
          availCode = value.activitiesData![0].lastcardcode!;
        } else {
          loadingBtn = false;
          setState(() {});
          showDialog('No data found...!!', 'Alert');
        }
      } else {
        loadingBtn = false;
        setState(() {});
        apiError = value.error!;
        showDialog('Something went wrong try agin...!!', 'Alert');
      }
    });
    return availCode;
  }

  Future<dynamic> callPostApi(String cardCode) async {
    var purpVisitModel = PurpVisitModel(
      Activity: 'Activity',
      SaleEmpCode: int.parse(GetValues.slpCode!), // GetValues.slpCode!
      U_PlanDate: selectedDateFrApi,
      U_PlanTime: mycontroller[2].text,
      cardCode: cardCode,
      notes: mycontroller[3].text,
      subject: int.parse(codeValue!),
    );
    await UnplannedVisitAPi.getGlobalData(purpVisitModel).then((value) {
      loadingBtn = false;
      setState(() {});
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        config.showDialogSucessB('Sucessfully Created...!!', 'Alert');
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        apiError = value.error!;
        loadingBtn = false;
        setState(() {});
        showDialog('${value.ErrorMsg!.message!.Value}', 'Alert');
      } else {
        apiError = value.error!;
        loadingBtn = false;
        setState(() {});
        showDialog('Something went wrong try agin...!!', 'Alert');
      }
    });
  }

  Future<dynamic> callPostApiForExistCst() async {
    log('datatatataexisssssttttt: ');
    final purpVisitModel = PurpVisitModel(
      Activity: 'Activity',
      SaleEmpCode: int.parse(GetValues.slpCode!), //  GetValues.slpCode!
      U_PlanDate: selectedDateFrApi,
      U_PlanTime: mycontroller[2].text,
      cardCode: sctdCardCode.toString(),
      notes: mycontroller[3].text,
      subject: int.parse(codeValue!),
    );
    await UnplannedVisitAPi.getGlobalData(purpVisitModel).then((value) async {
      loadingBtn = false;
      setState(() {});
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        //  PushNotify push = new PushNotify(
        //   msg: '${GetValues.userName} created a visit plan to this ${SelectedCustModel.CustomerName} customer..!!',
        //   title: "Visit Planing is pending",
        //   to: GetValues.LeadToken);
        // await SendNotifiationAPi.getGlobalData(push).then((valueNot) {
        //   if(valueNot.statusCode! >= 200 && valueNot.statusCode!=210){
        config.showDialogSucessB('Sucessfully Created...!!', 'Alert');
        //   }else {}
        // });
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        apiError = value.error!;
        loadingBtn = false;
        setState(() {});
        showDialog('${value.ErrorMsg!.message!.Value}', 'Alert');
      } else {
        apiError = value.error!;
        loadingBtn = false;
        setState(() {});
        showDialog('Something went wrong try agin...!!', 'Alert');
      }
    });
  }

  void showDialog(String msg, String title) {
    config.showDialog(msg, title);
  }
}
