import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xadrez/controller/Controller.dart';

class Registros extends StatefulWidget {
  const Registros({super.key});

  @override
  State<Registros> createState() => _RegistrosState();
}

class _RegistrosState extends State<Registros> {
  @override
  Widget build(BuildContext context) {
    return Center(
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
                            ValueListenableBuilder(
                              valueListenable: Controller.jogadasView,
                              builder: (context, value, child) {
                                if (value.isNotEmpty) {
                                  return Text(value.toString());
                                }
                                return Text("");
                              },
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
    );
  }
}
