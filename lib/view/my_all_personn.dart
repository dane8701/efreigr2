import 'package:flutter/material.dart';

class MyAllPersonn extends StatefulWidget {
  const MyAllPersonn({super.key});

  @override
  State<MyAllPersonn> createState() => _MyAllPersonnState();
}

class _MyAllPersonnState extends State<MyAllPersonn> {
  @override
  Widget build(BuildContext context) {
    return const Center(child:  Text("Afficher toutes les personnes"));
  }
}
