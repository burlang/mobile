import 'dart:io';
import 'package:burlang_demo/bloc/burlang_bloc.dart';
import 'package:burlang_demo/data/utils/router.dart';
import 'package:burlang_demo/presentation/screens/splash_start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<BurlangBloc>(create: (_) => BurlangBloc())],
      child: const MaterialApp(
          title: 'Burlang',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.generateRoute,
          home: SplashStartScreen()),
    );
  }
}
