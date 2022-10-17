import 'package:burlang_demo/bloc/burlang_bloc.dart';
import 'package:burlang_demo/constants/constants.dart';
import 'package:burlang_demo/models/news.dart';
import 'package:burlang_demo/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  bool isLoading = false;
  bool isError = false;

  List<News> news = [];

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BurlangBloc, BurlangState>(
      listener: (context, state) {
        if (state is BurlangInitializedNewsState) {
          setState(() {
            isLoading = false;
            isError = false;
            news = state.incomeNews;
          });
        }

        if (state is BurlangErrorState) {
          setState(() {
            isLoading = false;
            isError = true;
          });
        }
      },
      child: isLoading
          ? const LoaderWidget(
              padding: EdgeInsets.only(top: 20),
            )
          : isError
              ? Container()
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                        if (news == null) {
                          return Container();
                        } else {
                          return NewWidget(
                            title: news[index].title,
                            subtitle: news[index].createdAt,
                          );
                        }
                      }),
                      itemCount: news == null ? 1 : news.length),
                ]),
    );
  }

  void init() {
    setState(() {
      isLoading = true;
    });
    initializeDateFormatting('ru', null);
    BlocProvider.of<BurlangBloc>(context).add(BurlangInitializeNews());
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
              DateFormat.yMMMMd('ru').format(DateTime.parse(subtitle)),
              style: const TextStyle(color: Colors.grey),
            )
          ]),
        ),
      ),
    );
  }
}
