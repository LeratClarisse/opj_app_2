import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'src/core/Presentation/app.dart';

Future<void> main() async {
  await Hive.initFlutter();

  // App version from pubspec.yaml
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String appVersion = packageInfo.version;
  // App version from Hive
  Box settingBox = await Hive.openBox('settings');
  String? boxAppVersion = settingBox.get('version');
  await settingBox.close();

  if (appVersion != boxAppVersion) {
    Hive.openBox('questions');
    Hive.deleteFromDisk(); // Delete open boxes

    // Save new version in Hive
    (await Hive.openBox('settings')).put('version', appVersion);
  }

  return runApp(const App());
}
