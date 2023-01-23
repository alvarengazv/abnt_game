import 'package:abntplaybic/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BotaoInicio extends StatefulWidget {
  final String texto;
  final Function() funcaoBotao;

  const BotaoInicio({super.key, required this.texto, required this.funcaoBotao});

  @override
  State<BotaoInicio> createState() => _BotaoInicioState();
}

class _BotaoInicioState extends State<BotaoInicio> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15)
              ),
              height: 180,
              width: 140,
              child: ElevatedButton(
                onPressed: widget.funcaoBotao,
                style: ElevatedButton.styleFrom(
                  backgroundColor: lilas,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
              ), 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: Text(widget.texto,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: "PassionOne",
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
            )
    );
  }
}