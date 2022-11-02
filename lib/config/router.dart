import 'package:burlang_demo/screens/buryat_name_screen.dart';
import 'package:burlang_demo/screens/buryat_alphabets_screen.dart';
import 'package:burlang_demo/screens/new_screen.dart';
import 'package:burlang_demo/screens/search_word_screen.dart';
import 'package:burlang_demo/screens/buryat_names_screen.dart';
import 'package:flutter/material.dart';
import '../screens/news_screen.dart';

class RouteGenerator {
  static const SPLASH = '/';
  static const MAIN = 'main';
  static const LETTERS_NAMES = 'buryat_names';
  static const BURYAT_NAME = 'buryat_name';
  static const BURYAT_NAME_DISCRIPTION = 'buryat_name_discription';
  static const NEWS = 'news';
  static const NEW = 'new';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arg = settings.arguments;
    switch (settings.name) {
      case MAIN:
        return MaterialPageRoute(builder: (_) => const SearchWordScreen());

      case LETTERS_NAMES:
        return MaterialPageRoute(builder: (_) => const BuryatAlphabetsScreen());

      case BURYAT_NAME:
        return MaterialPageRoute(
            builder: (_) => BuryatNamesScreen(
                  letter: arg,
                ));

      case BURYAT_NAME_DISCRIPTION:
        return MaterialPageRoute(
            builder: (_) => BuryatNameScreen(
                  buryat_name: arg,
                ));

      case NEWS:
        return MaterialPageRoute(builder: (_) => const NewsScreen());

      case NEW:
        return MaterialPageRoute(
            builder: (_) => NewScreen(
                  slug: arg,
                ));
    }
    return MaterialPageRoute(builder: (_) => const SearchWordScreen());
  }
}
