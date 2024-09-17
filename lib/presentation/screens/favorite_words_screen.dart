import 'package:burlang_demo/data/constants/constants.dart';
import 'package:burlang_demo/presentation/widgets/appbar_widget.dart';
import 'package:burlang_demo/presentation/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class FavoriteWordsScreen extends StatelessWidget {
  const FavoriteWordsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerWidget(),
      body: ListView(children: [
        Text(
          'Избранные слова',
          style: Constants.textDrawerStyle,
        )
      ]),
    );
  }
}
