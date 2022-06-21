import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('郷土芸能資料'),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              AlertDialog(
                title: Text('hello'),
              );
            },
            icon: Icon(Icons.add),
            label: Text('追加'),
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('神楽予定表'),
          onPressed: () => _opneUrl(),
        ),
      ),
    );
  }

  void _opneUrl() async {
    const url =
        'https://www.npo-hiroshima.jp/cgi-bin/schedule/sche36.cgi'; //←ここに表示させたいURLを入力する
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
      );
    } else {
      throw 'このURLにはアクセスできません';
    }
  }
}
