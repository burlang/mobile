import 'package:burlang_demo/api/burlang_api.dart';
import 'package:burlang_demo/models/new.dart';
import 'package:burlang_demo/widgets/appbar_widget.dart';
import 'package:burlang_demo/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewScreen extends StatelessWidget {
  final String slug;
  const NewScreen({Key key, this.slug}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: FutureBuilder<New>(
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            final contentWithoutEquals = snapshot.data.content
                .replaceAll(RegExp("#|<br>"), "")
                .replaceAll('*', "");
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        snapshot.data.name,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(DateFormat.yMMMMd('ru')
                          .format(DateTime.parse(snapshot.data.createdAt))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(contentWithoutEquals),
                    ),
                  ]),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoaderWidget(
              padding: EdgeInsets.zero,
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Ошибка'),
            );
          }
          return const LoaderWidget(
            padding: EdgeInsets.zero,
          );
        }),
        future: BurlangApi().getNew(slug),
      ),
    );
  }
}
