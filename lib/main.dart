import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tp1exercice3/proposition.dart';
import 'package:tp1exercice3/propositionDatabase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //On initialise notre Hive Box
  await PropositionBox.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suivi de job',
      theme: ThemeData(
        primarySwatch: Colors.grey,
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
      floatingActionButton: FloatingActionButton(
        onPressed: goToProposition,
        child: const Icon(Icons.add),
      ),
    );
  }
}

//class de l'objet proposition (affiche les informations des propositions)
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
                  Text("Salaire brut annuel : " + proposition.salaireBrutAnuel,
                      style: TextStyle(color: Colors.grey[500], fontSize: 16)),
                  Text("Salaire net mensuel : " + proposition.salaireNetMensuel,
                      style: TextStyle(color: Colors.grey[500], fontSize: 16)),
                  Text("Statut propose : " + proposition.statutPropose,
                      style: TextStyle(color: Colors.grey[500], fontSize: 16)),
                  Text("Mon sentiment : " + proposition.mesSentiments,
                      style: TextStyle(color: Colors.grey[500], fontSize: 16))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

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

  void ajouterProposition() {
    String entreprise = myEntrepriseController.text;
    String salaireBrutAnuel = mySalaireBrutAnuelController.text;
    String statut = myStatutController.text;
    String salaireNetMensuel = mySalaireNetMensuelController.text;
    String sentiment = mySentimentController.text;
    Proposition proposition = new Proposition(
        entreprise, salaireBrutAnuel, statut, salaireNetMensuel, sentiment);

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
            TextField(
              controller: myStatutController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText:
                    'Choix statut proposé : Cadre (25%) / Non cadre (22%)',
              ),
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
