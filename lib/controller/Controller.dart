import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:xadrez/view/appPages/game_page.dart';
import 'package:xadrez/controller/parts/BispoActions.dart';
import 'package:xadrez/controller/parts/CavaloActions.dart';
import 'package:xadrez/controller/parts/PeaoActions.dart';
import 'package:xadrez/controller/parts/RainhaActions.dart';
import 'package:xadrez/controller/parts/ReiActions.dart';
import 'package:xadrez/controller/parts/TorreActions.dart';
import 'package:xadrez/controller/parts/PeaoActionsP.dart';
import 'package:xadrez/controller/rules/VerifyPlaysLegal.dart';
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
  static bool empasantWhite = false;
  static bool empasantBlack = false;

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
    Mapa.tabuleiro[partSaved[0]][partSaved[1]] = 0;
    Mapa.tabuleiro[row][col] = partSaved[2];

    verifyEmpasant();
    peaoPromote();

    savePlay();

    rockMove();

    trocaDeTurno();

    kingAfoged();
    chek();
    resetVariableRock();
  }

  void rockMove() {
    if (Tabuleiro.towerRightWhiteRock) {
      if (col == 6 && partSaved[2] == 16) {
        Tabuleiro.towerRightWhiteRock = false;
        Mapa.tabuleiro[7][7] = 0;
        Mapa.tabuleiro[7][5] = 14;
        jogada = [7, 7, 7, 5, 14];
        partidaAtual.add(jogada);
      }
    }
    if (Tabuleiro.towerLeftWhiteRock) {
      if (col == 2 && partSaved[2] == 16) {
        Tabuleiro.towerLeftWhiteRock = false;
        Mapa.tabuleiro[7][0] = 0;
        Mapa.tabuleiro[7][3] = 14;
        jogada = [7, 0, 7, 3, 14];
        partidaAtual.add(jogada);
      }
    }
    if (Tabuleiro.towerRightBlackRock) {
      if (col == 6 && partSaved[2] == 6) {
        Tabuleiro.towerRightBlackRock = false;
        Mapa.tabuleiro[0][7] = 0;
        Mapa.tabuleiro[0][5] = 4;
        jogada = [0, 7, 0, 5, 4];
        partidaAtual.add(jogada);
      }
    }
    if (Tabuleiro.towerLeftBlackRock) {
      if (col == 2 && partSaved[2] == 6) {
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

  void chek() {
    if (Check().check()) {
      if (VerifyPlaysLegal().chekMate()) {
        print("check mate");
      }
    }
  }

  void kingAfoged() {
    if (!Check().check()) {
      if (VerifyPlaysLegal().chekMate()) {
        print("rei afogado");
      }
    }
  }

  void trocaDeTurno() {
    Tabuleiro.vez = (Tabuleiro.vez == Turn.brancas)
        ? Turn.pretas
        : Turn.brancas;
  }

  void peaoPromote() {
    if (partSaved[2] == 11 && row == 0) {
      Mapa.tabuleiro[row][col] = 15;
    }
    if (partSaved[2] == 1 && row == 7) {
      Mapa.tabuleiro[row][col] = 5;
    }
  }

  void savePlay() {
    jogada = [partSaved[0], partSaved[1], row, col, partSaved[2]];
    partidaAtual.add(jogada);
  }

  void verifyEmpasant() {
    if (empasantBlack) {
      Mapa.tabuleiro[row - 1][col] = 0;
      empasantBlack = false;
    }
    if (empasantWhite) {
      Mapa.tabuleiro[row + 1][col] = 0;
      empasantWhite = false;
    }
  }
}
