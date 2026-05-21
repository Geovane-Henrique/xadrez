class Partida {
  final int id;
  final String playerOne;
  final String playerTwo;

  static late List<List<int>> historico;

  Partida({required this.id, required this.playerOne, required this.playerTwo});

  void addJogada(List<int> jogada) {
    historico.add(jogada);
  }
}
