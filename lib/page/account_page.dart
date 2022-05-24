import 'package:cloud_firestore/cloud_firestore.dart';
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
    final myId = FirebaseAuth.instance.currentUser!.uid;

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
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('myAccount')
                .doc(myId)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                    snapshot) {
              final doc = snapshot.data!;
              if (!snapshot.hasData) {
                return Center(
                  child: Text('登録後に情報でます'),
                );
              }

              return SingleChildScrollView(
                child: Consumer<UserModel>(builder: (context, model, child) {
                  return Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: doc.data()!['imagePath'] != null
                            ? FileImage(doc.data()!['imagePath'])
                            : null,
                        radius: 50,
                      ),
                      Column(
                        children: [
                          Text('ユーザーネーム：${doc.data()!['myName']}'),
                          Text('出身地域：${doc.data()!['homeArea']}'),
                          Text('好きな伝統・郷土芸能：${doc.data()!['likeTraditional']}'),
                        ],
                      ),
                      Divider(
                        color: Colors.black54,
                      ),
                      Text('過去の投稿一覧'),
                      SizedBox(height: 350, child: PostDataParts())
                    ],
                  );
                }),
              );
            }),
        drawer: Consumer<UserModel>(builder: (context, model, child) {
          final _auth = FirebaseAuth.instance;
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('myAccount')
                  .doc(myId)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                      snapshot) {
                final doc = snapshot.data!;
                if (!snapshot.hasData) {
                  return Center(
                    child: Text('登録後に情報でます'),
                  );
                }

                return Drawer(
                  child: ListView(
                    children: [
                      DrawerHeader(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text('アプリ情報'),
                              ListTile(
                                title: Text("ユーザーID\n" "${doc.data()!['uid']}"),
                              ),
                              ListTile(
                                title: Text(
                                    '登録されたアドレス\n' "${doc.data()!['email']}"),
                              )
                            ],
                          ),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                        ),
                      )
                    ],
                  ),
                );
              });
        }),
      ),
    );
  }
}
