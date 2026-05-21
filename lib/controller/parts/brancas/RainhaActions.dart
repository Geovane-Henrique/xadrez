import 'package:xadrez/controller/parts/brancas/BispoActions.dart';
import 'package:xadrez/controller/parts/brancas/TorreActions.dart';

class RainhaActions {
  final int part;
  final int col;
  final int row;

  RainhaActions({required this.part, required this.col, required this.row});

  void rainha() {
    BispoActions(part: part, col: col, row: row).bispo();
    TorreActions(part: part, col: col, row: row).torre();
  }
}
