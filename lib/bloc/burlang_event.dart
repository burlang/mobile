part of 'burlang_bloc.dart';

@immutable
abstract class BurlangEvent {}

class BurlangInitializeNews extends BurlangEvent {}

// class BurlangInitializeNames extends BurlangEvent {
//  final String letter;
//  final String query;
//  BurlangInitializeNames({this.letter, this.query});
// }

class BurlangSearchName extends BurlangEvent {
  final String letter;
  final String query;
  BurlangSearchName({this.letter, this.query});
}

class BurlangSearchBuryatWord extends BurlangEvent {
  final String textEditingController;
  BurlangSearchBuryatWord({this.textEditingController});
}

class BurlangSearchRussianWord extends BurlangEvent {
  final String textEditingController;
  BurlangSearchRussianWord({this.textEditingController});
}
