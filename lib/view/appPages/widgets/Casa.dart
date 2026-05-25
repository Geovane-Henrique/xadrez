import 'package:flutter/material.dart';
import 'package:xadrez/model/mapa/MapaPart.dart';
import 'package:xadrez/icons/Img.dart';

class Casa extends StatelessWidget {
  const Casa({
    super.key,
    required this.color,
    required this.part,
    required this.onPressed,
  });

  final Color color;
  final int part;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.zero),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          color: color,
          child: part != 0
              ? Image.asset(
                  part == 1
                      ? Img.peao
                      : part == 2
                      ? Img.bispo
                      : part == 3
                      ? Img.cavalo
                      : part == 4
                      ? Img.torre
                      : part == 5
                      ? Img.rainha
                      : part == 6
                      ? Img.rei
                      : part == 11
                      ? Img.peaoB
                      : part == 12
                      ? Img.bispoB
                      : part == 13
                      ? Img.cavaloB
                      : part == 14
                      ? Img.torreB
                      : part == 15
                      ? Img.rainhaB
                      : Img.reiB,
                )
              : null,
        ),
      ),
    );
  }
}

//<a href="https://www.flaticon.com/br/icones-gratis/xadrez" title="xadrez ícones">Xadrez ícones criados por Andrejs Kirma - Flaticon</a>
//<a href="https://www.flaticon.com/br/icones-gratis/xadrez" title="xadrez ícones">Xadrez ícones criados por Pixel perfect - Flaticon</a>
//<a href="https://www.flaticon.com/br/icones-gratis/xadrez" title="xadrez ícones">Xadrez ícones criados por Freepik - Flaticon</a>
//<a href="https://www.flaticon.com/br/icones-gratis/coroa" title="coroa ícones">Coroa ícones criados por Creative Stall Premium - Flaticon</a>
//<a href="https://www.flaticon.com/br/icones-gratis/xadrez" title="xadrez ícones">Xadrez ícones criados por deemakdaksina - Flaticon</a>
//<a href="https://www.flaticon.com/br/icones-gratis/xadrez" title="xadrez ícones">Xadrez ícones criados por smashingstocks - Flaticon</a>
//<a href="https://www.flaticon.com/br/icones-gratis/xadrez" title="xadrez ícones">Xadrez ícones criados por Freepik - Flaticon</a>
//<a href="https://www.flaticon.com/br/icones-gratis/xadrez" title="xadrez ícones">Xadrez ícones criados por Icongeek26 - Flaticon</a>
//<a href="https://www.flaticon.com/br/icones-gratis/bispo" title="bispo ícones">Bispo ícones criados por Freepik - Flaticon</a>
//<a href="https://www.flaticon.com/br/icones-gratis/estrategia" title="estratégia ícones">Estratégia ícones criados por Freepik - Flaticon</a>
//<a href="https://www.flaticon.com/br/icones-gratis/coroa" title="coroa ícones">Coroa ícones criados por surang - Flaticon</a>
//<a href="https://www.flaticon.com/br/icones-gratis/coroa" title="coroa ícones">Coroa ícones criados por Zlatko Najdenovski - Flaticon</a>
