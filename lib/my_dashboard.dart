import 'dart:typed_data';

import 'package:efreigrp2/controller/my_firestore_helper.dart';
import 'package:efreigrp2/globale.dart';
import 'package:efreigrp2/view/My_Map.dart';
import 'package:efreigrp2/view/my_all_personn.dart';
import 'package:efreigrp2/view/my_background.dart';
import 'package:efreigrp2/view/my_check_map.dart';
import 'package:efreigrp2/view/my_ml_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class MyDashboard extends StatefulWidget {
  String mail;
  String password;

  MyDashboard({required this.mail,required this.password,super.key});

  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  //variable
  bool isRecorded = false;
  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  String? nameImage;
  Uint8List? dataImage;
  int indexCurrent = 1;

  //méthode
  showImagePopUp(){
    showDialog(
      barrierDismissible: false,
        context: context, 
        builder: (context){
          return AlertDialog(
            title: const Text("Souhaitez-vous enregistrer cette image ?"),
            content: Image.memory(dataImage!),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, 
                  child: const Text("NON")
              ),
              TextButton(onPressed: (){
                //enregistrer les données
                MyFirestoreHelper().StorageFiles(datasImage: dataImage!, nameImage: nameImage!, dossier: "IMAGES", uid: moi.uid).then((value) {
                  setState(() {
                    moi.avatar = value;
                  });
                  Map<String,dynamic> data = {
                    "AVATAR":moi.avatar
                  };
                  MyFirestoreHelper().updateUser(moi.uid, data);
                });

                Navigator.pop(context);
              }, child: const Text("OUI")),
            ],
            
          );
        }
    );
  }
  pickImage()async {
    
    FilePickerResult? resultat = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.image
    );
    if(resultat != null){
      nameImage = resultat.files.first.name;
      dataImage = resultat.files.first.bytes;
      showImagePopUp();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexCurrent,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.map),
            label: "Carte"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
            label: "Personne"
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.rocket_launch),
            label: "Machine Learning"
          )
        ],
        onTap: (value){
          setState(() {
            indexCurrent = value;
          });

        },
      ),
      drawer: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width *0.80,
        decoration: const BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(85),topRight:Radius.circular(85) )

        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //image
              const Spacer(),
              GestureDetector(
                onTap: (){
                  pickImage();
                },
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(moi.avatar ?? imageDefault),
                ),
              ),
              const SizedBox(height: 10,),
              (isRecorded)?TextField(
                controller: prenom,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Entrer votre prénom",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),

              ):Container(),

              const SizedBox(height: 10,),
              (isRecorded)?TextField(
                controller: nom,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Entrer votre nom",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),

              ):Container(),

              const SizedBox(height: 10,),

              (isRecorded)?ElevatedButton(
                  onPressed: (){

                    setState(() {
                      isRecorded = false;
                      moi.nom = nom.text;
                      moi.prenom = prenom.text;
                    });
                    Map<String,dynamic> data = {
                      "NOM":nom.text,
                      "PRENOM":prenom.text,
                    };
                    MyFirestoreHelper().updateUser(moi.uid, data);

                  },
                  child: const Text("Enregistrement")
              ):Container(),


              //nom et prénom
              (isRecorded)?Container():Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //icone personne
                  const Icon(Icons.person),
                  Text(moi.fullName,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  IconButton(
                      onPressed: (){
                        setState(() {
                          isRecorded = true;
                        });

                      },
                      icon: const Icon(Icons.update)
                  )
                  //icone pencil
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.mail),
                  const SizedBox(width: 5,),
                  Text(moi.email,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                ],
              ),


              //adresse mail

              const Spacer(),
              ElevatedButton.icon(
                  onPressed: (){

                  },
                  icon: const Icon(Icons.exit_to_app),
                  label: Text('Deconnexion'),

              ),
              const SizedBox(height: 25,),





              //deconnexion  personne

            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.purple,
      body: Stack(
        children: [
          const MyBackground(),
          bodyPage(),
          //Center(child: Text("mon adresse mail est : ${moi.email}"))
        ],
      ),
    );
  }
  Widget bodyPage(){
    switch(indexCurrent){
      case 0 : return const MyCheckMaps();
      case 1 : return const MyAllPersonn();
      case 2 : return const MLView();
      default: return const Text("Impossible");
    }
  }
}
