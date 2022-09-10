import 'package:burlang_demo/widgets/drawer_widget.dart';
import 'package:burlang_demo/widgets/new_widget.dart';
import 'package:burlang_demo/widgets/search_dictionary_word_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/appbar_widget.dart';

class SearchWordScreen extends StatefulWidget {
  const SearchWordScreen({Key key}) : super(key: key);

  @override
  State<SearchWordScreen> createState() => _SearchWordScreenState();
}

class _SearchWordScreenState extends State<SearchWordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: const AppBarWidget(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
              shrinkWrap: true,
              children: const [SearchDictionaryWordWidget(), NewsWidget()]),
        ),
      ),
    );
  }
}
