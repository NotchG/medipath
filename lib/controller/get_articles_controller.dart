import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/article_model.dart';

class GetArticlesController {
  final String apiKey = 'd8a8ee3d0d434a3e8dc213090d3ebf27'; // Replace with your NewsAPI key

  Future<List<ArticleModel>> fetchArticles() async {
    final url = Uri.parse(
      'https://api.worldnewsapi.com/search-news?text=Heart+OR+Lungs+OR+Liver+OR+Virus&number=10',
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