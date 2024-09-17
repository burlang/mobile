import 'package:burlang_demo/data/utils/router.dart';
import 'package:burlang_demo/data/constants/constants.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Constants.color,
      elevation: 0.0,centerTitle:true,
      title: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(RouteGenerator.MAIN);
        },
        child: const Text('Burlang',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
