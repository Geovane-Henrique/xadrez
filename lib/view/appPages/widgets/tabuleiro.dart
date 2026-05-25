import 'package:flutter/material.dart';

import '../../../controller/Movimentos.dart';
import '../../../model/mapa/MapaColor.dart';
import '../../../model/mapa/MapaPart.dart';
import '../game_page.dart';
import 'Casa.dart';

class tabuleiro extends StatefulWidget {
  const tabuleiro({super.key});

  @override
  State<tabuleiro> createState() => _tabuleiroState();
}

class _tabuleiroState extends State<tabuleiro> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 64,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8,
          ),
          itemBuilder: (context, index) {
            int row = index ~/ 8;
            int col = index % 8;

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
              color = Colors.greenAccent.withOpacity(0.3);
              MapaColor.colors[row][col] = 0;
            } else if (MapaColor.colors[row][col] == 21) {
              color = Colors.red.withOpacity(0.3);
              MapaColor.colors[row][col] = 0;
            } else if (MapaColor.colors[row][col] == 22) {
              color = Colors.red;
              MapaColor.colors[row][col] = 0;
            } else if (MapaColor.colors[row][col] == 19) {
              color = Colors.red.withOpacity(0.4);
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
          },
        ),
      ),
    );
  }
}
