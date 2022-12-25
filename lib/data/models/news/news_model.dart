class NewsModel {
  String title;
  String link;
  String imageUrl;
  String sourceId;
  String date;
  NewsModel({
    required this.date,
    required this.title,
    required this.link,
    required this.imageUrl,
    required this.sourceId,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      date: json['published_at'] ?? '',
      title: json['title'] ?? '',
      link: json['url'] ?? '',
      imageUrl: json['image_url'] ?? '',
      sourceId: json['source'] ?? '',
    );
  }
}
