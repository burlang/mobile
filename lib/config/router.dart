import 'package:burlang_demo/screens/buryat_name_discription_screen.dart';
import 'package:burlang_demo/screens/buryat_names_screen.dart';
import 'package:burlang_demo/screens/home_screen.dart';
import 'package:burlang_demo/screens/buryat_name_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const MAIN = '/';
  static const BURYAT_NAMES = 'buryat_names';
  static const BURYAT_NAME = 'buryat_name';
  static const BURYAT_NAME_DISCRIPTION = 'buryat_name_discription';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arg = settings.arguments;
    switch (settings.name) {
      case MAIN:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case BURYAT_NAMES:
        return MaterialPageRoute(builder: (_) => const BuryatNamesScreen());

      case BURYAT_NAME:
        return MaterialPageRoute(builder: (_) => const BuryatNameScreen());

      case BURYAT_NAME_DISCRIPTION:
        return MaterialPageRoute(
            builder: (_) => BuryatNameDiscriptionScreen(
                  buryat_name: arg,
                ));
    }
    return MaterialPageRoute(builder: (_) => const HomeScreen());
  }
}
