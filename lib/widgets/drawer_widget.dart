import 'package:burlang_demo/config/router.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 55, 119, 151),
      child: ListView(children: [
        ListTile(
          title: const Text(
            'Словарь',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(RouteGenerator.MAIN);
          },
        ),
        ListTile(
          title: const Text(
            'Бурятские имена',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(RouteGenerator.BURYAT_NAMES);
          },
        ),
        ListTile(
          title: const Text(
            'Книги',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {},
        ),
        ListTile(
          title: const Text(
            'Новости',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {},
        ),
        ListTile(
          title: const Text(
            'Войти',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {},
        ),
      ]),
    );
  }
}
