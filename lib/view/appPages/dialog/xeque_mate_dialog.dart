import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class XequeMateDialog {
  void xequeMateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.only(top: 200),
          backgroundColor: Colors.red,
          alignment: Alignment.topCenter,
          title: Text("Xeque Mate", textAlign: TextAlign.center),
        );
      },
    );
  }
}
