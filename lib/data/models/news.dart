class News {
  final String title;
  final String slug;
  final String createdAt;
  News({this.title, this.slug, this.createdAt});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        title: json['title'],
        slug: json['slug'],
        createdAt: json['created_date']);
  }
}
