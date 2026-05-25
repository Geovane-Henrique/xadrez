import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReiAfogadoDialogDialog {
  void reiAfogadoDialogDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.only(top: 120),
          backgroundColor: Colors.yellowAccent,
          alignment: Alignment.topCenter,
          title: Text("Rei afogado", textAlign: TextAlign.center),
        );
      },
    );
  }
}
