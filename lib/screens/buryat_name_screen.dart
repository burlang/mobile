import 'package:burlang_demo/config/router.dart';
import 'package:burlang_demo/widgets/appbar_widget.dart';
import 'package:burlang_demo/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class BuryatNameScreen extends StatelessWidget {
  const BuryatNameScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      drawer: const DrawerWidget(),
      body: ListView(children: [
        ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(
                RouteGenerator.BURYAT_NAME_DISCRIPTION,
                arguments: 'Абармид');
          },
          title: const Text(
            'Абармид',
            style: TextStyle(fontSize: 16),
          ),
        )
      ]),
    );
  }
}
