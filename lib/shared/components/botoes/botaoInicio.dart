import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BotaoInicio extends StatefulWidget {
  final String texto;
  BotaoInicio({super.key, required this.texto});

  @override
  State<BotaoInicio> createState() => _BotaoInicioState();
}

class _BotaoInicioState extends State<BotaoInicio> {
  @override
  Widget build(BuildContext context) {
    return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15)
              ),
              height: 180,
              width: 140,
              child: ElevatedButton(
                onPressed: (){}, 
                child: Column(
                  children: [
                    Expanded(flex: 3, child: Container()),
                    Expanded(child: 
                      Text(widget.texto,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 165, 127, 165),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
              ),
            )
    );
  }
}