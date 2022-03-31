import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tp1exercice3/Pages/PropositionCard.dart';
import 'package:tp1exercice3/Models/propositionDatabase.dart';
import 'package:tp1exercice3/Widget/slideLeftWidget.dart';
import 'package:tp1exercice3/Widget/slideRightWidget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Function pour aller a la page d'ajout
  void goToProposition() {
    Navigator.pushNamed(context, '/addProposition');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ValueListenableBuilder(
          //On recupere les valeurs contenue dans notre box
          valueListenable: PropositionBox.box.listenable(),
          builder: (context, Box items, _) {
            List<String> keys = items.keys.cast<String>().toList();
            //Permet d'afficher les Propositions
            return ListView.builder(
                itemCount: keys.length,
                itemBuilder: (context, index) {
                  final proposition = items.get(keys[index]);
                  //Permet de supprimer une proposition
                  return Dismissible(
                      background: slideRight(),
                      secondaryBackground: slideLeftWidget(),
                      key: Key(proposition.entreprise),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text(
                                      "Voulez vous supprimé l'offre de ${proposition.entreprise}"),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          "Annuler",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                    FlatButton(
                                        onPressed: () {
                                          setState(() {
                                            PropositionBox.box
                                                .delete(proposition.key());
                                          });
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text(
                                                  "${proposition.entreprise} à été supprimé")));
                                        },
                                        child: Text(
                                          "Supprimé",
                                          style: TextStyle(color: Colors.red),
                                        ))
                                  ],
                                );
                              });
                        } else {
                          return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text(
                                      "Voulez vous modifier l'offre de ${proposition.entreprise}"),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          "Annuler",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.pushNamed(
                                              context, '/ModifierProposition',
                                              arguments: proposition);
                                        },
                                        child: Text(
                                          "Modifier",
                                          style: TextStyle(color: Colors.blue),
                                        ))
                                  ],
                                );
                              });
                        }
                      },
                      onDismissed: (direction) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "${proposition.entreprise} à été supprimé")));
                      },
                      child: PropositionItemWidget(
                        key: Key(proposition.key()),
                        proposition: proposition,
                      ));
                });
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: goToProposition,
        icon: const Icon(Icons.add),
        label: const Text('Ajouter une proposition'),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}
