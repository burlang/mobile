import 'package:burlang_demo/data/constants/constants.dart';
import 'package:burlang_demo/data/utils/launcher.dart';
import 'package:flutter/material.dart';

class TextMailWidget extends StatelessWidget {
  final String email;
  const TextMailWidget({
    this.email,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await Launcher.launch(Uri(
          path: email,
          scheme: 'mailto',
        ));
      },
      child: Text(
        email,
        style: Constants.textContactStyle,
      ),
    );
  }
}
