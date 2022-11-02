import 'package:burlang_demo/bloc/burlang_bloc.dart';
import 'package:burlang_demo/screens/splash_start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<BurlangBloc>(create: (_) => BurlangBloc())],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          onGenerateRoute: RouteGenerator.generateRoute,
          home: SplashStartScreen()),
    );
  }
}
