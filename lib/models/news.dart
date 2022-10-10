class News {
  final String title;
  final String createdAt;
  News({this.title,  this.createdAt});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'],
      createdAt: json['created_date']
    );
  }
}
