import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tp1exercice3/Models/proposition.dart';


class PropositionPage extends StatelessWidget {
  const PropositionPage({Key? key, required this.proposition}) : super(key: key);
  final Proposition proposition;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
              "Salaire brut annuel : " +
                  proposition.salaireBrutAnuel.toString(),
              style: TextStyle(fontSize: 40)),
          Text(
              "Salaire net mensuel : " +
                  proposition.salaireNetMensuel.toString(),
              style: TextStyle(fontSize: 40)),
          Text("Statut propose : " + proposition.statutPropose,
              style: TextStyle(fontSize: 40)),
          Text("Mon sentiment : " + proposition.mesSentiments,
              style: TextStyle(fontSize: 40)),
          ]
        
    );
  }
}