import 'package:burlang_demo/api/burlang_api.dart';
import 'package:burlang_demo/models/buryat_translation.dart';
import 'package:flutter/material.dart';

class SearchDictionaryWordWidget extends StatefulWidget {
  const SearchDictionaryWordWidget({
    Key key,
  }) : super(key: key);

  @override
  State<SearchDictionaryWordWidget> createState() =>
      _SearchDictionaryWordWidgetState();
}

class _SearchDictionaryWordWidgetState
    extends State<SearchDictionaryWordWidget> {
  bool isBur = true;

  String bur = 'Бурятско';
  String bur_rus = 'Русский';

  String rus = 'Русско';
  String rus_bur = 'Бурятский';

  String input_bur = 'Введите бурятское слово';
  String input_rus = 'Введите русское слово';

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.6,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                isBur ? bur : rus,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      isBur = !isBur;
                    });
                  },
                  icon: const Icon(
                    Icons.swap_horizontal_circle_sharp,
                    color: Color.fromARGB(255, 55, 119, 151),
                  )),
              Text(
                '${isBur ? bur_rus : rus_bur} словарь',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ]),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 35, right: 35, bottom: 25, top: 10),
            child: TextFormField(
              controller: textController,
              decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 55, 119, 151)),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: isBur ? input_bur : input_rus),
              onChanged: (val) async {
                setState(() {
                  textController.text = val;
                });
                Translations translations = await BurlangApi()
                    .getBuryatTranslation(textController.text);
              },
            ),
          )
        ],
      ),
    );
  }
}
