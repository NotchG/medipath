import 'package:flutter/material.dart';
import 'package:medipath/model/article_model.dart';

class ArticleListTile extends StatelessWidget {
  final ArticleModel article;
  final VoidCallback onTap;

  const ArticleListTile({
    Key? key,
    required this.article,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Color(0xffFDF3F2),
          borderRadius: BorderRadius.circular(20),
        ),
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage(article.imageUrl ?? "https://via.placeholder.com/300"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title ?? "Article Title",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    article.content ?? "This is a brief description of the article content. It provides an overview of the main points discussed in the article.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff22577A),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
