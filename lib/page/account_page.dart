import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kagura_geihoku/account/log_in/login_page.dart';
import 'package:kagura_geihoku/account/sign_up/signup_model.dart';
import 'package:kagura_geihoku/post_data_parts.dart';
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
            print('kokoha?');
            model.myAccountFetch();
            return Column(
              children: [
                GestureDetector(
                  child: CircleAvatar(
                    radius: 50,
                  ),
                  onTap: () {},
                ),
                Text('ユーザーネーム：${model.uid}'),
                Text('出身地域：${model.homeArea}'),
                Text('好きな伝統・郷土芸能：${model.likeTraditional}'),
                Text('一言コメント'),
                Divider(
                  color: Colors.black54,
                ),
                Text('過去の投稿一覧'),
                SizedBox(height: 300, child: PostDataParts())
              ],
            );
          }),
        ),
        drawer: Consumer<SignUpModel>(builder: (context, model, child) {
          return Drawer(
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
                        title: Text('登録されたアドレス:${model.mail}'),
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
                ),
                ListTile(
                  title: GestureDetector(
                    child: Text('ログイン'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
