import 'package:flutter/material.dart';
import 'package:kagura_geihoku/account/sign_up/signup_model.dart';
import 'package:provider/provider.dart';

import '../log_in/login_page.dart';

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
                GestureDetector(
                    onTap: () async {
                      await model.pickImage();
                    },
                    child: CircleAvatar(
                      backgroundImage: model.imageFile != null
                          ? FileImage(model.imageFile!)
                          : null,
                      radius: 100,
                    )),
                Text('注意：＊は必須項目です'),
                SizedBox(
                  width: 300,
                  child: TextField(
                      controller: model.nameController,
                      decoration: const InputDecoration(hintText: '名前＊'),
                      onChanged: (text) {
                        model.myName;
                      }),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: model.homeAreaController,
                    decoration: const InputDecoration(hintText: '出身地域'),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: model.likeController,
                    decoration: const InputDecoration(hintText: '好きな伝統・郷土芸能'),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: model.mailAdress,
                    decoration: const InputDecoration(hintText: 'メールアドレス＊'),
                    onChanged: (text) {
                      model.mail;
                    },
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: model.passWord,
                    decoration: const InputDecoration(hintText: 'パスワード＊'),
                    onChanged: (text) {
                      model.pass;
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await model.SignUp();
                      if (model.mailAdress.text.isNotEmpty &&
                          model.passWord.text.isNotEmpty &&
                          model.nameController.text.isNotEmpty) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
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
