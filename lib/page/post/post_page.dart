import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kagura_geihoku/home_screen.dart';
import 'package:kagura_geihoku/page/post/post_page_model.dart';
import 'package:provider/provider.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostPageModel>(
        create: (_) => PostPageModel(),
        child: Consumer<PostPageModel>(builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('投稿ページ'),
              actions: [
                if (model.name != null && model.episode != null)
                  ElevatedButton(
                      onPressed: () async {
                        await model.addPost();
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                  title: Text('保存しますか？'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen()));
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
            body: Center(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                ),
                Text('以下の事項埋めてください\n'
                    '１.郷土芸能の名前\n'
                    '2.あなたの感じる魅力\n'
                    '3.郷土芸能の写真'),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: SizedBox(
                            width: 300,
                            child: Column(
                              children: [
                                TextField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  onChanged: (text) {
                                    model.name = text;
                                  },
                                  decoration:
                                      const InputDecoration(hintText: '名称（必須）'),
                                  autofocus: true,
                                ),
                                TextField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  onChanged: (text) {
                                    model.area = text;
                                  },
                                  decoration:
                                      const InputDecoration(hintText: 'どこの芸能'),
                                ),
                                TextField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  onChanged: (text) {
                                    model.kaguraGrope = text;
                                  },
                                  decoration:
                                      const InputDecoration(hintText: '団体名'),
                                ),
                                TextField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  onChanged: (text) {
                                    model.episode = text;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: 'あなたの感じる魅力（必須）'),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(children: [
                                    GestureDetector(
                                      child: SizedBox(
                                          height: 200,
                                          width: 300,
                                          child: model.imageFile != null
                                              ? Image.file(model.imageFile!)
                                              : Icon(Icons.photo)),
                                      onTap: () async {
                                        await model.pickImage();
                                      },
                                    ),
                                    GestureDetector(
                                      child: SizedBox(
                                          height: 200,
                                          width: 300,
                                          child: model.imageVideo != null
                                              ? Image.file(model.imageVideo!)
                                              : Icon(Icons.movie)),
                                      onTap: () async {
                                        final pickedFile = await model.picker
                                          ..pickVideo(
                                              source: ImageSource.gallery);
                                        if (pickedFile != null) {
                                          model.pickVideo();
                                        }
                                      },
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          );
        }));
  }
}
