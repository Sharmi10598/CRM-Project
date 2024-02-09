// ignore_for_file: unnecessary_lambdas, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_new, omit_local_variable_types, prefer_single_quotes, prefer_if_elements_to_conditional_expressions

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_bundle/SalesApp/Api/CheckinApi/GetApprovedApi.dart';
import 'package:ultimate_bundle/SalesApp/Model/GetActivities/GetAprvActivityModel.dart';
import 'package:ultimate_bundle/SalesApp/Model/SelectionCustModel.dart';
import 'package:ultimate_bundle/src/furney/src/DB/DBHelper.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class SlctcustApDialog extends StatefulWidget {
  const SlctcustApDialog({
    Key? key,
  }) : super(key: key);

  @override
  MyDialogState createState() => new MyDialogState();
}

class MyDialogState extends State<SlctcustApDialog> {
  bool isLoading = false;
  String message = '';

  @override
  void initState() {
    super.initState();
    // callApprovedActivity();
    getDataINDB();
  }

  List<GetActivityApvdData> data = [];
  Future<void> getDataINDB() async {
    SelectedCustModel.CustomerCode = '';
    SelectedCustModel.CustomerName = '';
    SelectedCustModel.details = '';
    SelectedCustModel.clgcode = null;

    data = await DataBaseHelper.getApprovedCustData();
    setState(() {});
  }

  Future<void> callApprovedActivity() async {
    isLoading = true;
    message = '';
    setState(() {});
    print("GetValues.slpCode:::${GetValues.slpCode}");

    await GetActivityApvdAPi.getGlobalData(GetValues.slpCode!).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.activitiesData != null) {
          setState(() {
            isLoading = false;
            data = value.activitiesData!;
          });
        } else {
          setState(() {
            message = 'No data';
            isLoading = false;
          });
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      content: SizedBox(
        width: Screens.width(context),
        child: isLoading == true && message.isEmpty
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(child: CircularProgressIndicator()),
                ],
              )
            : isLoading == false && message.isNotEmpty
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Container(
                          child: Text(message),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                SelectedCustModel.CustomerName =
                                    data[index].CardName;
                                SelectedCustModel.CustomerCode =
                                    data[index].CardCode;
                                SelectedCustModel.clgcode = data[index].ClgCode;
                                SelectedCustModel.details = data[index].Details;
                                Get.back<void>();
                              },
                              child: Card(
                                child: SizedBox(
                                  width: Screens.width(context),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Text('${data[index].CardCode}'),
                                      ),
                                      Container(
                                        child: Text('${data[index].CardName}'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
      ),
    );
  }
}
