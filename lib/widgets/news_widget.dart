import 'package:burlang_demo/bloc/burlang_bloc.dart';
import 'package:burlang_demo/config/router.dart';
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
              padding: EdgeInsets.only(top: 60),
            )
          : isError
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List<Widget>.generate(news.length + 1,
                      (index) => itemBuilder(context, index)).toList(),
                ),
    );
  }

  void init() {
    setState(() {
      isLoading = true;
    });
    initializeDateFormatting('ru', null);
    BlocProvider.of<BurlangBloc>(context).add(BurlangInitializeNews());
  }

  itemBuilder(BuildContext context, int index) {
    if (news == null) {
      return Container();
    } else if (index == 0) {
      return const Padding(
        padding: EdgeInsets.only(left: 14, right: 14, bottom: 7, top: 14),
        child: Text(
          'Новости',
          style: TextStyle(fontSize: 25, fontFamily: 'Arial'),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 10),
        child: NewWidget(
          title: news[index - 1].title,
          subtitle: news[index - 1].createdAt,
          slug: news[index - 1].slug,
        ),
      );
    }
  }
}

class NewWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String slug;
  const NewWidget({
    this.title,
    this.subtitle,
    this.slug,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RouteGenerator.NEW, arguments: slug);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.height,
        height: MediaQuery.of(context).size.height / 5,
        child: Card(
          color: Constants.backgroundColor,
          elevation: 0.6,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Constants.color,
                        fontSize: 20,
                        fontFamily: 'Arial'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    DateFormat.yMMMMd('ru').format(DateTime.parse(subtitle)),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
