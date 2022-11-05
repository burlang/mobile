import 'package:burlang_demo/bloc/burlang_bloc.dart';
import 'package:burlang_demo/constants/constants.dart';
import 'package:burlang_demo/models/buryat_search_words.dart';
import 'package:burlang_demo/models/language_translation.dart';
import 'package:burlang_demo/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Card(
            color: Constants.backgroundColor,
            elevation: 0.6,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(isBur ? Constants.bur : Constants.rus,
                              style: Constants.textSearchFormWordStyle),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                textController.text = '';
                                isBur = !isBur;
                              });
                            },
                            icon: Padding(
                              padding: const EdgeInsets.only(
                                  top: 2.5, bottom: 2.5, right: 1, left: 1),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Constants.color),
                                    borderRadius: BorderRadius.circular(3)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.5),
                                  child: SvgPicture.asset(
                                    'assets/toggle.svg',
                                    fit: BoxFit.cover,
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                              '${isBur ? Constants.bur_rus : Constants.rus_bur}',
                              style: Constants.textSearchFormWordStyle),
                        ]),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 15, right: 15),
                    child: Text('Словарь',
                        style: Constants.textSearchFormWordStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 5, bottom: 7),
                    child: Divider(
                      thickness: 1.2,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: TextFormField(
                              focusNode: textFocusNode,
                              autocorrect: true,
                              controller: textController,
                              decoration: InputDecoration(
                                  suffixIcon: isBur
                                      ? Container(
                                          height: 65,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(5),
                                                bottomRight:
                                                    Radius.circular(5)),
                                            border: Border.all(
                                                color: Constants.color),
                                          ),
                                          child: Row(
                                            children: [
                                              letterWidget(
                                                  letter: 'ү', isCenter: false),
                                              letterWidget(
                                                  letter: 'һ', isCenter: true),
                                              letterWidget(
                                                  letter: 'ө', isCenter: false)
                                            ],
                                          ),
                                        )
                                      : Icon(Icons.abc, color: Colors.white),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide:
                                        BorderSide(color: Constants.color),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide:
                                        BorderSide(color: Constants.color),
                                  ),
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
                                  await Future.delayed(
                                          Duration(milliseconds: 500))
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
                                        ? BlocProvider.of<BurlangBloc>(context)
                                            .add(BurlangSearchBuryatWord(
                                                query: val.trim()))
                                        : BlocProvider.of<BurlangBloc>(context)
                                            .add(BurlangSearchRussianWord(
                                                query: val.trim()));
                                  } catch (e) {
                                    debugPrint(e);
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                  isLoading
                      ? const LoaderWidget(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                        )
                      : isError
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 20, left: 15, right: 15),
                              child: Card(
                                  elevation: 1.0,
                                  color:
                                      const Color.fromARGB(255, 242, 222, 222),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 40),
                                    child: Text(
                                      errorText,
                                      style: const TextStyle(
                                          fontFamily: 'Arial',
                                          color:
                                              Color.fromARGB(255, 169, 69, 68)),
                                    ),
                                  )))
                          : textController.text != ''
                              ? Container(
                                  constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      minHeight: 100),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemBuilder: ((context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Card(
                                          color: const Color.fromRGBO(
                                              223, 240, 216, 1),
                                          elevation: 1.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: ListTile(
                                              title: Text(
                                                words[index].value,
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, left: 21),
                                                child: Text(
                                                  '• ${translations[index].translations.first.value}',
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              ),
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
        ),
      ),
    );
  }

  Expanded letterWidget({String letter, bool isCenter}) {
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
          decoration: isCenter
              ? BoxDecoration(
                  border: Border.symmetric(
                      vertical: BorderSide(color: Constants.color)),
                )
              : BoxDecoration(),
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
