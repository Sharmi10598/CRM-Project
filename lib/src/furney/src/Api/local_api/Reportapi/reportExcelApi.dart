// ignore_for_file: file_names, prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, prefer_final_locals, omit_local_variable_types, unawaited_futures

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:chunked_stream/chunked_stream.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class ReportExcelApi {
  static Future<int> getGlobalData(String content, String methodname) async {
    try {
      log("$methodname::" + URL.reportUrl + content);
      final response = await http.get(
        Uri.parse(
          URL.reportUrl + content,
        ),
        headers: {
          'content-type': 'application/octet-stream',
        },
      );
      log("$methodname Excel statusCode: " + response.statusCode.toString());
      if (response.statusCode == 200) {
        log("$methodname Excel bytes: " + response.bodyBytes.toString());
        final bytes = response.bodyBytes;
        final tempDir = await getTemporaryDirectory();
        final file =
            await File('${tempDir.path}/$methodname-${GetValues.slpCode}.xlsx')
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
    Stream<List<int>> fileStream = File('README.md').openRead();

    // Read all bytes from the stream
    final Uint8List bytes = await readByteStream(fileStream);
    print(bytes);
    // Convert content to string using utf8 codec from dart:convert and print
    print(utf8.decode(bytes));
  }
}
