import 'package:burlang_demo/api/burlang_api.dart';
import 'package:burlang_demo/config/router.dart';
import 'package:burlang_demo/models/buryat_names.dart';
import 'package:burlang_demo/widgets/drawer_widget.dart';
import 'package:burlang_demo/widgets/loader_widget.dart';
import 'package:burlang_demo/widgets/search_buryat_name_widget.dart';
import 'package:flutter/material.dart';

class BuryatNamesScreen extends StatefulWidget {
  final String letter;
  const BuryatNamesScreen({Key key, this.letter}) : super(key: key);

  @override
  State<BuryatNamesScreen> createState() => _BuryatNamesScreenState();
}

class _BuryatNamesScreenState extends State<BuryatNamesScreen> {
  bool isLoading;
  List<BuryatNames> names = [];
  String query = '';

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? const LoaderWidget() : Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 55, 119, 151),
          elevation: 0.0,
          title: const Text('Burlang'),
        ),
        drawer: const DrawerWidget(),
        body: Column(
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
        ));
  }

  searchName(String query) async {
    final buryatNames = await BurlangApi().getAllNames(widget.letter, query);

    if (!mounted) return;

    setState(() {
      this.query = query;
      names = buryatNames;
    });
  }

  Future init() async {
    isLoading = true;
    final incomeNames = await BurlangApi().getAllNames(widget.letter, query);
    setState(() {
      names = incomeNames;
    });
    isLoading = false;
  }
}
