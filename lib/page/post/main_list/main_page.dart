import 'package:flutter/material.dart';
import 'package:kagura_geihoku/page/post/main_list/main_page_model.dart';
import 'package:kagura_geihoku/post_data_parts.dart';
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
          body: PostDataParts()),
    );
  }
}
