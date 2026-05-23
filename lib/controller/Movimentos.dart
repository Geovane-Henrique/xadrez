import 'package:flutter/material.dart';
import 'package:xadrez/appPages/Tabuleiro.dart';
import 'package:xadrez/model/enums/EnunTurn.dart';

import '../model/mapa/MapaPart.dart';
import 'Controller.dart';

class Movimentos {
  final int part;
  final int col;
  final int row;
  final Color color;

  Movimentos({
    required this.part,
    required this.col,
    required this.row,
    required this.color,
  });

  bool turnos() {
    if (Tabuleiro.vez == Turn.brancas && this.part > 10) {
      return true;
    }
    if (Tabuleiro.vez == Turn.pretas && this.part < 10) {
      return true;
    }
    return false;
  }

  void action() {
    if (color == Colors.red.withOpacity(0.4)) {
      if (Tabuleiro.vez == Turn.brancas) {
        Controller.empasantWhite = true;
      } else {
        Controller.empasantBlack = true;
      }
      Controller(
        part: Mapa.tabuleiro[row][col],
        col: col,
        row: row,
        partSaved: Tabuleiro.partSaved,
      ).move();
    } else if (color == Colors.greenAccent.withOpacity(0.3) ||
        color == Colors.red.withOpacity(0.3) && Tabuleiro.partSaved[2] != 0) {
      Controller(
        part: Mapa.tabuleiro[row][col],
        col: col,
        row: row,
        partSaved: Tabuleiro.partSaved,
      ).move();
    } else {
      if (!turnos()) {
        return;
      }
      Controller(
        part: Mapa.tabuleiro[row][col],
        col: col,
        row: row,
        partSaved: Tabuleiro.partSaved,
      ).findCordenadas();
    }
    if (Mapa.tabuleiro[row][col] != 0) {
      Tabuleiro.partSaved = [row, col, Mapa.tabuleiro[row][col]];
    }
  }
}
