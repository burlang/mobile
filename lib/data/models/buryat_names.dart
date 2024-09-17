class BuryatNames {
  final String name;

  BuryatNames({this.name});

  factory BuryatNames.fromJson(Map<String, dynamic> json) {
    return BuryatNames(name: json['value']);
  }
}