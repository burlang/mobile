import 'package:burlang_demo/bloc/burlang_bloc.dart';
import 'package:burlang_demo/widgets/appbar_widget.dart';
import 'package:burlang_demo/widgets/contacts_widget.dart';
import 'package:burlang_demo/widgets/drawer_widget.dart';
import 'package:burlang_demo/widgets/navigator_widget.dart';
import 'package:burlang_demo/widgets/news_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool isLoading = false;
  bool isError = false;
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<BurlangBloc, BurlangState>(
      listener: (context, state) {
        if (state is BurlangErrorState) {
          if (!mounted) return;
          setState(() {
            isError = state.isError;
            errorText = state.text;
          });
        }
      },
      child: Scaffold(
        appBar: AppBarWidget(),
        drawer: DrawerWidget(),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: ListView(
            children: [
              NavigatorWidget(
                subtitle: 'Новости',
              ),
              isError
                  ? SizedBox(
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Card(
                                elevation: 1.0,
                                color: const Color.fromARGB(255, 242, 222, 222),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 40),
                                  child: Center(
                                    child: Text(
                                      errorText,
                                      style: const TextStyle(
                                          fontFamily: 'Arial',
                                          color:
                                              Color.fromARGB(255, 169, 69, 68)),
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )
                  : NewsWidget(),
              ContactsWidget()
            ],
          ),
        ),
      ),
    );
  }
}
