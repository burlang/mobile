import 'package:burlang_demo/bloc/burlang_bloc.dart';
import 'package:burlang_demo/constants/constants.dart';
import 'package:burlang_demo/models/buryat_search_words.dart';
import 'package:burlang_demo/models/language_translation.dart';
import 'package:burlang_demo/widgets/loader_widget.dart';
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
        // from refresh indicator in main screen
        if (state is BurlangInitializedNewsState) {
          if (!mounted) return;
          setState(() {
            isLoading = false;
            isError = false;
          });
        }

        if (state is BurlangErrorFindingWordState) {
          if (!mounted) return;
          setState(() {
            isLoading = false;
            isError = true;
            errorText = state.text;
          });
        }

        if (state is BurlangErrorState) {
          if (!mounted) return;
          setState(() {
            isLoading = false;
            isError = state.isError;
            errorText = state.text;
          });
        }

        if (state is BurlangDataSearchedBuryatWordState) {
          if (!mounted) return;
          if (state.buryatWords.first.value
              .contains(textController.text.trim())) {
            setState(() {
              isLoading = false;
              isError = false;
              words = state.buryatWords;
              translations = state.translationList;
            });
          }
        }

        if (state is BurlangDataSearchedRussianWordState) {
          if (!mounted) return;
          if (state.russianWords.first.value
              .contains(textController.text.trim())) {
            setState(() {
              isLoading = false;
              isError = false;
              words = state.russianWords;
              translations = state.translationList;
            });
          }
        }
      },
      child: Form(
        key: _formKey,
        child: Card(
          color: Constants.backgroundColor,
          elevation: 0.6,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                          textController.text = '';
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
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Arial'),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 10, top: 10),
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
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(color: Constants.color),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Constants.color),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            hintStyle: TextStyle(
                              fontFamily: 'Arial',
                            ),
                            hintText: isBur
                                ? Constants.input_bur
                                : Constants.input_rus),
                        onChanged: (val) async {
                          if (val == '' || val == '' && isError) {
                            setState(() {
                              isLoading = true;
                            });
                            await Future.delayed(Duration(milliseconds: 500))
                                .then((_) {
                              setState(() {
                                isLoading = false;
                                isError = false;
                              });
                            });
                          } else if (val.endsWith(' ')) {
                            return null;
                          } else {
                            try {
                              setState(() {
                                isLoading = true;
                              });
                              isBur
                                  ? BlocProvider.of<BurlangBloc>(context).add(
                                      BurlangSearchBuryatWord(
                                          query: val.trim()))
                                  : BlocProvider.of<BurlangBloc>(context).add(
                                      BurlangSearchRussianWord(
                                          query: val.trim()));
                            } catch (e) {
                              debugPrint(e);
                            }
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
                                letterWidget('һ'),
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
                  ? const LoaderWidget(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
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
                                      fontFamily: 'Arial',
                                      color: Color.fromARGB(255, 169, 69, 68)),
                                ),
                              )))
                      : textController.text != ''
                          ? Container(
                              constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height / 2,
                                  minHeight: 100),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: ((context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Card(
                                      color: const Color.fromRGBO(
                                          223, 240, 216, 1),
                                      elevation: 1.0,
                                      child: ListTile(
                                        title: Text(
                                          words[index].value,
                                          style: TextStyle(fontFamily: 'Arial'),
                                        ),
                                        subtitle: Text(
                                          translations[index]
                                              .translations
                                              .first
                                              .value,
                                          style: TextStyle(fontFamily: 'Arial'),
                                        ),
                                      ),
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
            });
            textFocusNode.requestFocus();
            textController.selection = TextSelection.fromPosition(
                TextPosition(offset: textController.text.length));
            BlocProvider.of<BurlangBloc>(context).add(
                BurlangSearchBuryatWord(query: textController.text.trim()));
          } catch (e) {
            debugPrint(e);
          }
        },
        child: Container(
          height: 60,
          width: 90,
          decoration: BoxDecoration(border: Border.all(color: Constants.color)),
          child: Center(
              child: Text(
            letter,
            style: TextStyle(fontSize: 17),
          )),
        ),
      ),
    );
  }
}
