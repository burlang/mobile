import 'package:bloc/bloc.dart';
import 'package:burlang_demo/api/burlang_api.dart';
import 'package:burlang_demo/models/buryat_names.dart';
import 'package:burlang_demo/models/buryat_search_words.dart';
import 'package:burlang_demo/models/buryat_translation.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'burlang_event.dart';
part 'burlang_state.dart';

class BurlangBloc extends Bloc<BurlangEvent, BurlangState> {
  BurlangBloc() : super(BurlangInitial()) {

    on<BurlangOnValueSearchNamesChanged>((event, emit) async {
      final searchedNames =
          await BurlangApi().getAllNames(event.letter, event.query);
      emit(BurlangDataSearchNamesState(
          searchedNames: searchedNames, query: event.query));
    });

    on<BurlangOnValueSearchWordChanged>((event, emit) async {
      try {
        final buryatwords =
            await BurlangApi().getBuryatWord(event.textEditingController.text);

        final List<Translations> translationList = [];

        for (var element in buryatwords) {
          final buryatTransation =
              await BurlangApi().getBuryatTranslation(element.value);
          translationList.add(buryatTransation);
        }

        emit(BurlangDataSearchBuryatWordState(buryatwords, translationList));

        if (buryatwords.isEmpty && event.textEditingController.text != '') {
          emit(BurlangErrorState());
        }
      } catch (e) {
        debugPrint(e);
      }
    });
  }
}
