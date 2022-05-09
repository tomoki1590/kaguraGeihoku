import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kagura_geihoku/domain/kagura.dart';

class MainPageModel extends ChangeNotifier {
  List<Kagura>? kagura;

  void kaguraFetchList() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('kagura').get();
    final List<Kagura> kagura = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String area = data['area'];
      final String name = data['name'];
      final String gropeName = data['gropeName'];
      final String? imgURL = data['imgURL'];
      return Kagura(id, area, name, gropeName, imgURL);
    }).toList();

    this.kagura = kagura;
    notifyListeners();
  }

  Future delete(Kagura kagura) {
    return FirebaseFirestore.instance
        .collection('kagura')
        .doc(kagura.id)
        .delete();
  }
}
