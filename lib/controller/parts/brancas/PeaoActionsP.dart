import '../../../model/mapa/MapaColor.dart';
import '../../../model/mapa/MapaPart.dart';
import '../../Controller.dart';

class PeaoActionsP {
  final int part;
  final int col;
  final int row;

  PeaoActionsP({required this.part, required this.col, required this.row});

  void peao() {
    if (row == 1 && Mapa.tabuleiro[row + 1][col] == 0) {
      Mapa.tabuleiro[row + 2][col] == 0
          ? MapaColor.colors[row + 2][col] = 20
          : MapaColor.colors[row + 2][col];
    }
    Mapa.tabuleiro[row + 1][col] == 0
        ? MapaColor.colors[row + 1][col] = 20
        : MapaColor.colors[row + 1][col];

    empasante();

    for (int l = -1; l < 2; l++) {
      if (col + l > -1 && col + l < 8) {
        if (Mapa.tabuleiro[row + 1][col + l] != 0 &&
            Mapa.tabuleiro[row + 1][col + l] > 10) {
          MapaColor.colors[row + 1][col + l] = 21;
        }
      }
      l++;
    }
  }

  void empasante() {
    for (int l = -1; l < 2; l++) {
      if (col + l > -1 && col + l < 8) {
        if (Mapa.tabuleiro[row][col + l] != 0 &&
            Mapa.tabuleiro[row][col + l] == 11) {
          if (Controller.jogada[2] == 4 &&
              Controller.jogada[3] == col + l &&
              Controller.jogada[0] == 6) {
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
