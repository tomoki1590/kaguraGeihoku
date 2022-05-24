import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'sign_up/signup_model.dart';

class EditAccount extends StatelessWidget {
  const EditAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpModel>(
      create: (_) => SignUpModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('アカウント情報の編集'),
          actions: [ElevatedButton(onPressed: () {}, child: Text('保存'))],
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
              ],
            );
          }),
        ),
      ),
    );
  }
}
