import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostPageModel extends ChangeNotifier {
  final nameController = TextEditingController();
  final areaController = TextEditingController();
  final kaguraGropeController = TextEditingController();

  String? name;
  String? area;
  String? kaguraGrope;
  File? imageFile;
  File? imageVideo;
  File? image;
  String? imgURL;
  bool? isLoading = false;

  final picker = ImagePicker();
  Future addPost() async {
    final doc = FirebaseFirestore.instance.collection('kagura').doc();
    if (imageFile != null) {
      //imageFileをストレージにあげる
      final task = await FirebaseStorage.instance
          .ref('kagura/${doc.id}')
          .putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL();
      notifyListeners();
    }
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }
}
