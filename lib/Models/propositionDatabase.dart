import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tp1exercice3/Models/proposition.dart';

class PropositionBox {
  static final PropositionBox instance = PropositionBox();
  static late Box box;

  //Initialise la Box Hive
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
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
    Proposition("Google", 200, "cadre", 300, "Google c'est google"),
    Proposition(
        "Facebook", 200, "cadre", 300, "React native c'est pas mal"),
    Proposition("Amazon", 900, "cadre", 300, "Bon pour apprendre l'AWS"),
    Proposition("Netflix", 700, "cadre", 300, "Abonnement moins chere"),
    Proposition("Microsoft", 100, "cadre", 300, "windows oof"),
  ];
}
