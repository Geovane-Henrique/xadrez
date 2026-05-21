import '../../../model/mapa/MapaColor.dart';
import '../../../model/mapa/MapaPart.dart';
import '../../IlegalMoveKing.dart';
import '../../rules/KingCordenadas.dart';

class CavaloActions {
  final int part;
  final int col;
  final int row;

  CavaloActions({required this.part, required this.col, required this.row});

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

  void cavalo() {
    List<List<int>> cordenadas = [
      [2, 1],
      [2, -1],
      [-2, 1],
      [-2, -1],
      [1, 2],
      [-1, 2],
      [1, -2],
      [-1, -2],
    ];

    for (var cor in cordenadas) {
      int r = row + cor[0];
      int c = col + cor[1];

      if (r > -1 && r < 8 && c > -1 && c < 8) {
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
        }
      }
    }
  }
}
