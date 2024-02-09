// ignore_for_file: file_names, prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:io';
import 'package:chunked_stream/chunked_stream.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/pages/showPdf/ShowPdf.dart';


class NetPendingOrderAPi{
  static String? slpCode;
  static String? fromDate;
  static String? toDate;


  static Future<int> getGlobalData() async {
    print( URL.reportUrl+ 'NetPendingOrder/$slpCode,$fromDate,$toDate');
    try {
    final response = await http.get(
        Uri.parse(
     URL.reportUrl+ 'NetPendingOrder/$slpCode,$fromDate,$toDate', //866   $docEntry
      ),
        headers: {
        'content-type': 'application/octet-stream',
        },
      );
      if (response.statusCode == 200) {
      //  print("streamm: "+ json.fuse() response.body);
      //  var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
       // print("bodyBytes: "+ response.bodyBytes.toString());
         final bytes =  response.bodyBytes;
       //  print("Uint8List bytes: "+bytes.toString());
       final tempDir = await getTemporaryDirectory();
       print("direc: "+tempDir.path);
       final file = await File('${tempDir.path}/NetPendingOrder-$slpCode.pdf').create();
       print('${tempDir.path}/NetPendingOrder-$slpCode.pdf');
       file.writeAsBytesSync(bytes);
       final doc = await PDFDocument.fromFile(file);
        ShowPdfs.document = doc;
        ShowPdfs.docNO = slpCode;
        ShowPdfs.title = 'NetPendingOrder';
        await Get.toNamed<dynamic>(FurneyRoutes.showpdf);
     return 200;
      } else {
  
      return 400;
      }
    } catch (e) {
       print(e);

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
