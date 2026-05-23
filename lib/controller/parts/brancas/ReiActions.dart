import 'package:xadrez/appPages/Tabuleiro.dart';
import 'package:xadrez/controller/Controller.dart';
import 'package:xadrez/controller/IlegalMoveKing.dart';

import '../../../model/mapa/MapaColor.dart';
import '../../../model/mapa/MapaPart.dart';

class ReiActions {
  final int part;
  final int col;
  final int row;

  ReiActions({required this.part, required this.col, required this.row});

  String identificarPart(int newPart) {
    if (newPart == 0) {
      return "vazio";
    }
    if (this.part > 10 && newPart < 10) {
      return "inimigo";
    }

    if (this.part < 10 && newPart > 10) {
      return "inimigo";
    }

    return "aliado";
  }

  void rei() {
    for (int i = -1; i < 2; i++) {
      for (int l = -1; l < 2; l++) {
        if (row + i < 8 && row + i > -1 && col + l < 8 && col + i > -1) {
          String resultado = identificarPart(Mapa.tabuleiro[row + i][col + l]);

          if (resultado == "vazio") {
            if (IllegalMoveKing().illegalMoveKingTest(row + i, col + l, part)) {
              MapaColor.colors[row + i][col + l] = 20;
            }
          }

          if (resultado == "inimigo") {
            if (IllegalMoveKing().illegalMoveKingTest(row + i, col + l, part)) {
              MapaColor.colors[row + i][col + l] = 21;
            }
          }
        }
      }
    }
    rock();
  }

  bool reiMoveChek() {
    for (var chek in Controller.partidaAtual) {
      if (chek[4] == part) {
        return true;
      }
    }
    return false;
  }

  bool towerMoveCheck(int row, int col, int part) {
    for (var chek in Controller.partidaAtual) {
      if (chek[4] == part && chek[0] == row && chek[1] == col) {
        return true;
      }
    }
    return false;
  }

  void rock() {
    bool reiMove = reiMoveChek();
    if (!reiMove) {
      if (part > 10) {
        bool towerDireitaMove = towerMoveCheck(7, 7, 14);
        bool towerEsquerdaMove = towerMoveCheck(7, 0, 14);
        if (!towerDireitaMove) {
          if (Mapa.tabuleiro[7][5] == 0 && Mapa.tabuleiro[7][6] == 0) {
            if (IllegalMoveKing().illegalMoveKingTest(7, 6, 16)) {
              MapaColor.colors[7][5] = 20;
              MapaColor.colors[7][6] = 20;
              Tabuleiro.towerRightWhiteRock = true;
            }
          }
        }
        if (!towerEsquerdaMove) {
          if (Mapa.tabuleiro[7][1] == 0 &&
              Mapa.tabuleiro[7][2] == 0 &&
              Mapa.tabuleiro[7][3] == 0) {
            if (IllegalMoveKing().illegalMoveKingTest(7, 1, 16)) {
              if (IllegalMoveKing().illegalMoveKingTest(7, 2, 16)) {
                MapaColor.colors[7][2] = 20;
                MapaColor.colors[7][3] = 20;
                Tabuleiro.towerLeftWhiteRock = true;
              }
            }
          }
        }
      } else {
        bool towerDireitaMove = towerMoveCheck(0, 7, 4);
        bool towerEsquerdaMove = towerMoveCheck(0, 0, 4);
        if (!towerDireitaMove) {
          if (Mapa.tabuleiro[0][5] == 0 && Mapa.tabuleiro[0][6] == 0) {
            if (IllegalMoveKing().illegalMoveKingTest(0, 6, 6)) {
              MapaColor.colors[0][5] = 20;
              MapaColor.colors[0][6] = 20;
              Tabuleiro.towerRightBlackRock = true;
            }
          }
        }
        if (!towerEsquerdaMove) {
          if (Mapa.tabuleiro[0][1] == 0 &&
              Mapa.tabuleiro[0][2] == 0 &&
              Mapa.tabuleiro[0][3] == 0) {
            if (IllegalMoveKing().illegalMoveKingTest(0, 1, 6)) {
              if (IllegalMoveKing().illegalMoveKingTest(0, 2, 6)) {
                MapaColor.colors[0][2] = 20;
                MapaColor.colors[0][3] = 20;
                Tabuleiro.towerLeftBlackRock = true;
              }
            }
          }
        }
      }
    }
  }
}
