import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:xadrez/appPages/Tabuleiro.dart';
import 'package:xadrez/controller/parts/brancas/BispoActions.dart';
import 'package:xadrez/controller/parts/brancas/CavaloActions.dart';
import 'package:xadrez/controller/parts/brancas/PeaoActions.dart';
import 'package:xadrez/controller/parts/brancas/RainhaActions.dart';
import 'package:xadrez/controller/parts/brancas/ReiActions.dart';
import 'package:xadrez/controller/parts/brancas/TorreActions.dart';
import 'package:xadrez/controller/parts/brancas/PeaoActionsP.dart';
import 'package:xadrez/controller/rules/CheckMate.dart';
import 'package:xadrez/controller/rules/check.dart';

import '../model/enums/EnunTurn.dart';
import '../model/mapa/MapaColor.dart';
import '../model/mapa/MapaPart.dart';

class Controller {
  final int part;
  final int col;
  final int row;
  final List<int> partSaved;

  static List<List<int>> partidaAtual = [];
  static List<int> jogada = [];

  Controller({
    required this.part,
    required this.col,
    required this.row,
    required this.partSaved,
  });

  void findCordenadas() {
    switch (part) {
      case 11:
        PeaoActions(part: part, col: col, row: row).peao();
        break;

      case 12 || 2:
        BispoActions(part: part, col: col, row: row).bispo();
        break;

      case 13 || 3:
        CavaloActions(part: part, col: col, row: row).cavalo();
        break;

      case 14 || 4:
        TorreActions(part: part, col: col, row: row).torre();
        break;

      case 15 || 5:
        RainhaActions(part: part, col: col, row: row).rainha();
        break;

      case 16 || 6:
        ReiActions(part: part, col: col, row: row).rei();
        break;

      case 1:
        PeaoActionsP(part: part, col: col, row: row).peao();
        break;
      default:
        break;
    }
  }

  void move() {
    print(Tabuleiro.kingWhiteCheck);
    if (Tabuleiro.kingWhiteCheck) {
      simuladorChek(row, col, partSaved[0], partSaved[1], partSaved[2]);
    }
    if (Tabuleiro.kingBlackCheck) {
      simuladorChek(row, col, partSaved[0], partSaved[1], partSaved[2]);
    }
    if (Tabuleiro.kingWhiteCheck == true) {
      return;
    }
    if (Tabuleiro.kingBlackCheck == true) {
      return;
    }
    Mapa.tabuleiro[partSaved[0]][partSaved[1]] = 0;
    Mapa.tabuleiro[row][col] = partSaved[2];
    if (partSaved[2] == 11 && row == 0) {
      Mapa.tabuleiro[row][col] = 15;
    }
    if (partSaved[2] == 1 && row == 7) {
      Mapa.tabuleiro[row][col] = 5;
    }

    jogada = [partSaved[0], partSaved[1], row, col, partSaved[2]];
    partidaAtual.add(jogada);

    rockMove();
    Check().check();
    if (Checkmate().chekMate()) {
      print("check mate");
    }
    Tabuleiro.vez = (Tabuleiro.vez == Turn.brancas)
        ? Turn.pretas
        : Turn.brancas;
    resetVariableRock();
  }

  void rockMove() {
    if (Tabuleiro.towerRightWhiteRock) {
      if (col == 6) {
        Tabuleiro.towerRightWhiteRock = false;
        Mapa.tabuleiro[7][7] = 0;
        Mapa.tabuleiro[7][5] = 14;
        jogada = [7, 7, 7, 5, 14];
        partidaAtual.add(jogada);
      }
    }
    if (Tabuleiro.towerLeftWhiteRock) {
      if (col == 2) {
        Tabuleiro.towerLeftWhiteRock = false;
        Mapa.tabuleiro[7][0] = 0;
        Mapa.tabuleiro[7][3] = 14;
        jogada = [7, 0, 7, 3, 14];
        partidaAtual.add(jogada);
      }
    }
    if (Tabuleiro.towerRightBlackRock) {
      if (col == 6) {
        Tabuleiro.towerRightBlackRock = false;
        Mapa.tabuleiro[0][7] = 0;
        Mapa.tabuleiro[0][5] = 4;
        jogada = [0, 7, 0, 5, 4];
        partidaAtual.add(jogada);
      }
    }
    if (Tabuleiro.towerLeftBlackRock) {
      if (col == 2) {
        Tabuleiro.towerLeftBlackRock = false;
        Mapa.tabuleiro[0][0] = 0;
        Mapa.tabuleiro[0][3] = 4;
        jogada = [0, 0, 0, 3, 4];
        partidaAtual.add(jogada);
      }
    }
  }

  void resetVariableRock() {
    Tabuleiro.towerLeftBlackRock = false;
    Tabuleiro.towerRightBlackRock = false;
    Tabuleiro.towerLeftWhiteRock = false;
    Tabuleiro.towerRightWhiteRock = false;
  }

  void simuladorChek(int row, int col, int rowO, int colO, part) {
    int partSalva = Mapa.tabuleiro[row][col];
    Mapa.tabuleiro[rowO][colO] = 0;
    Mapa.tabuleiro[row][col] = part;
    Check().check();
    Mapa.tabuleiro[rowO][colO] = part;
    Mapa.tabuleiro[row][col] = partSalva;
  }
}
