import 'package:flutter/material.dart';
import 'package:medipath/model/article_model.dart';

class ArticlePage extends StatefulWidget {
  final ArticleModel? article;
  const ArticlePage({super.key, this.article});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.article?.imageUrl ?? '',
                fit: BoxFit.cover,
              ),
            ),
            pinned: true,
            title: Text(widget.article?.title ?? 'Article'),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.article?.description ?? 'No content available.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
