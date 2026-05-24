import 'package:xadrez/view/appPages/game_page.dart';
import 'package:xadrez/controller/Controller.dart';
import 'package:xadrez/controller/rules/IlegalMoveKing.dart';
import 'package:xadrez/controller/rules/KingCordenadas.dart';
import 'package:xadrez/model/enums/EnunTurn.dart';
import 'package:xadrez/model/mapa/MapaColor.dart';
import 'package:xadrez/model/mapa/MapaPart.dart';

class BispoActions {
  final int part;
  final int col;
  final int row;

  BispoActions({required this.part, required this.col, required this.row});

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

  void bispo() {
    //diagonal superior esquerda
    List<List<int>> cordenadas = [
      [-1, -1],
      [-1, 1],
      [1, -1],
      [1, 1],
    ];

    for (var cor in cordenadas) {
      int r = row;
      int c = col;

      while (true) {
        r += cor[0];
        c += cor[1];

        if (r < 0 || r > 7 || c < 0 || c > 7) {
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
