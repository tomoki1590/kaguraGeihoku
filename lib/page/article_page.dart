import 'package:flutter/material.dart';
import 'package:kagura_geihoku/page/article_model.dart';
import 'package:provider/provider.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ArticleModel>(
      create: (_) => ArticleModel(),
      child: Consumer<ArticleModel>(builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('記事'),
          ),
          body: SingleChildScrollView(
            child: Card(
              child: Container(
                child: Column(
                  children: [
                    Text('投稿日：'),
                    Text('郷土芸能の名前:${model.kaguraData}'),
                    Text('団体名：'),
                    Text('芸能の地域：'),
                    Text('あなたの感じる魅力：'),
                    Center(
                      child: Image.network(
                        "https://pbs.twimg.com/media/Dt5OowNU0AAznML?format=jpg&name=large",
                        width: 300,
                        height: 300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
