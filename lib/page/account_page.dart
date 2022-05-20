import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kagura_geihoku/account/sign_up/signup_model.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    return ChangeNotifierProvider<SignUpModel>(
      create: (_) => SignUpModel()..myAccountFetch,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('アカウントページ'),
          actions: [
            ElevatedButton(
                onPressed: () async {
                  // await model.addPost();
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(title: Text('保存しますか？'), actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('yes')),
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('no'))
                        ]);
                      });
                },
                child: Text('保存'))
          ],
        ),
        body: SingleChildScrollView(
          child: Consumer<SignUpModel>(builder: (context, model, child) {
            return Column(
              children: [
                GestureDetector(
                  child: CircleAvatar(
                    radius: 50,
                  ),
                  onTap: () {},
                ),
                Text('ユーザーネーム：${model.myName}'),
                Text('出身地域：${model.homeArea}'),
                Text('好きな伝統・郷土芸能：${model.likeTraditional}'),
                Text('一言コメント'),
                Divider(
                  color: Colors.black54,
                ),
                Text('過去の投稿一覧'),
              ],
            );
          }),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    Text('アプリ情報'),
                    ListTile(
                      title: Text('アカウントID：'),
                    ),
                    ListTile(
                      title: Text('登録されたアドレス'),
                    )
                  ],
                ),
              ),
              ListTile(
                title: GestureDetector(
                  child: Text('ログアウト'),
                  onTap: () {
                    _auth.signOut();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
