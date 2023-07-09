import 'package:flutter/material.dart';

import '../../../../shared/colors.dart';

class InformacaoPage extends StatefulWidget {
  const InformacaoPage({super.key});

  @override
  State<InformacaoPage> createState() => _InformacaoPageState();
}

class _InformacaoPageState extends State<InformacaoPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          color: roxo,
          icon: const Icon(
            Icons.arrow_back,
            size: 32,
          ),
        ),
        title: const Text(
          "ABNT Play",
          style: TextStyle(fontFamily: "Righteous", color: roxo, fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 70, vertical: 35),
            child: Text(
              "\t\tEste material é parte do produto educacional desenvolvido a partir da dissertação de mestrado \"O lugar da normalização dos trabalhos acadêmicos na formação de estudantes da educação profissional técnica de nível médio\", produzida por Maria de Lourdes Cardoso, sob a orientação do professor Rodrigo Alves dos Santos, no Programa de Pós-Graduação em Educação Profissional e Tecnológica - PROFEPT, do campus Divinópolis do CEFET-MG.\n\n\n\t\tJogo desenvolvido por Guilherme Alvarenga de Azevedo e Pedro Ferreira Manoel, estudantes do curso técnico integrado em Informática pelo CEFET-MG Divinópolis, então bolsistas de iniciação científica FAPEMIG/CNPq/CEFET-MG.",
              style: TextStyle(
                color: primary,
                fontFamily: "PassionOne",
                fontSize: size.width < 768 ? size.width * 0.038 : size.width * 0.025
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: size.width < 768
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "src/images/cefet.png",
                        width: size.width * .17,
                      ),
                      Image.asset(
                        "src/images/profept.png",
                        width: size.width * .19,
                      ),
                      Image.asset(
                        "src/images/fapemig.png",
                        width: size.width * .19,
                      ),
                      Image.asset(
                        "src/images/cnpq.png",
                        width: size.width * .19,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Image.asset(
                          "src/images/cefet.png",
                          width: 100,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Image.asset(
                          "src/images/profept.png",
                          width: 130,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Image.asset(
                          "src/images/fapemig.png",
                          width: 125,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Image.asset(
                          "src/images/cnpq.png",
                          width: 100,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
