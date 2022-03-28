import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tp1exercice3/Pages/HomePage.dart';
import 'package:tp1exercice3/Models/proposition.dart';
import 'package:tp1exercice3/Models/propositionDatabase.dart';

//Class d'ajout des propositions
class AddProposition extends StatefulWidget {
  const AddProposition({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<AddProposition> createState() => _AddPropositionState();
}

class _AddPropositionState extends State<AddProposition> {
  final myEntrepriseController = TextEditingController();
  final mySalaireBrutAnuelController = TextEditingController();
  final myStatutController = TextEditingController();
  final mySalaireNetMensuelController = TextEditingController();
  final mySentimentController = TextEditingController();

  bool _value = false;
  int val = -1;

  void ajouterProposition() {
    String entreprise = myEntrepriseController.text;
    String salaireBrutAnuel = mySalaireBrutAnuelController.text;
    String statut = myStatutController.text;
    String salaireNetMensuel = mySalaireNetMensuelController.text;
    String sentiment = mySentimentController.text;
    Proposition proposition = new Proposition(
        entreprise, double.parse(salaireBrutAnuel), statut, double.parse(salaireNetMensuel), sentiment);
    PropositionBox.box.put(proposition.key(), proposition);
    // On retourne a la page d'accueil
    Navigator.pushNamed(context, '/');
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myEntrepriseController.dispose();
    mySalaireBrutAnuelController.dispose();
    myStatutController.dispose();
    mySalaireNetMensuelController.dispose();
    mySentimentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: myEntrepriseController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Entrez le nom d\' une entreprise',
              ),
            ),
            TextField(
              controller: mySalaireBrutAnuelController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Salaire brut annuel',
              ),
            ),
            ListTile(
              title: Text("Non cadre (22%)"),
              leading: Radio(
                value: 1,
                groupValue: val,
                onChanged: (value) {
                  setState(() {
                    val = int.parse(value.toString());
                  });
                },
                activeColor: Colors.green,
              ),
            ),
            ListTile(
              title: Text("Cadre (25%)"),
              leading: Radio(
                value: 2,
                groupValue: val,
                onChanged: (value) {
                  setState(() {
                    val = int.parse(value.toString());
                  });
                },
                activeColor: Colors.green,
              ),
            ),
            TextField(
              controller: myStatutController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText:
                'Choix statut proposé : Cadre (25%) / Non cadre (22%)',
              ),
            ),
            DropdownButton(
              onChanged: (String? newValue) {
                setState(() {});
              },
              items: <String>['Cadre (25%)', 'Non cadre (22%)']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              controller: mySalaireNetMensuelController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Salaire net mensuel',
              ),
            ),
            TextField(
              controller: mySentimentController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Mon sentiment',
              ),
            ),
            FloatingActionButton(
              onPressed: ajouterProposition,
              backgroundColor: Colors.lightBlue,
              tooltip: 'Ajouter une proposition',
              child: const Icon(Icons.add),
              //backgroundColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
