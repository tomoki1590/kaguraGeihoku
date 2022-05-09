import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kagura_geihoku/page/post/post_page_model.dart';
import 'package:provider/provider.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostPageModel>(
        create: (_) => PostPageModel(),
        child: Scaffold(
          body: Center(
            child: Consumer<PostPageModel>(builder: (context, model, child) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                                    controller: model.nameController,
                                    decoration:
                                        const InputDecoration(hintText: '名称'),
                                    autofocus: true,
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    controller: model.areaController,
                                    decoration: const InputDecoration(
                                        hintText: 'どこの芸能'),
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    controller: model.kaguraGropeController,
                                    decoration:
                                        const InputDecoration(hintText: '団体名'),
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    controller: model.kaguraGropeController,
                                    decoration: const InputDecoration(
                                        hintText: 'あなたの感じる魅力'),
                                  ),
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
                                  ElevatedButton(
                                      onPressed: () {}, child: Text('保存')),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child: Container(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                final pickedFile = await model
                                                    .picker
                                                    .pickImage(
                                                        source: ImageSource
                                                            .gallery);

                                                if (pickedFile != null) {
                                                  model.pickImage();
                                                }
                                              },
                                              child: const Icon(Icons.photo),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                final pickedFile = await model
                                                    .picker
                                                  ..pickVideo(
                                                      source:
                                                          ImageSource.gallery);
                                                if (pickedFile != null) {
                                                  model.pickImage();
                                                }
                                              },
                                              child: const Icon(Icons.movie),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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
              );
            }),
          ),
        ));
  }
}
