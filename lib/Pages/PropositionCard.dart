import 'package:flutter/material.dart';
import 'package:tp1exercice3/Models/proposition.dart';

//Cette page permet de modéliser les Card des propositions qui seront afficher dans HomePage.dart

class PropositionItemWidget extends StatelessWidget {
  const PropositionItemWidget({Key? key, required this.proposition})
      : super(key: key);
  final Proposition proposition;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.all(8),
        elevation: 8,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(proposition.entreprise,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  Text(
                      "Salaire brut annuel : " +
                          proposition.salaireBrutAnuel.toString(),
                      style: TextStyle(color: Colors.grey[500], fontSize: 16)),
                  Text(
                      "Salaire net mensuel : " +
                          proposition.salaireNetMensuel.toString(),
                      style: TextStyle(color: Colors.grey[500], fontSize: 16)),
                  Text("Statut propose : " + proposition.statutPropose,
                      style: TextStyle(color: Colors.grey[500], fontSize: 16)),
                  Text("Mon sentiment : " + proposition.mesSentiments,
                      style: TextStyle(color: Colors.grey[500], fontSize: 16)),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
