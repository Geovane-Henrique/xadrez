import 'package:xadrez/appPages/Tabuleiro.dart';
import 'package:xadrez/controller/Controller.dart';
import 'package:xadrez/model/enums/EnunTurn.dart';
import 'package:xadrez/model/mapa/MapaColor.dart';
import 'package:xadrez/model/mapa/MapaPart.dart';

class Checkmate {
  bool findColor() {
    for (int i = 0; i < 8; i++) {
      for (int l = 0; l < 8; l++) {
        if (MapaColor.colors[i][l] == 20 || MapaColor.colors[i][l] == 21) {
          return true;
        }
      }
    }
    return false;
  }

  void clearColor() {
    for (int i = 0; i < 8; i++) {
      for (int l = 0; l < 8; l++) {
        if (MapaColor.colors[i][l] != 22) {
          MapaColor.colors[i][l] = 0;
        }
      }
    }
  }

  bool chekMate() {
    for (int i = 0; i < 8; i++) {
      for (int l = 0; l < 8; l++) {
        if (Tabuleiro.vez == Turn.brancas) {
          if (Mapa.tabuleiro[i][l] > 10) {
            Controller(
              part: Mapa.tabuleiro[i][l],
              col: l,
              row: i,
              partSaved: [],
            ).findCordenadas();
          }
        } else {
          if (Mapa.tabuleiro[i][l] < 10) {
            Controller(
              part: Mapa.tabuleiro[i][l],
              col: l,
              row: i,
              partSaved: [],
            ).findCordenadas();
          }
        }
      }
    }
    if (findColor()) {
      clearColor();
      return false;
    } else {
      return true;
    }
  }
}
