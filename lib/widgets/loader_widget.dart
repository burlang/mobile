import 'package:burlang_demo/constants/constants.dart';
import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  const LoaderWidget({Key key, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:padding ,
        child: const CircularProgressIndicator(
          color: Constants.color,
        ),
      ),
    );
  }
}
