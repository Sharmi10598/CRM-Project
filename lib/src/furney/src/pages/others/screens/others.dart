import 'package:flutter/material.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/models/allmenudata.dart';
import 'package:ultimate_bundle/src/furney/src/pages/others/widget/allmenu.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';


class Others extends StatefulWidget {
  const Others({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  _OthersState createState() => _OthersState();
}

class _OthersState extends State<Others> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(context, _scaffoldKey, widget.title),
      drawer: drawer(context),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.only(
                top: Screens.heigth(context) * 0.02,
                left: Screens.width(context) * 0.02,
                right: Screens.width(context) * 0.02,
                bottom: Screens.width(context) * 0.02,),
            child:
            Allmenu(itemCount: dataList(context),),
                ),
      ),
    );
  }
}


