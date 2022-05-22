import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kagura_geihoku/account/edit_account.dart';
import 'package:kagura_geihoku/account/log_in/login_page.dart';
import 'package:kagura_geihoku/account/userdata.dart';
import 'package:kagura_geihoku/post_data_parts.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    return ChangeNotifierProvider<UserModel>(
      create: (_) => UserModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('アカウントページ'),
          actions: [
            ElevatedButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(title: Text('編集しますか？'), actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditAccount()));
                              },
                              child: Text('yes')),
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('no'))
                        ]);
                      });
                },
                child: Text('編集'))
          ],
        ),
        body: SingleChildScrollView(
          child: Consumer<UserModel>(builder: (context, model, child) {
            return Column(
              children: [
                GestureDetector(
                  child: CircleAvatar(
                    radius: 50,
                  ),
                  onTap: () {},
                ),
                Text('ユーザーネーム：${model.mail}'),
                Text('出身地域：'),
                Text('好きな伝統・郷土芸能：'),
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
        drawer: Consumer<UserModel>(builder: (context, model, child) {
          return Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Column(
                    children: [
                      Text('アプリ情報'),
                      ListTile(
                        title: Text('アカウントID：${model.myName}'),
                      ),
                      ListTile(
                        title: Text('登録されたアドレス:'),
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
