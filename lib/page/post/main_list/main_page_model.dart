import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kagura_geihoku/domain/kagura.dart';

class MainPageModel extends ChangeNotifier {
  List<Kagura>? kaguraData;

  void kaguraFetchList() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('kaguraData').get();
    final List<Kagura> kaguraData =
        snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String episode = data['episode'];
      final String name = data['name'];
      final String? imgURL = data['imgURL'];
      final Timestamp? createdTime = data['createdTime'];
      final Timestamp? updateTime = data['updateTime'];
      return Kagura(id, episode, name, imgURL, createdTime, updateTime);
    }).toList();

    this.kaguraData = kaguraData;
    notifyListeners();
  }

  Future delete(Kagura kagura) {
    return FirebaseFirestore.instance
        .collection('kaguraData')
        .doc(kagura.id)
        .delete();
  }
}
