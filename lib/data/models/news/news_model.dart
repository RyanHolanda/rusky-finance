class NewsModel {
  String title;
  String link;
  String description;
  String pubDate;
  String imageUrl;
  String sourceId;
  NewsModel({
    required this.title,
    required this.link,
    required this.description,
    required this.pubDate,
    required this.imageUrl,
    required this.sourceId,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? '',
      link: json['link'] ?? '',
      description: json['description'] ?? '',
      pubDate: json['pubDate'] ?? '',
      imageUrl: json['image_url'] ?? '',
      sourceId: json['source_id'] ?? '',
    );
  }
}
