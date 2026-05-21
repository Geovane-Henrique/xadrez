import '../../appPages/Tabuleiro.dart';
import '../../model/enums/EnunTurn.dart';
import '../../model/mapa/MapaPart.dart';

class Kingcordenadas {
  List<int> cordenadasKing() {
    late int rei;
    Tabuleiro.vez == Turn.brancas ? rei = 16 : rei = 6;
    List<int> cordenadaRei = [];

    for (int i = 0; i < 8; i++) {
      for (int l = 0; l < 8; l++) {
        if (Mapa.tabuleiro[i][l] == rei) {
          return [i, l, rei];
        }
      }
    }
    return cordenadaRei;
  }
}
