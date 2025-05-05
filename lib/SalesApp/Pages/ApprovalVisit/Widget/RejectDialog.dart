import 'package:flutter/material.dart';
import 'package:ultimate_bundle/SalesApp/Api/UpdateVisit/RejectVisit.dart';
import 'package:ultimate_bundle/SalesApp/Model/GetActivities/GetActivitieModel.dart';
import 'package:ultimate_bundle/src/furney/src/Api/Notification/NotificationApi.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';

class RejectDialog extends StatefulWidget {
  RejectDialog({required this.clgcode, required this.activiti, Key? key})
      : super(key: key);
  int? clgcode;
  GetActivitiesData? activiti;

  @override
  MyDialogState createState() => MyDialogState();
}

class MyDialogState extends State<RejectDialog> {
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
    final theme = Theme.of(context);
    return AlertDialog(
      content: SizedBox(
        //  color: Colors.black12,
        //  height: heigth * 0.4,
        width: width * 0.8,
        child: isLoading == true && message.isEmpty
            ? const Column(
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
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        child: Text('You Reject this visit'),
                      ),
                      SizedBox(
                        height: Screens.heigth(context) * 0.01,
                      ),
                      const SizedBox(
                        child: Text('Please input the reason for rejections'),
                      ),
                      SizedBox(
                        height: Screens.heigth(context) * 0.01,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: theme.primaryColor
                              .withOpacity(0.1), //Colors.grey[200],
                          borderRadius: BorderRadius.circular(
                            Screens.width(context) * 0.02,
                          ),
                        ),
                        child: TextFormField(
                          controller: mycontroller[0],
                          maxLines: 3,
                          autocorrect: false,
                          onChanged: (v) {},
                          decoration: const InputDecoration(
                            filled: false,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
      actions: isLoading == true && message.isEmpty
          ? <Widget>[const SizedBox()]
          : <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // setState(() => showMSG = false);
                },
                child: const Text('Cancel'),
              ),
              isdone == false
                  ? TextButton(
                      onPressed: btnActive == true
                          ? () {
                              callRejectApi();
                            }
                          : null,
                      child: const Text('Ok'),
                    )
                  : const SizedBox(),
            ],
    );
  }

  bool isdone = false;
  Future<void> callRejectApi() async {
    setState(() => btnActive = false);

    setState(() => isLoading = true);
    setState(() => message = '');

    final aprv = RejectVisitModel(
      clgCode: widget.clgcode!,
      status: 'R',
      remarks: mycontroller[0].text,
    );
    await RejectVisitAPi.getGlobalData(aprv).then((value) async {
      setState(() => btnActive = true);

      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        final push = PushNotify(
          msg: 'Your ${widget.activiti!.cardName} visit Rejected..!!',
          title: 'Notification From Manager',
          to: widget.activiti!.fcmToken,
        );
        await SendNotifiationAPi.getGlobalData(push).then((valueNot) {
          if (valueNot.statusCode! >= 200 && valueNot.statusCode != 210) {
            setState(() {
              isLoading = false;
              message = 'Successfully rejected..!!';
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
}
