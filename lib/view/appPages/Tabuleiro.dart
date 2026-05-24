import 'package:flutter/material.dart';
import 'package:xadrez/model/enums/EnunTurn.dart';
import 'package:xadrez/model/mapa/MapaPart.dart';
import 'package:xadrez/controller/Controller.dart';
import 'package:xadrez/controller/Movimentos.dart';

import 'casas/Casa.dart';
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
      body: Column(
        children: List.generate(8, (row) {
          return Row(
            children: List.generate(8, (col) {
              bool isWhite = (row + col) % 2 == 0;
              Color color = isWhite ? Colors.white : Colors.brown;
              MapaColor.colors[row][col] == 20
                  ? color = Colors.greenAccent.withOpacity(0.3)
                  : color;
              MapaColor.colors[row][col] == 21
                  ? color = Colors.red.withOpacity(0.3)
                  : MapaColor.colors[row][col] == 22
                  ? color = Colors.red
                  : MapaColor.colors[row][col] == 19
                  ? color = Colors.red.withOpacity(0.4)
                  : null;
              if (MapaColor.colors[row][col] == 20) {
                MapaColor.colors[row][col] = 0;
              }
              if (MapaColor.colors[row][col] == 21) {
                MapaColor.colors[row][col] = 0;
              }
              if (MapaColor.colors[row][col] == 22) {
                MapaColor.colors[row][col] = 0;
              }
              if (MapaColor.colors[row][col] == 19) {
                if (!Tabuleiro.kingChek) {
                  MapaColor.colors[row][col] = 0;
                }
              }
              return Casa(
                color: color,
                part: Mapa.tabuleiro[row][col],
                onPressed: () {
                  setState(() {
                    Movimentos(
                      part: Mapa.tabuleiro[row][col],
                      col: col,
                      row: row,
                      color: color,
                    ).action();
                  });
                },
              );
            }),
          );
        }),
      ),
    );
  }
}
