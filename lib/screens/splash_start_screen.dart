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
    await Future.delayed(Duration(milliseconds: 1300)).then((_) {
      Navigator.pushNamed(context, RouteGenerator.MAIN);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 107, 143, 1),
      body: Center(
        child: Image.asset(
          'assets/cover.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
