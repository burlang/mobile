part of 'burlang_bloc.dart';

@immutable
abstract class BurlangState {}

class BurlangInitial extends BurlangState {}

class BurlangInitializedNewsState extends BurlangState {
  final List<News> incomeNews;
  BurlangInitializedNewsState({this.incomeNews});
}

class BurlangInitializedNamesState extends BurlangState {
  final List<BuryatNames> incomeNames;
  BurlangInitializedNamesState({this.incomeNames});
}

class BurlangDataSearchedNamesState extends BurlangState {
  final String query;
  final List<BuryatNames> searchedNames;
  BurlangDataSearchedNamesState({this.searchedNames, this.query});
}

class BurlangDataSearchedBuryatWordState extends BurlangState {
  final String query;
  final List<SearchWords> buryatWords;
  final List<Translations> translationList;
  BurlangDataSearchedBuryatWordState(this.query, this.buryatWords, this.translationList);
}

class BurlangDataSearchedRussianWordState extends BurlangState {
  final String query;
  final List<SearchWords> russianWords;
  final List<Translations> translationList;
  BurlangDataSearchedRussianWordState(this.query, this.russianWords, this.translationList);
}

class BurlangErrorFindingWordState extends BurlangState {
  final bool isError;
  final String text;
  BurlangErrorFindingWordState({this.isError, this.text});
}

class BurlangErrorState extends BurlangState {
  final bool isError;
  final String text;
  BurlangErrorState({this.isError, this.text});
}
