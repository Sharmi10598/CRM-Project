// ignore_for_file: prefer_final_locals, unused_local_variable, omit_local_variable_types, cascade_invocations, prefer_single_quotes

part of '../profile_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    getAllmethods();
  }

  Future<void> getAllmethods() async {
    var preff = await SharedPreferences.getInstance();
    setState(() {
      branch = preff.getString("branch");
      userCode = preff.getString("userCode");
      userName = preff.getString("UserName");
      deviceCode = preff.getString("DeviceCode");
      email = preff.getString("email");
      sapUserName = preff.getString("sapUserName");
      active = preff.getString("active");
      user_crp = preff.getString("U_CrpUsr");
    });
  }

  String? branch;
  String? userCode;
  String? userName;
  String? deviceCode;
  String? email;
  String? sapUserName;
  String? active;
  String? user_crp;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer:
          //  GetValues.userRoll == '3' ? drawer2(context) :
          drawer(context),
      appBar: appBar(context, _scaffoldKey, widget.title),
      body: branch == null
          ? Center(
              child: SpinKitThreeBounce(
                size: Screens.heigth(context) * 0.06,
                color: theme.primaryColor,
              ),
            )
          : Container(
              width: Screens.width(context),
              height: Screens.heigth(context),
              //color: Colors.red,
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                top: Screens.heigth(context) * 0.02,
                left: Screens.width(context) * 0.02,
                right: Screens.width(context) * 0.02,
                bottom: Screens.width(context) * 0.02,
              ),
              child: Column(
                children: [
                  // Center(
                  //   child: Text("$userName",
                  //   style: TextStyles.boldPC1(context),
                  //   ),
                  // ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        //  color: Colors.red,
                        width: Screens.width(context) * 0.3,
                        child: Text(
                          "User Name",
                          style: TextStyles.boldgrey(context),
                        ),
                      ),
                      SizedBox(
                        //  color: Colors.red,
                        width: Screens.width(context) * 0.05,
                        child: Text(
                          ":",
                          style: TextStyles.boldPC1(context),
                        ),
                      ),
                      SizedBox(
                        //   color: Colors.red,
                        width: Screens.width(context) * 0.6,
                        child: Text(
                          "$userName",
                          style: TextStyles.boldPC1(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        //  color: Colors.red,
                        width: Screens.width(context) * 0.3,
                        child: Text(
                          "User Code",
                          style: TextStyles.boldgrey(context),
                        ),
                      ),
                      SizedBox(
                        //  color: Colors.red,
                        width: Screens.width(context) * 0.05,
                        child: Text(
                          ":",
                          style: TextStyles.boldPC1(context),
                        ),
                      ),
                      SizedBox(
                        //   color: Colors.red,
                        width: Screens.width(context) * 0.6,
                        child: Text(
                          "$userCode",
                          style: TextStyles.boldPC1(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        //  color: Colors.red,
                        width: Screens.width(context) * 0.3,
                        child: Text(
                          "Branch",
                          style: TextStyles.boldgrey(context),
                        ),
                      ),
                      SizedBox(
                        //  color: Colors.red,
                        width: Screens.width(context) * 0.05,
                        child: Text(
                          ":",
                          style: TextStyles.boldPC1(context),
                        ),
                      ),
                      SizedBox(
                        //   color: Colors.red,
                        width: Screens.width(context) * 0.6,
                        child: Text(
                          "$branch",
                          style: TextStyles.boldPC1(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        //  color: Colors.red,
                        width: Screens.width(context) * 0.3,
                        child: Text(
                          "Email",
                          style: TextStyles.boldgrey(context),
                        ),
                      ),
                      SizedBox(
                        //  color: Colors.red,
                        width: Screens.width(context) * 0.05,
                        child: Text(
                          ":",
                          style: TextStyles.boldPC1(context),
                        ),
                      ),
                      SizedBox(
                        //   color: Colors.red,
                        width: Screens.width(context) * 0.6,
                        child: Text(
                          "$email",
                          style: TextStyles.boldPC1(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        //  color: Colors.red,
                        width: Screens.width(context) * 0.3,
                        child: Text(
                          "SAP UserName",
                          style: TextStyles.boldgrey(context),
                        ),
                      ),
                      SizedBox(
                        //  color: Colors.red,
                        width: Screens.width(context) * 0.05,
                        child: Text(
                          ":",
                          style: TextStyles.boldPC1(context),
                        ),
                      ),
                      SizedBox(
                        //   color: Colors.red,
                        width: Screens.width(context) * 0.6,
                        child: Text(
                          "$sapUserName",
                          style: TextStyles.boldPC1(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        //  color: Colors.red,
                        width: Screens.width(context) * 0.3,
                        child: Text(
                          "Device Code",
                          style: TextStyles.boldgrey(context),
                        ),
                      ),
                      SizedBox(
                        //  color: Colors.red,
                        width: Screens.width(context) * 0.05,
                        child: Text(
                          ":",
                          style: TextStyles.boldPC1(context),
                        ),
                      ),
                      SizedBox(
                        //   color: Colors.red,
                        width: Screens.width(context) * 0.6,
                        child: Text(
                          "$deviceCode",
                          style: TextStyles.boldPC1(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        //  color: Colors.red,
                        width: Screens.width(context) * 0.3,
                        child: Text(
                          "Active",
                          style: TextStyles.boldgrey(context),
                        ),
                      ),
                      SizedBox(
                        //  color: Colors.red,
                        width: Screens.width(context) * 0.05,
                        child: Text(
                          ":",
                          style: TextStyles.boldPC1(context),
                        ),
                      ),
                      SizedBox(
                        //   color: Colors.red,
                        width: Screens.width(context) * 0.6,
                        child: Text(
                          active == 'Y' ? "Yes" : "",
                          style: TextStyles.boldPC1(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        //  color: Colors.red,
                        width: Screens.width(context) * 0.3,
                        child: Text(
                          "Corporate User",
                          style: TextStyles.boldgrey(context),
                        ),
                      ),
                      SizedBox(
                        //  color: Colors.red,
                        width: Screens.width(context) * 0.05,
                        child: Text(
                          ":",
                          style: TextStyles.boldPC1(context),
                        ),
                      ),
                      SizedBox(
                        //   color: Colors.red,
                        width: Screens.width(context) * 0.6,
                        child: Text(
                          user_crp!.toLowerCase() == 'yes' ? "Yes" : "No",
                          style: TextStyles.boldPC1(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.02,
                  ),

                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      //color: Colors.red,
                      width: Screens.width(context) * 0.9,
                      child: Text(
                        "Change Password?",
                        style: TextStyles.underLine(context),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.02,
                  ),
                  CustomSpinkitdButton(
                    onTap: () async {
                      await logOutClicked();
                    },
                    isLoading: logoutLoD,
                    labelLoading: 'Logging Out',
                    label: 'Logout',
                  ),
                ],
              ),
            ),
    );
  }

  bool logoutLoD = false;

  Future<void> logOutClicked() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() => logoutLoD = true);
    LogOutDataModel logdata = LogOutDataModel();
    logdata.deviceCode = deviceCode;
    logdata.userCode = userCode;

    await LogoutUserAPi.getGlobalData(logdata).then((value) async {
      setState(() => logoutLoD = false);

      if (value.stCodel! >= 200 && value.stCodel! <= 210) {
        if (value.msg == "device code was successfully reset") {
          Get.offAllNamed<dynamic>(FurneyRoutes.signIn);
          await preferences.remove('countryCode');
        } else {
          await preferences.remove('countryCode');
          Get.offAllNamed<dynamic>(FurneyRoutes.signIn);
          // showSnack(value.msg!);
        }
      } else if (value.stCodel! >= 400 && value.stCodel! <= 410) {
        showSnack("Some thing went wrong try again");
      } else {
        showSnack("Some thing went wrong try again");
      }
    });
  }

  void showSnack(String msg) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.red,
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
