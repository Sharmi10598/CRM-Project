import 'package:flutter/material.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class NotesDetails extends StatefulWidget {
  const NotesDetails({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  NotesDetailsState createState() => NotesDetailsState();
}

class NotesDetailsState extends State<NotesDetails> {
  @override
  void initState() {}

  @override
  void dispose() {
    super.dispose();
  }

  static String? heading;
  static String? description;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(context, _scaffoldKey, widget.title),
      drawer:
          // GetValues.userRoll == '3' ? drawer2(context) :
          drawer(context),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Screens.heigth(context) * 0.02,
            horizontal: Screens.width(context) * 0.02,
          ),
          child: Card(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: Screens.heigth(context) * 0.02,
                horizontal: Screens.width(context) * 0.02,
              ),
              //alignment: Alignment.topLeft,
              width: Screens.width(context),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$heading',
                    style: TextStyles.boldPC1(context),
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Center(
                    child: Container(
                      width: Screens.width(context),
                      height: Screens.heigth(context) * 0.2,
                      color: Colors.indigo,
                    ),
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),

                  Text(
                    '$description',
                    style: TextStyles.bodytextBlack1(context),
                  ),
                  //      Text('ViewedOn:',
                  //  style: GoogleFonts.poppins(
                  //               //  color: theme.primaryColor,
                  //                 fontSize: Screens.width(context) * 0.035,
                  //               //    fontWeight: FontWeight.bold
                  //               ),
                  // ),
                  //      Text('IsSeen:',
                  //  style: GoogleFonts.poppins(
                  //               //  color: theme.primaryColor,
                  //                 fontSize: Screens.width(context) * 0.035,
                  //               //    fontWeight: FontWeight.bold
                  //               ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
