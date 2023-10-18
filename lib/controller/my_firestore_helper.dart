
import 'package:cloud_firestore/cloud_firestore.dart';
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
  CreateUserDataBase(String email , String password) async {
    UserCredential credential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    String uid = credential.user!.uid;
    Map<String,dynamic> data = {
      "NOM":"",
      "PRENOM":"",
      "EMAIL":email
    };
    addUser(uid, data);


  }

  addUser(String uid , Map<String,dynamic> data){
    cloudUsers.doc(uid).set(data);

  }



  //connexion d'un utilisateur




}