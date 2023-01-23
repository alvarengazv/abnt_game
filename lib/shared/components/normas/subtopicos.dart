import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TelaSubtopicos extends StatefulWidget {
  final String titulo;
  final Widget corpo;
  final String descricao;

  const TelaSubtopicos({super.key, required this.titulo, required this.corpo, required this.descricao});

  @override
  State<TelaSubtopicos> createState() => _TelaSubtopicosState();
}

class _TelaSubtopicosState extends State<TelaSubtopicos> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
              Container(
                width: size.width,
                child: Text(
                  widget.titulo,
                  style: TextStyle(
                    fontFamily: "PassionOne",
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: size.width,
                padding: EdgeInsets.only(top: 30),
                child: Align(
                  alignment: Alignment.center,
                  child: widget.corpo,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: size.width * 0.9,
                  height: size.height * 0.19,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: AutoSizeText(
                    widget.descricao,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
      ],
    );
  }
}