import 'package:xadrez/appPages/Tabuleiro.dart';
import 'package:xadrez/controller/IlegalMoveKing.dart';
import 'package:xadrez/model/mapa/MapaColor.dart';
import 'package:xadrez/model/mapa/MapaPart.dart';

import '../../model/enums/EnunTurn.dart';
import '../Controller.dart';

class Check {
  void check() {
    int rei = Tabuleiro.vez == Turn.brancas ? 6 : 16;
    Tabuleiro.kingWhiteCheck == true ? rei = 16 : null;
    Tabuleiro.kingBlackCheck == true ? rei = 6 : null;
    for (int i = 0; i < 8; i++) {
      for (int l = 0; l < 8; l++) {
        if (Mapa.tabuleiro[i][l] == rei) {
          if (!IllegalMoveKing().illegalMoveKingTest(i, l, rei)) {
            MapaColor.colors[i][l] = 22;
            if (rei == 16) {
              Tabuleiro.kingWhiteCheck = true;
            } else {
              Tabuleiro.kingBlackCheck = true;
            }
          } else {
            Tabuleiro.kingWhiteCheck = false;
            Tabuleiro.kingBlackCheck = false;
          }
        }
      }
    }
  }
}
