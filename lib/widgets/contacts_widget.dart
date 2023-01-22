import 'package:burlang_demo/widgets/gender_name_container_widget.dart';
import 'package:burlang_demo/widgets/text_contact_widget.dart';
import 'package:burlang_demo/widgets/text_mail_widget.dart';
import 'package:flutter/material.dart';

class ContactsWidget extends StatelessWidget {
  const ContactsWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 45,
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Divider(
          thickness: 1.2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextContactWidget(
              url: 'https://github.com/burlang/mobile',
              text: 'GitHub',
            ),
            TextContactWidget(
              url: 'http://burlang.ru/api/v1',
              text: 'Api',
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child: TextMailWidget(
              email: 'dbulats88@gmail.com',
            )),
            Expanded(
                child: TextMailWidget(
              email: 'bairdarmaev@gmail.com',
            )),
          ],
        ),
        TextMailWidget(
          email: 'bubeevm@gmail.com',
        ),
        const SizedBox(
          height: 5,
        ),
        TextContainerWidget(
          text: 'Ⓒ Burlang 2013-2022',
        )
      ]),
    );
  }
}
