import 'package:flutter/material.dart';
import 'package:ultimate_bundle/src/furney/src/pages/home/home_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/notification/notification_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/profile/profile_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/schemes/discover_page.dart';

class BottomNavigationList {
  static List<Widget> pageList(BuildContext context) => [
        const FurneyHomeScreen(title: 'DashBoard',),
        const Schemes(title: 'Schemes',),
        const NotificationScreen(title: 'Notifications',),
        //FurneyCartScreen(),///notification
        // const FurneySearchScreen(),
        const ProfileScreen(title: 'Profile',),
      ];
}
