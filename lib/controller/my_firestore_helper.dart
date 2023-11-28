
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efreigrp2/model/message.dart';
import 'package:efreigrp2/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MyFirestoreHelper {
  //gérer les opérations dans la base de donnée

  //attributs
  final auth = FirebaseAuth.instance;
  final cloudUsers = FirebaseFirestore.instance.collection("UTILISATEURS");
  final cloudMessage = FirebaseFirestore.instance.collection("MESSAGES");
  final storage = FirebaseStorage.instance;
  



  //méhode


  //creation d'un utilisateur
  Future <MyUser>CreateUserDataBase(String email , String password) async {
    UserCredential credential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    String uid = credential.user!.uid;
    Map<String,dynamic> data = {
      "NOM":"",
      "PRENOM":"",
      "EMAIL":email
    };
    addUser(uid, data);
    return getUser(uid);
  }

  Future<MyUser> getUser(String uid) async {
    DocumentSnapshot snapshot = await cloudUsers.doc(uid).get();
    return MyUser.dataBase(snapshot);
  }

  Stream<List<MyUser>> get getDiscussionUser {
    return cloudUsers
        .where('uid', isNotEqualTo: MyFirestoreHelper().user.uid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => MyUser.fromJson(e.data())).toList());
  }

  addUser(String uid , Map<String,dynamic> data){
    cloudUsers.doc(uid).set(data);
  }
  updateUser(String uid , Map<String,dynamic> data){
    cloudUsers.doc(uid).update(data);
  }
  
  Stream<List<Message>> getMessage(String receiverUID, [bool myMessage = true]) {
    return cloudMessage
        .where('senderUID', isEqualTo: myMessage ? MyFirestoreHelper().user.uid : receiverUID)
        .where('receiverUID', isEqualTo: myMessage ? receiverUID : MyFirestoreHelper().user.uid)
        .snapshots()
        .map((event) => event.docs.map((e) => Message.fromJson(e.data(), e.id)).toList());
  }

  Future<bool> sendMesssage(Message msg) async {
    try {
      await cloudMessage.doc().set(msg.toJson());
      return true;
    }
    catch (e) {
      return false;
    }
  }



  //connexion d'un utilisateur
  Future<MyUser>ConnectUserDataBase(String email, String password) async {
      UserCredential credential = await auth.signInWithEmailAndPassword(email: email, password: password);
      String uid = credential.user!.uid;
      return getUser(uid);
  }

  Future<String>StorageFiles({required Uint8List datasImage,required String nameImage,required String dossier, required String uid}) async {
    TaskSnapshot snapshot = await storage.ref("$dossier/$uid/$nameImage").putData(datasImage);
    String url = await snapshot.ref.getDownloadURL();
    return url ;

  }

  User get user => FirebaseAuth.instance.currentUser!;
  Stream<User?> get onChangeUser => auth.authStateChanges();

  SignOut () async {
    try {
      await auth.signOut();
    }
    catch (e) { }
  }

  DeleteAccount(MyUser user) async {
    try {
      if(FirebaseAuth.instance.currentUser!.uid == user.uid) {
            await cloudUsers.doc(user.uid).delete();
            await FirebaseAuth.instance.currentUser!.delete();
        }
    }
    catch (e) {
      print('Erreur lors de la suppression de l\'utilisateur : $e');
    }
  }
}