
import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser{
  //attributs
  late String uid;
  late String nom;
  late String prenom;
  late String email;
  int? tel;
  String? avatar;
  List? favoris;


  //constructeur

  MyUser(){
    uid = "";
    nom = "";
    prenom = "";
    email = "";
  }

  MyUser.dataBase(DocumentSnapshot snapshot){
    uid = snapshot.id;
    Map<String,dynamic> data = snapshot.data() as Map<String,dynamic>;
    nom = data["NOM"];
    prenom = data["PRENOM"];
    email = data["EMAIL"];
    tel = data["TEL"] ?? 0;
    favoris = data["FAVORIS"]??[];
    avatar = data["AVATAR"]??"https://firebasestorage.googleapis.com/v0/b/efreigr2.appspot.com/o/Made-in-Abyss-1.jpeg?alt=media&token=8a3f20b2-42b0-40f5-9440-b8b454401ece&_gl=1*12cxcme*_ga*MjI5OTU5NDY3LjE2OTM4MjQ5OTQ.*_ga_CW55HF8NVT*MTY5NzYxMjk1Ny4zNy4xLjE2OTc2MTMyODMuNTIuMC4w";

  }

}