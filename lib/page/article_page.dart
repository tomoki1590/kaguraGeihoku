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
            scrollDirection: Axis.horizontal,
            child: Container(
              child: Column(
                children: [
                  Text(''),
                  Text('郷土芸能の名前'),
                  Text('投稿した団体名'),
                  Text('投稿した地域と芸能の地域'),
                  Text('あなたの感じる魅力'),
                  Row(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 300,
                            width: 300,
                            child: Container(),
                          ),
                          Image.network(
                            "https://pbs.twimg.com/media/Dt5OowNU0AAznML?format=jpg&name=large",
                            width: 300,
                            height: 300,
                          ),
                        ],
                      ),
                      Image.network(
                        "https://pbs.twimg.com/media/DhO-r07U8AEMv8W.jpg",
                        width: 300,
                        height: 300,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
