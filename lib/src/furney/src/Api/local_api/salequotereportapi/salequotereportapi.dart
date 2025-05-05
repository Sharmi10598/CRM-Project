// ignore_for_file: file_names, prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, prefer_final_locals, omit_local_variable_types, unawaited_futures, unnecessary_string_interpolations, noop_primitive_operations

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:chunked_stream/chunked_stream.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/pages/showPdf/ShowPdf.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class salequoteReportApi {
  static Future<int> getGlobalData(String Docentry) async {
    log("AAHAJJAJA");
    try {
      log('AAHAJJAJA22::' + URL.reportUrl + '/Quatation/$Docentry');
      final response = await http.get(
        Uri.parse(
          URL.reportUrl + 'Quatation/$Docentry',
        ),
        headers: {
          'content-type': 'application/octet-stream',
        },
      );
      print(response.statusCode);
      // log("message::::" + response.body.toString());
      if (response.statusCode == 200) {
        final Uint8List bytes = response.bodyBytes;
        final tempDir = await getTemporaryDirectory();
        print("direc: " + tempDir.path.toString());
        File file =
            await File('${tempDir.path}/$Docentry-${GetValues.slpCode}.pdf')
                .create();
        print('${tempDir.path}/$Docentry-${GetValues.slpCode}.pdf');
        file.writeAsBytesSync(bytes);
        PDFDocument doc = await PDFDocument.fromFile(file);
        ShowPdfs.document = doc;
        ShowPdfs.docNO = GetValues.slpCode;
        ShowPdfs.title = '$Docentry';

        Get.toNamed<void>(FurneyRoutes.showpdf)!.then((value) {
          ShowPdfs.notstream = true;
        });
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
    Stream<List<int>> fileStream = File('README.md').openRead();

    // Read all bytes from the stream
    final Uint8List bytes = await readByteStream(fileStream);
    print(bytes);
    // Convert content to string using utf8 codec from dart:convert and print
    print(utf8.decode(bytes));
  }
}
