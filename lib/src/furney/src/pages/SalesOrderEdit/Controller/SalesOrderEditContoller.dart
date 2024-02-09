// // ignore_for_file: avoid_void_async, omit_local_variable_types, prefer_single_quotes, avoid_print, unawaited_futures, prefer_interpolation_to_compose_strings, unnecessary_statements

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/items_api/items_api.dart';
// import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/items_api/mainsubApi/mainGroup.dart';
// import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/items_api/mainsubApi/subGroup.dart';
// import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/item_modal/item_modal.dart';
// import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/item_modal/mainsubModal/mainModal.dart';
// import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/item_modal/mainsubModal/subModal.dart';
// import 'package:ultimate_bundle/src/furney/src/pages/SalesOrderEdit/Models/SalesORderModel.dart';
// import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/creation/content_order_creation.dart';
// import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

// class SalesOrfderEditController extends ChangeNotifier{
// late SalesModel salesData;
//  LocationPermission? permission;
//   String? latitude;
//   String? longitude;
//   bool isloading = true;
//   List<TextEditingController> mycontroller =List.generate(15, (i) => TextEditingController());


//   void currentDate() {
//     final DateTime now = DateTime.now();
//       salesData.docDate ="${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
//   }

//   void init() {
//     currentDate();
//     getLocation();
//   }

//   void getLocation() async {
//     final bool checkper = await checkPermision();

//     if (checkper == false) {
//       showsnb("give location permission to crm app & turn on the Location!!");
//     } else if (checkper == true) {
//       final bool isa = await isLocationAvailable();
//       if (isa == false) {
//         showsnb('give location permission to crm app & turn on the Location!!');
//       } else if (isa == true) {
//         final Position pos = await Geolocator.getCurrentPosition();
//         latitude = pos.latitude.toString();
//         longitude = pos.longitude.toString();
//           isloading = false;
//       }
//     }
//   }

//   Future<bool> checkPermision() async {
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       return Future.value(false);
//     } else if (permission == LocationPermission.deniedForever) {
//       permission = await Geolocator.requestPermission();
//       return Future.value(false);
//     } else if (permission == LocationPermission.unableToDetermine) {
//       permission = await Geolocator.requestPermission();
//       return Future.value(false);
//     } else if (permission == LocationPermission.always) {
//       permission = await Geolocator.requestPermission();
//       return Future.value(true);
//     }
//     return Future.value(false);
//   }

//   void showsnb(String msg) {
//     Get.defaultDialog(
//       title: 'Alert',
//       middleText: msg,
//       //'Please give location permission to crm app & turn on the Location!!..'
//     );
    
//     Future.delayed(const Duration(seconds: 3),
//       () => Get.back<dynamic>(),
//     );
//   }

//   Future<bool> isLocationAvailable() async {
//     bool? serviceEnabled;
//     try {
//       serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (serviceEnabled == true) {
//         //  print("serviceEnabled1111 $serviceEnabled");
//         return Future.value(true);
//       } else if (serviceEnabled == false) {
//         //  print("serviceEnabled2222 $serviceEnabled");

//         return Future.value(false);
//       }
//     } catch (e) {
//       showsnb("Please turn on the Location!!..");
//       Future.delayed(
//         const Duration(seconds: 2),
//         () => Get.back<dynamic>(),
//       );
//     }
//     return Future.value(false);
//   }


// // ! *** CONTENT PAGE FUNCTIONS ***

//   PageController pageController = PageController();
//   int pageChanged = 0;
//   bool visibleBtn = true;
//   List<AddItem> itemsDetails = [];
//   List<TextEditingController> textcontCont =List.generate(15, (i) => TextEditingController());
//   GlobalKey<FormState> itemChooseValidateKey = GlobalKey<FormState>();
//   GlobalKey<FormState> mainGropValidate = GlobalKey<FormState>();
//   String? valueSelectedMain;
//   String? valueSelectedSub;
//   String? selectedTax;
//   bool error = false;
//   List<String> taxData = [
//      'O0 - 0 % Output VAT',
//      "O1 - 18 % Output VAT",
//      "O3 - Exempted Output VAT",
//      "X0 - Exempt Output",
//   ];

