// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class LocalNotificationService {
  AndroidNotificationChannel channel = AndroidNotificationChannel(
      'hig_importance_channel', 'High Importance Notification',
      importance: Importance.high,);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> showNitification(
      {int? notifycount,String? titile, String? msg, RemoteMessage? message,}) async {
    if (message!.notification!.android!.imageUrl!= null) {
      final url = _getImageUrl(message.notification!);
      final filePath = await _downloadAndSavePicture(url, 'notify');

      final notificationDetails =
          _buildDetails(titile!, msg!, filePath, true);
           await flutterLocalNotificationsPlugin.show(
       notifycount!, // 0id!,
        titile,
        msg,
        notificationDetails,
        );
    }else{
  await flutterLocalNotificationsPlugin.show(
        1,
        titile ?? 'Testing !!!',
        msg ?? 'Testing how are you',
        NotificationDetails(
            android: AndroidNotificationDetails(
          channel.id, channel.name,
          importance: Importance.high,
          color: Colors.red,
          enableLights: true,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          // styleInformation: StyleInformation()
        ),),
        );
    }  
  }

  String? _getImageUrl(RemoteNotification notification) {
    if (Platform.isIOS && notification.apple != null) {
      return notification.apple?.imageUrl;
    }
    if (Platform.isAndroid && notification.android != null) {
      return notification.android?.imageUrl;
    }
    return null;
  }

  Future<String?> _downloadAndSavePicture(String? url, String fileName) async {
    if (url == null) return null;
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final response = await http.get(Uri.parse(url));
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  NotificationDetails _buildDetails(
      String title, String body, String? picturePath, bool showBigPicture,) {
    final androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      styleInformation: buildBigPictureStyleInformation(
          title, body, picturePath, showBigPicture,),
      importance: Importance.high,
      color: Colors.red,
      enableLights: true,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );
    //   final IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails(
    //   attachments: [if (picturePath != null) IOSNotificationAttachment(picturePath)],
    // );
    final details = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      //iOS: iOSPlatformChannelSpecifics,
    );
    return details;
  }

  BigPictureStyleInformation? buildBigPictureStyleInformation(
    String title,
    String body,
    String? picturePath,
    bool showBigPicture,
  ) {
    if (picturePath == null) return null;
    final filePath = FilePathAndroidBitmap(picturePath);
    return BigPictureStyleInformation(
      showBigPicture ? filePath : const FilePathAndroidBitmap('empty'),
      largeIcon: filePath,
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: body,
      htmlFormatSummaryText: true,
    );
  }
}
