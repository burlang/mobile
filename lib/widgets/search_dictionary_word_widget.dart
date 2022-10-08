import 'package:burlang_demo/bloc/burlang_bloc.dart';
import 'package:burlang_demo/constants/constants.dart';
import 'package:burlang_demo/models/buryat_search_words.dart';
import 'package:burlang_demo/models/language_translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  List<SearchWords> words = [];
  List<Translations> translations = [];
  String errorText = '';

  final _formKey = GlobalKey<FormState>();

  bool isBur = true;
  bool isLoading = false;
  bool isError = false;

  TextEditingController textController = TextEditingController();
  FocusNode textFocusNode = FocusNode();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BurlangBloc, BurlangState>(
      listener: (context, state) {
        if (state is BurlangDataSearchedBuryatWordState) {
          if (!mounted) return;
          setState(() {
            isLoading = false;
            words = state.buryatWords;
            translations = state.translationList;
          });
        }

        if (state is BurlangDataSearchedRussianWordState) {
          if (!mounted) return;
          setState(() {
            isLoading = false;
            words = state.russianWords;
            translations = state.translationList;
          });
        }

        if (state is BurlangErrorState) {
          setState(() {
            isLoading = false;
            isError = state.isError;
            errorText = state.text;
          });
        }
      },
      child: Form(
        key: _formKey,
        child: Card(
          elevation: 0.6,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    isBur ? Constants.bur : Constants.rus,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w400),
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
                    '${isBur ? Constants.bur_rus : Constants.rus_bur} словарь',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: textController.text == '' ? 25 : 5,
                    top: 10),
                child: Row(
                  children: [
                    Flexible(
                      flex: 8,
                      child: TextFormField(
                        focusNode: textFocusNode,
                        autocorrect: true,
                        controller: textController,
                        decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Constants.color),
                            ),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Constants.color),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: isBur
                                ? Constants.input_bur
                                : Constants.input_rus),
                        onChanged: (val) {
                          try {
                            setState(() {
                              isLoading = true;
                              isError = false;
                            });
                            isBur
                                ? BlocProvider.of<BurlangBloc>(context).add(
                                    BurlangSearchBuryatWord(
                                        textEditingController: val))
                                : BlocProvider.of<BurlangBloc>(context).add(
                                    BurlangSearchRussianWord(
                                        textEditingController: val));
                          } catch (e) {
                            debugPrint(e);
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    isBur
                        ? Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                letterWidget('ү'),
                                const SizedBox(
                                  width: 5,
                                ),
                                letterWidget('h'),
                                const SizedBox(
                                  width: 5,
                                ),
                                letterWidget('ө')
                              ],
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
              isLoading
                  ? const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child:
                            CircularProgressIndicator(color: Constants.color),
                      ),
                    )
                  : isError
                      ? Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Card(
                              elevation: 1.0,
                              color: const Color.fromARGB(255, 242, 222, 222),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 40),
                                child: Text(
                                  errorText,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 169, 69, 68)),
                                ),
                              )))
                      : textController.text != ''
                          ? SizedBox(
                              height: words.length == 1
                                  ? 100
                                  : MediaQuery.of(context).size.height / 2,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: ((context, index) {
                                  return Card(
                                    elevation: 1.0,
                                    child: ListTile(
                                      title: Text(
                                        words[index].value,
                                      ),
                                      subtitle: Text(translations[index]
                                          .translations
                                          .first
                                          .value),
                                    ),
                                  );
                                }),
                                itemCount: words.length,
                              ))
                          : Container()
            ],
          ),
        ),
      ),
    );
  }

  Expanded letterWidget(String letter) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          try {
            setState(() {
              textController.text += letter;
              isLoading = true;
              isError = false;
            });
            textFocusNode.requestFocus();
            textController.selection = TextSelection.fromPosition(
                TextPosition(offset: textController.text.length));
            BlocProvider.of<BurlangBloc>(context).add(
                BurlangSearchBuryatWord(textEditingController: textController.text));
          } catch (e) {
            debugPrint(e);
          }
        },
        child: Container(
          height: 55,
          width: 90,
          decoration: BoxDecoration(border: Border.all(color: Constants.color)),
          child: Center(child: Text(letter)),
        ),
      ),
    );
  }
}
