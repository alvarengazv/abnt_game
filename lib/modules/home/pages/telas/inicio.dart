import 'package:abntplaybic/modules/atividades/pages/principal.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/botoes/botao_inicio.dart';
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
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text.rich(
                  TextSpan(
                    text: "1200 ",
                    style: TextStyle(
                        fontFamily: "BebasNeue", color: verde, fontSize: 25),
                    children: [
                      TextSpan(
                          text: "XP",
                          style: TextStyle(
                              fontFamily: "BebasNeue",
                              color: verde,
                              fontSize: 15))
                    ],
                  ),
                ),
              ),
            )
          ],
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "ABNT Play",
            style:
                TextStyle(fontFamily: "Righteous", color: roxo, fontSize: 40),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BotaoInicio(
                    texto: "Trabalhos Acadêmicos",
                    funcaoBotao: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainAtividadesPage()),
                    ),
                  ),
                  BotaoInicio(
                    texto: "Sumário",
                    funcaoBotao: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainAtividadesPage()),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BotaoInicio(
                    texto: "Referências Bibliográficas",
                    funcaoBotao: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainAtividadesPage()),
                    ),
                  ),
                  BotaoInicio(
                    texto: "",
                    funcaoBotao: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainAtividadesPage()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
