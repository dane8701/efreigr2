import 'package:efreigrp2/controller/my_firestore_helper.dart';
import 'package:efreigrp2/globale.dart';
import 'package:efreigrp2/view/my_background.dart';
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(moi.avatar ?? imageDefault),
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
          Center(child: Text("mon adresse mail est : ${moi.email}"))
        ],
      ),
    );
  }
}
