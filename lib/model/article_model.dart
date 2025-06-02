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
    return ArticleModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      description: map['description'],
      imageUrl: map['urlToImage'],
    );
  }
}