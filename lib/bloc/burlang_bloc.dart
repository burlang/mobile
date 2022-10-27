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
    on<BurlangInitializeNames>((event, emit) async {
      try {
        final incomeNames =
            await BurlangApi().getAllNames(event.letter, event.query);
        emit(BurlangInitializedNamesState(incomeNames: incomeNames));
      } on ClientException catch (e) {
        emit(BurlangErrorState(
            isError: true, text: 'Проверьте подключение к сети Интернет'));
        debugPrint(e.message);
      } catch (e) {
        emit(BurlangErrorState(isError: true, text: 'Произошла ошибка'));
        debugPrint(e.toString());
      }
    });

    on<BurlangInitializeNews>((event, emit) async {
      try {
        final incomeNews = await BurlangApi().getNews();
        emit(BurlangInitializedNewsState(incomeNews: incomeNews));
      } on ClientException catch (e) {
        emit(BurlangErrorState(
            isError: true, text: 'Проверьте подключение к сети Интернет'));
        debugPrint(e.message);
      } catch (e) {
        emit(BurlangErrorState(isError: true, text: 'Произошла ошибка'));
        debugPrint(e.toString());
      }
    });

    on<BurlangSearchName>((event, emit) async {
      try {
        final searchedNames =
            await BurlangApi().getAllNames(event.letter, event.query);
        emit(BurlangDataSearchedNamesState(
            searchedNames: searchedNames, query: event.query));
      } on ClientException catch (e) {
        emit(BurlangErrorState(
            isError: true, text: 'Проверьте подключение к сети Интернет'));
        debugPrint(e.message);
      } catch (e) {
        emit(BurlangErrorState(isError: true, text: 'Произошла ошибка'));
        debugPrint(e.toString());
      }
    });

    on<BurlangSearchBuryatWord>((event, emit) async {
      try {
        final buryatwords =
            await BurlangApi().getBuryatWord(event.query);

        final List<Translations> translationList = [];

        for (var element in buryatwords) {
          final buryatTransation =
              await BurlangApi().getBuryatTranslation(element.value);
          translationList.add(buryatTransation);
        }

        if (buryatwords.isEmpty && event.query != '') {
          emit(BurlangErrorFindingWordState(
              isError: true, text: 'Подходящее слово не найдено'));
        } else {
          emit(BurlangDataSearchedBuryatWordState(
              buryatWords: buryatwords, translationList: translationList));
        }
      } on ClientException catch (e) {
        emit(BurlangErrorState(
            isError: true, text: 'Проверьте подключение к сети Интернет'));
        debugPrint(e.message);
      } catch (e) {
        emit(BurlangErrorState(isError: true, text: 'Произошла ошибка'));
        debugPrint(e.toString());
      }
    });

    on<BurlangSearchRussianWord>((event, emit) async {
      try {
        final russianwords =
            await BurlangApi().getRussianWord(event.query.trim());

        final List<Translations> translationList = [];

        for (var element in russianwords) {
          final russianTranslations =
              await BurlangApi().getRussianTranslation(element.value);
          translationList.add(russianTranslations);
        }

        if (russianwords.isEmpty && event.query != '') {
          emit(BurlangErrorFindingWordState(
              isError: true, text: 'Подходящее слово не найдено'));
        } else {
          emit(BurlangDataSearchedRussianWordState(
              russianWords: russianwords, translationList: translationList));
        }
      } on ClientException catch (e) {
        emit(BurlangErrorState(
            isError: true, text: 'Проверьте подключение к сети Интернет'));
        debugPrint(e.message);
      } catch (e) {
        emit(BurlangErrorState(isError: true, text: 'Произошла ошибка'));
        debugPrint(e.toString());
      }
    });
  }
}
