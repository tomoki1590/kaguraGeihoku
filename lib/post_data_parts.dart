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
                child: Column(
                  children: [
                    Divider(
                      color: Colors.black12,
                    ),
                    Card(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  kagura.imgURL!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(kagura.name)

                              ///TODO Accountデータに変更
                            ],
                          ),
                          SizedBox(
                              width: 200,
                              height: 200,
                              child: Image.network(kagura.imgURL!)),
                          ListTile(
                            title: Text("芸能名:${kagura.name}"),
                            subtitle: Text("魅力:${kagura.episode}"),
                          ),
                        ],
                      ),
                    ),
                  ],
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
