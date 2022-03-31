import 'package:flutter/material.dart';
import 'package:tp1exercice3/Models/proposition.dart';
import 'package:tp1exercice3/Pages/AjoutProposistionPage.dart';
import 'package:tp1exercice3/Pages/HomePage.dart';
import 'package:tp1exercice3/Models/propositionDatabase.dart';
import 'package:tp1exercice3/Pages/PropositionPage.dart';

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
      initialRoute: '/',
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (context) => MyHomePage(title: 'Accueil'));
      case '/addProposition':
        return MaterialPageRoute(builder: (context) => AddProposition(title: 'Ajout'));
      case '/Proposition':
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation)=> PropositionPage(proposition: settings.arguments as Proposition),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              animation = CurvedAnimation(curve: Curves.ease, parent: animation);
              return FadeTransition(
                opacity:animation,
                child: child,
              );
            }
        );

      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                appBar: AppBar(title:Text("Error"), centerTitle: true),
                body: Center(
                  child: Text("Page not found"),
                )
            )
        );
    }

  }
}