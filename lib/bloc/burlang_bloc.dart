import 'package:bloc/bloc.dart';
import 'package:burlang_demo/api/burlang_api.dart';
import 'package:burlang_demo/models/buryat_names.dart';
import 'package:burlang_demo/models/buryat_search_words.dart';
import 'package:burlang_demo/models/language_translation.dart';
import 'package:burlang_demo/models/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'burlang_event.dart';
part 'burlang_state.dart';

class BurlangBloc extends Bloc<BurlangEvent, BurlangState> {
  BurlangBloc() : super(BurlangInitial()) {
    // on<BurlangInitializeNames>((event, emit)async {
    //  try {
    //     final incomeNames = await BurlangApi().getAllNames(event.letter, event.query);
    //    emit(BurlangInitializedNamesState(incomeNames: incomeNames));
    // } on ClientException {
    //  emit(BurlangErrorState(
    //     isError: true, text: 'Проверьте подключение к сети Интернет'));
    //} catch (e) {
    // debugPrint(e.message);
    // }
    //});

    on<BurlangInitializeNews>((event, emit) async {
      try {
        final incomeNews = await BurlangApi().getNews();
        emit(BurlangInitializedNewsState(incomeNews: incomeNews));
      } on ClientException {
        emit(BurlangErrorState(
            isError: true, text: 'Проверьте подключение к сети Интернет'));
      } catch (e) {
        debugPrint(e.message);
      }
    });

    on<BurlangSearchName>((event, emit) async {
      try {
        final searchedNames =
            await BurlangApi().getAllNames(event.letter, event.query);
        emit(BurlangDataSearchedNamesState(
            searchedNames: searchedNames, query: event.query));
      } on ClientException {
        emit(BurlangErrorState(
            isError: true, text: 'Проверьте подключение к сети Интернет'));
      } catch (e) {
        debugPrint(e.message);
      }
    });

    on<BurlangSearchBuryatWord>((event, emit) async {
      try {
        final buryatwords =
            await BurlangApi().getBuryatWord(event.textEditingController);

        final List<Translations> translationList = [];

        for (var element in buryatwords) {
          final buryatTransation =
              await BurlangApi().getBuryatTranslation(element.value);
          translationList.add(buryatTransation);
        }

        emit(BurlangDataSearchedBuryatWordState(buryatwords, translationList));

        if (buryatwords.isEmpty && event.textEditingController != '') {
          emit(BurlangErrorState(
              isError: true, text: 'Подходящее слово не найдено'));
        }
      } on ClientException {
        emit(BurlangErrorState(
            isError: true, text: 'Проверьте подключение к сети Интернет'));
      } catch (e) {
        debugPrint(e.message);
      }
    });

    on<BurlangSearchRussianWord>((event, emit) async {
      try {
        final russianwords =
            await BurlangApi().getRussianWord(event.textEditingController);

        final List<Translations> translationList = [];

        for (var element in russianwords) {
          final russianTranslations =
              await BurlangApi().getRussianTranslation(element.value);
          translationList.add(russianTranslations);
        }

        emit(
            BurlangDataSearchedRussianWordState(russianwords, translationList));

        if (russianwords.isEmpty && event.textEditingController != '') {
          emit(BurlangErrorState(
              isError: true, text: 'Подходящее слово не найдено'));
        }
      } on ClientException {
        emit(BurlangErrorState(
            isError: true, text: 'Проверьте подключение к сети Интернет'));
      } catch (e) {
        debugPrint(e.message);
      }
    });
  }
}
