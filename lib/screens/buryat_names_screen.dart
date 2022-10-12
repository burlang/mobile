import 'dart:io';

import 'package:burlang_demo/api/burlang_api.dart';
import 'package:burlang_demo/bloc/burlang_bloc.dart';
import 'package:burlang_demo/config/router.dart';
import 'package:burlang_demo/models/buryat_names.dart';
import 'package:burlang_demo/widgets/appbar_widget.dart';
import 'package:burlang_demo/widgets/loader_widget.dart';
import 'package:burlang_demo/widgets/search_buryat_name_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class BuryatNamesScreen extends StatefulWidget {
  final String letter;
  const BuryatNamesScreen({Key key, this.letter}) : super(key: key);

  @override
  State<BuryatNamesScreen> createState() => _BuryatNamesScreenState();
}

class _BuryatNamesScreenState extends State<BuryatNamesScreen> {
  bool isLoading = false;
  bool isError = false;

  List<BuryatNames> names = [];

  String query = '';
  String textError = '';

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoaderWidget()
        : BlocListener<BurlangBloc, BurlangState>(
            listener: (context, state) {
              if (state is BurlangDataSearchedNamesState) {
                if (!mounted) return;

                setState(() {
                  query = state.query;
                  names = state.searchedNames;
                });
              }
            },
            child: Scaffold(
                appBar: const AppBarWidget(),
                body: isError
                    ? Center(
                        child: Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Card(
                                elevation: 1.0,
                                color: const Color.fromARGB(255, 242, 222, 222),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 40),
                                  child: Text(
                                    textError,
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 169, 69, 68)),
                                  ),
                                ))),
                      )
                    : Column(
                        children: [
                          SearchBuryatNameWidget(
                            text: query,
                            onChanged: searchName,
                            hintText: 'Введите имя',
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                final sortedIndex = index + 1;
                                return ListTile(
                                  title: Text(names[index].name),
                                  trailing: Text(sortedIndex.toString()),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        RouteGenerator.BURYAT_NAME_DISCRIPTION,
                                        arguments: names[index].name);
                                  },
                                );
                              },
                              itemCount: names.length,
                            ),
                          ),
                        ],
                      )),
          );
  }

  searchName(String query) {
    BlocProvider.of<BurlangBloc>(context)
        .add(BurlangSearchName(letter: widget.letter, query: query));
  }

  Future<void> init() async {
    try {
      setState(() {
        isLoading = true;
      });

      final incomeNames = await BurlangApi().getAllNames(widget.letter, query);

      setState(() {
        isLoading = false;
        names = incomeNames;
      });
    } on SocketException catch (e) {
      setState(() {
        isLoading = false;
        isError = true;
        textError = 'Проверьте подключение к сети Интернет';
      });
      debugPrint(e.message);
    } catch (e) {
      setState(() {
        isLoading = false;
        isError = true;
        textError = 'Произошла ошибка';
      });
      debugPrint(e.toString());
    }
  }
}
