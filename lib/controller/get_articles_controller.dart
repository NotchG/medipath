import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../model/article_model.dart';

class GetArticlesController {
  final String apiKey = dotenv.get("ARTICLE_API_KEY"); // Replace with your NewsAPI key

  Future<List<ArticleModel>> fetchArticles() async {
    final url = Uri.parse(
      'https://api.worldnewsapi.com/search-news?text=Heart+OR+Lungs+OR+Liver+OR+Virus&number=5',
    );
    final response = await http.get(
        url,
        headers: {
          'x-api-key': apiKey,
        },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articles = data['news'];
      return articles.map((article) {
        return ArticleModel.fromMap(article);
      }).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }
}