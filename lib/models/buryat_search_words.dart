class BuryatSearchWords {
  final String value;
  BuryatSearchWords({this.value});

  factory BuryatSearchWords.fromJson(Map<String, dynamic> json) {
    return BuryatSearchWords(value: json['value']);
  }
}
