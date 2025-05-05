// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';

class ShowBottomSheet extends StatefulWidget {
  const ShowBottomSheet({Key? key}) : super(key: key);

  @override
  State<ShowBottomSheet> createState() => _ShowBottomSheetState();
}

class _ShowBottomSheetState extends State<ShowBottomSheet> {
  bool loading = true;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   body:
        loading == true
            ? Container(
                width: Screens.width(context),
                height: Screens.heigth(context) * 0.3,
                color: Colors.red[200],
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                height: Screens.heigth(context) * 0.5,
                color: Colors.green[200],
                width: Screens.width(context),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('loadddinggggg completeddd'),
                  ],
                ),
              );
  }
}
