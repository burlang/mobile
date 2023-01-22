import 'package:burlang_demo/bloc/burlang_bloc.dart';
import 'package:burlang_demo/config/router.dart';
import 'package:burlang_demo/constants/constants.dart';
import 'package:burlang_demo/widgets/contacts_widget.dart';
import 'package:burlang_demo/widgets/drawer_widget.dart';
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
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
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
              child: ListView(shrinkWrap: true, children: [
                SearchDictionaryWordWidget(),
                const SizedBox(
                  height: 12,
                ),
                isError
                    ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
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
                      )
                    : NewsWidget(),
                ContactsWidget()
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
