import 'package:efreigrp2/controller/my_animation.dart';
import 'package:efreigrp2/controller/my_firestore_helper.dart';
import 'package:efreigrp2/controller/my_permission_access_photo.dart';
import 'package:efreigrp2/globale.dart';
import 'package:efreigrp2/my_dashboard.dart';
import 'package:efreigrp2/view/my_background.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51GQ8hTDVXOXIy9UxpbYscBnuiq9FTW63gCk5agdRp2JOjym1NvC03WVaEBdj6wwFkJzAeCit9ZA77sBTeQHaI9rI00fsdMSCog";
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MyPermissionAccessPhoto().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //variables
  String email= "";
  TextEditingController password = TextEditingController();


  //méthode
  popError(){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return AlertDialog(
            title: const Text("adresse mail ou mot de passe erronée"),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text("OK")
              ),
            ],
          );
        }
    );
  }



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.transparent,
        elevation: 0,

      ),
      backgroundColor: Colors.purple,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const MyBackground(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30,),
                //Image
                MyAnimation(
                  duree: 1,
                    child: Image.network("https://i.ytimg.com/vi/pmR7XyTE-9M/maxresdefault.jpg")),

                const SizedBox(height: 10,),
                //adresse mail
                MyAnimation(
                  duree: 2,
                  child: TextField(
                    onChanged: (valueTapped){
                      setState(() {
                        email = valueTapped;
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: const Icon(Icons.mail),
                      fillColor: Colors.amber,
                      hintText: "Entrer votre mail",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                      )
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                MyAnimation(
                  duree: 3,
                  child: TextField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                        filled: true,
                        suffixIcon: const Icon(Icons.remove_red_eye),
                        prefixIcon: const Icon(Icons.lock),
                        fillColor: Colors.amber,
                        hintText: "Entrer votre password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                        )
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                MyAnimation(
                  duree: 4,
                  child: ElevatedButton(
                      onPressed: (){
                        print("Je m'isncris");
                        MyFirestoreHelper().CreateUserDataBase(email, password.text).then((value) {
                          setState(() {
                            moi = value;
                          });
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context){
                                return MyDashboard(mail: email,password: password.text,);
                              }
                          ));
                        }).catchError((onError){
                          popError();
                        });

                      },
                      child: Text("Inscription")
                  ),
                ),


                MyAnimation(
                  duree: 5,
                  child: ElevatedButton(
                      onPressed: (){
                        MyFirestoreHelper().ConnectUserDataBase(email, password.text)
                            .then((value) {
                              setState(() {
                                moi = value;
                              });
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context){
                                return MyDashboard(mail: email,password: password.text,);
                              }
                          ));

                        })
                            .catchError((onError){
                          // un message d'erreur
                          popError();
                        });


                      },
                      child: Text("Connexion")
                  ),
                ),




                //mot de passe


                //bouton
              ],
            ),
          ),
        ],
      )
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
