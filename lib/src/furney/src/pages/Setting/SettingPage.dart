// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sign_in/sign_in_page.dart';
import '../../Api/local_api/SettingAPI/SettingsApi.dart';
import '../../helpers/screens.dart';

class SettingWidget extends StatefulWidget {
  SettingWidget({
    required this.theme,
    Key? key,
  }) : super(key: key);
  final ThemeData theme;
  @override
  State<SettingWidget> createState() => SettingWidgetState();
}

class SettingWidgetState extends State<SettingWidget> {
  static List<GlobalKey<FormState>> formkey =
      List.generate(100, (i) => GlobalKey<FormState>());
  static List<TextEditingController> mycontroller =
      List.generate(150, (i) => TextEditingController());
  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  disableKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  validateMethod() async {
    if (formkey[0].currentState!.validate()) {
      final pref2 = await pref;
      await pref2.setString(
        'countryCode',
        mycontroller[3].text,
      );

      SettingModelAPi.countryCode = mycontroller[3].text;
      await SettingModelAPi.getGlobalData().then((value) async {
        if (value.stsCode! >= 200 && value.stsCode! <= 210) {
          if (value.countryClass != null) {
            await pref2.setString(
              'queryUrl',
              value.countryClass!.queryUrl,
            );
            await pref2.setString(
              'localURL',
              value.countryClass!.localUrl,
            );
            await pref2.setString(
              'reportUrl',
              value.countryClass!.reportUrl,
            );
            await pref2.setBool(
              'schemeReq',
              value.countryClass!.schemeReq,
            );
            URL.dynamicUrl = value.countryClass!.queryUrl;
            URL.reportUrl = value.countryClass!.reportUrl;
            URL.urlLocal = value.countryClass!.localUrl;
            FurneySignInScreenState.settingMsg = '';
            Navigator.pop(context);
          } else if (value.countryClass == null) {
            mycontroller[3].text = '';
            await pref2.remove('countryCode');

            final snackBar = SnackBar(
              duration: Duration(seconds: 5),
              backgroundColor: Colors.red,
              content: Text(
                'Invalid Country Name..!!',
                style: TextStyle(color: Colors.white),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        } else {
          final snackBar = SnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red,
            content: Text(
              'Something went wrong try again..!!',
              style: TextStyle(color: Colors.white),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        // if (value.stsCode! >= 400 && value.stsCode! <= 410) {
        //   final snackBar = SnackBar(
        //     duration: Duration(seconds: 5),
        //     backgroundColor: const Color.fromARGB(255, 180, 168, 168),
        //     content: Text(
        //       '${value.excep}',
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   );
        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // }
      });
    }
  }

  saveCountryCode() async {
    final pref2 = await pref;
    if (pref2.getString('countryCode') != null) {
      log("xxxxxx::: ${pref2.getString('countryCode')}");
      mycontroller[3].text = pref2.getString('countryCode')!;
    } else {
      mycontroller[3].text = '';
    }
  }

  initState() {
    // TODO: implement initState
    super.initState();
    saveCountryCode();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(
      //     top: Screens.heigth(context) * 0.01,
      //     left: Screens.width(context) * 0.03,
      //     right: Screens.width(context) * 0.03,
      //     bottom: Screens.heigth(context) * 0.01,),
      // width: Screens.width(context) * 1.5,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.heigth(context) * 0.05,
              color: widget.theme.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: Screens.heigth(context) * 0.02,
                      right: Screens.heigth(context) * 0.02,
                    ),
                    // color: Colors.red,
                    // width: Screens.width(context) * 0.7,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Configure',
                      style: widget.theme.textTheme.bodyText2
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        // size: Screens.heigth(context) * 0.025,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Screens.heigth(context) * 0.02,
            ),
            Form(
              key: formkey[0],
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: Screens.width(context) * 0.02,
                      right: Screens.width(context) * 0.02,
                    ),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.grey.withOpacity(0.001),
                    ),
                    child: TextFormField(
                      autofocus: true,
                      controller: mycontroller[3],
                      cursorColor: Colors.grey,
                      //keyboardType: TextInputType.number,
                      onChanged: (v) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter the Country Name';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: 'Country Name',
                        hintStyle: widget.theme.textTheme.bodyText2
                            ?.copyWith(color: Colors.grey),
                        filled: false,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 25,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.02,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  validateMethod();
                });

                disableKeyBoard(context);
              },
              // logCon.progrestext == true
              //     ? null
              //     : () {
              //         st(() {
              //           logCon.settingvalidate(context);
              //         });
              //       },
              child: Container(
                alignment: Alignment.center,
                height: Screens.heigth(context) * 0.045,
                decoration: BoxDecoration(
                  color: widget.theme.primaryColor,
                ),
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    child:
                        //  logCon.progrestext == true
                        //     ? CircularProgressIndicator(
                        //         color: Colors.white,
                        //       )
                        //     :
                        Text(
                      'Ok',
                      textAlign: TextAlign.center,
                      style: widget.theme.textTheme.bodyText1
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}