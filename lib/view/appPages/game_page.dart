import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xadrez/model/enums/EnunTurn.dart';
import 'package:xadrez/model/mapa/MapaPart.dart';
import 'package:xadrez/controller/Controller.dart';
import 'package:xadrez/controller/Movimentos.dart';
import 'package:xadrez/view/appPages/widgets/tabuleiro.dart';

import '../../model/mapa/MapaColor.dart';

class Tabuleiro extends StatefulWidget {
  static List<int> partSaved = [0, 0, 0];
  static Turn vez = Turn.brancas;
  static bool towerRightWhiteRock = false;
  static bool towerLeftWhiteRock = false;
  static bool towerRightBlackRock = false;
  static bool towerLeftBlackRock = false;
  static bool kingChek = false;

  const Tabuleiro({super.key});

  @override
  State<Tabuleiro> createState() => _TabuleiroState();
}

class _TabuleiroState extends State<Tabuleiro> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 35,
          backgroundColor: Colors.black87,
          title: Center(
            child: Text(
              "Over Chess",
              style: TextStyle(color: Colors.white, fontSize: 27),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.black,
                padding: EdgeInsets.only(left: 3, right: 3),
                child: Row(
                  spacing: 1,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "player 2",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 26, color: Colors.white),
                    ),
                    Text(
                      "Tempo 0:00",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 31,
              child: Center(
                child: Container(
                  color: Colors.black,
                  alignment: Alignment.topCenter,
                  child: AspectRatio(aspectRatio: 1, child: tabuleiro()),
                ),
              ),
            ),
            Expanded(
              flex: 23,
              child: Center(
                child: Container(
                  alignment: Alignment.topCenter,
                  color: Colors.black26,
                  child: Column(
                    children: [
                      Text("jogadas feitas", style: TextStyle(fontSize: 25)),
                      Expanded(
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    children: [
                                      Text(
                                        "Brancas",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const VerticalDivider(
                                color: Colors.black,
                                endIndent: 10,
                                indent: 10,
                                thickness: 3,
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    children: [
                                      Text(
                                        "Pretas",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.center,
                color: Colors.black,
                padding: EdgeInsets.only(left: 3, right: 3),
                child: SafeArea(
                  top: false,
                  left: false,
                  right: false,
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsetsGeometry.only(left: 3, right: 3),
                    child: Row(
                      spacing: 1,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "player 1",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 26, color: Colors.white),
                        ),
                        Text(
                          "Tempo 0:00",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Expanded(flex: 1, child: Container(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
