import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chunked_stream/chunked_stream.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';

class NetPendingOrderExcelAPi {
  static String? slpCode;
  static String? fromDate;
  static String? toDate;

  static Future<int> getGlobalData() async {
    log('NetPendingExcel::${URL.reportUrl}NetPendingOrderExcel/$slpCode,$fromDate,$toDate');
    try {
      final response = await http.get(
        Uri.parse(
          '${URL.reportUrl}NetPendingOrderExcel/$slpCode,$fromDate,$toDate', //866   $docEntry
        ),
        headers: {
          'content-type': 'application/octet-stream',
        },
      );
      log('NetPendingExcelstsCode::${response.statusCode}');

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        //  log("Uint8List bytes: "+bytes.toString());
        final tempDir = await getTemporaryDirectory();
        final file = await File('${tempDir.path}/NetPendingOrder-$slpCode.xlsx')
            .create();
        file.writeAsBytesSync(bytes);
        await OpenFile.open(file.path);

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
