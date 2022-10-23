import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Launcher {
  static Future<void> launch(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint('can not open url');
    }
  }
}
