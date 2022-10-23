import 'package:burlang_demo/config/launcher.dart';
import 'package:burlang_demo/constants/constants.dart';
import 'package:flutter/material.dart';

class ContactsWidget extends StatelessWidget {
  const ContactsWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const SizedBox(
        height: 40,
      ),
      const Divider(
        thickness: 1.2,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () async {
              await Launcher.launch(
                  Uri.parse('https://github.com/damasco/burlang.ru'));
            },
            child: const Text(
              'GitHub',
              style: TextStyle(color: Constants.color, fontSize: 14),
            ),
          ),
          TextButton(
            onPressed: () async {
              await Launcher.launch(Uri.parse('http://burlang.ru/api/v1'));
            },
            child: const Text(
              'Api',
              style: TextStyle(color: Constants.color, fontSize: 14),
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: TextButton(
              onPressed: () async {
                await Launcher.launch(Uri(
                  path: 'dbulats88@gmail.com',
                  scheme: 'mailto',
                ));
              },
              child: const Text(
                'dbulats88@gmail.com',
                style: TextStyle(color: Constants.color, fontSize: 14),
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () async {
                await Launcher.launch(Uri(
                  path: 'bairdarmaev@gmail.com',
                  scheme: 'mailto',
                ));
              },
              child: const Text(
                'bairdarmaev@gmail.com',
                style: TextStyle(color: Constants.color, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      TextButton(
        onPressed: () async {
          await Launcher.launch(Uri(
            path: 'bubeevm@gmail.com',
            scheme: 'mailto',
          ));
        },
        child: const Text(
          'bubeevm@gmail.com',
          style: TextStyle(color: Constants.color, fontSize: 14),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(3),
        decoration: const BoxDecoration(color: Colors.black54),
        child: const Text(
          'Ⓒ Burlang 2013-2022',
          style: TextStyle(color: Colors.white),
        ),
      )
    ]);
  }
}
