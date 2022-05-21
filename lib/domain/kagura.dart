import 'package:cloud_firestore/cloud_firestore.dart';

class Kagura {
  Kagura(this.id, this.episode, this.name, this.imgURL, this.createdTime,
      this.updateTime);
  String id;
  String name;
  String episode;
  String? imgURL;
  Timestamp? createdTime;
  Timestamp? updateTime;
}

class Account {
  Account(this.id, this.myName, this.homeArea, this.likeTraditional);
  String? myName;
  String? homeArea;
  String? likeTraditional;
  String? id;
}
