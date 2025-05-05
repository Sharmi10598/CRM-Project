import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ultimate_bundle/src/furney/src/Modal/NotificationModel/NotificationModel.dart';

class SendNotifiationAPi {
  static String? deviceId;

  static Future<NotificationModel> getGlobalData(PushNotify pshNotify) async {
    try {
      final body = {
        'to': '${pshNotify.to}',
        'notification': {
          'title': '${pshNotify.title}',
          'body': '${pshNotify.msg}',
          'sound': 'default',
        },
        'priority': 'high',
      };
      final response = await http.post(
        Uri.parse(
          'https://fcm.googleapis.com/fcm/send',
        ),
        headers: {
          'content-type': 'application/json',
          'Authorization':
              'key=AAAAeAM_7bw:APA91bHwQqF9k3-JMdcnbMvK3VzL31Xokv7hWBBIsNQmUJ6nFc3gSOQ-U6vLeZSqoZSWOEtB-f1p9GDiUmiFq_vOIRd_7d3cvOg-FTglywTGmpDZq58CA1lzeBb_FlAvyo6RdgZwPac2',
        },
        body: jsonEncode(
          body,
        ),
      );

      log(
        'data: ${jsonEncode(
          body,
        )}',
      );

      log(response.body);
      print(response.statusCode);
      // throw Exception("Error!!...");
      return NotificationModel.fromJson(response.body, response.statusCode);
    } catch (e) {
      print(e);
      // throw Exception("Exceptionsss: $e");
      return NotificationModel.fromJson('Error', 500);
    }
  }
}

class PushNotify {
  String? to;
  String? title;
  String? msg;

  PushNotify({
    required this.msg,
    required this.title,
    required this.to,
  });
}
