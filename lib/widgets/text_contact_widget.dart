import 'package:burlang_demo/config/launcher.dart';
import 'package:burlang_demo/constants/constants.dart';
import 'package:flutter/material.dart';

class TextContactWidget extends StatelessWidget {
  final String url;
  final String text;
  const TextContactWidget({
    this.url,
    this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await Launcher.launch(Uri.parse(url));
      },
      child: Text(
        text,
        style: Constants.textContactStyle,
      ),
    );
  }
}
