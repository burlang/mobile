import 'package:flutter/material.dart';

class TextContainerWidget extends StatelessWidget {
  final String text;
  const TextContainerWidget({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.black54, borderRadius: BorderRadius.circular(5)),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
