import 'package:burlang_demo/config/router.dart';
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
                  fontSize: 80,
                  color: Colors.white)),
          Text(
            'Русско-Бурятский,',
            style: TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.w600,
                fontSize: 26,
                color: Colors.white),
          ),
          Text(
            'Бурятско-Русский',
            style: TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.w600,
                fontSize: 26,
                color: Colors.white),
          ),
          Text(
            'электронный словарь',
            style: TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.w600,
                fontSize: 26,
                color: Colors.white),
          )
        ],
      )),
    );
  }
}
