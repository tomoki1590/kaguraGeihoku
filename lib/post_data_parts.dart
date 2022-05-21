import 'package:flutter/material.dart';
import 'package:kagura_geihoku/page/article_page.dart';
import 'package:kagura_geihoku/page/post/main_list/main_page_model.dart';
import 'package:provider/provider.dart';

import 'domain/kagura.dart';

ChangeNotifierProvider<MainPageModel> PostDataParts() {
  return ChangeNotifierProvider<MainPageModel>(
    create: (_) => MainPageModel()..kaguraFetchList(),
    child: Center(
      child: Consumer<MainPageModel>(builder: (context, model, child) {
        final List<Kagura>? kaguraData = model.kaguraData;
        if (kaguraData == null) {
          return CircularProgressIndicator();
        }

        final List<Widget> widgets = kaguraData
            .map(
              (kagura) => GestureDetector(
                child: ListTile(
                  title: Text(kagura.name),
                  subtitle: Text(kagura.episode),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ArticlePage()));
                },
              ),
            )
            .toList(); //mapで変換

        return ListView(
          children: widgets,
        );
      }),
    ),
  );
}
