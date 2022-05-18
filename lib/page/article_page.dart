import 'package:flutter/material.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('記事'),
      ),
      body: Column(
        children: [
          Text('投稿日：'),
          Text('名称：'),
          Text('場所：'),
          Text('団体：'),
          Text('魅力：'),
        ],
      ),
    );
  }
}
