
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/custom_app_bar.dart';

class FurneyAllProductScreen extends StatefulWidget {
  const FurneyAllProductScreen({Key? key}) : super(key: key);
  @override
  _FurneyAllProductScreenState createState() => _FurneyAllProductScreenState();
}

class _FurneyAllProductScreenState extends State<FurneyAllProductScreen> {
  String _title = '';

  @override
  void initState() {
    super.initState();
    _title = Get.arguments as String;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        title: _title,
      ),
      body:
      Padding(
        padding: const EdgeInsets.only(left:10,right:10,),
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context,i){
          return Card(
            elevation: 8,
            child:InkWell(
              onTap: (){
                showbottomsheet(context ,i);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Center(
                  //   child: 
               
                  SizedBox(height: Screens.heigth(context) *0.02),
                  Row(
                //    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                   Image.asset(
                  'assets/CRM/logo.png',
                  width: 80,
                  height:80,
                  color: Colors.red,
                ),
                SizedBox(width:Screens.width(context) *0.08),
                           Column(
                             crossAxisAlignment:CrossAxisAlignment.start,
                             children: [
                               Text('$_title ${i+1}',
                    style: GoogleFonts.poppins(
                      color:Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                     Text('Task: task no 1',
                    style: GoogleFonts.poppins(
                      color:Colors.black87,
                      fontSize: 15,
                    ),
                    ),
                             ],
                           ),
                    ],
                  )
                ],
              ),
            ),
          );
        },),
      ),
      //  StaggeredGridView.countBuilder(
      //   itemCount: ProductList.bestSellerList.length,
      //   crossAxisCount: 4,
      //   staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
      //   mainAxisSpacing: 15,
      //   crossAxisSpacing: 15,
      //   shrinkWrap: true,
      //   physics: const ScrollPhysics(),
      //   padding: const EdgeInsets.symmetric(
      //     horizontal: 18,
      //   ),
      //   itemBuilder: (context, index) {
      //     final product = ProductList.bestSellerList[index];
      //     return ProductCard(
      //       product: product,
      //       cardType: ProductCardType.horizontal,
      //     );
      //   },
      // ),
    );
  }

      Future<void> showbottomsheet(BuildContext context,int i) {
    return showModalBottomSheet<void>(
          context: context,
          builder: (builder){
            return  Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Form(
           // key: formkey[2],
            child: SizedBox(
              height:  Screens.heigth(context) * 0.2,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              Text('$_title ' '${i+1}',
                 style: GoogleFonts.poppins(
                    color:Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),),
              SizedBox(
                height: Screens.heigth(context) * 0.015,
              ),
               Text('Description ....',
                 style: GoogleFonts.poppins(
                    color:Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),),
                    SizedBox(
                height: Screens.heigth(context) * 0.02,
              ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                             
                                Navigator.pop(context);
                         
                            },
                            child: const Text('Reject'),),
                        ElevatedButton(
                            onPressed: () {
                        
                            },
                            child: const Text('Approve'),),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
            );
          },
      );
  }
}
