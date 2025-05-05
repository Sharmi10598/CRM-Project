// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/customer_bp/new_customer_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';

class ListOfCustomer extends StatelessWidget {
  const ListOfCustomer({
    Key? key,
  }) : super(key: key);
  static List<CustomerDetailsValue> data = [];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int i) {
          return Card(
            child: InkWell(
              onTap: () {
                // print('object');
                //Get.toNamed<dynamic>(FurneyRoutes.salesquotdetails);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Screens.width(context) * 0.02,
                ),
                height: Screens.heigth(context) * 0.08,
                width: Screens.width(context),
                decoration: BoxDecoration(
                  // color:Colors.green,
                  // borderRadius: BorderRadius.circular(Const.radius),
                  border: Border.all(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'CardName: ',
                        style: GoogleFonts.poppins(
                          fontSize: Screens.heigth(context) * 0.02,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.heigth(context) * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'CardCode: ',
                          style: theme.textTheme.bodyMedium,
                        ),
                        Text(
                          'CardType: ',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
