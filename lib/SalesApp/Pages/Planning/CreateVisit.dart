// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, omit_local_variable_types, prefer_single_quotes, leading_newlines_in_multiline_strings, unnecessary_lambdas, unnecessary_new, prefer_final_locals, require_trailing_commas, prefer_interpolation_to_compose_strings, unawaited_futures

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_bundle/SalesApp/Api/GetFCM/GetFCMTOk.dart';
import 'package:ultimate_bundle/SalesApp/Api/PuposeVisitApi/PurposeVisitApi.dart';
import 'package:ultimate_bundle/SalesApp/Api/VisitCreatePostApi/PursVisitPostApi.dart';
import 'package:ultimate_bundle/SalesApp/Model/PurposeVisitModel.dart/PurposeVisitModel.dart';
import 'package:ultimate_bundle/SalesApp/Model/SelectionCustModel.dart';
import 'package:ultimate_bundle/helpers/GetLeadToken.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/uikit_model.dart';
import 'package:ultimate_bundle/src/furney/src/Api/Notification/NotificationApi.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/SalesAppBar.dart';

class CreateVisitPage extends StatefulWidget {
  const CreateVisitPage({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  State<CreateVisitPage> createState() => CreateVisitPageState();
}

class CreateVisitPageState extends State<CreateVisitPage> {

  static String date='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callVisitApi();
  }

List<PurposeVisitData>? purposeVisitData = [];
bool loadinapi = true;
String apiError = '';
 Future<void>  callVisitApi()async{
  loadinapi = true;

    await GetPurposeVisitAPi.getGlobalData().then((value) {
          loadinapi = false;
      if(value.statusCode! >= 200 && value.statusCode! <=210){
          if(value.purposeData != null){
            purposeVisitData = value.purposeData;
          }else{
            apiError = value.message!;
          }
      }else if(value.statusCode! >= 400 && value.statusCode! <=410){
        apiError = value.error!;
      }else {
        apiError = value.error!;
      }
      setState(() { });
    });
  }

   TimeOfDay _timeOfDay = TimeOfDay(hour: 18, minute: 30);
  String? codeValue;
  Future<void> showTime()async {
    //  final newTime = await showTimePicker(
    //     context: context,
    //     initialTime: TimeOfDay.now(),
    //     builder: (context, child) {
    //       return MediaQuery(
    //         data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
    //       child: child ?? Container(),
    //       );
    //     },
    //   );

      // mycontroller[2].text = '${newTime!.hour}:${newTime!.minute}';
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      _timeOfDay = value!;

      mycontroller[2].text = _timeOfDay.format(context);
    });
  }
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<TextEditingController> mycontroller =  List.generate(10, (i) => TextEditingController());
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
      drawer: drawer(context),
      appBar: salesappBar(context, _scaffoldKey, widget.title),
      body: loadinapi == true && apiError.isEmpty?
      Center(child: CircularProgressIndicator(),):
      loadinapi == true && apiError.isEmpty?
      Center(child: Text(apiError),)
      :Container(
        width: Screens.width(context),
        height: Screens.heigth(context),
        padding: EdgeInsets.only(
            left: Screens.width(context) * 0.03,
            right: Screens.width(context) * 0.03,
            top: Screens.heigth(context) * 0.03),
        child: 
        
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Form(
                  key:formkey[0],
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: Screens.width(context) * 0.01,
                          right: Screens.width(context) * 0.01,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                date,
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.black, fontSize: 18),
                              ),
                              Text("-",
                                  style: theme.textTheme.bodyLarge!
                                      .copyWith(color: Colors.black, fontSize: 18)),
                              Text("New Visit Task",
                                  style: theme.textTheme.bodyLarge!
                                      .copyWith(color: Colors.black, fontSize: 18)),
                            ]),
                      ),
                      SizedBox(
                        height: Screens.heigth(context) * 0.02,
                      ),
                      InkWell(
                        // onTap: (){
                        //   Get.toNamed<void>(FurneyRoutes.selectionCustomer)!.then((value) {
                        //     mycontroller[0].text = 
                        //     '''${SelectedCustModel.CustomerName}\n
                        //     ${SelectedCustModel.billAddress}\n${SelectedCustModel.shipAddress}''';
                        //     setState(() { });
                        //   });
                        // },
                        child: Container(
                          // alignment: Alignment.topLeft,
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                         // height: Screens.heigth(context) * 0.20,
                          width: Screens.width(context),
                          color: Colors.grey[200],
                          child: TextFormField(
                            onTap: (){
                          Get.toNamed<void>(FurneyRoutes.selectionCustomer)!.then((value) {
                          mycontroller[0].text = 
                          '''${SelectedCustModel.CustomerCode}\n${SelectedCustModel.CustomerName}''';//\n${SelectedCustModel.shipAddress}
                          
                     sctdCardCode = SelectedCustModel.CustomerCode;
                          setState(() { });
                          });
                        },
                        readOnly: true,
                            controller: mycontroller[0],
                            validator: (value) {
                              if(value!.isEmpty){
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
                                hintText: "Select Customer",
                                hintStyle: theme.textTheme.bodyLarge!.copyWith(
                                  color: theme.primaryColor,
                                  fontSize: 15,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Screens.heigth(context) * 0.01,
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        height: Screens.heigth(context) * 0.10,
                        width: Screens.width(context),
                        color: Colors.grey[200],
                        child: SizedBox.expand(
                          child: DropdownButtonFormField<String>(
                              validator: (value) =>
                                  value == null ? 'Required' : null,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              icon: Icon(Icons.arrow_drop_down),
                              value: codeValue,
                              items: purposeVisitData!.map((e) {
                                      return DropdownMenuItem(
                                          // ignore: unnecessary_brace_in_string_interps
                                          value: "${e.Code}",
                                          child: Container(
                                              // height: Screens.bodyheight(context)*0.1,
                                              child: Text(e.Name.toString())));
                                    }).toList(),
                              hint: Text("Select Purpose of Visit",
                                  style: theme.textTheme.bodyLarge
                                      ?.copyWith(color: theme.primaryColor)),
                              onChanged: (String? value) {
                                setState(() {
                                  codeValue = value!;
                                  print("sleect code: "+codeValue.toString());
                                });
                              }),
                        ),
                      ),
                      SizedBox(
                        height: Screens.heigth(context) * 0.01,
                      ),
                       Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
                            if(value!.isEmpty){
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
                              hintText: "Visit Planned Date",
                              hintStyle: theme.textTheme.bodyLarge!.copyWith(
                                color: theme.primaryColor,
                                fontSize: 15,
                              )),
                        ),
                      ),
                        SizedBox(
                        height: Screens.heigth(context) * 0.01,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        height: Screens.heigth(context) * 0.10,
                        width: Screens.width(context),
                        color: Colors.grey[200],
                        child: SizedBox.expand(
                          child: TextFormField(
                            onTap: () {
                              showTime();
                            },
                             validator: (value) {
                            if(value!.isEmpty){
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
                                hintText: "Visit Planned Time",
                                hintStyle: theme.textTheme.bodyLarge!.copyWith(
                                  color: theme.primaryColor,
                                  fontSize: 15,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Screens.heigth(context) * 0.01,
                      ),
                      Container(
                        // alignment: Alignment.bottomRight,
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                     //   height: Screens.heigth(context) * 0.10,
                        width: Screens.width(context),
                        color: Colors.grey[200],
                        child: TextFormField(
                          controller: mycontroller[3],
                          validator: (value) {
                            if(value!.isEmpty){
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
                                hintText: "Planned Details of Visit",
                                hintStyle: theme.textTheme.bodyLarge!.copyWith(
                                  color: theme.primaryColor,
                                  fontSize: 15,
                                ))),
                      ),                  
                       SizedBox(
                  height: Screens.heigth(context) * 0.01,
              ),
                    ],
                  ),
                ),
              ),
           
              SizedBox(
                //  height: Screens.heigth(context)*0.10,
                width: Screens.width(context),
                child: ElevatedButton(
                    onPressed:  LoadingBtn == false? () {
                      if(mycontroller[3].text.length <= 100){
                        validatebtn();
                      }else {
                        ShowDialog("Details field must be 100 characters you entered more than that..!!","Alert");
                      }
                    }:null,
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        backgroundColor: theme.primaryColor),
                    child: 
                    LoadingBtn == false?
                    Text(
                      "Create Visit Task",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ):SizedBox(
                      width: Screens.width(context)*0.05,
                      height: Screens.heigth(context)*0.03,
                      child: CircularProgressIndicator(),)),
              )
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
        var date = DateTime.parse(selectedDate);
        selectedDate = '';
        mycontroller[1].text = "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().padLeft(2, '0')}";
        selectedDateFrApi = "${date.year.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      });
    });
  }

 void validatebtn(){
    if(formkey[0].currentState!.validate()){
      callPostApi();
    }
  }

  Future<void> callPostApi()async
  {
    LoadingBtn = true;
    setState(() { });
    PurpVisitModel purpVisitModel = new PurpVisitModel
    (Activity: "Activity",
     SaleEmpCode: int.parse(GetValues.slpCode!),// GetValues.slpCode!
     U_PlanDate: selectedDateFrApi, 
     U_PlanTime: mycontroller[2].text, 
     cardCode: sctdCardCode!, 
     notes: mycontroller[3].text,
     subject:int.parse(codeValue!));
          await PostPurposeVisitAPi.getGlobalData(purpVisitModel).
          then((value) async{
            LoadingBtn = false;
    setState(() { });
           if(value.statusCode! >= 200 && value.statusCode! <=210){
            await sendNotio();
     await GetLeadToken.getGlobalData().then((tokens)async {
      if(tokens != 'Error'){
          PushNotify push = new PushNotify(
          msg: '${GetValues.userName} created a visit plan to this ${SelectedCustModel.CustomerName} customer..!!',
          title: "Visit Planing is pending", 
          to: tokens);
        await SendNotifiationAPi.getGlobalData(push).then((valueNot) {
          if(valueNot.statusCode! >= 200 && valueNot.statusCode!=210){
           config.showDialogSucessB("Sucessfully Created...!!","Alert");
          }
          else {}
        });
      }
     });       
              
      }else if(value.statusCode! >= 400 && value.statusCode! <=410){
        apiError = value.error!;
        ShowDialog("${value.ErrorMsg!.message!.Value}","Alert");
      }else {
        apiError = value.error!;
        ShowDialog("Something went wrong try agin...!!","Alert");
      }});         
  }
}

 Future sendNotio()async{
  GetCountryHeadTokenAPi.getGlobalData().then((value) async{
    if(value.activitiesData !=null && value.activitiesData!.isNotEmpty){
       PushNotify push = new PushNotify(
          msg: '${GetValues.userName} created a visit plan to this ${SelectedCustModel.CustomerName} customer..!!',
          title: "Visit Planing is pending", 
          to: value.activitiesData![0].token);
        await SendNotifiationAPi.getGlobalData(push);
    }
  });
 }

Config config = Config();
 void ShowDialog(String msg,String title){
    config.showDialog(msg, title);
  }

      // showDialog<dynamic>(
      //                   context: context,
      //                   builder: (BuildContext context) {
      //                     return AlertDialog(
      //                       backgroundColor: theme.primaryColor,
      //                       shape: RoundedRectangleBorder(
      //                           borderRadius:
      //                               BorderRadius.all(Radius.circular(20))),
      //                       contentPadding: EdgeInsets.all(12),
      //                       insetPadding: EdgeInsets.all(15),
      //                       content: Container(
      //                           height: Screens.heigth(context) * 0.18,
      //                           child: Column(
      //                             children: [
      //                               Text(
      //                                 "Visit Task Created\n    Successfully.",
      //                                 style: theme.textTheme.bodyText1!
      //                                     .copyWith(color: Colors.white),
      //                               ),
      //                               SizedBox(
      //                                 height: Screens.heigth(context) * 0.04,
      //                               ),
      //                               Text(
      //                                   "Visit Request has been send to \n       Manager for approval.",
      //                                   style: theme.textTheme.bodyText1!
      //                                       .copyWith(color: Colors.white)),
      //                             ],
      //                           )),
      //                     );
      //                   });
