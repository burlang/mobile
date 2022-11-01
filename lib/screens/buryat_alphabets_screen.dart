import 'package:burlang_demo/config/router.dart';
import 'package:burlang_demo/constants/constants.dart';
import 'package:burlang_demo/widgets/appbar_widget.dart';
import 'package:burlang_demo/widgets/drawer_widget.dart';
import 'package:burlang_demo/widgets/navigator_widget.dart';
import 'package:flutter/material.dart';

class BuryatAlphabetsScreen extends StatefulWidget {
  const BuryatAlphabetsScreen({Key key}) : super(key: key);

  @override
  State<BuryatAlphabetsScreen> createState() => _BuryatAlphabetsScreenState();
}

class _BuryatAlphabetsScreenState extends State<BuryatAlphabetsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          NavigatorWidget(
            subtitle: 'Бурятские имена',
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 20, left: 3, right: 3),
            child: Text(
              'Бурятские имена',
              style: TextStyle(
                fontSize: 34,
                fontFamily: 'Arial',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 5, right: 5),
            child: Divider(
              thickness: 1.2,
            ),
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 120,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: Constants.letters_names.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 3, right: 3),
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            RouteGenerator.BURYAT_NAME,
                            arguments: Constants.letters_names[index]);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Constants.letters_names[index],
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Arial',
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(204, 204, 204, 1),
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                Constants.letters_numbers[index],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ]),
      ),
    );
  }
}
