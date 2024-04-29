// ignore_for_file: file_names, prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chunked_stream/chunked_stream.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/pages/showPdf/ShowPdf.dart';

class StreamDataAPi {
  static String? docEntry;
  static String? docNO;

  static Future<int> getGlobalData() async {
    try {
      log("Messageeeee:::" + URL.reportUrl + 'PoReport/$docEntry');
      final response = await http.get(
        Uri.parse(
          URL.reportUrl + 'PoReport/$docEntry', //866   $docEntry
        ),
        headers: {
          'content-type': 'application/octet-stream',
        },
      );

      log('Stream stsCode::${response.statusCode}');
      log('Stream Response::${jsonDecode(utf8.decode(response.bodyBytes))}');
      if (response.statusCode == 200) {
        //  print("streamm: "+ json.fuse() response.body);
        //  var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        log("bodyBytes: " + response.bodyBytes.toString());
        final bytes = response.bodyBytes;
        final tempDir = await getTemporaryDirectory();
        print("direc: " + tempDir.path);
        final file =
            await File('${tempDir.path}/SaleOrder-$docNO.pdf').create();
        print('${tempDir.path}/SaleOrder-$docNO.pdf');
        file.writeAsBytesSync(bytes);
        final doc = await PDFDocument.fromFile(file);
        ShowPdfs.document = doc;
        ShowPdfs.docNO = docNO;
        ShowPdfs.title = 'SaleOrder';
        await Get.toNamed<dynamic>(FurneyRoutes.showpdf);

        //  print(utf8.decode(bytes));

        // print("file stream:"+fileStream);
        //   return CheckUserLogin.fromJson(json.decode(response.body)as Map<String,dynamic>);
        return 200;
      } else {
        //  print(json.decode(response.body));
        //  print(response.statusCode.toString());
        // throw Exception("Error!!...");
        // return CheckUserLogin.issue('Restart the app or contact the admin!!..');
        return 400;
      }
    } catch (e) {
      print(e);
      // throw Exception("Exceptionsss: $e");
      //  return CheckUserLogin.exception('Restart the app or contact the admin!!..');
      return 500;
    }
  }

  static Future<void> mainss() async {
    // Open README.md as a byte stream
    final fileStream = File('README.md').openRead();

    // Read all bytes from the stream
    final bytes = await readByteStream(fileStream);
    print(bytes);
    // Convert content to string using utf8 codec from dart:convert and print
    print(utf8.decode(bytes));
  }
}
