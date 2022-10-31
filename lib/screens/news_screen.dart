import 'package:burlang_demo/widgets/appbar_widget.dart';
import 'package:burlang_demo/widgets/drawer_widget.dart';
import 'package:burlang_demo/widgets/navigator_widget.dart';
import 'package:burlang_demo/widgets/news_widget.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerWidget(),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            NavigatorWidget(
              subtitle: 'Новости',
            ),
            NewsWidget(),
          ],
        ),
      ),
    );
  }
}
