// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/approvals_api/approvals_details_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_quotations_api/approvals_quot_api/approvals_quotApi.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/sales_quot/approvals_quot_modal/approvals_quot_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/showdetails/Approvals_details_quot.dart';

class ApprovalsQuotDetails extends StatefulWidget {
  const ApprovalsQuotDetails({ Key? key, }) : super(key: key);
  @override
  ApprovalsQuotDetailsState createState() => ApprovalsQuotDetailsState();
}

class ApprovalsQuotDetailsState extends State<ApprovalsQuotDetails> {
  List<ApprovalsQuotValue> approvalsQuotValues=[];
   List<ApprovalsQuotValue> filterapprovals=[];
    @override
  void initState() {
    ApprovalsQuotAPi.getGlobalData().then((value) {
      if(value.approvalsQuotValue!.isNotEmpty){
        if(mounted){
          setState(() {
          print(value.approvalsQuotValue![0].cardName);
          approvalsQuotValues = value.approvalsQuotValue!;
           filterapprovals = approvalsQuotValues;
           isApprovalLengthnull = false;
      });
        }
      }else if(value.approvalsQuotValue!.isEmpty){
        setState(() {
            isApprovalLengthnull = false;
        });
          const snackBar = SnackBar(
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
          content: Text(
            'There is no Approved to show!!..',
            style: TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //    Future.delayed(const Duration(seconds: 5),(){
         
      // });
      }
    });
  }

   @override
   void dispose() {
    super.dispose();
  }
   bool isLoading = false;
   bool isApprovalLengthnull = true;
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return 
    Scaffold(
      backgroundColor: Colors.grey[200],
      body: isApprovalLengthnull == true? Center(
              child:  SpinKitThreeBounce(
                            size: Screens.heigth(context)*0.06,
                            color:theme.primaryColor,
                          ),
            ):
       SafeArea(
              child: Padding(
               padding: EdgeInsets.only(
              left: Screens.width(context) * 0.02,
              right: Screens.width(context) * 0.02,
              top: Screens.heigth(context) * 0.01,
             // bottom: Screens.width(context) * 0.01
              ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                       Stack(
                children:[ 
                  Container(
                  height: Screens.heigth(context) * 0.06,
                  decoration: BoxDecoration(
                    color: theme.hintColor.withOpacity(.05),
                    borderRadius: BorderRadius.circular(Const.radius),
                  ),
                  child: TextField(
                   controller: mycontroller[0],
                    autocorrect: false,
                    style: theme.textTheme.bodyMedium,
                    onChanged: (v) {
                      setState(() {
                        filterapprovals = approvalsQuotValues
                            .where((e) =>
                                e
                                    .cardName!
                                    .toLowerCase()
                                    .contains(v.toLowerCase()) ||
                                e
                                    .cardCode!
                                    .toLowerCase()
                                    .contains(v.toLowerCase()),)
                            .toList();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for Approvals',
                      hintStyle: TextStyles.bodytextBlack1(context),
                      // AppLocalizations.of(context)!
                      //     .search_sales_quot,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                        //    SalesQuotAPi.searchValue = mycontroller[0].text;
                        // setState(() {
                        //   quotData.clear();
                        //   quotDataFilter.clear();
                        //   });
                        
                        //   SalesQuotAPi.searchData().then((value) {
                        //         if(value.salesQuotValue!=null){
                        //           setState(() {
                        //             print(value.salesQuotValue![0].docEntry);
                        //             quotData = value.salesQuotValue!;
                        //             quotDataFilter =quotData;
                        //           });
                        //         }
                        //   });
                        }, //
                        color: theme.primaryColor,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 5,
                      ),
                    ),
                  ),
                ),
                //  Positioned(
                //     left: Screens.width(context)*0.8,
                //     child: IconButton(onPressed: (){
                //       //print("object");
                    
                //       // Get.toNamed<dynamic>(FurneyRoutes.creationDetails);
                //     }, icon: Icon(Icons.add,
                //     color: theme.primaryColor,
                //     size: Screens.width(context)*0.08,
                //     )))   
                ],
              ),

              SizedBox(
                //width: Screens.width(context),
              //  maxHeight: Screens.heigth(context)*0.67,
                height: Screens.heigth(context)*0.74,
                //color: Colors.red,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: filterapprovals.length,
                        itemBuilder: (c,i){
                        return InkWell(
                          onTap:(){
                            ApprovalsDetailsQuotState.docTypeName =  filterapprovals[i].ObjType.toString().contains('13')?'A/R Invoice':
                                                   filterapprovals[i].ObjType.toString().contains('23')?'Sales Quotation':
                                                    filterapprovals[i].ObjType.toString().contains('17')?'Sales Order':
                                                     filterapprovals[i].ObjType.toString().contains('14')?'Sales Return':
                                                     filterapprovals[i].ObjType.toString().contains('15')?'Deliveries':'';
                            ApprovalsDetailsAPi.draftEntry = filterapprovals[i].docEntry.toString();
                            Get.toNamed<dynamic>(FurneyRoutes.approvalsDetailsSalesQuot);
                          },
                          child: Card(
                            child: Container(
                               padding: EdgeInsets.symmetric(horizontal: Screens.width(context)*0.01),
                                  child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                            Row(//row 1
                             //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Container(
                                //   width: Screens.width(context)*0.01,
                                //  height: double.infinity,
                                //   color: Colors.blue,
                                // ),
                                //SizedBox(width: Screens.width(context)*0.01,),
                                SizedBox(
                               ///  color: Colors.greenAccent,
                                    width: Screens.width(context)*0.2,
                                  child: Text('${filterapprovals[i].cardCode}',
                                  style: TextStyles.bodytextBlack1(context),),
                                ),
                                 SizedBox(width: Screens.width(context)*0.01,),
                                SizedBox(
                                //   color: Colors.blue,
                                    width: Screens.width(context)*0.4,
                                  child: Text('${filterapprovals[i].cardName}',
                                  style: TextStyles.bodytextBlack1(context),),
                                )
                              ],
                            ),
            
                            Padding(
                              padding:  EdgeInsets.only(top:Screens.width(context)*0.02),
                              child: Row(
                                children: [
                                  Container(
                                    alignment: Alignment.centerRight,
                                 //    color: Colors.red,
                                    width: Screens.width(context)*0.22,
                                    child: Column(
                                      children: [
                                        Text(
                                       '${filterapprovals[i].docEntry}' , style:TextStyles.bodytextBlack1(context),),
                                        Text('${filterapprovals[i].DocDate}' ,style: TextStyles.bodytextBlack1(context),),
                                      ],
                                    ),
                                  ),
                                  Icon(Icons.chevron_right,
                                  color:  theme.primaryColor,)
                                ],
                              ),
                            )
                      ],
                    ),
                            ),
                          ),
                        );
                      },),
                    ),
                  ],
                ),
              ),
            //     Container(
            //    // width: Screens.width(context),
            //     height: Screens.heigth(context)*0.06,
            //     //color: Colors.green,
            //     child: CustomSpinkitdButton(
            //   onTap: () async {
            //     //callServiceLayerApi();
            //   },
            //   isLoading: isLoading,
            // //  labelLoading: AppLocalizations.of(context)!.signing,
            //   label: 'Save',
            // ),
            //   ),
                  ],
                ),
              ),
            ),
    );
  }
 
}