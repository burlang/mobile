import 'package:flutter/material.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Padding(
            padding: EdgeInsets.all(14.0),
            child: Text(
              'Новости',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          NewWidget(
            title: 'Обновили главную страницу и страницу с бурятскими именами',
            subtitle: '11 июн. 2022 г.',
          ),
          NewWidget(
            title: 'Добавили раздел "Книги"',
            subtitle: '5 июн. 2016 г.',
          ),
          NewWidget(
            title: 'Новая версия сайта',
            subtitle: '21 апр. 2016 г.',
          ),
        ]);
  }
}

class NewWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const NewWidget({
     this.title,
     this.subtitle,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 0.6,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              title,
              style: const TextStyle(
                  color: Color.fromARGB(255, 55, 119, 151), fontSize: 24),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.grey),
            )
          ]),
        ),
      ),
    );
  }
}
