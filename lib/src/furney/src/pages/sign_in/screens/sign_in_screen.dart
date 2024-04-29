// ignore_for_file: prefer_const_constructors

part of '../sign_in_page.dart';

class FurneySignInScreen extends StatefulWidget {
  const FurneySignInScreen({Key? key}) : super(key: key);
  @override
  FurneySignInScreenState createState() => FurneySignInScreenState();
}

class FurneySignInScreenState extends State<FurneySignInScreen> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  bool _isLoading = false;
  final bool _obscureText = true;

  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  List<GlobalKey<FormState>> formkey =
      List.generate(3, (i) => GlobalKey<FormState>());
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  static String? settingMsg;
  disableKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _emailController = TextEditingController();
      _passwordController = TextEditingController();
      errorText();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Form(
        key: formkey[0],
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Container(
            // height: Screens.heigth(context) * 0.1, //5
            padding: const EdgeInsets.symmetric(horizontal: Const.margin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ListView(
                //   padding: const EdgeInsets.symmetric(horizontal: Const.margin),
                //   children: [
                SizedBox(height: Screens.heigth(context) * 0.1), //5
                const HeaderImage(),
                SizedBox(height: Screens.heigth(context) * 0.05),
                _HeaderSection(),
                SizedBox(height: Screens.heigth(context) * 0.04),
                Text(
                  settingMsg == null || settingMsg!.isEmpty ? '' : settingMsg!,
                  style:
                      theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
                ),
                SizedBox(height: Screens.heigth(context) * 0.02),
                // _BodySection(
                //   emailController: _emailController,
                //   passwordController: _passwordController,
                //   obscureText: _obscureText,
                //   onObscureTextTap: () {
                //     setState(() => _obscureText = !_obscureText);
                //   },
                // ),
                CustomShakeTransition(
                  duration: const Duration(milliseconds: 900),
                  child: AutoSizeText(
                    '${AppLocalizations.of(context)!.userCode}*',
                    style: theme.textTheme.bodyMedium,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 5),
                CustomShakeTransition(
                  duration: const Duration(milliseconds: 900),
                  child: SizedBox(
                    child: TextFormField(
                      validator: (value) {
                        if (mycontroller[0].text.isEmpty) {
                          return '*Enter Usercode';
                        }

                        return null;
                      },
                      //obscureText: true,
                      controller: mycontroller[0],
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),

                        // //focusborder
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),

                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                      cursorColor: theme.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: Const.space25),

                CustomShakeTransition(
                  duration: const Duration(milliseconds: 900),
                  child: AutoSizeText(
                    '${AppLocalizations.of(context)!.password}*',
                    style: theme.textTheme.bodyMedium,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 5),
                CustomShakeTransition(
                  duration: const Duration(milliseconds: 900),
                  child: SizedBox(
                    child: TextFormField(
                      validator: (value) {
                        if (mycontroller[1].text.isEmpty) {
                          return '*Enter Password';
                        }

                        return null;
                      },
                      obscureText: true,
                      controller: mycontroller[1],
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),

                        // //focusborder
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),

                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                      cursorColor: theme.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: Const.space25),
                // _BuildSignInButton(
                //   isLoading: _isLoading,
                //   onSignInTap: () {
                //     FocusScope.of(context).requestFocus(FocusNode());
                //     // if (_formKey.currentState!.validate()) {
                //       setState(() => _isLoading = true);
                //       Future.delayed(
                //         const Duration(seconds: 3),
                //         (){
                //             Get.toNamed<dynamic>(FurneyRoutes.home);
                //             setState(() => _isLoading = false);
                //         }
                //         //mee
                //         // setState(() => _isLoading = false);
                //       );
                //     // }
                //   },
                // ),

                CustomSpinkitdButton(
                  onTap: () {
                    setState(() {
                      setupValidation();
                      disableKeyBoard(context);
                    });

                    // validate();
                    //callServiceLayerApi();
                  },
                  isLoading: _isLoading,
                  labelLoading: AppLocalizations.of(context)!.signing,
                  label: AppLocalizations.of(context)!.sign_in,
                ),
                const SizedBox(height: Const.space8),
                const _BuildForgotPasswordButton(),
                // _BuildSignUpButton()
                SizedBox(height: Screens.heigth(context) * 0.04),

                InkWell(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder: (context, st) {
                            return AlertDialog(
                              contentPadding: EdgeInsets.all(0),
                              content: SettingWidget(
                                theme: theme,
                              ),
                            );
                          });
                        });
                  },
                  child: Container(
                    width: Screens.width(context) * 0.1,
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.settings),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? sapUserName;
  String? sapUserPass;
  final firebaseMessaging = FirebaseMessaging.instance;
  Future<String?> getToken() async {
    return firebaseMessaging.getToken();
  }

  // settingsMethod() {
  //   final theme = Theme.of(context);

  //   return Container(
  //     padding: EdgeInsets.only(
  //       top: Screens.heigth(context) * 0.01,
  //       left: Screens.width(context) * 0.03,
  //       right: Screens.width(context) * 0.03,
  //       bottom: Screens.heigth(context) * 0.01,
  //     ),
  //     width: Screens.width(context) * 1.1,
  //     child: SingleChildScrollView(
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Container(
  //             width: Screens.width(context),
  //             height: Screens.heigth(context) * 0.05,
  //             color: theme.primaryColor,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Container(
  //                   padding: EdgeInsets.only(
  //                       left: Screens.heigth(context) * 0.02,
  //                       right: Screens.heigth(context) * 0.02),
  //                   // color: Colors.red,
  //                   width: Screens.width(context) * 0.7,
  //                   alignment: Alignment.centerLeft,
  //                   child: Text(
  //                     'Configure',
  //                     style: theme.textTheme.bodyText2
  //                         ?.copyWith(color: Colors.white),
  //                   ),
  //                 ),
  //                 Container(
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(5),
  //                   ),
  //                   child: IconButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                     icon: Icon(
  //                       Icons.close,
  //                       size: Screens.heigth(context) * 0.025,
  //                       color: Colors.white,
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //           SizedBox(
  //             height: Screens.heigth(context) * 0.02,
  //           ),
  //           Form(
  //             key: formkey[1],
  //             child: Column(
  //               children: [
  //                 Container(
  //                   alignment: Alignment.centerRight,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(3),
  //                     color: Colors.grey.withOpacity(0.001),
  //                   ),
  //                   child: TextFormField(
  //                     autofocus: true,
  //                     controller: mycontroller[3],
  //                     cursorColor: Colors.grey,
  //                     //keyboardType: TextInputType.number,
  //                     onChanged: (v) {},
  //                     validator: (value) {
  //                       if (value!.isEmpty) {
  //                         return 'Enter the Country Name';
  //                       } else {
  //                         return null;
  //                       }
  //                     },
  //                     decoration: InputDecoration(
  //                       errorBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(5),
  //                         borderSide: BorderSide(color: Colors.red),
  //                       ),
  //                       focusedErrorBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(5),
  //                         borderSide: BorderSide(color: Colors.red),
  //                       ),
  //                       enabledBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(5),
  //                         borderSide: BorderSide(color: Colors.grey),
  //                       ),
  //                       focusedBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(5),
  //                         borderSide: BorderSide(color: Colors.grey),
  //                       ),
  //                       hintText: 'Country Name',
  //                       hintStyle: theme.textTheme.bodyText2
  //                           ?.copyWith(color: Colors.grey),
  //                       filled: false,
  //                       contentPadding: const EdgeInsets.symmetric(
  //                         vertical: 10,
  //                         horizontal: 25,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: Screens.heigth(context) * 0.02,
  //                 ),
  //               ],
  //             ),
  //           ),
  //           InkWell(
  //             onTap: () {
  //               Navigator.pop(context);
  //             },
  //             // logCon.progrestext == true
  //             //     ? null
  //             //     : () {
  //             //         st(() {
  //             //           logCon.settingvalidate(context);
  //             //         });
  //             //       },
  //             child: Container(
  //               alignment: Alignment.center,
  //               height: Screens.heigth(context) * 0.045,
  //               decoration: BoxDecoration(
  //                 color: theme.primaryColor,
  //               ),
  //               child: Center(
  //                 child: Container(
  //                   alignment: Alignment.center,
  //                   child:
  //                       //  logCon.progrestext == true
  //                       //     ? CircularProgressIndicator(
  //                       //         color: Colors.white,
  //                       //       )
  //                       //     :
  //                       Text(
  //                     'Ok',
  //                     textAlign: TextAlign.center,
  //                     style: theme.textTheme.bodyText1
  //                         ?.copyWith(color: Colors.white),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );

  //   // SettingWidget(
  //   //     theme: theme, formkey: formkey, mycontroller: mycontroller);
  // }

  errorText() async {
    settingMsg = '';
    final pref2 = await pref;
    log('SettingWidgetState.mycontroller::${SettingWidgetState.mycontroller[3].text}');
    setState(() {
      if (SettingWidgetState.mycontroller[3].text.isEmpty) {
        log("countryCode:: ${pref2.getString('countryCode')}");
        settingMsg = 'Complete the setup..!!';
      } else {
        setState(() {
          settingMsg = '';
        });
      }
    });
  }

  setupValidation() async {
    final pref2 = await pref;

    // if (pref2.getString('countryCode') == null) {
    if (SettingWidgetState.mycontroller[3].text.isEmpty) {
      settingMsg = 'Complete the setup..!!';

      SettingWidgetState.mycontroller[3].text = '';
    } else {
      settingMsg = '';

      final pref2 = await pref;
      pref2.setString(
        'countryCode',
        SettingWidgetState.mycontroller[3].text.toString(),
      );

      await validate();
    }
  }

  Future<void> validate() async {
    log('message1');
    if (formkey[0].currentState!.validate()) {
      setState(() => _isLoading = true);
      var preff = await SharedPreferences.getInstance();
      String? tokenFCM = await getToken();
      // setState(() => _isLoading = true);
      LoginUserAPi.deviceId = preff.getString('deviceID');
      LoginUserAPi.userCode = mycontroller[0].text;
      LoginUserAPi.password = mycontroller[1].text;
      log('LoginUserAPi.userCode: ${LoginUserAPi.userCode}');
      log('LoginUserAPi.password: ${LoginUserAPi.password}');
      log('LoginUserAPi.deviceId: ${LoginUserAPi.deviceId}');
      await LoginUserAPi.getGlobalData(tokenFCM!).then((value) async {
        if (value.loginUserData != null) {
          setState(() => _isLoading = false);
          final pref2 = await pref;
          pref2.setString(
            'UserName',
            value.loginUserData![0].userName.toString(),
          );
          pref2.setString(
              'userCode', value.loginUserData![0].userCode.toString());
          pref2.setString(
              'userRoll', value.loginUserData![0].userRoll.toString());
          pref2.setString('active', value.loginUserData![0].active.toString());
          pref2.setString('branch', value.loginUserData![0].branch.toString());
          pref2.setString('email', value.loginUserData![0].email.toString());
          pref2.setString('crmUserID', value.loginUserData![0].id.toString());
          pref2.setString(
              'password', value.loginUserData![0].password.toString());
          pref2.setString(
              'reportTo', value.loginUserData![0].reportTo.toString());
          pref2.setString(
              'sapPassword', value.loginUserData![0].sapPassword.toString());
          pref2.setString('sapUrl', value.loginUserData![0].sapUrl.toString());
          URL.url = value.loginUserData![0].sapUrl.toString();
          print('url:${URL.url}');
          pref2.setString(
              'sapUserName', value.loginUserData![0].sapUserName.toString());
          pref2.setString(
              'SlpCode', value.loginUserData![0].slpCode.toString());
          pref2.setString(
              'DeviceCode', value.loginUserData![0].deviceCode.toString());
          pref2.setString('SapDB', value.loginUserData![0].sapDB.toString());
          Get.offAllNamed<dynamic>(FurneyRoutes.home);
          pref2.setString(
              'LeadToken', value.loginUserData![0].ManagerFCM.toString());
          pref2.setString('FCMToken', value.loginUserData![0].FCM.toString());
          pref2.setString(
              'U_CrpUsr', value.loginUserData![0].U_CrpUsr.toString());
          // Get.offAllNamed<dynamic>(FurneyRoutes.home);
          // sapUserName = value.loginUserData![0].sapUserName.toString();
          // sapUserPass = value.loginUserData![0].sapPassword.toString();
          callServiceLayerApi();
        } else if (value.loginUserData == null && value.status == false) {
          setState(() => _isLoading = false);
          const snackBar = SnackBar(
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red,
            content: Text(
              'Invalid Credenial Please Check!!..',
              style: TextStyle(color: Colors.white),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (value.loginUserData == null && value.error != null) {
          setState(() => _isLoading = false);
          final snackBar = SnackBar(
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.red,
            content: Text(
              value.error.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        print('Status: ${value.status}');
      });
    }
  }

  void callServiceLayerApi() {
    PostSAPLoginAPi.username = sapUserName; //'crmapp';//sapUserName;
    PostSAPLoginAPi.password =
        sapUserPass; //'Tanzania';sapUserPass;//Tanzania crmapp
    PostSAPLoginAPi.getGlobaldData().then((value) async {
      final pref2 = await pref;
      if (value.error == null) {
        await pref2.setString('sessionId', value.sessionId.toString());
        await pref2.setString(
            'sessionTimeout', value.sessionTimeout.toString());
        print('session:${value.sessionId}');
        Get.offAllNamed<dynamic>(FurneyRoutes.home);
        //    Future.delayed(const Duration(seconds: 2), () {
        //    setState(() => _isLoading = false);
        //   Get.offAllNamed<dynamic>(FurneyRoutes.home);
        // });
      } else if (value.error != null) {
        setState(() => _isLoading = false);
        final snackBar = SnackBar(
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          content: Text(
            '${value.error!.message!.value}\nCheck Your Sap Details !!..',
            style: const TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }
}
