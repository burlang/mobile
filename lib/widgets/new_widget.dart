import 'package:burlang_demo/api/burlang_api.dart';
import 'package:burlang_demo/constants/constants.dart';
import 'package:burlang_demo/models/news.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({
    Key key,
  }) : super(key: key);

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  void initState() {
    initializeDateFormatting('ru', null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<News>>(
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Text(
                    'Новости',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return NewWidget(
                      title: snapshot.data[index].title,
                      subtitle: snapshot.data[index].createdAt,
                    );
                  }),
                  itemCount: snapshot.data.length,
                )
              ]);
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return const Center(
              child: Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Card(
                      elevation: 1.0,
                      color: Color.fromARGB(255, 242, 222, 222),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        child: Text(
                          'Произошла ошибка',
                          style: TextStyle(
                              color: Color.fromARGB(255, 169, 69, 68)),
                        ),
                      ))));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: CircularProgressIndicator(
                color: Constants.color,
              ),
            ),
          );
        }
        return Container();
      }),
      future: BurlangApi().getNews(),
    );
  }
}

class NewWidget extends StatelessWidget {
  final String locale;
  final String title;
  final String subtitle;
  const NewWidget({
    this.locale,
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
              DateFormat.yMMMMd('ru').format(DateTime.parse(subtitle)),
              style: const TextStyle(color: Colors.grey),
            )
          ]),
        ),
      ),
    );
  }
}
