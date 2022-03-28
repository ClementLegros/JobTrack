import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tp1exercice3/Pages/HomePage.dart';
import 'package:tp1exercice3/Models/proposition.dart';
import 'package:tp1exercice3/Models/propositionDatabase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //On initialise notre Hive Box
  await PropositionBox.init();
  runApp(const MyApp());
}
