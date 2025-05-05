import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:ultimate_bundle/src/furney/src/Api/customer_bp/customer_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/customer_bp/customer_api.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/customer_bp/new_customer_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';

class MyDialog extends StatefulWidget {
  const MyDialog({Key? key}) : super(key: key);

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  List<CustomerDetailsValue> customerData = [];
  List<CustomerDetailsValue> customerDataFilter = [];
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    // print("alert dialog");
    GetCustomerAPi.getGlobalData().then((value) {
      setState(() {
        // customerData = value.value!;
        // customerDataFilter = customerData;
        print('leng...${customerData.length}');
        // print("cardcode: " + customerData[0].cardCode.toString());
        // print("cardname: " + customerData[1].cardCode.toString());
      });
    });
    //  method();
  }

  void method() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = true);
      // Get.offAllNamed<dynamic>(FurneyRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      content: SizedBox(
        //  color: Colors.black12,
        height: Screens.heigth(context) * 0.4,
        width: Screens.width(context) * 0.8,
        child: customerData.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    height: Screens.heigth(context) * 0.06,
                    decoration: BoxDecoration(
                      color: theme.hintColor.withOpacity(.05),
                      borderRadius: BorderRadius.circular(Const.radius),
                    ),
                    child: TextField(
                      //  controller: searchController,
                      autocorrect: false,
                      style: theme.textTheme.bodyMedium,
                      onChanged: (v) {
                        setState(() {
                          // customerDataFilter = customerData
                          //     .where((e) =>
                          //         (e)
                          //             .cardName!
                          //             .toLowerCase()
                          //             .contains(v.toLowerCase()) ||
                          //         (e)
                          //             .cardCode!
                          //             .toLowerCase()
                          //             .contains(v.toLowerCase()))
                          //     .toList();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search for Customer',
                        // AppLocalizations.of(context)!
                        //     .search_sales_quot,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {}, //
                          color: theme.primaryColor,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 5,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: customerDataFilter.length,
                      itemBuilder: (BuildContext context, int i) {
                        return
                            //  Card(
                            //    elevation: 8,
                            //   child:
                            InkWell(
                          onTap: () {
                            print('object');
                            setState(() {
                            //  PaymentCustomerState.custName = customerDataFilter[i].cardName.toString();
                             // PageOneState.custName = customerDataFilter[i].cardName.toString();
                            });
                            Navigator.pop(context);
                            // BPInfoState.data = customerDataFilter;
                            // GeneralState.datas = customerDataFilter;
                            // Get.toNamed<dynamic>(FurneyRoutes.bpinfo);
                            //   print(customerDataFilter[i].cardName.toString());
                            // GeneralState.index = i;
                            // BPInfoState.index = i;
                          },
                          child: Container(
                              // height: Screens.heigth(context)*0.1,
                              width: Screens.width(context),
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Screens.width(context) * 0.52,
                                  //  color: Colors.greenAccent,
                                    child: Text(
                                   '',//   customerDataFilter[i].cardName.toString(),
                                      style: GoogleFonts.poppins(
                                        color: Colors.black54,
                                        fontSize: Screens.width(context) * 0.04,
                                        //  fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        //width: Screens.width(context)*0.55,
                                        //  color: Colors.greenAccent,
                                        child: Text(
                                      '',//    customerDataFilter[i]  
                                          style: GoogleFonts.poppins(
                                            color: Colors.red[200],
                                            fontSize:
                                                Screens.width(context) * 0.035,

                                            ///  fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      // top: Screens.heigth(context) * 0.005,
                                      // bottom: Screens.heigth(context) * 0.005,
                                      left: Screens.width(context) * 0.06,
                                      right: Screens.width(context) * 0.06,
                                    ),
                                    child: const Divider(
                                      thickness: 1.5,
                                    ),
                                  ),
                                ],
                              ),),
                          //  ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
      // actions: <Widget>[
      //   TextButton(
      //         onPressed: () => Navigator.pop(context),
      //         child: Text("Cancel"),
      //       ),
      //       TextButton(
      //         onPressed: () {
      //           setState(() {
      //            // contentText = "Changed Content of Dialog";
      //           });
      //         },
      //         child: Text("Change"),
      //       ),
      // ],
    );
  }
}
