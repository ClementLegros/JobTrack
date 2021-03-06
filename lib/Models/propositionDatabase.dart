import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tp1exercice3/Models/proposition.dart';

class PropositionBox {
  static final PropositionBox instance = PropositionBox();
  static late Box box;

  //Initialise la Box Hive
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PropositionAdapter());
    box = await Hive.openBox('propositionsBox');
    var values = box.values;
    if (values == null || values.isEmpty) {
      PropositionBox.box.putAll(
          Map.fromIterable(propositions, key: (e) => e.key(), value: (e) => e));
    }
  }

  //Jeux d'essaie, les valeurs sont des valeurs fictive
  static final List<Proposition> propositions = [
    Proposition("Google", 200, "Cadre", 300, "Google c'est google"),
    Proposition(
        "Facebook", 200, "Cadre", 300, "React native c'est pas mal"),
    Proposition("Amazon", 900, "Non cadre", 300, "Bon pour apprendre l'AWS"),
    Proposition("Netflix", 700, "Non cadre", 300, "Abonnement moins chere"),
    Proposition("Microsoft", 100, "Cadre", 300, "windows oof"),
  ];
}
