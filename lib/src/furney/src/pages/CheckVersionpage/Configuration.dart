import 'dart:developer';
import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:upgrader/upgrader.dart';

class CheckVersionConfig {
  Future<String?> getStoreVersion(String myAppBundleId) async {
    String? storeVersion;
    if (Platform.isAndroid) {
      final playStoreSearchAPI = PlayStoreSearchAPI();
      final result2 =
          await playStoreSearchAPI.lookupById(myAppBundleId, country: 'IN');
      if (result2 != null) storeVersion = playStoreSearchAPI.version(result2);
      // log('PlayStore version: $storeVersion}');
      // } else if (Platform.isIOS) {

      // log('AppStore version: $storeVersion}');
    } else if (Platform.isIOS) {
      final iTunesSearchAPI = ITunesSearchAPI();
      final result =
          await iTunesSearchAPI.lookupByBundleId(myAppBundleId, country: 'IN');
      if (result != null) storeVersion = iTunesSearchAPI.version(result);
    } else {
      storeVersion = null;
    }
    return storeVersion;
  }

  Future<String?> getPackageDetails() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final appName = packageInfo.appName;
    final packageName = packageInfo.packageName;
    final versionNum = packageInfo.version;
    final buildNumber = packageInfo.buildNumber;
    log('packageName::$packageName');
    return versionNum;
  }
}