//   List<MainModalValue> mainValueValue = [];
//   List<SubModalValue> subValueValue = [];
//   bool loadItemValues = false;
//   List<ItemValue> itemValue = [];
//   List<ItemValue> filteritemValue = [];


//   initContent()async{
//    await callMainSubGrp();
//   }


//   callMainSubGrp()async{
//      await MainGroupAPi.getGlobalData().then((value) {
//         if(value.itemValueValue!= null){
//           mainValueValue = value.itemValueValue!;

//         }
       
//     });

//   await  SubGroupAPi.getGlobalData().then((value) {
//       if(value.itemValueValue!= null){
//           subValueValue = value.itemValueValue!;
//       }
//         });
     
//   }

//   void valuesAdd()async {
//       ItemsAPi.mainGroup = valueSelectedMain;
//       ItemsAPi.subGroup = valueSelectedSub;
//       ItemsAPi.searchData = mycontroller[7].text;
//       loadItemValues = true;
//     await  ItemsAPi.getGlobalData(mycontroller[8].text).then((value) {
//           if (value.itemValueValue!.isNotEmpty) {
//             itemValue = value.itemValueValue!;
//             filteritemValue = itemValue;
//             loadItemValues = false;

//           } else if (value.itemValueValue!.isEmpty) {
//             loadItemValues = false;
           
//           }
//       });
//   }


//   // ! *** ADD ITEMS CODE ****

//   bool loadingscrn = false;

//     void setValuesToListPage(int i) {
//     double price = double.parse(mycontroller[1].text);
//     int qty = int.parse(mycontroller[2].text);
//     double discountper =
//         double.parse(mycontroller[3].text == '' ? "0" : mycontroller[3].text);
//     double discount = (price * qty) * discountper / 100;
//     double taxper =  selectedTax== 'O1 - 18 % Output VAT'?18.00:0.00;

//     double taxs = ((qty * price) - discount)* taxper / 100;
//    double total = (qty * price)- discount; //- discount) + taxs
//     total=total+taxs;

//     double bfd = (qty * price); 


//     int carton1 = 0;
//     print("tax: " + taxs.toStringAsFixed(0));
//     if (filteritemValue[i].U_Pack_Size! < 10 &&
//         filteritemValue[i].U_Tins_Per_Box! > 0) {
//       carton1 = qty ~/ filteritemValue[i].U_Tins_Per_Box!;
//     }

//     double valueAFdisc1 = (qty * price) - discount;
//     itemsDetails.add(AddItem(
//         itemCode: filteritemValue[i].itemCode.toString(),
//         itemName: filteritemValue[i].itemName.toString(),
//         discount: discount,
//         price: price,
//         qty: qty,
//         total: total,
//         tax: taxs,
//         valueBFdisc: bfd,
//         valuechoosed: selectedTax,
//         taxCode: getTaxCode(selectedTax!),
//         discounpercent: discountper.toDouble(),
//         wareHouseCode: GetValues.branch,
//         taxName: selectedTax,
//         carton: carton1,
//         U_Pack_Size: filteritemValue[i].U_Pack_Size,
//         U_Tins_Per_Box: filteritemValue[i].U_Tins_Per_Box,
//         valueAFdisc: valueAFdisc1,
//         taxPer: getPercent(selectedTax!)));
//     pageController.animateToPage(--pageChanged,
//         duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
//     sumofTotal();
//      loadingscrn = false;
//   }

//   //  double getTaxValue(String taxname){
//   //     double res = 0.0;
//   //     for(int i=0; i<taxData.length; i++){
//   //       if(taxname == taxData[i]){
//   //         res
//   //       }
//   //     }
//   //   }

//    String getTaxCode(String taxname){
//      return   taxname == "O1 - 18 % Output VAT"?"O1":
//          taxname == "O3 - Exempted Output VAT"?"O3":
//          taxname == "X0 - Exempt Output"?"X0":
//          "O0";
//     }
    
//     double  getPercent(String s) {
//         return   s == "O1 - 18 % Output VAT"?18.00:0.00;
//       }

// }