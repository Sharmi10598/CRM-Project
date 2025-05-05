// ignore_for_file: unnecessary_lambdas, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_new, omit_local_variable_types, prefer_single_quotes, prefer_if_elements_to_conditional_expressions, require_trailing_commas, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:ultimate_bundle/SalesApp/Api/UpdateVisit/ApproveVisit.dart';
import 'package:ultimate_bundle/SalesApp/Model/GetActivities/GetActivitieModel.dart';
import 'package:ultimate_bundle/src/furney/src/Api/Notification/NotificationApi.dart';

class MyApprovalDialog extends StatefulWidget {
  MyApprovalDialog({required this.clgcode, required this.activiti, Key? key})
      : super(key: key);
  int? clgcode;
  GetActivitiesData? activiti;
  @override
  MyDialogState createState() => new MyDialogState();
}

class MyDialogState extends State<MyApprovalDialog> {
  bool isLoading = false;
  bool btnActive = true;
  String message = '';

  @override
  void initState() {
    super.initState();
  }

  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return AlertDialog(
      content: SizedBox(
        //  color: Colors.black12,
        //  height: heigth * 0.4,
        width: width * 0.8,
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
                          child: SizedBox(
                        child: Text(message),
                      )),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Are you want to approve this visit..??'),
                    ],
                  ),
      ),
      actions: isLoading == true && message.isEmpty
          ? <Widget>[SizedBox()]
          : <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // setState(() => showMSG = false);
                },
                child: Text("Cancel"),
              ),
              isdone == false
                  ? TextButton(
                      onPressed: btnActive == true
                          ? () {
                              callAprovalApi();
                            }
                          : null,
                      child: Text("Ok"),
                    )
                  : SizedBox(),
            ],
    );
  }

  bool isdone = false;

  Future<void> callAprovalApi() async {
    setState(() => btnActive = false);
    setState(() => isLoading = true);
    setState(() => message = '');

    final ApproveVisitModel aprv =
        new ApproveVisitModel(clgCode: widget.clgcode!, status: 'A');
    await ApproveVisitAPi.getGlobalData(aprv).then((value) async {
      setState(() => btnActive = true);

      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        final PushNotify push = new PushNotify(
            msg: 'Your ${widget.activiti!.cardName} visit Approved..!!',
            title: "Notification From Manager",
            to: widget.activiti!.fcmToken);
        await SendNotifiationAPi.getGlobalData(push).then((valueNot) {
          if (valueNot.statusCode! >= 200 && valueNot.statusCode != 210) {
            setState(() {
              isLoading = false;
              message = "Successfully Approved..!!";
              isdone = true;
            });
          } else {}
        });
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        setState(() {
          isLoading = false;
          message = value.ErrorMsg!.message!.Value!;
        });
      } else {
        setState(() {
          isLoading = false;
          message = value.Msg!;
        });
      }
    });
  }

  Future<void> pusnoti() async {
    final PushNotify push = new PushNotify(
        msg: 'Your ${widget.activiti!.cardName} visit Approved..!!',
        title: "Notification From Manager",
        to: widget.activiti!.fcmToken);
    await SendNotifiationAPi.getGlobalData(push).then((valueNot) {
      if (valueNot.statusCode! >= 200 && valueNot.statusCode != 210) {
        print("Message: " + valueNot.success.toString());
      } else {}
    });
  }
}
