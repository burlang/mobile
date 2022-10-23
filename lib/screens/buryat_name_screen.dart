import 'package:burlang_demo/api/burlang_api.dart';
import 'package:burlang_demo/models/buryat_name.dart';
import 'package:burlang_demo/widgets/appbar_widget.dart';
import 'package:burlang_demo/widgets/drawer_widget.dart';
import 'package:burlang_demo/widgets/gender_name_container_widget.dart';
import 'package:burlang_demo/widgets/loader_widget.dart';
import 'package:flutter/material.dart';

class BuryatNameScreen extends StatelessWidget {
  final String buryat_name;
  const BuryatNameScreen({Key key, this.buryat_name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: FutureBuilder<BuryatName>(
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    snapshot.data.name,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
                subtitle: Card(
                  color: Colors.green[100],
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data.description,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: Color.fromRGBO(60, 118, 61, 1)),
                            ),
                            const SizedBox(height: 9),
                            Text(snapshot.data.note),
                            const SizedBox(height: 9),
                            snapshot.data.male == 1 && snapshot.data.female == 1
                                ? Row(
                                    children: const [
                                      GenderNameContainerWidget(
                                        gender: 'Мужское имя',
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      GenderNameContainerWidget(
                                        gender: 'Женское имя',
                                      ),
                                    ],
                                  )
                                : snapshot.data.male == 1
                                    ? const GenderNameContainerWidget(
                                        gender: 'Мужское имя',
                                      )
                                    : snapshot.data.female == 1
                                        ? const GenderNameContainerWidget(
                                            gender: 'Женское имя',
                                          )
                                        : null,
                          ]),
                    ),
                  ),
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoaderWidget(
              padding: EdgeInsets.zero,
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Ошибка'),
            );
          }
          return const LoaderWidget(
            padding: EdgeInsets.zero,
          );
        }),
        future: BurlangApi().getName(buryat_name),
      ),
    );
  }
}
