// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, omit_local_variable_types, unawaited_futures, prefer_single_quotes, prefer_interpolation_to_compose_strings, unnecessary_string_interpolations

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ultimate_bundle/helpers/constants.dart';

class UIKitModel {
  final String? name;
  final int? totalScreen;
  final String? image;
  final VoidCallback? navigation;

  UIKitModel({this.name, this.totalScreen, this.image, this.navigation});
}


class Config {

  Future<void> showDialog(String msg,String title) async{
      Get.defaultDialog<void>(
        title: title,
        content: Container(
          child: Column(
            children: [
              Text(msg),
            ],
          ),
        ),
      );
  }
 

    void showDialogSucessB(String msg,String title){
      Get.defaultDialog<void>(
        title: title,
        content: Container(
          child: Column(
            children: [
              Text(msg),
            ],
          ),
        ),
      ).then((value) {
        Get.back<void>();
      });
  }

    void showDialogSucessDB(String msg,String title){
      Get.defaultDialog<void>(
        title: title,
        content: Container(
          child: Column(
            children: [
              Text(msg),
            ],
          ),
        ),
      ).then((value) {
        Get.offAllNamed<dynamic>(FurneyRoutes.home);
      });
  }
   
      String alignDate(String date) {
   final String dateT = date.replaceAll("T", "");
    final dates = DateTime.parse(date);
    print(
        "${dates.day.toString().padLeft(2, '0')}-${dates.month.toString().padLeft(2, '0')}-${dates.year}",);
    return "${dates.day.toString().padLeft(2, '0')}-${dates.month.toString().padLeft(2, '0')}-${dates.year}";
  }
   String alignDate2(String date) {
  //  String dateT = date.replaceAll("T", "");
 if(date=='null'){
  return '';
 }
    final dates = DateTime.parse(date);
    return "${dates.day.toString().padLeft(2, '0')}-${dates.month.toString().padLeft(2, '0')}-${dates.year}";
  }

   String convertintToTime(int value){
  final String data = value.toString();
  String retunData = '';
  for(int i=0; i<data.length; i++ ){
    if(data.length == 3){
       if(i == 0 ){
          
        retunData = retunData + data[i]+ ":";
  
       }else{
        retunData = retunData  +data[i] ;
      }
       //else{
      //    if(i.isEven){
      //   retunData = retunData + data[i];
      // }else{
      //   retunData = retunData  +data[i] + ":";
      // }
      // }
    }
  else  if(data.length == 4){
      if(i == data.length -1){
           if(i.isEven){
        retunData = retunData + data[i];
      }else{
        retunData = retunData  +data[i] ;
      }
      }else{
         if(i.isEven){
        retunData = retunData + data[i];
      }else{
        retunData = retunData  +data[i] + ":";
      }
      }
     
      
    }else if (data.length == 6){
         if(i == data.length -1){
           if(i.isEven){
        retunData = retunData + data[i];
      }else{
        retunData = retunData  +data[i] ;
      }
      }else{
         if(i.isEven){
        retunData = retunData + data[i];
      }else{
        retunData = retunData  +data[i] + ":";
      }
      }
    }
  }

  return retunData;
  }
String currentDate() {
    final DateTime now = DateTime.now();

    final String currentDateTime =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    print("date: " + currentDateTime);
    return currentDateTime;
  }
      String currentDateTimeServer() {
    final DateTime now = DateTime.now();
    return
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
   
  }

    String currentTimeServer() {
    final DateTime now = DateTime.now();
    return
          "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
   
  }

 Future<bool> haveInterNet()async{
     final result = await Connectivity().checkConnectivity();
    final hasInternet = result != ConnectivityResult.none;
    return hasInternet;
  }

 int checkedinExpired(String date){
  final String onlydate = date.replaceAll("T", "").replaceAll(":", "").replaceAll("00",""); 
  // List<String> data =  onlydate.split("-");
  // String fromDate = '';
  // for(int i= (data.length-1) ; i>0; i--){
  //    // data
  //    fromDate = fromDate + data[i] ;
  //    log(data[i]);
  // }
  final parsedDate = DateTime.parse('$onlydate');//2023-05-30
  final int value  =   daysBetween(parsedDate);
  return value;
  }
  
   int daysBetween(DateTime from) {
    final DateTime fromDate = DateTime(from.year, from.month, from.day);
final DateTime to = DateTime.now();
  final DateTime   toDate = DateTime(to.year, to.month, to.day);
   return (toDate.difference(fromDate).inHours / 24).round();
  }   

}

