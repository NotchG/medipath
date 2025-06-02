import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/article_model.dart';

class GetArticlesController {
  final String apiKey = 'b512c00cc7be4135b35d5bbac2d6229d'; // Replace with your NewsAPI key

  Future<List<ArticleModel>> fetchArticles() async {
    final url = Uri.parse(
      'https://newsapi.org/v2/top-headlines?category=health&apiKey=$apiKey',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articles = data['articles'];
      return articles.map((article) {
        return ArticleModel.fromMap(article);
      }).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }
}