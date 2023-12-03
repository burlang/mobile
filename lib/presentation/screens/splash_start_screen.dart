import 'package:burlang_demo/data/utils/router.dart';
import 'package:burlang_demo/data/constants/constants.dart';
import 'package:flutter/material.dart';

class SplashStartScreen extends StatefulWidget {
  const SplashStartScreen({Key key}) : super(key: key);

  @override
  State<SplashStartScreen> createState() => _SplashStartScreenState();
}

class _SplashStartScreenState extends State<SplashStartScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    await Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.pushNamed(context, RouteGenerator.MAIN);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 107, 143, 1),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 14,
          ),
          Text('Burlang',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 67,
                  color: Colors.white)),
          Text(
            'Русско-Бурятский,',
            style: Constants.textSplashStyle
          ),
          Text(
            'Бурятско-Русский',
            style: Constants.textSplashStyle
          ),
          Text(
            'электронный словарь',
            style: Constants.textSplashStyle
          )
        ],
      )),
    );
  }
}
