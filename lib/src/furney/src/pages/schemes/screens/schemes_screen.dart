part of '../discover_page.dart';

class Schemes extends StatefulWidget {
  const Schemes({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  SchemesnState createState() => SchemesnState();
}

class SchemesnState extends State<Schemes> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return
        // WillPopScope(
        //   onWillPop: onbackpress,
        //   child:
        Scaffold(
      key: _scaffoldKey,
      drawer:
          // GetValues.userRoll == '3' ? drawer2(context) :
          drawer(context),
      appBar: appBar(context, _scaffoldKey, widget.title),
      body: Center(
        child: Text(
          'Schemes',
          style: GoogleFonts.poppins(
            fontSize: Screens.heigth(context) * 0.018,
          ),
        ),
      ),
      // ),
    );
  }

  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    final now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.offAllNamed<dynamic>(FurneyRoutes.home);
      return Future.value(true);
    } else {
      return Future.value(true);
    }
  }
}
