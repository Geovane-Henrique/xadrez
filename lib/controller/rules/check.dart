import 'package:xadrez/appPages/Tabuleiro.dart';
import 'package:xadrez/controller/IlegalMoveKing.dart';
import 'package:xadrez/model/mapa/MapaColor.dart';
import 'package:xadrez/model/mapa/MapaPart.dart';

import '../../model/enums/EnunTurn.dart';
import '../Controller.dart';

class Check {
  bool check() {
    int rei = Tabuleiro.vez == Turn.brancas ? 16 : 6;
    for (int i = 0; i < 8; i++) {
      for (int l = 0; l < 8; l++) {
        if (Mapa.tabuleiro[i][l] == rei) {
          if (!IllegalMoveKing().illegalMoveKingTest(i, l, rei)) {
            MapaColor.colors[i][l] = 22;
            return true;
          }
        }
      }
    }
    return false;
  }
}
