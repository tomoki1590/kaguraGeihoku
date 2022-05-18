import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth_model.dart';
import '../log_in/login_page.dart';
import 'signup_model.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('新規登録'),
        ),
        body: Center(
          child: Consumer<SignUpModel>(builder: (context, model, child) {
            return Column(
              children: [
                // CircleAvatar(
                //   foregroundImage: image == null ? null : FileImage(image!),
                //   radius: 50,
                //   child: const Icon(Icons.add),
                // ),
                SizedBox(
                  width: 300,
                  child: TextField(
                     onChanged: (text) {
                                    model.myName = text;
                                  },
                    decoration: const InputDecoration(hintText: '名前'),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                     onChanged: (text) {
                                    model.homeArea = text;
                                  },
                    decoration: const InputDecoration(hintText: '出身地域'),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                     onChanged: (text) {
                                    model.likeTraditional = text;
                                  },
                    decoration: const InputDecoration(hintText: '好きな伝統・郷土芸能'),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: model.mailAdress,
                    decoration: const InputDecoration(hintText: 'メールアドレス＊'),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: model.passWord,
                    decoration: const InputDecoration(hintText: 'パスワード＊'),
                  ),
                ),
                  ElevatedButton(
                      onPressed: () async {
                        model.addAccount();
                        if (model.mailAdress.text.isNotEmpty &&
                            model.passWord.text.isNotEmpty) {
                          var result = await Authentication.signUp(
                              email: model.mailAdress.text,
                              pass: model.passWord.text);
                          {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          }
                        }
                      },
                      child: const Text("新規アカウント作成")),
              ],
            );
          }),
        ),
      ),
    );
  }
}
