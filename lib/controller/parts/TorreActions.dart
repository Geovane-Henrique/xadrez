import 'package:xadrez/model/mapa/MapaColor.dart';

import '../../model/mapa/MapaPart.dart';
import '../rules/IlegalMoveKing.dart';
import '../rules/KingCordenadas.dart';

class TorreActions {
  final int part;
  final int col;
  final int row;

  TorreActions({required this.part, required this.col, required this.row});

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

  void torre() {
    List<List<int>> cordenadas = [
      [1, 0],
      [-1, 0],
      [0, 1],
      [0, -1],
    ];

    for (var cor in cordenadas) {
      int r = row;
      int c = col;

      while (true) {
        r += cor[0];
        c += cor[1];
        if (c < 0 || c > 7 || r < 0 || r > 7) {
          break;
        }

        String resultado = identificarPart(Mapa.tabuleiro[r][c]);

        if (resultado == "vazio") {
          int partSalva = Mapa.tabuleiro[r][c];
          List<int> cordenadasRei = Kingcordenadas().cordenadasKing();
          Mapa.tabuleiro[row][col] = 0;
          Mapa.tabuleiro[r][c] = part;

          if (IllegalMoveKing().illegalMoveKingTest(
            cordenadasRei[0],
            cordenadasRei[1],
            cordenadasRei[2],
          )) {
            Mapa.tabuleiro[r][c];
            MapaColor.colors[r][c] = 20;
          }
          Mapa.tabuleiro[row][col] = part;
          Mapa.tabuleiro[r][c] = partSalva;
        }

        if (resultado == "inimigo") {
          int partSalva = Mapa.tabuleiro[r][c];
          List<int> cordenadasRei = Kingcordenadas().cordenadasKing();
          Mapa.tabuleiro[row][col] = 0;
          Mapa.tabuleiro[r][c] = part;

          if (IllegalMoveKing().illegalMoveKingTest(
            cordenadasRei[0],
            cordenadasRei[1],
            cordenadasRei[2],
          )) {
            Mapa.tabuleiro[r][c];
            MapaColor.colors[r][c] = 21;
          }
          Mapa.tabuleiro[row][col] = part;
          Mapa.tabuleiro[r][c] = partSalva;

          break;
        }
        if (resultado == "aliado") {
          break;
        }
      }
    }
  }
}
