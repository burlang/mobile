import 'package:burlang_demo/api/burlang_api.dart';
import 'package:burlang_demo/config/launcher.dart';
import 'package:burlang_demo/config/router.dart';
import 'package:burlang_demo/models/new.dart';
import 'package:burlang_demo/widgets/appbar_widget.dart';
import 'package:burlang_demo/widgets/contacts_widget.dart';
import 'package:burlang_demo/widgets/loader_widget.dart';
import 'package:burlang_demo/widgets/navigator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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
            return Padding(
              padding: const EdgeInsets.all(12),
              child: ListView(children: [
                slug == 'obnovili-glavnuu-stranicu-i-stranicu-s-buratskimi-imenami'
                    ? NavigatorWidget(
                        subtitle: 'Новости',
                        overFlowTitle: snapshot.data.name,
                        routeName: RouteGenerator.NEWS,
                        isOverFlow: true,
                      )
                    : NavigatorWidget(
                        subtitle: 'Новости',
                        childTitle: snapshot.data.name,
                        routeName: RouteGenerator.NEWS,
                      ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 10, left: 8),
                  child: Text(
                    DateFormat.yMMMMd('ru')
                        .format(DateTime.parse(snapshot.data.createdAt)),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MarkdownBody(
                      onTapLink: (text, url, title) async {
                        await Launcher.launch(
                          Uri.parse(url),
                        );
                      },
                      styleSheet:
                          MarkdownStyleSheet.fromTheme(Theme.of(context))
                              .copyWith(textScaleFactor: 1.2),
                      data: snapshot.data.content.replaceAll('*', ''),
                    )),
                ContactsWidget()
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
