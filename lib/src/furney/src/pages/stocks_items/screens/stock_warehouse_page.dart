// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, unnecessary_const, prefer_is_empty, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
// import 'package:ultimate_bundle/src/furney/src/Api/Stock_Item_Api/stock_api.dart';
// import 'package:ultimate_bundle/src/furney/src/Api/Stock_Item_Api/stock_warehouse_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/Stock_Item_Api/stock_warehouse_api.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/stock_item_modal.dart/stock_warehouse_modal.dart';
//import 'package:ultimate_bundle/src/furney/src/Modal/customer_bp/new_customer_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class StockWarehouse extends StatefulWidget {
  const StockWarehouse({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  StockWarehouseState createState() => StockWarehouseState();
}

class StockWarehouseState extends State<StockWarehouse> {
  static String? itemCode;
  static String? itemName;
  static String? qty;
  List<ItemWarehouseInfoCollection> itemWarehouse = [];
  List<ItemWarehouseInfoCollection> itemWarehouseFilter = [];
  int indexOFWarehouse=0;
  @override
  void initState() {
    super.initState();
     StockWarehouseAPi.itemcode = itemCode;
     print( StockWarehouseAPi.itemcode );
     StockWarehouseAPi.getGlobalData().then((value) {
      if(value.itemWarehouse!=null){
        setState(() {
           print(value.itemWarehouse![0].warehouseCode);
          itemWarehouse = value.itemWarehouse!;
          itemWarehouseFilter = itemWarehouse;
        });
        getWarehouse();
      }
     
    });
    
  }
  void getWarehouse(){
    print(GetValues.branch);
    print('length: '+itemWarehouse.length.toString());
    print('GetValues.branch: '+GetValues.branch!.toLowerCase());
    for(var i=0; i<itemWarehouse.length;i++){
      if(itemWarehouse[i].warehouseCode!.toLowerCase()==GetValues.branch!.toLowerCase()){
        print('warehouse: '+itemWarehouse[i].warehouseCode.toString());
        print('i: '+i.toString());
        setState(() {
          indexOFWarehouse = i;
        });
      }
     //  print("warehouse: "+itemWarehouse[i].warehouseCode!.toLowerCase().toString());
    }
  }
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: drawer(context),
      key: _scaffoldKey,
      appBar: appBar(context, _scaffoldKey, widget.title),
      body:
          itemWarehouse.length==0? Center(
            child:  SpinKitThreeBounce(
                          size: Screens.heigth(context)*0.06,
                          color:theme.primaryColor,
                        ),
          ):
          Padding(
        padding: EdgeInsets.only(
          top: Screens.heigth(context) * 0.02,
          left: Screens.width(context) * 0.02,
          bottom: Screens.heigth(context) * 0.02,
          right: Screens.width(context) * 0.02,
        ),
        child:
        //  Card(
        //   elevation: 6,
        //   child:
           Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Center(
                //   child: 
                SizedBox(
                   // alignment: Alignment.center,
                    width: Screens.width(context),
                    //color: Colors.greenAccent,
                    child:
                     Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          
                        //  color: Colors.red,
                          width: Screens.width(context)*0.28,
                          child: Text(
                            'Item Code: ',
                            style:  TextStyles.boldPC1(context),
                          ),
                        ),
                        
                        Container(
                         //   color: Colors.red,
                           alignment: Alignment.bottomLeft,
                          width: Screens.width(context)*0.6,
                          child: Text(
                            '$itemCode',
                            style:  TextStyles.boldPC1(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                // ),
                SizedBox(
                  height: Screens.heigth(context) * 0.02,
                ),
                 SizedBox(
                     width: Screens.width(context),
                    //color: Colors.greenAccent,
                   child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Screens.width(context) * 0.28,
                            //  color: Colors.greenAccent,
                            child: Text(
                              'Item Name: ',
                              style: TextStyles.headlineBlack1(context),
                            ),
                          ),
                          //                SizedBox(width: Screens.width(context) * 0.05),
                          Container(
                              alignment: Alignment.bottomLeft,
                            width: Screens.width(context) * 0.6,
                        //     color: Colors.redAccent,
                            child: Text(
                              '$itemName ',
                              style: TextStyles.headlineBlack1(context),
                            ),
                          ),
                        ],
                      ),
                 ),
                    SizedBox(
                      height: Screens.heigth(context) * 0.01,
                    ),
              Card(
                elevation: 6,
                child: Container(
                  padding: EdgeInsets.only(
                    top: Screens.heigth(context) * 0.02,
                    left: Screens.width(context) * 0.02,
                    bottom: Screens.heigth(context) * 0.02,
                    right: Screens.width(context) * 0.02,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(Screens.width(context) * 0.02),),
                  width: Screens.width(context),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // // Center(
                      // //   child: Container(
                      // //     alignment: Alignment.center,
                      // //     width: Screens.width(context),
                      // //     // color: Colors.greenAccent,
                      // //     child:
                      //      Row(
                      //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Container(
                                
                      //         //  color: Colors.red,
                      //           width: Screens.width(context)*0.28,
                      //           child: Text(
                      //             "Item Code: ",
                      //             style: GoogleFonts.poppins(
                      //               color: Colors.red[200],
                      //               fontSize: Screens.width(context) * 0.045,
                      
                      //               ///  fontWeight: FontWeight.bold
                      //             ),
                      //           ),
                      //         ),
                              
                      //         Container(
                      //          //   color: Colors.red,
                      //            alignment: Alignment.bottomLeft,
                      //           width: Screens.width(context)*0.6,
                      //           child: Text(
                      //             "$itemCode",
                      //             style: GoogleFonts.poppins(
                      //               color: Colors.red[200],
                      //               fontSize: Screens.width(context) * 0.045,
                      
                      //               ///  fontWeight: FontWeight.bold
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      // //   ),
                      // // ),
                      // SizedBox(
                      //   height: Screens.heigth(context) * 0.02,
                      // ),
                      // Container(
                      //   alignment: Alignment.center,
                      //   width: Screens.width(context),
                      //   // color: Colors.greenAccent,
                      //   child: Text(
                      //     "itemName",
                      //     style: GoogleFonts.poppins(
                      //       color: Colors.red[200],
                      //       fontSize: Screens.width(context) * 0.045,
                      
                      //       ///  fontWeight: FontWeight.bold
                      //     ),
                      //   ),
                      // ),
                      
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Container(
                      //       width: Screens.width(context) * 0.28,
                      //       //  color: Colors.greenAccent,
                      //       child: Text(
                      //         "Item Name: ",
                      //         style: GoogleFonts.poppins(
                      //           color: Colors.black54,
                      //           fontSize: Screens.width(context) * 0.035,
                      //           //  fontWeight: FontWeight.bold
                      //         ),
                      //       ),
                      //     ),
                      //     //                SizedBox(width: Screens.width(context) * 0.05),
                      //     Container(
                      //         alignment: Alignment.bottomLeft,
                      //       width: Screens.width(context) * 0.6,
                      //   //     color: Colors.redAccent,
                      //       child: Text(
                      //         "$itemName ",
                      //         style: GoogleFonts.poppins(
                      //           color: Colors.black54,
                      //           fontSize: Screens.width(context) * 0.035,
                      //           //  fontWeight: FontWeight.bold
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: Screens.heigth(context) * 0.01,
                      // ),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Screens.width(context) * 0.3,
                            //  color: Colors.greenAccent,
                            child: Text(
                              'Quantity: ',
                              style:TextStyles.headlineBlack1(context),
                            ),
                          ),
                          //                SizedBox(width: Screens.width(context) * 0.05),
                          Container(
                            alignment: Alignment.bottomRight,
                            width: Screens.width(context) *0.5,
                          //   color: Colors.redAccent,
                            child: Text(
                              '${itemWarehouseFilter[indexOFWarehouse].inStock} ',
                              style: TextStyles.headlineBlack1(context),
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
                            width: Screens.width(context) * 0.35,
                             // color: Colors.greenAccent,
                            child: Text(
                              'WarehouseCode: ',
                              style:TextStyles.headlineBlack1(context),
                            ),
                          ),
                          //                SizedBox(width: Screens.width(context) * 0.05),
                          Container(
                            alignment: Alignment.bottomRight,
                            width: Screens.width(context) * 0.5,
                            // color: Colors.redAccent,
                            child: Text(
                              '${itemWarehouseFilter[indexOFWarehouse].warehouseCode}',
                              style:TextStyles.headlineBlack1(context),
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
                            width: Screens.width(context) * 0.3,
                            //  color: Colors.greenAccent,
                            child: Text(
                              'Committed: ',
                              style: TextStyles.headlineBlack1(context),
                            ),
                          ),
                          //                SizedBox(width: Screens.width(context) * 0.05),
                          Container(
                            alignment: Alignment.bottomRight,
                            width: Screens.width(context) * 0.5,
                          //   color: Colors.redAccent,
                            child: Text(
                              '${itemWarehouseFilter[indexOFWarehouse].committed}',
                              style:TextStyles.headlineBlack1(context),
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
                            width: Screens.width(context) * 0.3,
                            //  color: Colors.greenAccent,
                            child: Text(
                              'Ordered: ',
                              style:TextStyles.headlineBlack1(context),
                            ),
                          ),
                          //                SizedBox(width: Screens.width(context) * 0.05),
                          Container(
                            alignment: Alignment.bottomRight,
                            width: Screens.width(context) * 0.5,
                          //   color: Colors.redAccent,
                            child: Text(
                              '${itemWarehouseFilter[indexOFWarehouse].ordered}',
                              style:TextStyles.headlineBlack1(context),
                            ),
                          ),
                        ],
                      ),              
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
   //   ),
    );
  }
}
