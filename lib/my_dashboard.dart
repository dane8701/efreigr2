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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.purple,
      body: Stack(
        children: [
          MyBackground(),
          Center(child: Text("mon adresse mail est : ${moi.email}"))
        ],
      ),
    );
  }
}
