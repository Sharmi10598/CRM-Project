// ignore_for_file: noop_primitive_operations, omit_local_variable_types, prefer_interpolation_to_compose_strings, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/notes_api/notesapi.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/notes_modal/notes_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/notes/screen/notes_details.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  NotesPageState createState() => NotesPageState();
}

class NotesPageState extends State<NotesPage> {
  List<NotesData> notesData=[];
   List<NotesData> filterNotesData=[];
   ScrollController scrollController = ScrollController();
  int lenthofList=0;
  int minuslength=0;
   List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  @override
  void initState() {
    NotesAPi.getGlobalData().then((value) {
      if(value.notesData != null){
        setState(() {
           print(value.notesData![0].HeaderId);
         notesData = value.notesData!;
         print('read: '+notesData[0].read.toString());
         filterNotesData = notesData;
        });
        
      }else if (value.error != null) {
        final snackBar = SnackBar(
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          content: Text(
            '${value.error}!!..',
            style: const TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }else if(value.notesData == null){
            const snackBar = SnackBar(
            backgroundColor: Colors.red,
          content: Text(
            'There is no notes!!..',
            style: TextStyle(color: Colors.white),
          ),
        );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Future.delayed(const Duration(seconds: 5),(){
         Navigator.pop(context);
      });
      }
     
    });
  }

   @override
   void dispose() {
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
   DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    final DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
       print('are you sure');
  //   Get.offAllNamed<dynamic>(FurneyRoutes.home);
      return Future.value(true);
    }
   //  Get.offAllNamed<dynamic>(FurneyRoutes.home);
      return Future.value(true);
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return
        WillPopScope(
          onWillPop:onbackpress ,
          child: Scaffold(
           // backgroundColor: Colors.grey[200],
       key: _scaffoldKey,
      drawer: drawer(context),
      appBar: appBar(context, _scaffoldKey, widget.title),
      //  ),

      body:
            notesData.isEmpty? Center(
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
              bottom: Screens.width(context) * 0.01,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        filterNotesData = notesData
                            .where((e) =>
                                e
                                    .MsgHeading!
                                    .toLowerCase()
                                    .contains(v.toLowerCase()) ||
                                e
                                    .MsgDescription!
                                    .toLowerCase()
                                    .contains(v.toLowerCase()),)
                            .toList();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for Notes',
                      hintStyle: TextStyles.bodytextBlack1(context),
                      // AppLocalizations.of(context)!
                      //     .search_sales_quot,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          // SalesQuotAPi.searchValue = mycontroller[0].text;
                        setState(() {
                          // quotData.clear();
                          // quotDataFilter.clear();
                          });
                        
                          // SalesQuotAPi.searchData().then((value) {
                          //       if(value.salesQuotValue!=null){
                          //         setState(() {
                          //           print(value.salesQuotValue![0].docEntry);
                          //           // quotData = value.salesQuotValue!;
                          //           // quotDataFilter =quotData;
                          //         });
                          //       }
                          // });
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
                //       setAllNull();
                //        Get.toNamed<dynamic>(FurneyRoutes.creationDetails);
                //     }, icon: Icon(Icons.add,
                //     color: theme.primaryColor,
                //     size: Screens.width(context)*0.08,
                //     )))   
                ],
              ),
               Expanded(
                child: ListView.builder(
                  controller: scrollController,
                    itemCount:filterNotesData.length,
                    itemBuilder: (context, i) {
                      // if(i ==filteritemValue.length-1 ){
                      //   if(mycontroller[0].text.isEmpty){
                      //     print("1111111");
                      //             return SpinKitThreeBounce(
                      //           size: Screens.width(context)*0.06,
                      //           color:theme.primaryColor,
                      //         );
                      //   }   
                             // }
                      return Card(
                        color:filterNotesData[i].IsSeen=='0'?Colors.white:Colors.grey[200] ,
                          elevation: 8,
                          child: InkWell(
                            onTap: () {
                      NotesDetailsState.heading = filterNotesData[i].MsgHeading;
                      NotesDetailsState.description = filterNotesData[i].MsgDescription;
                        Get.toNamed<dynamic>(FurneyRoutes.notesDetails);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical:Screens.heigth(context)*0.01,
                              horizontal: Screens.width(context)*0.02,
                              ),
                 // height: Screens.heigth(context)*0.07,
                 width: Screens.width(context),
                  decoration: const BoxDecoration(
                      // color:Colors.green,
                     // borderRadius: BorderRadius.circular(Const.radius),
                    // border: Border.all(color: Colors.black)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(//row 1
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              //color: Colors.greenAccent,
                                width: Screens.width(context)*0.7,
                              child: Text(
                             '${filterNotesData[i].MsgHeading}',
                              style: TextStyles.boldPC1(context),),
                            ),
                              SizedBox(height: Screens.heigth(context)*0.01,),
                            SizedBox(
                             //  color: Colors.blue,
                                  width: Screens.width(context)*0.7,
                              child: Text(
                                '${filterNotesData[i].MsgDescription}',
                                maxLines: 2,
                            //    softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              style: TextStyles.headlineBlack1(context),),
                            )
                          ],
                        ),
                        SizedBox(
                          width: Screens.width(context)*0.16,
                       //   color: Colors.red,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Icon(Icons.chevron_right_outlined,
                                color: theme.primaryColor,
                                size: Screens.width(context)*0.1,
                                ),
                              ),
                              Container(
                                child: Text('${filterNotesData[i].CreatedDate}',
                                style:TextStyles.bodytextBlack2(context),
                                ),
                              ),
                                 Container(
                                child: Text('${filterNotesData[i].CreatedTime}',
                                style: TextStyles.bodytextBlack2(context),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
              ),
                          ),);
                    },),
              ),
            ],
          ),
      ),),
    ),
        );
  }
}
