import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class PostPageModel extends ChangeNotifier {
  final nameController = TextEditingController();
  final areaController = TextEditingController();
  final kaguraGropeController = TextEditingController();
  final episodeController = TextEditingController();
  VideoPlayerController? controller;
  String? episode;
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
    final doc = FirebaseFirestore.instance.collection('kaguraData').doc();
    if (imageFile != null) {
      //imageFileをストレージにあげる
      final task = await FirebaseStorage.instance
          .ref('kaguraData/${doc.id}')
          .putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL();
    }
    await doc.set({
      'name': name,
      'episode': episode,
      'area': area,
      'kaguraGrope': kaguraGrope,
      'imgURL': imgURL,
      'createdTime': Timestamp.now()
    });
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future pickVideo() async {
    final pickedVideo = await picker.pickVideo(source: ImageSource.gallery);
    controller = VideoPlayerController.file(File(pickedVideo!.path));
    imageVideo = File(pickedVideo.path);
    controller!.play();
    notifyListeners();
  }
}
