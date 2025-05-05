// ignore_for_file: unawaited_futures, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ComplaintsPage extends StatefulWidget {
  const ComplaintsPage({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  ComplaintsPageState createState() => ComplaintsPageState();
}

class ComplaintsPageState extends State<ComplaintsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  WebViewController? controllerGlobal;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    loadWebView();
  }

  Future<void> loadWebView() async {
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
      ..loadRequest(
        Uri.parse(
          'https://docs.google.com/forms/d/e/1FAIpQLSdttOWQ7iNqVgtfQ3xLQBJwTjEVIlNORKKmrxIqG4jWWZYRMg/viewform',
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer:
          // GetValues.userRoll == '3' ? drawer2(context) :
          drawer(context),
      appBar: appBar(context, _scaffoldKey, widget.title),
      body: SafeArea(
        child: loading == false
            ? WebViewWidget(controller: controllerGlobal!)
            : Center(
                child: CircularProgressIndicator(),
              ),
        // WebView(
        //    initialUrl: 'https://docs.google.com/forms/d/e/1FAIpQLSdttOWQ7iNqVgtfQ3xLQBJwTjEVIlNORKKmrxIqG4jWWZYRMg/viewform',
        //    javascriptMode: JavascriptMode.unrestricted,
        //          ),
      ),
    );
  }
}
