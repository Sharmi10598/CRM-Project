import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/customer_bp/new_customer_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/customers/widget/all_addresses.dart';
import 'package:ultimate_bundle/src/furney/src/pages/customers/widget/all_contacts.dart';
import 'package:url_launcher/url_launcher.dart';

class AddressContacts extends StatefulWidget {
  const AddressContacts({Key? key}) : super(key: key);

  @override
  AddressContactsState createState() => AddressContactsState();
}

class AddressContactsState extends State<AddressContacts> {
  static CustomerDetailsValue? customerDetailsValue;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: Screens.width(context) * 0.02),
            width: Screens.width(context),
            //  height: Screens.heigth(context) * 0.3,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: Screens.heigth(context) * 0.01,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed<dynamic>(FurneyRoutes.contactInfo);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Main Contact',
                        style: TextStyles.boldPC1(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              customerDetailsValue!.contactPerson
                                  .toString(), // "Max Teq",
                              style: TextStyles.headlineBlack1(context),
                            ),
                          ),
                          // Container(
                          //   child: Icon(
                          //     Icons.navigate_next_outlined,
                          //     color: theme.primaryColor,
                          //     size: Screens.heigth(context) * 0.06,
                          //   ),
                          // )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Screens.heigth(context) * 0.01,
                ),
                GestureDetector(
                  onTap: () {
                    AllContactState.customerDetailsValue = customerDetailsValue;
                    Get.toNamed<dynamic>(FurneyRoutes.bpAllContacts);
                  },
                  child: Center(
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.3,
                        ),
                        Text(
                          'All Contacts',
                          style: TextStyles.boldPC1(context),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.27,
                        ),
                        Container(
                          child: Icon(
                            Icons.navigate_next_outlined,
                            color: theme.primaryColor,
                            size: Screens.heigth(context) * 0.06,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Screens.heigth(context) * 0.01,
          ),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: Screens.width(context) * 0.02),
            width: Screens.width(context),
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: Screens.heigth(context) * 0.01,
                ),
                GestureDetector(
                  onTap: () {
                    openMap(13.0827, 80.2707);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bill to',
                        style: TextStyles.boldPC1(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              //    "4417 Stonebridge RD Northampton Pennsylvania 18067 US",
                              customerDetailsValue!.bpaddress.isNotEmpty
                                  ? '${customerDetailsValue!.bpaddress[0].addressName}\n${customerDetailsValue!.bpaddress[0].block}\n${customerDetailsValue!.bpaddress[0].street}\n${customerDetailsValue!.bpaddress[0].city}\n${customerDetailsValue!.bpaddress[0].state}\n${customerDetailsValue!.bpaddress[0].country2}'
                                  : '',
                              style: TextStyles.headlineBlack1(context),
                            ),
                          ),
                          // Container(
                          //   child: Icon(
                          //     Icons.navigate_next_outlined,
                          //     color: theme.primaryColor,
                          //     size: Screens.heigth(context) * 0.06,
                          //   ),
                          // )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Screens.heigth(context) * 0.01,
                ),
                GestureDetector(
                  onTap: () {
                    openMap(13.0827, 80.2707);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ship to',
                        style: TextStyles.boldPC1(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Screens.width(context) * 0.83,
                            // color: Colors.blue,
                            child: Text(
                              // "4417 Stonebridge RD Northampton Pennsylvania 18067 US",
                              customerDetailsValue!.bpaddress.length == 2
                                  ? '${customerDetailsValue!.bpaddress[1].addressName}\n${customerDetailsValue!.bpaddress[1].block}\n${customerDetailsValue!.bpaddress[1].street}\n${customerDetailsValue!.bpaddress[1].city}\n${customerDetailsValue!.bpaddress[1].street}\n${customerDetailsValue!.bpaddress[0].country2}'
                                  : '',
                              style: TextStyles.headlineBlack1(context),
                            ),
                          ),
                          // Container(
                          //   child: Icon(
                          //     Icons.navigate_next_outlined,
                          //     color: theme.primaryColor,
                          //     size: Screens.heigth(context) * 0.06,
                          //   ),
                          // )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Screens.heigth(context) * 0.01,
                ),
                GestureDetector(
                  onTap: () {
                    AllAdressState.customerDetailsValue = customerDetailsValue;
                    Get.toNamed<dynamic>(FurneyRoutes.bpAllAddresses);
                  },
                  child: Center(
                    child: Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.3,
                        ),
                        Text(
                          'All Addresses',
                          style: TextStyles.boldPC1(context),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.22,
                        ),
                        Container(
                          child: Icon(
                            Icons.navigate_next_outlined,
                            color: theme.primaryColor,
                            size: Screens.heigth(context) * 0.06,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> openMap(double latitude, double longitude) async {
    final googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
