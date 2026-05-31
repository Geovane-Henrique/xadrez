import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:xadrez/view/appPages/dialog/rei_afogado_dialog.dart';
import 'package:xadrez/view/appPages/dialog/xeque_mate_dialog.dart';
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

  final BuildContext? context;

  static ValueNotifier<List<List<int>>> partidaAtual = ValueNotifier([]);
  static ValueNotifier<List<List<String>>> jogadasView = ValueNotifier([]);
  static List<int> jogada = [];
  static bool empasantWhite = false;
  static bool empasantBlack = false;
  List<String> jogadaView = [];

  Controller({
    required this.part,
    required this.col,
    required this.row,
    required this.partSaved,
    this.context,
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
        jogadaView = jogada.map((i) => i.toString()).toList();
        jogadaView[1] = replaceColuna(jogadaView[1]);
        jogadaView[3] = replaceColuna(jogadaView[3]);
        jogadaView[0] = replaceLinha(jogadaView[0]);
        jogadaView[2] = replaceLinha(jogadaView[2]);
        jogadaView = [
          jogadaView[1] + jogadaView[0] + " > " + jogadaView[3] + jogadaView[2],
        ];
        Controller.jogadasView.value = [
          ...Controller.jogadasView.value,
          jogadaView,
        ];
      }
    }
    if (Tabuleiro.towerLeftWhiteRock) {
      if (col == 2 && partSaved[2] == 16) {
        Tabuleiro.towerLeftWhiteRock = false;
        Mapa.tabuleiro[7][0] = 0;
        Mapa.tabuleiro[7][3] = 14;
        jogada = [7, 0, 7, 3, 14];
        jogadaView = jogada.map((i) => i.toString()).toList();
        jogadaView[1] = replaceColuna(jogadaView[1]);
        jogadaView[3] = replaceColuna(jogadaView[3]);
        jogadaView[0] = replaceLinha(jogadaView[0]);
        jogadaView[2] = replaceLinha(jogadaView[2]);
        jogadaView = [
          jogadaView[1] + jogadaView[0] + " > " + jogadaView[3] + jogadaView[2],
        ];
        Controller.jogadasView.value = [
          ...Controller.jogadasView.value,
          jogadaView,
        ];
      }
    }
    if (Tabuleiro.towerRightBlackRock) {
      if (col == 6 && partSaved[2] == 6) {
        Tabuleiro.towerRightBlackRock = false;
        Mapa.tabuleiro[0][7] = 0;
        Mapa.tabuleiro[0][5] = 4;
        jogada = [0, 7, 0, 5, 4];
        jogadaView = jogada.map((i) => i.toString()).toList();
        jogadaView[1] = replaceColuna(jogadaView[1]);
        jogadaView[3] = replaceColuna(jogadaView[3]);
        jogadaView[0] = replaceLinha(jogadaView[0]);
        jogadaView[2] = replaceLinha(jogadaView[2]);
        jogadaView = [
          jogadaView[1] + jogadaView[0] + " > " + jogadaView[3] + jogadaView[2],
        ];
        Controller.jogadasView.value = [
          ...Controller.jogadasView.value,
          jogadaView,
        ];
      }
    }
    if (Tabuleiro.towerLeftBlackRock) {
      if (col == 2 && partSaved[2] == 6) {
        Tabuleiro.towerLeftBlackRock = false;
        Mapa.tabuleiro[0][0] = 0;
        Mapa.tabuleiro[0][3] = 4;
        jogada = [0, 0, 0, 3, 4];
        jogadaView = jogada.map((i) => i.toString()).toList();
        jogadaView[1] = replaceColuna(jogadaView[1]);
        jogadaView[3] = replaceColuna(jogadaView[3]);
        jogadaView[0] = replaceLinha(jogadaView[0]);
        jogadaView[2] = replaceLinha(jogadaView[2]);
        jogadaView = [
          jogadaView[1] + jogadaView[0] + " > " + jogadaView[3] + jogadaView[2],
        ];
        Controller.jogadasView.value = [
          ...Controller.jogadasView.value,
          jogadaView,
        ];
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
        XequeMateDialog().xequeMateDialog(context!);
      }
    }
  }

  void kingAfoged() {
    if (!Check().check()) {
      if (VerifyPlaysLegal().chekMate()) {
        print("rei afogado");
        ReiAfogadoDialogDialog().reiAfogadoDialogDialog(context!);
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
    jogadaView = jogada.map((i) => i.toString()).toList();
    jogadaView[1] = replaceColuna(jogadaView[1]);
    jogadaView[3] = replaceColuna(jogadaView[3]);
    jogadaView[0] = replaceLinha(jogadaView[0]);
    jogadaView[2] = replaceLinha(jogadaView[2]);
    jogadaView = [
      jogadaView[1] + jogadaView[0] + " > " + jogadaView[3] + jogadaView[2],
    ];
    print(jogadaView);
    Controller.jogadasView.value = [
      ...Controller.jogadasView.value,
      jogadaView,
    ];
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

  String replaceColuna(String item) {
    switch (item) {
      case "0":
        return "H";
      case "1":
        return "G";
      case "2":
        return "F";
      case "3":
        return "E";
      case "4":
        return "D";
      case "5":
        return "C";
      case "6":
        return "B";
      case "7":
        return "A";
      default:
        return item;
    }
  }

  String replaceLinha(String item) {
    switch (item) {
      case "0":
        return "8";
      case "1":
        return "7";
      case "2":
        return "6";
      case "3":
        return "5";
      case "4":
        return "4";
      case "5":
        return "3";
      case "6":
        return "2";
      case "7":
        return "1";
      default:
        return item;
    }
  }
}
