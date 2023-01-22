part of 'burlang_bloc.dart';

@immutable
abstract class BurlangEvent {}

class BurlangInitializeNews extends BurlangEvent {}

class BurlangInitializeNames extends BurlangEvent {
  final String letter;
  final String query;
  BurlangInitializeNames({this.letter, this.query});
}

class BurlangSearchBuryatWord extends BurlangEvent {
  final String query;
  BurlangSearchBuryatWord({this.query});
}

class BurlangSearchRussianWord extends BurlangEvent {
  final String query;
  BurlangSearchRussianWord({this.query});
}
