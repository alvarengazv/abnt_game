import 'package:abntplaybic/shared/components/botoes/botaoInicio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: (){},
            child: Row(
              children: const [
                Text(
                "1200 ",
                style: TextStyle(
                color: Color.fromARGB(255, 105, 163, 107),
                fontSize: 20
              ),
              ),
                Text(
                    "XP",
                    style: TextStyle(
                    color: Color.fromARGB(255, 105, 163, 107),
                    fontSize: 10
                  ),
                  ),
              ],
            ),
            )
        ],
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("ABNT Play", 
          style: TextStyle(
            color: Color.fromARGB(255, 64, 1, 53),
            fontSize: 30
          ),
        ),
      ),
      body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BotaoInicio(texto: "Trabalhos Acadêmicos",),
              BotaoInicio(texto: "Sumário")
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BotaoInicio(texto: "Referências Bibliográficas",),
              BotaoInicio(texto: "",),
            ],
          ),
        ),
        Text("ABNT Play INÍCIO", 
            style: TextStyle(
              color: Color.fromARGB(255, 64, 1, 53),
              fontSize: 30
            ),
        ),
      ],
    )
    );
  }
}