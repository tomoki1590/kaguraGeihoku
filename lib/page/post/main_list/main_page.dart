import 'package:flutter/material.dart';
import 'package:kagura_geihoku/domain/kagura.dart';
import 'package:kagura_geihoku/page/post/main_list/main_page_model.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainPageModel>(
      create: (_) => MainPageModel()..kaguraFetchList(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('郷土芸能自慢'),
        ),
        body: Center(
          child: Consumer<MainPageModel>(builder: (context, model, child) {
            final List<Kagura>? kaguraData = model.kaguraData;
            if (kaguraData == null) {
              return CircularProgressIndicator();
            }

            final List<Widget> widgets = kaguraData
                .map(
                  (kagura) => ListTile(
                    title: Text(kagura.name),
                    subtitle: Text(kagura.episode),
                  ),
                )
                .toList(); //mapで変換

            return ListView(
              children: widgets,
            );
          }),
        ),
      ),
    );
  }
}
