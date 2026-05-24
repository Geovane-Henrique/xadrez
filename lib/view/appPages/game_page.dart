import 'package:flutter/material.dart';
import 'package:xadrez/model/enums/EnunTurn.dart';
import 'package:xadrez/model/mapa/MapaPart.dart';
import 'package:xadrez/controller/Controller.dart';
import 'package:xadrez/controller/Movimentos.dart';
import 'package:xadrez/view/appPages/widgets/tabuleiro.dart';

import '../../model/mapa/MapaColor.dart';

class Tabuleiro extends StatefulWidget {
  static List<int> partSaved = [0, 0, 0];
  static Turn vez = Turn.brancas;
  static bool towerRightWhiteRock = false;
  static bool towerLeftWhiteRock = false;
  static bool towerRightBlackRock = false;
  static bool towerLeftBlackRock = false;
  static bool kingChek = false;

  const Tabuleiro({super.key});

  @override
  State<Tabuleiro> createState() => _TabuleiroState();
}

class _TabuleiroState extends State<Tabuleiro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.grey, title: Text("Xadrez")),
      body: tabuleiro(),
    );
  }
}
