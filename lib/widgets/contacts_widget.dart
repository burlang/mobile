import 'package:burlang_demo/config/launcher.dart';
import 'package:burlang_demo/constants/constants.dart';
import 'package:burlang_demo/widgets/gender_name_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsWidget extends StatelessWidget {
  const ContactsWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 30,
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
                  style: Constants.textContactStyle,
                ),
              ),
              TextButton(
                onPressed: () async {
                  await Launcher.launch(Uri.parse('http://burlang.ru/api/v1'));
                },
                child: const Text(
                  'Api',
                  style: Constants.textContactStyle,
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
                    style: Constants.textContactStyle,
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
                    style: Constants.textContactStyle,
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
              style: Constants.textContactStyle,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextContainerWidget(
            gender: 'Ⓒ Burlang 2013-2022',
          )
        ]);
  }
}
