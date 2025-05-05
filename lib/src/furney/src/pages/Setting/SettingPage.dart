import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/SettingAPI/SettingsApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sign_in/sign_in_page.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({
    required this.theme,
    Key? key,
  }) : super(key: key);
  final ThemeData theme;
  @override
  State<SettingWidget> createState() => SettingWidgetState();
}

class SettingWidgetState extends State<SettingWidget> {
  // static List<GlobalKey<FormState>> formkey =
  //     List.generate(100, (i) => GlobalKey<FormState>());
  final formKey = GlobalKey<FormState>();
  static List<TextEditingController> mycontroller =
      List.generate(150, (i) => TextEditingController());
  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  disableKeyBoard(BuildContext context) {
    final currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  List dropList = ['Tanzania', 'Zambia'];

  String? countryValue;
  validateeMethod() async {
    log('message1setting');
    if (formKey.currentState!.validate()) {
      final pref2 = await pref;
      SettingModelAPi.countryCode = mycontroller[3].text;
      await SettingModelAPi.getGlobalData().then((value) async {
        if (value.stsCode! >= 200 && value.stsCode! <= 210) {
          if (value.countryClass != null) {
            await pref2.setString(
              'countryCode',
              value.countryClass!.countryName,
            );
            setState(() {
              GetValues.countryCode = value.countryClass!.countryName;
              FurneySignInScreenState.settingMsg = '';
              log('FurneySignInScreenState.settingMsg ::${FurneySignInScreenState.settingMsg}');
            });

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
            if (pref2.getString('countryCode')!.toLowerCase().trim() ==
                'tanzania') {
              setState(() {
                pref2.setString('TSapPassword', 'Insignia@2021#');

                // GetValues.sapPassword = 'Insignia@2021#';
                GetValues.sapPassword = pref2.getString('TSapPassword');

                GetValues.currency = 'TZS';
                GetValues.countryCode = pref2.getString('countryCode');
              });
              log('sapdetails::${GetValues.sapPassword},${GetValues.currency} ,${GetValues.countryCode}');
            } else if (pref2.getString('countryCode')!.toLowerCase().trim() ==
                    'zambia'
                //  ||
                //     pref2.getString('countryCode') == 'Zambia'
                ) {
              setState(() {
                pref2.setString('ZSapPassword', 'Insignia@2023#');

                // GetValues.sapPassword = 'Insignia@2023#';
                GetValues.sapPassword = pref2.getString('ZSapPassword');

                GetValues.currency = 'ZMW';
                GetValues.countryCode = pref2.getString('countryCode');
              });
            }

            log('sapdetails::${GetValues.sapPassword},${GetValues.currency} ,${GetValues.countryCode}');
            Navigator.pop(context);
          } else if (value.countryClass == null) {
            mycontroller[3].text = '';
            await pref2.remove('countryCode');

            const snackBar = SnackBar(
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
          await pref2.remove('countryCode');
          mycontroller[3].text = '';
          const snackBar = SnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red,
            content: Text(
              'Something went wrong try again..!!',
              style: TextStyle(color: Colors.white),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    }
  }

  saveCountryCode() async {
    final pref2 = await pref;
    log('message:::${pref2.getString('countryCode')}');
    if (pref2.getString('countryCode') != null) {
      setState(() {
        mycontroller[3].text = pref2.getString('countryCode')!;
        countryValue = pref2.getString('countryCode');
      });
    } else {
      mycontroller[3].text = '';
      countryValue = '';
    }
  }

  @override
  initState() {
    super.initState();
    saveCountryCode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: Colors.white,

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
                    // color: Colors.red,s
                    // width: Screens.width(context) * 0.7,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Configure',
                      style: widget.theme.textTheme.bodyMedium
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
                      icon: const Icon(
                        Icons.close,
                        // size: Screens.heigth(context) * 0.025,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Screens.heigth(context) * 0.02,
            ),
            Form(
              key: formKey,
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
                    ),
                    child: DropdownButtonFormField<String>(
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      validator: (value) => value == null ? 'Required' : null,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                      icon: const Icon(Icons.arrow_drop_down),
                      value: countryValue,
                      items: dropList
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item.toString(),
                              child: Text(
                                item.toString(),
                                style: theme.textTheme.bodyLarge
                                    ?.copyWith(color: theme.primaryColor),
                              ),
                            ),
                          )
                          .toList(),
                      hint: Text(
                        'Select Country Code',
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.grey),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          countryValue = value;
                          mycontroller[3].text = value.toString();
                          print('sleect country code: $countryValue');
                        });
                      },
                    ),
                    //
                    // TextFormField(
                    //   autofocus: true,
                    //   controller: mycontroller[3],
                    //   cursorColor: Colors.grey,
                    //   //keyboardType: TextInputType.number,
                    //   onChanged: (v) {},
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'Enter the Country Name';
                    //     } else {
                    //       return null;
                    //     }
                    //   },
                    // decoration: InputDecoration(
                    //   errorBorder: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(5),
                    //     borderSide: BorderSide(color: Colors.red),
                    //   ),
                    //   focusedErrorBorder: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(5),
                    //     borderSide: BorderSide(color: Colors.red),
                    //   ),
                    //   enabledBorder: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(5),
                    //     borderSide: BorderSide(color: Colors.grey),
                    //   ),
                    //   focusedBorder: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(5),
                    //     borderSide: BorderSide(color: Colors.grey),
                    //   ),
                    //     hintText: 'Country Name',
                    // hintStyle: widget.theme.textTheme.bodyMedium
                    //     ?.copyWith(color: Colors.grey),
                    //     filled: false,
                    //     contentPadding: const EdgeInsets.symmetric(
                    //       vertical: 10,
                    //       horizontal: 25,
                    //     ),
                    //   ),
                    // ),
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.02,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.pop(context);
                setState(() {
                  validateeMethod();
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: Screens.heigth(context) * 0.045,
                decoration: BoxDecoration(
                  color: widget.theme.primaryColor,
                ),
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Ok',
                      textAlign: TextAlign.center,
                      style: widget.theme.textTheme.bodyLarge
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
