import 'package:flutter/material.dart';

class GenderNameContainerWidget extends StatelessWidget {
  final String gender;
  const GenderNameContainerWidget({Key key, this.gender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 100,
      decoration: BoxDecoration(
          color: Colors.black54, borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            gender,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
