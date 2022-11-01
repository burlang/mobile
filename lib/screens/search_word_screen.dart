import 'package:burlang_demo/bloc/burlang_bloc.dart';
import 'package:burlang_demo/config/router.dart';
import 'package:burlang_demo/constants/constants.dart';
import 'package:burlang_demo/widgets/contacts_widget.dart';
import 'package:burlang_demo/widgets/drawer_widget.dart';
import 'package:burlang_demo/widgets/loader_widget.dart';
import 'package:burlang_demo/widgets/news_widget.dart';
import 'package:burlang_demo/widgets/search_dictionary_word_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/appbar_widget.dart';

class SearchWordScreen extends StatefulWidget {
  const SearchWordScreen({Key key}) : super(key: key);

  @override
  State<SearchWordScreen> createState() => _SearchWordScreenState();
}

class _SearchWordScreenState extends State<SearchWordScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: const AppBarWidget(),
      body: GestureDetector(
        onTap: () {
          final FocusScopeNode currentScope = FocusScope.of(context);
          if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: RefreshIndicator(
            color: Constants.color,
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 2)).then((_) {
                Navigator.of(context).pushNamed(RouteGenerator.MAIN);
              });
            },
            child: ListView(shrinkWrap: true, children: const [
              SearchDictionaryWordWidget(),
              const SizedBox(
                height: 12,
              ),
              NewsWidget(),
              ContactsWidget()
            ]),
          ),
        ),
      ),
    );
  }
}
