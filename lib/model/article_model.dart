class ArticleModel {
  String? id;
  String? title;
  String? content;
  String? description;
  String? author;
  String? imageUrl;
  DateTime? publishedDate;

  ArticleModel({
    this.id,
    this.title,
    this.content,
    this.description,
    this.author,
    this.imageUrl,
    this.publishedDate,
  });

  // Factory method to create an instance from a map
  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    DateTime? parsedDate;
    final dateStr = map['publish_date'];
    if (dateStr != null && dateStr is String && dateStr.isNotEmpty) {
      try {
        parsedDate = DateTime.parse(dateStr);
      } catch (_) {
        parsedDate = null;
      }
    }
    return ArticleModel(
      id: map['id'].toString(),
      title: map['title'],
      content: map['summary'],
      description: map['text'],
      imageUrl: map['image'],
      publishedDate: parsedDate,
    );
  }
}