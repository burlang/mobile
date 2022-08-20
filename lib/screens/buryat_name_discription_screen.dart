import 'package:burlang_demo/api/burlang_api.dart';
import 'package:burlang_demo/models/buryat_name.dart';
import 'package:burlang_demo/widgets/appbar_widget.dart';
import 'package:burlang_demo/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class BuryatNameDiscriptionScreen extends StatelessWidget {
  final buryat_name;
  const BuryatNameDiscriptionScreen({Key key, this.buryat_name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      drawer: const DrawerWidget(),
      body: FutureBuilder<BuryatName>(
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  snapshot.data.name,
                  style: TextStyle(fontSize: 24),
                ),
                subtitle: Card(
                  color: Colors.green[100],
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: SizedBox(
                      height: 190,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data.description,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Text(snapshot.data.note),
                            const SizedBox(height: 4),
                            Container(
                              height: 20,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  snapshot.data.male == 1
                                      ? 'Мужское имя'
                                      : 'Женское имя',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ]),
                    ),
                  ),
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Ошибка'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
        future: BurlangApi().getName(buryat_name),
      ),
    );
  }
}
