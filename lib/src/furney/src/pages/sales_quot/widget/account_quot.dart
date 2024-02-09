// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';

class AccountingQuot extends StatefulWidget {
  const AccountingQuot({Key? key}) : super(key: key);

  @override
  AccountingQuotState createState() => AccountingQuotState();
}

class AccountingQuotState extends State<AccountingQuot> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body:
          // Padding(
          //  padding: EdgeInsets.only(top:Screens.heigth(context)*0.01,),//left: Screens.width(context)*0.01,right: Screens.width(context)*0.01,
          // child:
          SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Screens.width(context) * 0.02,),
              color: Colors.white,
              width: Screens.width(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [             
              SizedBox(height: Screens.heigth(context) * 0.01, ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                         'Payment Terms',
                          style:  TextStyles.boldPC1(context),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                            '2P10Net30',
                            style:TextStyles.headlineBlack1(context),
                          ),
                        ),
                      ],
                    ),
             SizedBox(height: Screens.heigth(context) * 0.01, ),
                       Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                         'Payment Means',
                          style: TextStyles.boldPC1(context),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.83,
                          // color: Colors.blue,
                          child: Text(
                            'Incoming BT 02',
                            style:TextStyles.headlineBlack1(context),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            SizedBox(
              height: Screens.heigth(context) * 0.01,
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
