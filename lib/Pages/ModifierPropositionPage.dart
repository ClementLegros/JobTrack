import 'package:flutter/material.dart';
import 'package:tp1exercice3/Models/proposition.dart';
import 'package:tp1exercice3/Models/propositionDatabase.dart';


class ModifierPropositionPage extends StatefulWidget {
  const ModifierPropositionPage({Key? key, required this.proposition})
      : super(key: key);
  final Proposition proposition;

  @override
  State<ModifierPropositionPage> createState() => _ModifierPropositionState();
}

class _ModifierPropositionState extends State<ModifierPropositionPage> {
  final myEntrepriseController = TextEditingController();
  final mySalaireBrutAnuelController = TextEditingController();
  final mySalaireNetMensuelController = TextEditingController();
  final mySentimentController = TextEditingController();

  //On initialise les text
  @override
  void initState() {
    myEntrepriseController.text = widget.proposition.entreprise;
    mySalaireBrutAnuelController.text =
        widget.proposition.salaireBrutAnuel.toString();
    mySalaireNetMensuelController.text =
        widget.proposition.salaireNetMensuel.toString();
    mySentimentController.text = widget.proposition.mesSentiments;
    if (widget.proposition.statutPropose == "Non cadre") {
      val = 1;
    }
    else {
      val = 2;
    }
  }

  String statut = "";

  bool _value = false;
  int val = -1;

  //Fonction déclancher lorsqu'on écrit dans salaire BrutAnnuel ou en appuyant sur les radios buttons
  void calculSalaire(salaireBrutAnnuel) {
    //On vérifie si la valeur récupérer est bien un double
    var salaireBrutAnnu = double.tryParse(salaireBrutAnnuel);
    if (salaireBrutAnnu == null) {
      //Si le champs est mal renseigner on remet à 0 le champs net
      mySalaireNetMensuelController.text = "";

      return;
    }
    //Test pour savoir quel checkbox est coché
    if (val == 1) {
      //Non cadre 22%
      statut = "Non cadre";
      salaireBrutAnnu = salaireBrutAnnu - (22 / 100 * salaireBrutAnnu);
      mySalaireNetMensuelController.text = salaireBrutAnnu.toString();
    } else if (val == 2) {
      //Cadre 25%
      statut = "Cadre";
      salaireBrutAnnu = salaireBrutAnnu - (25 / 100 * salaireBrutAnnu);
      mySalaireNetMensuelController.text = salaireBrutAnnu.toString();
    }
  }

  //Function déclancher par le button d'ajout
  void ajouterProposition() {
    //Récupération des informations contenue dans les champs de texte
    String entreprise = myEntrepriseController.text;
    String salaireBrutAnuel = mySalaireBrutAnuelController.text;
    String salaireNetMensuel = mySalaireNetMensuelController.text;
    String sentiment = mySentimentController.text;

    //On crée une proposition et on l'ajoute à notre Box
    Proposition newProposition = new Proposition(
        entreprise,
        double.parse(salaireBrutAnuel),
        statut,
        double.parse(salaireNetMensuel),
        sentiment);
    PropositionBox.box.delete(widget.proposition.key());
    PropositionBox.box.put(newProposition.key(), newProposition);

    // On retourne a la page d'accueil
    Navigator.pushNamed(context, '/');
  }

  @override
  void dispose() {
    // Nettoyage des controllers
    myEntrepriseController.dispose();
    mySalaireBrutAnuelController.dispose();
    mySalaireNetMensuelController.dispose();
    mySentimentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Modifier la proposition de " + widget.proposition.entreprise),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 2),
            TextField(
              controller: myEntrepriseController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Entrez le nom d\' une entreprise',
                  hintStyle: TextStyle(color: Colors.grey[400])),
            ),
            Spacer(flex: 1),
            TextField(
              controller: mySalaireBrutAnuelController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Salaire brut annuel',
                  hintStyle: TextStyle(color: Colors.grey[400])),
              onChanged: (text) {
                calculSalaire(text.toString());
              },
            ),
            Spacer(flex: 1),
            ListTile(
              title: Text("Non cadre (22%)"),
              leading: Radio(
                value: 1,
                groupValue: val,
                onChanged: (value) {
                  setState(() {
                    val = int.parse(value.toString());
                  });
                  //On effectue le calcul de salaire après pour que la fonctionne puisse détecter le changement de val, sinon lors du premier click sur un RB aucun affichage ne serait fait
                  calculSalaire(mySalaireBrutAnuelController.text);
                },
                activeColor: Colors.lightBlue,
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
                  //On effectue le calcul de salaire après pour que la fonctionne puisse détecter le changement de val, sinon lors du premier click sur un RB aucun affichage ne serait fait
                  calculSalaire(mySalaireBrutAnuelController.text);
                },
                activeColor: Colors.lightBlue,
              ),
            ),
            Spacer(flex: 1),
            TextField(
              controller: mySalaireNetMensuelController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Salaire net mensuel',
                  hintStyle: TextStyle(color: Colors.grey[400])),
            ),
            Spacer(flex: 1),
            TextField(
              controller: mySentimentController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Mon sentiment',
                  hintStyle: TextStyle(color: Colors.grey[400])),
            ),
            Spacer(flex: 1),
            FloatingActionButton(
              onPressed: ajouterProposition,
              backgroundColor: Colors.lightBlue,
              tooltip: 'Modifier la proposition',
              child: const Icon(Icons.edit),
              //backgroundColor: Colors.white,
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
