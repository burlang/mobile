part of 'burlang_bloc.dart';

@immutable
abstract class BurlangEvent {}

class BurlangOnValueSearchNamesChanged extends BurlangEvent{
  final String letter;
  final String query;
  BurlangOnValueSearchNamesChanged({this.letter, this.query});

}

class BurlangOnValueSearchWordChanged extends BurlangEvent {
  final TextEditingController textEditingController;
  BurlangOnValueSearchWordChanged({this.textEditingController});
}
