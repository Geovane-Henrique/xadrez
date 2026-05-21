import 'package:xadrez/controller/Controller.dart';
import 'package:xadrez/controller/IlegalMoveKing.dart';

import '../../../model/mapa/MapaColor.dart';
import '../../../model/mapa/MapaPart.dart';
import '../../rules/KingCordenadas.dart';

class PeaoActions {
  final int part;
  final int col;
  final int row;

  PeaoActions({required this.part, required this.col, required this.row});

  String identificarPart(int newPart) {
    if (newPart == 0) {
      return "vazio";
    }
    if (part > 10 && newPart < 10) {
      return "inimigo";
    }

    if (part < 10 && newPart > 10) {
      return "inimigo";
    }

    return "aliado";
  }

  void peao() {
    String resultado;

    if (row == 6 && Mapa.tabuleiro[row - 1][col] == 0) {
      if (row == 6 && Mapa.tabuleiro[row - 2][col] == 0) {
        List<int> cordenadasRei = Kingcordenadas().cordenadasKing();
        int partSalva = Mapa.tabuleiro[row - 2][col];
        Mapa.tabuleiro[row][col] = 0;
        Mapa.tabuleiro[row - 2][col] = part;
        if (IllegalMoveKing().illegalMoveKingTest(
          cordenadasRei[0],
          cordenadasRei[1],
          cordenadasRei[2],
        )) {
          MapaColor.colors[row - 2][col] = 20;
        }
        Mapa.tabuleiro[row][col] = part;
        Mapa.tabuleiro[row - 2][col] = partSalva;
      }
    }
    if (Mapa.tabuleiro[row - 1][col] == 0) {
      List<int> cordenadasRei = Kingcordenadas().cordenadasKing();
      int partSalva = Mapa.tabuleiro[row - 2][col];
      Mapa.tabuleiro[row][col] = 0;
      Mapa.tabuleiro[row - 2][col] = part;
      if (IllegalMoveKing().illegalMoveKingTest(
        cordenadasRei[0],
        cordenadasRei[1],
        cordenadasRei[2],
      )) {
        MapaColor.colors[row - 1][col] = 20;
      }
      Mapa.tabuleiro[row][col] = part;
      Mapa.tabuleiro[row - 2][col] = partSalva;
    }

    for (int l = -1; l < 2; l++) {
      if (col + l > -1 && col + l < 8) {
        if (Mapa.tabuleiro[row - 1][col + l] != 0 &&
            Mapa.tabuleiro[row - 1][col + l] < 10) {
          List<int> cordenadasRei = Kingcordenadas().cordenadasKing();
          int partSalva = Mapa.tabuleiro[row - 1][col + l];
          Mapa.tabuleiro[row][col] = 0;
          Mapa.tabuleiro[row - 1][col + l] = part;
          if (IllegalMoveKing().illegalMoveKingTest(
            cordenadasRei[0],
            cordenadasRei[1],
            cordenadasRei[2],
          )) {
            MapaColor.colors[row - 1][col + l] = 21;
          }
          Mapa.tabuleiro[row][col] = part;
          Mapa.tabuleiro[row - 1][col + l] = partSalva;
        }
      }
      l++;
    }
  }

  void empasante() {
    for (int l = -1; l < 2; l++) {
      if (col + l > -1 && col + l < 8) {
        if (Mapa.tabuleiro[row][col + l] != 0 &&
            Mapa.tabuleiro[row][col + l] == 1) {
          if (Controller.jogada[2] == 3 &&
              Controller.jogada[3] == col + l &&
              Controller.jogada[0] == 1) {
            MapaColor.colors[row][col + l] = 21;
            Controller.jogada = [row, col, row, col + l, part];
            Controller.partidaAtual.add(Controller.jogada);
          }
        }
      }
      l++;
    }
  }
}
