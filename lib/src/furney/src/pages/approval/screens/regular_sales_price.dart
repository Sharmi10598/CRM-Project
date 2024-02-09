import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';


//changes done in: search
class RegularSalesPrice extends StatefulWidget {
  const RegularSalesPrice({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  RegularSalesPriceState createState() => RegularSalesPriceState();
}

class RegularSalesPriceState extends State<RegularSalesPrice> {
 final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        appBar: appBar(context, _scaffoldKey, widget.title),
        drawer: drawer(context),
        backgroundColor: Colors.grey[200],
      body: 
      // Container(padding: EdgeInsets.symmetric(horizontal: Screens.width(context)*0.02 ),
      //   width: Screens.width(context),
      //   height: Screens.heigth(context) * 0.3,
      //   color: Colors.white,
      //   child:
        Padding(
          padding: EdgeInsets.only(
          // left:Screens.width(context) * 0.02,
          // right: Screens.width(context) * 0.02,
          top: Screens.heigth(context) * 0.01,
         // bottom: Screens.width(context) * 0.01
        ),
          child: Column(
            children:  [
             //   SearchBar( searchHint: 'Search Here!!..',),
              Container(
                padding: EdgeInsets.symmetric(horizontal: Screens.width(context)*0.02,vertical: Screens.width(context)*0.02 ),
                height: Screens.heigth(context) * 0.82,
                width: Screens.width(context),
                color: Colors.white,
                  child: ListView.builder(
                    itemCount: 100,
                    itemBuilder: (BuildContext context, int i){
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                             Container(
                               child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                    Container(
                         color: Colors.red,
                         width: Screens.width(context)*0.07,
                         height: Screens.heigth(context)*0.03,
                       ),
                         SizedBox(height: Screens.heigth(context)*0.005,),
                           Row(
                                     children: [
                                         Container(
                                 color: Colors.red,
                                 width: Screens.width(context)*0.07,
                                 height: Screens.heigth(context)*0.03,
                               ),
                               SizedBox(width: Screens.heigth(context)*0.005,),

                                 Container(
                                 color: Colors.red,
                                 width: Screens.width(context)*0.07,
                                 height: Screens.heigth(context)*0.03,
                               ),
                                     ],
                                   ),
                                 ],
                               ),
                             ),

                             Container(
                               child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text('A00001',
                                      style: GoogleFonts.poppins(
                                        fontSize: Screens.heigth(context) * 0.025,
                                        //color: heme.prtimaryColor
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        ),
                                   ),
                                    Text('J.B Officeprint 1420',
                                      style: GoogleFonts.poppins(
                                        fontSize: Screens.heigth(context) * 0.018,
                                         color: Colors.grey,),)
                                 ],
                               ),
                             ),

                         Container(
                               child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(r'600.00 $',
                                      style: GoogleFonts.poppins(
                                        fontSize: Screens.heigth(context) * 0.015,
                                        //color: heme.prtimaryColor
                                        color: Colors.grey,
                                        // fontWeight: FontWeight.bold
                                        ),
                                   ),
                                    Text(r'400.00 $',
                                      style: GoogleFonts.poppins(
                                        fontSize: Screens.heigth(context) * 0.015,
                                         color: Colors.grey,),)
                                 ],
                               ),
                             ),
                            ],
                          ),
                          const Divider(thickness: 2,)
                        ],
                      ),
                    );
                  },),
                ),
            ],
          ),
        ),
     // ),
    );
  }
 

}
//  