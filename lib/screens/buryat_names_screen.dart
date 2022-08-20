import 'package:burlang_demo/config/router.dart';
import 'package:burlang_demo/constants/constants.dart';
import 'package:burlang_demo/widgets/appbar_widget.dart';
import 'package:burlang_demo/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class BuryatNamesScreen extends StatefulWidget {
  const BuryatNamesScreen({Key key}) : super(key: key);

  @override
  State<BuryatNamesScreen> createState() => _BuryatNamesScreenState();
}

class _BuryatNamesScreenState extends State<BuryatNamesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      drawer: const DrawerWidget(),
      body: Column(children: [
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 15, bottom: 15, left: 7, right: 7),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 120,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: Constants.letters_names.length,
                itemBuilder: (BuildContext ctx, index) {
                  return OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          RouteGenerator.BURYAT_NAME,
                          arguments: Constants.letters_names[index]);
                    },
                    child: Text(
                      Constants.letters_names[index],
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  );
                }),
          ),
        ),
      ]),
    );
  }
}
