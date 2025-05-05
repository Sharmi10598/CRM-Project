import 'package:flutter/material.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/customer_bp/new_customer_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class AllAdress extends StatefulWidget {
  const AllAdress({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  AllAdressState createState() => AllAdressState();
}

class AllAdressState extends State<AllAdress> {
  static CustomerDetailsValue? customerDetailsValue;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      key: _scaffoldKey,
      appBar: appBar(context, _scaffoldKey, widget.title),
      drawer:
          // GetValues.userRoll == '3' ? drawer2(context) :
          drawer(context),
      body: SafeArea(
        child: Container(
          width: Screens.width(context),
          height: Screens.heigth(context),
          color: Colors.grey[300],
          padding: EdgeInsets.symmetric(
            horizontal: Screens.width(context) * 0.02,
            vertical: Screens.heigth(context) * 0.02,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: customerDetailsValue!.bpaddress.length,
                  itemBuilder: (context, i) {
                    return Card(
                      child: Container(
                        width: Screens.width(context),
                        // height: Screens.heigth(context),
                        // color: Colors.grey[300],
                        padding: EdgeInsets.symmetric(
                          horizontal: Screens.width(context) * 0.02,
                          vertical: Screens.heigth(context) * 0.02,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              // color: Colors.indigo,
                              width: Screens.width(context),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    //   color: Colors.indigo,
                                    width: Screens.width(context) * 0.3,
                                    child: Text(
                                      'AddressName',
                                      style: TextStyles.boldPC1(context),
                                    ),
                                  ),
                                  // SizedBox(width: Screens.width(context)*0.025,),
                                  SizedBox(
                                    //color: Colors.amber,
                                    width: Screens.width(context) * 0.02,
                                    child: Text(
                                      ':',
                                      style: TextStyles.boldPC1(context),
                                    ),
                                  ),

                                  SizedBox(
                                    //     color: Colors.indigo,
                                    width: Screens.width(context) * 0.57,
                                    child: Text(
                                      '${customerDetailsValue!.bpaddress[i].addressName}',
                                      style: TextStyles.headlineBlack1(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              // color: Colors.indigo,
                              width: Screens.width(context),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    //    color: Colors.indigo,
                                    width: Screens.width(context) * 0.3,
                                    child: Text(
                                      'Block',
                                      style: TextStyles.boldPC1(context),
                                    ),
                                  ),
                                  // SizedBox(width: Screens.width(context)*0.025,),
                                  SizedBox(
                                    //    color: Colors.amber,
                                    width: Screens.width(context) * 0.02,
                                    child: Text(
                                      ':',
                                      style: TextStyles.boldPC1(context),
                                    ),
                                  ),

                                  SizedBox(
                                    //     color: Colors.indigo,
                                    width: Screens.width(context) * 0.57,
                                    child: Text(
                                      '${customerDetailsValue!.bpaddress[i].block}',
                                      style: TextStyles.headlineBlack1(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              // color: Colors.indigo,
                              width: Screens.width(context),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    //    color: Colors.indigo,
                                    width: Screens.width(context) * 0.3,
                                    child: Text(
                                      'Street',
                                      style: TextStyles.boldPC1(context),
                                    ),
                                  ),
                                  // SizedBox(width: Screens.width(context)*0.025,),
                                  SizedBox(
                                    //   color: Colors.amber,
                                    width: Screens.width(context) * 0.02,
                                    child: Text(
                                      ':',
                                      style: TextStyles.boldPC1(context),
                                    ),
                                  ),

                                  SizedBox(
                                    //      color: Colors.indigo,
                                    width: Screens.width(context) * 0.57,
                                    child: Text(
                                      '${customerDetailsValue!.bpaddress[i].street}',
                                      style: TextStyles.headlineBlack1(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              // color: Colors.indigo,
                              width: Screens.width(context),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    //  color: Colors.indigo,
                                    width: Screens.width(context) * 0.3,
                                    child: Text(
                                      'City',
                                      style: TextStyles.boldPC1(context),
                                    ),
                                  ),
                                  // SizedBox(width: Screens.width(context)*0.025,),
                                  SizedBox(
                                    //  color: Colors.amber,
                                    width: Screens.width(context) * 0.02,
                                    child: Text(
                                      ':',
                                      style: TextStyles.boldPC1(context),
                                    ),
                                  ),

                                  SizedBox(
                                    //  color: Colors.indigo,
                                    width: Screens.width(context) * 0.57,
                                    child: Text(
                                      '${customerDetailsValue!.bpaddress[i].city}',
                                      style: TextStyles.headlineBlack1(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              // color: Colors.indigo,
                              width: Screens.width(context),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    //  color: Colors.indigo,
                                    width: Screens.width(context) * 0.3,
                                    child: Text(
                                      'State',
                                      style: TextStyles.boldPC1(context),
                                    ),
                                  ),
                                  // SizedBox(width: Screens.width(context)*0.025,),
                                  SizedBox(
                                    //  color: Colors.amber,
                                    width: Screens.width(context) * 0.02,
                                    child: Text(
                                      ':',
                                      style: TextStyles.boldPC1(context),
                                    ),
                                  ),

                                  SizedBox(
                                    //  color: Colors.indigo,
                                    width: Screens.width(context) * 0.57,
                                    child: Text(
                                      '${customerDetailsValue!.bpaddress[i].state}',
                                      style: TextStyles.headlineBlack1(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              // color: Colors.indigo,
                              width: Screens.width(context),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    //  color: Colors.indigo,
                                    width: Screens.width(context) * 0.3,
                                    child: Text(
                                      'Country',
                                      style: TextStyles.boldPC1(context),
                                    ),
                                  ),
                                  // SizedBox(width: Screens.width(context)*0.025,),
                                  SizedBox(
                                    //  color: Colors.amber,
                                    width: Screens.width(context) * 0.02,
                                    child: Text(
                                      ':',
                                      style: TextStyles.boldPC1(context),
                                    ),
                                  ),

                                  SizedBox(
                                    //  color: Colors.indigo,
                                    width: Screens.width(context) * 0.57,
                                    child: Text(
                                      '${customerDetailsValue!.bpaddress[i].country2}',
                                      style: TextStyles.headlineBlack1(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
