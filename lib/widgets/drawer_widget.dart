import 'package:burlang_demo/config/router.dart';
import 'package:burlang_demo/constants/constants.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Constants.color,
      child: ListView(children: [
        ListTile(
          title: const Text('Словарь', style: Constants.textDrawerStyle),
          onTap: () {
            Navigator.of(context).pushNamed(RouteGenerator.MAIN);
          },
        ),
        ListTile(
          title:
              const Text('Бурятские имена', style: Constants.textDrawerStyle),
          onTap: () {
            Navigator.of(context).pushNamed(RouteGenerator.LETTERS_NAMES);
          },
        ),
        ListTile(
          title:
              const Text('Избранные слова', style: Constants.textDrawerStyle),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Новости', style: Constants.textDrawerStyle),
          onTap: () {
            Navigator.of(context).pushNamed(RouteGenerator.NEWS);
          },
        ),
      ]),
    );
  }
}
