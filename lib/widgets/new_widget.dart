import 'package:burlang_demo/api/burlang_api.dart';
import 'package:burlang_demo/bloc/burlang_bloc.dart';
import 'package:burlang_demo/constants/constants.dart';
import 'package:burlang_demo/models/news.dart';
import 'package:burlang_demo/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({
    Key key,
  }) : super(key: key);

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  bool isError = false;
  bool isLoading = false;
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
          ? const SizedBox(height: 70, width: 60, child: LoaderWidget())
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
                    itemBuilder: (context, index) {
                      return NewWidget(
                        title: news[index].title,
                        subtitle: news[index].createdAt,
                      );
                    },
                    shrinkWrap: true,
                    itemCount: news.length,
                  )
                ]),
    );
  }

  Future<void> init() async {
    setState(() {
      isLoading = true;
    });
    BlocProvider.of<BurlangBloc>(context).add(BurlangInitializeNews());
    await initializeDateFormatting('ru', null);
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
