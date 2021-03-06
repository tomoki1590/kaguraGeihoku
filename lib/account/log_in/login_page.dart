import 'package:flutter/material.dart';
import 'package:kagura_geihoku/account/log_in/login_model.dart';
import 'package:kagura_geihoku/account/sign_up/signup_page.dart';
import 'package:provider/provider.dart';

import '../../home_screen.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
      create: (_) => LoginModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("入団"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Consumer<LoginModel>(builder: (context, model, child) {
              return Column(
                children: [
                  Container(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: TextField(
                        controller: model.mailAdress,
                        decoration: const InputDecoration(hintText: "メールアドレス"),
                        onChanged: (text) {
                          model.mailAdress.text;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: model.passWord,
                      decoration: const InputDecoration(hintText: 'パスワード'),
                      onChanged: (text) {
                        model.passWord.text;
                      },
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (model.mail != null &&
                            model.pass != null) //TODO Userの有無によって許可
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));

                        try {
                          await model.emailSignIn();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        } catch (e) {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(e.toString()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: const Text('Login')),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                        if (model.mail == null ||
                            model.pass == null) //TODO ログのデータに変更すべき
                        {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('ゲストとして参加中'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Text('ゲストとして参加する')),
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text("初めての方はこちらから"),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },

                      ///TODOサインアップ処理
                      child: const Text("新規登録")),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
