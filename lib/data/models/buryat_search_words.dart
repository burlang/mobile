class SearchWords {
  final String value;
  SearchWords({this.value});

  factory SearchWords.fromJson(Map<String, dynamic> json) {
    return SearchWords(value: json['value']);
  }
}
