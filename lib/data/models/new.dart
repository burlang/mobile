class New {
  final String name;
  final String content;
  final String createdAt;
  New({this.name, this.content, this.createdAt});

  factory New.fromJson(Map<String, dynamic> json) {
    return New(
        name: json['name'],
        content: json['content'],
        createdAt: json['created_date']);
  }
}
