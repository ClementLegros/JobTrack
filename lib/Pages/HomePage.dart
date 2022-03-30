import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tp1exercice3/Pages/AjoutProposistionPage.dart';
import 'package:tp1exercice3/Pages/PropositionPage.dart';
import 'package:tp1exercice3/Models/propositionDatabase.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suivi de job',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      routes: {
        '/': (context) => MyHomePage(title: 'Mon suivi de job'),
        '/addProposition': (context) =>
            AddProposition(title: 'Ajout de proposition')
      },
    );
  }
}

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
                      key: Key(proposition.entreprise),
                      onDismissed: (direction) {
                        setState(() {
                          PropositionBox.box.delete(proposition.key());
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                            Text("${proposition.entreprise} supprime")));
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