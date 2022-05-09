import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_model.dart';
import 'page/account_page.dart';
import 'page/chat_page.dart';
import 'page/post/main_list/main_page.dart';
import 'page/post/post_page.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  List<Widget> tabs = <Widget>[
    MainPage(),
    PostPage(),
    ChatPage(),
    AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainModel(),
      child: Consumer<MainModel>(builder: (context, model, child) {
        return SafeArea(
          child: Scaffold(
            body: tabs[model.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: model.currentIndex,
              onTap: (index) {
                model.currentIndex = index;
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: '一覧ページ'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.photo), label: '投稿ページ'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat), label: 'チャットページ'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_box_outlined), label: 'アカウントページ'),
              ],
              selectedItemColor: Colors.amber,
              unselectedItemColor: Colors.black,
            ),
          ),
        );
      }),
    );
  }
}
