import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ultimate_bundle/SalesApp/Api/LocationApi/LocationPostApi.dart';
import 'package:ultimate_bundle/SalesApp/Model/LocationModel/LocationModel.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LocationDialog extends StatefulWidget {
  LocationDialog({required this.getLocDetData, Key? key}) : super(key: key);
  GetLocDetData? getLocDetData;

  @override
  MyDialogState createState() => MyDialogState();
}

class MyDialogState extends State<LocationDialog> {
  @override
  void initState() {
    super.initState();
    determinePosition();
  }

  String? longi;
  String? lati;
  String latitude = '';
  String langitude = '';
  String? adrress;
  String? url;

  Future<void> determinePosition() async {
    bool? serviceEnabled;
    LocationPermission permission;
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (serviceEnabled == false) {
        try {
          await Geolocator.getCurrentPosition();
          permission = await Geolocator.checkPermission();
          if (permission == LocationPermission.denied) {
            permission = await Geolocator.requestPermission();
            if (permission == LocationPermission.denied) {
              //return Future.error('Location permissions are denied');
            }
          }

          if (permission == LocationPermission.deniedForever) {}
          final pos = await Geolocator.getCurrentPosition();
          // print('lattitude: ${pos.latitude}');
          latitude = pos.latitude.toString();
          langitude = pos.longitude.toString();
          longi = langitude;
          lati = latitude;

          setState(() {
            url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';
          });
          final lat = double.parse(latitude);
          final long = double.parse(langitude);

          final placemarks = await placemarkFromCoordinates(lat, long);
          setState(() {
            adrress =
                '${placemarks[0].street} ${placemarks[0].thoroughfare} ${placemarks[0].locality}';
          });
          await loadWebView();
        } catch (e) {
          const snackBar = SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Colors.red,
            content: Text('Please turn on the Location!!..'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Future.delayed(
            const Duration(seconds: 2),
            () => Get.back<dynamic>(),
          );
        }
      } else if (serviceEnabled == true) {
        final pos = await Geolocator.getCurrentPosition();
        // print('lattitude: ${pos.latitude}');
        latitude = pos.latitude.toString();
        langitude = pos.longitude.toString();
        longi = langitude;
        lati = latitude;

        setState(() {
          url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';
        });
        final lat = double.parse(latitude);
        final long = double.parse(langitude);

        final placemarks = await placemarkFromCoordinates(lat, long);
        setState(() {
          adrress =
              '${placemarks[0].street} ${placemarks[0].thoroughfare} ${placemarks[0].locality}';
        });
        await loadWebView();
      }
    } catch (e) {
      final snackBar =
          SnackBar(backgroundColor: Colors.red, content: Text('$e'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  WebViewController? controllerGlobal;
  bool loading = true;

  Future loadWebView() async {
    controllerGlobal = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              loading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          //   onNavigationRequest: (NavigationRequest request) {
          //     if (request.url.startsWith('https://www.youtube.com/')) {
          //       return NavigationDecision.prevent;
          //     }
          //     return NavigationDecision.navigate;
          //   },
        ),
      )
      ..loadRequest(Uri.parse(url!));
  }

  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return AlertDialog(
      content: (url == null)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              width: width * 0.8,
              child: (isdone == true && msgresp == '')
                  ? const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(child: CircularProgressIndicator()),
                      ],
                    )
                  : (isdone == false && msgresp != '')
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(child: Text(msgresp)),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Lat: $latitude'),
                            SizedBox(
                              height: Screens.heigth(context) * 0.02,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text('Long: $langitude'),
                            ),
                            SizedBox(
                              height: Screens.heigth(context) * 0.02,
                            ),
                            Container(
                              width: Screens.width(context),
                              height: Screens.heigth(context) * 0.37,
                              decoration: const BoxDecoration(),
                              child: loading == false
                                  ? WebViewWidget(controller: controllerGlobal!)
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                            ),
                            SizedBox(
                              height: Screens.heigth(context) * 0.02,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text('${widget.getLocDetData!.CardCode}'),
                            ),
                            SizedBox(
                              height: Screens.heigth(context) * 0.01,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text('${widget.getLocDetData!.CardName}'),
                            ),
                            SizedBox(
                              height: Screens.heigth(context) * 0.02,
                            ),
                          ],
                        ),
            ),
      actions: isdone == false && msgresp != ''
          ? <Widget>[const SizedBox()]
          : <Widget>[
              TextButton(
                onPressed: () {
                  callAprovalApi('A');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                child: const Text('Approve'),
              ),
              TextButton(
                onPressed: () {
                  callAprovalApi('R');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: const Text('Reject'),
              ),
            ],
    );
  }

  bool isdone = false;
  String msgresp = '';

  Future<void> callAprovalApi(String status) async {
    final aprv = LocationStatusModel(
      clgCode: widget.getLocDetData!.ClgCode!,
      status: status,
    );
    isdone = true;
    msgresp = '';
    setState(() {});
    await LocationApproveAPi.getGlobalData(aprv).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        isdone = false;
        msgresp = 'Success..!!';

        setState(() {});
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        isdone = false;
        msgresp = 'Try again..!!';

        setState(() {});
      } else {
        isdone = false;
        msgresp = 'Try again..!!';
        setState(() {});
      }
    });
  }
}
