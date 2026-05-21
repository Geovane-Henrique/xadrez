import '../model/mapa/MapaPart.dart';

class IllegalMoveKing {
  String identificarPart(row, col, part, whiteEnyme, blackEnyme) {
    if (Mapa.tabuleiro[row][col] == 0 || Mapa.tabuleiro[row][col] == part) {
      return "vazio";
    }
    if (part > 10 && Mapa.tabuleiro[row][col] == whiteEnyme) {
      return "inimigo";
    }
    if (part < 10 && Mapa.tabuleiro[row][col] == blackEnyme) {
      return "inimigo";
    }
    return "aliado";
  }

  bool illegalMoveKingTest(int row, int col, int part) {
    if (enymeBishop(row, col, part, 2, 12)) {
      if (enymetower(row, col, part, 4, 14)) {
        if (enemyRainha(row, col, part, 5, 15)) {
          if (enemyCavalo(row, col, part, 3, 13)) {
            if (enemyKing(row, col, part, 6, 16)) {
              if (part > 10) {
                if (enemyPeaoBlack(row, col, part, 1, 11)) {
                  return true;
                }
              } else {
                if (enemyPeaoWhite(row, col, part, 1, 11)) {
                  return true;
                }
              }
            }
          }
        }
      }
    }
    return false;
  }

  bool enymeBishop(int row, int col, int part, whiteEnyme, blackEnyme) {
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

        String resultado = identificarPart(r, c, part, whiteEnyme, blackEnyme);

        if (resultado == "inimigo") {
          return false;
        }
        if (resultado == "aliado") {
          break;
        }
      }
    }
    return true;
  }

  bool enymetower(int row, int col, int part, whiteEnyme, blackEnyme) {
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

        if (r < 0 || r > 7 || c < 0 || c > 7) {
          break;
        }

        String resultado = identificarPart(r, c, part, whiteEnyme, blackEnyme);
        if (resultado == "inimigo") {
          return false;
        }
        if (resultado == "aliado") {
          break;
        }
      }
    }
    return true;
  }

  bool enemyRainha(row, col, part, whiteEnyme, blackEnyme) {
    if (enymeBishop(row, col, part, whiteEnyme, blackEnyme)) {
      if (enymetower(row, col, part, whiteEnyme, blackEnyme)) {
        return true;
      }
    }
    return false;
  }

  bool enemyCavalo(row, col, part, whiteEnyme, blackEnyme) {
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
        String resultado = identificarPart(r, c, part, whiteEnyme, blackEnyme);

        if (resultado == "inimigo") {
          return false;
        }
      }
    }
    return true;
  }

  bool enemyKing(row, col, part, whiteEnyme, blackEnyme) {
    for (int i = -1; i < 2; i++) {
      for (int l = -1; l < 2; l++) {
        if (row + i < 8 && row + i > -1 && col + l < 8 && col + l > -1) {
          String resultado = identificarPart(
            row + i,
            col + l,
            part,
            whiteEnyme,
            blackEnyme,
          );

          if (resultado == "inimigo") {
            return false;
          }
        }
      }
    }
    return true;
  }

  bool enemyPeaoBlack(row, col, part, whiteEnyme, blackEnyme) {
    for (int l = -1; l < 2; l++) {
      if (col + l > -1 && col + l < 8) {
        String resultado = identificarPart(
          row - 1,
          col + l,
          part,
          whiteEnyme,
          blackEnyme,
        );

        if (resultado == "inimigo") {
          return false;
        }
      }
      l++;
    }
    return true;
  }

  bool enemyPeaoWhite(row, col, part, whiteEnyme, blackEnyme) {
    for (int l = -1; l < 2; l++) {
      if (col + l > -1 && col + l < 8) {
        String resultado = identificarPart(
          row + 1,
          col + l,
          part,
          whiteEnyme,
          blackEnyme,
        );

        if (resultado == "inimigo") {
          return false;
        }
      }
      l++;
    }
    return true;
  }
}
