import 'package:cloud_firestore/cloud_firestore.dart';

import '../controller/my_firestore_helper.dart';

class Message {
  String? uid;
  String? content;
  String? senderUID;
  String? receiverUID;
  Timestamp? createdAt;

  Message({this.content, this.createdAt, this.receiverUID, this.senderUID, this.uid});

  Message.fromJson(Map<String, dynamic> json, String id) {
    uid = id;
    content = json['content'];
    senderUID = json['senderUID'];
    receiverUID = json['receiverUID'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'senderUID': senderUID,
      'receiverUID': receiverUID,
      'createdAt': createdAt
    };
  }

  bool get isMe => MyFirestoreHelper().user.uid == senderUID;
}