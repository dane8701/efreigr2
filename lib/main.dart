import 'package:efreigrp2/controller/my_animation.dart';
import 'package:efreigrp2/my_dashboard.dart';
import 'package:flutter/material.dart';

void main() {
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
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //Image
            MyAnimation(
              duree: 1,
                child: Image.network("https://i.ytimg.com/vi/pmR7XyTE-9M/maxresdefault.jpg")),

            const SizedBox(height: 10,),
            //adresse mail
            TextField(
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
            const SizedBox(height: 10,),
            TextField(
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
            const SizedBox(height: 15,),
            ElevatedButton(
                onPressed: (){
                  print("Je m'isncris");
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return MyDashboard(mail: email,password: password.text,);
                      }
                  ));
                },
                child: Text("Inscription")
            )




            //mot de passe


            //bouton
          ],
        ),
      )
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
