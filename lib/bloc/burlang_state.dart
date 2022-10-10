part of 'burlang_bloc.dart';

@immutable
abstract class BurlangState {}

class BurlangInitial extends BurlangState {}

class BurlangDataSearchedNamesState extends BurlangState {
  final String query;
  final List<BuryatNames> searchedNames;
  BurlangDataSearchedNamesState({this.searchedNames, this.query});
}

class BurlangDataSearchedBuryatWordState extends BurlangState {
  final List<SearchWords> buryatWords;
  final List<Translations> translationList;
  BurlangDataSearchedBuryatWordState(this.buryatWords, this.translationList);
}

class BurlangDataSearchedRussianWordState extends BurlangState {
  final List<SearchWords> russianWords;
  final List<Translations> translationList;
  BurlangDataSearchedRussianWordState(this.russianWords, this.translationList);
}

class BurlangErrorState extends BurlangState {
  final bool isError;
  final String text;
  BurlangErrorState({this.isError, this.text});
}
