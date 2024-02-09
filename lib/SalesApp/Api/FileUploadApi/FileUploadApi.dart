import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/SalesApp/Model/FileUploadModel/FileUpload.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';

class FilePostApi {
  static Future<FilePostModel> getFilePostData(
      String? fileBytes, String? filename,) async {
    try {
      final response = await http.post(
          Uri.parse('${URL.urlLocal}SaveToPhysicalLocation',
            ),
          headers: {
            'content-type': 'application/json',
          },
          body: jsonEncode({
            'files': [
              {
                'imageBytes': '$fileBytes',
                'filePath': 'D:\\Checkout Attachements\\$filename'
              }
            ]
          }),);

          // log(jsonEncode({
          //   'files': [
          //     {
          //       'imageBytes': '$fileBytes',
          //       'filePath': 'D:\\Checkout Attachements\\$filename'
          //     }
          //   ]
          // }));
       print('file picker:${response.body}');

      // log("json: " +
      //     jsonEncode({
      //       "files": [
      //         {
      //           "imageBytes": "$fileBytes",
      //           "filePath": "C:\\SupportApp\\Profile\\$filename"
      //         }
      //       ]
      //     }).toString());

      // print("file picker:" + response.body.toString());
      if (response.statusCode == 200) {
        return FilePostModel.fromJson(
            response.body, response.statusCode,);
      } else {
        //  throw Exception("Error");

        return FilePostModel.issue(
            'Something went wrong Bad Request..', response.statusCode,);
      }
    } catch (e) {
      // throw Exception(e.toString());
      return FilePostModel.exception('Someting went wrong Try again..', 500);
    }
  }
}


