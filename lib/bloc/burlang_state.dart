part of 'burlang_bloc.dart';

@immutable
abstract class BurlangState {}

class BurlangInitial extends BurlangState {}

class BurlangDataSearchNamesState extends BurlangState {
  final String query;
  final List<BuryatNames> searchedNames;
  BurlangDataSearchNamesState({this.searchedNames, this.query});
}

class BurlangDataSearchBuryatWordState extends BurlangState {
  final List<BuryatSearchWords> buryatWords;
  final List<Translations> translationList;
  BurlangDataSearchBuryatWordState(this.buryatWords, this.translationList);
}

class BurlangErrorState extends BurlangState {}
