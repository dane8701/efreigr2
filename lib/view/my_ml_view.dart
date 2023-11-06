import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class MLView extends StatefulWidget {
  const MLView({super.key});

  @override
  State<MLView> createState() => _MLViewState();
}

class _MLViewState extends State<MLView> {
  //variable
  TextEditingController controllerLang = TextEditingController();
  LanguageIdentifier identifier = LanguageIdentifier(confidenceThreshold: 0.5);
  String afficheLang ="";

  //méthodes
  langueIdentification() async{
    if(controllerLang != null && controllerLang.text != ""){
      String lang = controllerLang.text;

      String maLangue = await identifier.identifyLanguage(lang);
      setState(() {
        afficheLang = maLangue;
      });


    }


  }
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextField(
            controller: controllerLang,

            ),
            ElevatedButton(
                onPressed: langueIdentification,
                child: const Text("Detection d'une langue"),

            ),

            ElevatedButton(
              onPressed: langueIdentification,
              child: const Text("Detection de plusieurs langues"),

            ),
            Text(afficheLang)
          ],
        ),

    );
  }
}