// List<UIKitModel> allFullUIKitList(BuildContext context) => [
//   // UIKitModel(
//   //   name: 'Barbera | Barbershop UI Kit',
//   //   totalScreen: 45,
//   //   image: 'https://i.pinimg.com/originals/0e/e7/d0/0ee7d06bc78e5080a768c36c4a915b99.jpg',
//   //   navigation: (){
//   //     context.read<ThemeProvider>().themeUIKit = ThemeUIKit.barbera;
//   //     Get.toNamed<dynamic>(UIKitRoutes.barbera);
//   //   },
//   // ),
//   UIKitModel(
//     name: 'Bellcommerce | eCommerce UI Kit',
//     totalScreen: 27,
//     image: 'https://i.pinimg.com/originals/34/7d/7c/347d7cb503e27652e3f105b7029fcbf3.jpg',
//     navigation: (){
//       context.read<ThemeProvider>().themeUIKit = ThemeUIKit.bellcommerce;
//       Get.toNamed<dynamic>(UIKitRoutes.bellcommerce);
//     },
//   ),
//   UIKitModel(
//     name: 'Lestate | Real Estate UI Kit',
//     totalScreen: 22,
//     image: 'https://i.pinimg.com/originals/0e/55/69/0e556999465b2a7c7bcf41a0bc7f5a79.jpg',
//     navigation: (){
//       context.read<ThemeProvider>().themeUIKit = ThemeUIKit.lestate;
//       Get.toNamed<dynamic>(UIKitRoutes.lestate);
//     },
//   ),
//   UIKitModel(
//     name: 'Treshop | eCommerce UI Kit',
//     totalScreen: 35,
//     image: 'https://i.pinimg.com/originals/1b/aa/02/1baa0236ece6195c327b7b46a4ce6805.jpg',
//     navigation: (){
//       context.read<ThemeProvider>().themeUIKit = ThemeUIKit.treshop;
//       Get.toNamed<dynamic>(UIKitRoutes.treshop);
//     },
//   ),
//   UIKitModel(
//     name: 'Foodiy | Food Market UI Kit',
//     totalScreen: 18,
//     image: 'https://i.pinimg.com/originals/08/c1/4d/08c14d960cd220c339c3cbeef7e1bc2b.jpg',
//     navigation: (){
//       context.read<ThemeProvider>().themeUIKit = ThemeUIKit.foodiy;
//       Get.toNamed<dynamic>(UIKitRoutes.foodiy);
//     },
//   ),
//   UIKitModel(
//     name: 'Furney | Furniture UI Kit',
//     totalScreen: 25,
//     image: 'https://i.pinimg.com/originals/f1/95/2d/f1952df4225c1ea082ba9f7d99ffa80a.jpg',
//     navigation: (){
//       context.read<ThemeProvider>().themeUIKit = ThemeUIKit.furney;
//       Get.toNamed<dynamic>(UIKitRoutes.furney);
//     },
//   ),
//   UIKitModel(
//     name: 'Coffiy | Coffee Shop UI Kit',
//     totalScreen: 20,
//     image: 'https://i.pinimg.com/originals/11/a6/67/11a6679e6a2732987d5a6b672c1cf4cc.jpg',
//     navigation: (){
//       context.read<ThemeProvider>().themeUIKit = ThemeUIKit.coffiy;
//       Get.toNamed<dynamic>(UIKitRoutes.coffiy);
//     },
//   ),
//   UIKitModel(
//     name: 'Shuppy | eCommerce UI Kit',
//     totalScreen: 23,
//     image: 'https://i.pinimg.com/originals/12/c1/c1/12c1c15ca0e9e37d37a2acfe6450ee1a.jpg',
//     navigation: (){
//       context.read<ThemeProvider>().themeUIKit = ThemeUIKit.shuppy;
//       Get.toNamed<dynamic>(UIKitRoutes.shuppy);
//     },
//   ),
//   UIKitModel(
//     name: 'Belila | eCommerce UI Kit',
//     totalScreen: 34,
//     image: 'https://i.pinimg.com/originals/61/c1/7b/61c17be168dc6131af7bc90665e8ed93.jpg',
//     navigation: (){
//       context.read<ThemeProvider>().themeUIKit = ThemeUIKit.belila;
//       Get.toNamed<dynamic>(UIKitRoutes.belila);
//     },
//   ),
//   UIKitModel(
//     name: 'Movlix | Movie App UI Kit',
//     totalScreen: 7,
//     image: 'https://i.pinimg.com/originals/c8/47/cf/c847cf6621a1b9085e5b0678ba7637c4.jpg',
//     navigation: (){
//       context.read<ThemeProvider>().themeUIKit = ThemeUIKit.movlix;
//       Get.toNamed<dynamic>(UIKitRoutes.movlix);
//     },
//   ),
// ];


// List<UIKitModel> allOnboardingList(BuildContext context) => [
//   UIKitModel(
//     name: 'On boarding 1',
//     navigation: (){
//       Get.toNamed<dynamic>(OnBoardingRoutes.onboarding1);
//     }
//   ),
//   UIKitModel(
//     name: 'On boarding 2',
//     navigation: (){
//       Get.toNamed<dynamic>(OnBoardingRoutes.onboarding2);
//     }
//   ),
//   UIKitModel(
//     name: 'On boarding 3',
//     navigation: (){
//       Get.toNamed<dynamic>(OnBoardingRoutes.onboarding3);
//     }
//   ),
//   UIKitModel(
//     name: 'On boarding 4',
//     navigation: (){
//       Get.toNamed<dynamic>(OnBoardingRoutes.onboarding4);
//     }
//   ),
//   UIKitModel(
//     name: 'On boarding 5',
//     navigation: (){
//       Get.toNamed<dynamic>(OnBoardingRoutes.onboarding5);
//     }
//   ),
//   UIKitModel(
//     name: 'On boarding 6',
//     navigation: (){
//       Get.toNamed<dynamic>(OnBoardingRoutes.onboarding6);
//     }
//   ),
//   UIKitModel(
//     name: 'On boarding 7',
//     navigation: (){
//       Get.toNamed<dynamic>(OnBoardingRoutes.onboarding7);
//     }
//   ),
//   UIKitModel(
//     name: 'On boarding 8',
//     navigation: (){
//       Get.toNamed<dynamic>(OnBoardingRoutes.onboarding8);
//     }
//   ),
//   UIKitModel(
//     name: 'On boarding 9',
//     navigation: (){
//       Get.toNamed<dynamic>(OnBoardingRoutes.onboarding9);
//     }
//   ),
// ];
