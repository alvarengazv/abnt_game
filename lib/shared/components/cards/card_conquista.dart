import 'package:abntplaybic/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CardConquista extends StatefulWidget {
  final String titulo;
  final int progresso;
  final Function() funcaoBotao;

  const CardConquista({super.key, required this.titulo, required this.progresso, required this.funcaoBotao});

  @override
  State<CardConquista> createState() => _CardConquistaState();
}

class _CardConquistaState extends State<CardConquista> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: widget.funcaoBotao,
      child: Ink(
        width: size.width * 0.9,
        height: size.height * 0.1,
        decoration: BoxDecoration(
          color: azul,
          borderRadius: BorderRadius.circular(9)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.titulo,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "BebasNeue",
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "PROGRESSO",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "BebasNeue",
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          MdiIcons.trophy,
                          color: widget.progresso >= 1 ? ouro : ouro.withOpacity(0.5),
                          size: 26,
                        ),
                        Icon(
                          MdiIcons.trophy,
                          color: widget.progresso >= 2 ? ouro : ouro.withOpacity(0.5),
                          size: 32,
                        ),
                        Icon(
                          MdiIcons.trophy,
                          color: widget.progresso >= 3 ? ouro : ouro.withOpacity(0.5),
                          size: 40,
                        ),
                      ],
                    )
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
