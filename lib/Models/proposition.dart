import 'package:hive/hive.dart';
part 'proposition.g.dart';

@HiveType(typeId: 0)
class Proposition {
  //Les champs sont initialiser en String car l'applications en requiert pas de calcul
  @HiveField(0)
  String entreprise;
  @HiveField(1)
  double salaireBrutAnuel;
  @HiveField(2)
  String statutPropose;
  @HiveField(3)
  double salaireNetMensuel;
  @HiveField(4)
  String mesSentiments;

  Proposition(this.entreprise, this.salaireBrutAnuel, this.statutPropose,
      this.salaireNetMensuel, this.mesSentiments);

  String key() => entreprise.hashCode.toString();
}
