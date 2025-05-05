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
import 'package:ultimate_bundle/src/furney/src/pages/reports/screens/reports.dart';
import 'package:ultimate_bundle/src/furney/src/pages/showPdf/ShowPdf.dart';

class SubGroupSalesPdfReportAPi {
  static String? slpCode;
  static String? fromDate;
  static String? toDate;
  static String? methodName;
  static String? cardCode;

  static Future<int> getGlobalData() async {
    try {
      log(
        'SubGroupSalesPdfReportAPi::${URL.reportUrl}$methodName/$slpCode,$fromDate,$toDate,$cardCode',
      );
      final response = await http.get(
        Uri.parse(
          '${URL.reportUrl}$methodName/$slpCode,$fromDate,$toDate,$cardCode', //866   $docEntry
        ),
        headers: {
          'content-type': 'application/octet-stream',
        },
      );
      log('SubGroupSalesPdf statusCode::${response.statusCode}');

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        // log("Uint8List bytes: " + bytes.toString());
        final tempDir = await getTemporaryDirectory();
        final file =
            await File('${tempDir.path}/YTDGrowthSLPExcel-$slpCode.pdf')
                .create();
        file.writeAsBytesSync(bytes);
        final doc = await PDFDocument.fromFile(file);
        ShowPdfs.document = doc;
        ShowPdfs.docNO = slpCode;
        ShowPdfs.title = 'YTDGrowthSLPExcel';
        await Get.toNamed<dynamic>(FurneyRoutes.showpdf);
        SReportsState.isLoading = false;
        return 200;
      } else {
        return 400;
      }
    } catch (e) {
      log(e.toString());

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
