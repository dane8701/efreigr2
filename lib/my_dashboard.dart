import 'package:flutter/material.dart';

class MyDashboard extends StatefulWidget {
  String mail;
  String password;
  MyDashboard({required this.mail,required this.password,super.key});

  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seconde page"),
      ),
      body: Text("mon adresse mail est : ${widget.mail} avec  ${widget.password} comme mot de passe"),
    );
  }
}
