import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tp1exercice3/Models/proposition.dart';


class PropositionPage extends StatelessWidget {
  const PropositionPage({Key? key, required this.proposition}) : super(key: key);
  final Proposition proposition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proposition')
      ),
      body: Center(
        child: Text(proposition.entreprise),
      ),
    );
  }
}