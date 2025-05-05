import 'package:flutter/material.dart';
import 'package:ultimate_bundle/SalesApp/Api/GetFCM/GetFCMTOk.dart';
import 'package:ultimate_bundle/SalesApp/Api/PuposeVisitApi/PurposeVisitApi.dart';
import 'package:ultimate_bundle/SalesApp/Api/VisitCreatePostApi/PursVisitPostApi.dart';
import 'package:ultimate_bundle/SalesApp/Api/VisitCreatePostApi/UpdateVisitedDate.dart';
import 'package:ultimate_bundle/SalesApp/Model/PurposeVisitModel.dart/PurposeVisitModel.dart';
import 'package:ultimate_bundle/helpers/GetLeadToken.dart';
import 'package:ultimate_bundle/helpers/uikit_model.dart';
import 'package:ultimate_bundle/src/furney/src/Api/Notification/NotificationApi.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/SalesAppBar.dart';

class UpdateVisitPage extends StatefulWidget {
  const UpdateVisitPage({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  State<UpdateVisitPage> createState() => UpdateVisitPageState();
}

class UpdateVisitPageState extends State<UpdateVisitPage> {
  static String date = '';
  @override
  void initState() {
    super.initState();
    callVisitApi();
  }

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
          mapvalue();
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

  static int? clgcode;
  static String? cardcode;
  static String? cardname;
  static String? datechosed;
  static String? time;
  static String? details;

  Future<void> mapvalue() async {
    mycontroller[0].text = '${cardcode!}\n${cardname!}';
    mycontroller[1].text = config.alignDate(datechosed!);
    mycontroller[2].text = config.convertintToTime(int.parse(time!));
    mycontroller[3].text = details!;
    setState(() {});
  }

  TimeOfDay _timeOfDay = const TimeOfDay(hour: 18, minute: 30);
  static String? codeValue;
  Future<void> showTime() async {
    await showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      _timeOfDay = value!;

      mycontroller[2].text = _timeOfDay.format(context);
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static List<TextEditingController> mycontroller =
      List.generate(10, (i) => TextEditingController());
  List<GlobalKey<FormState>> formkey =
      List.generate(3, (i) => GlobalKey<FormState>());
  String? sctdCardCode;
  bool LoadingBtn = false;

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
                                      'Edit Visit Task',
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
                                    //         onTap: (){
                                    //       Get.toNamed<void>(FurneyRoutes.selectionCustomer)!.then((value) {
                                    //       mycontroller[0].text =
                                    //       '''${SelectedCustModel.CustomerCode}\n${SelectedCustModel.CustomerName}''';//\n${SelectedCustModel.shipAddress}

                                    //  sctdCardCode = SelectedCustModel.CustomerCode;
                                    //       setState(() { });
                                    //       });
                                    //     },
                                    readOnly: true,
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
                                      hintText: 'Select Customer',
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
                                alignment: Alignment.topCenter,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 20,
                                ),
                                height: Screens.heigth(context) * 0.10,
                                width: Screens.width(context),
                                color: Colors.grey[200],
                                child: SizedBox.expand(
                                  child: DropdownButtonFormField<String>(
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
                                        // ignore: unnecessary_brace_in_string_interps
                                        value: '${e.Code}',
                                        child: Text(e.Name.toString()),
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
                                  // maxLength: 10,
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
                            onPressed: LoadingBtn == false
                                ? () {
                                    if (mycontroller[3].text.length <= 100) {
                                      validatebtn();
                                    } else {
                                      ShowDialog(
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
                            child: LoadingBtn == false
                                ? const Text(
                                    'Update Visit Task',
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

  void validatebtn() {
    if (formkey[0].currentState!.validate()) {
      callPostApi();
    }
  }

  Future<void> callPostApi() async {
    LoadingBtn = true;
    setState(() {});
    final purpVisitModel = PurpVisitModel(
      Activity: 'Activity',
      clgCode: clgcode,
      SaleEmpCode: int.parse(GetValues.slpCode!), //  GetValues.slpCode!
      U_PlanDate: selectedDateFrApi.isEmpty ? datechosed! : selectedDateFrApi,
      U_PlanTime: mycontroller[2].text,
      cardCode: cardcode!,
      notes: mycontroller[3].text,
      subject: int.parse(codeValue!),
    );
    await PatchPurposeVisitAPi.getGlobalData(purpVisitModel)
        .then((value) async {
      LoadingBtn = false;
      setState(() {});
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        await sendNotio();
        await GetLeadToken.getGlobalData().then((tokens) async {
          if (tokens != 'Error') {
            final push = PushNotify(
              msg:
                  '${GetValues.userName} Update a visit plan to this ${cardname!} customer..!!',
              title: 'Visit Planing is pending',
              to: tokens,
            );
            await SendNotifiationAPi.getGlobalData(push).then((valueNot) {
              if (valueNot.statusCode! >= 200 && valueNot.statusCode != 210) {
                config.showDialogSucessB('Sucessfully Created...!!', 'Alert');
              } else {}
            });
          }
        });
        //            PushNotify push = new PushNotify(
        //   msg: '${GetValues.userName} Update a visit plan to this ${cardname!} customer..!!',
        //   title: "Visit Planing is pending",
        //   to: GetValues.LeadToken);
        // await SendNotifiationAPi.getGlobalData(push).then((valueNot) {
        //   if(valueNot.statusCode! >= 200 && valueNot.statusCode!=210){
        //    config.showDialogSucessB("Sucessfully Created...!!","Alert");
        //   }
        //   else {}
        // });
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        apiError = value.msg!;
        ShowDialog('${value.ErrorMsg!.message!.Value}', 'Alert');
      } else {
        apiError = value.msg!;
        ShowDialog('Something went wrong try agin...!!', 'Alert');
      }
    });
  }

  Future<dynamic> sendNotio() async {
    await GetCountryHeadTokenAPi.getGlobalData().then((value) async {
      if (value.activitiesData != null && value.activitiesData!.isNotEmpty) {
        final PushNotify push = PushNotify(
          msg:
              '${GetValues.userName} Update a visit plan to this ${cardname!} customer..!!',
          title: 'Visit Planing is pending',
          to: value.activitiesData![0].token,
        );
        await SendNotifiationAPi.getGlobalData(push);
      }
    });
  }
}

Configuration config = Configuration();
void ShowDialog(String msg, String title) {
  config.showDialog(msg, title);
}
