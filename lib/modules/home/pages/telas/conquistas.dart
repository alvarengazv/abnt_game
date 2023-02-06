import 'package:abntplaybic/modules/home/models/model_conquista.dart';
import 'package:abntplaybic/modules/perfil/controller/perfilProvider.dart';
import 'package:abntplaybic/modules/perfil/models/perfilAluno.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/cards/card_conquista.dart';
import 'package:abntplaybic/shared/funcoes_conquistas.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:im_stepper/main.dart';
import 'package:im_stepper/stepper.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class ConquistasPage extends StatefulWidget {
  const ConquistasPage({super.key});

  @override
  State<ConquistasPage> createState() => _ConquistasPageState();
}

class _ConquistasPageState extends State<ConquistasPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "ABNT Play",
          style: TextStyle(
            fontFamily: "Righteous",
            color: roxo,
            fontSize: 40,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "CONQUISTAS ALCANÇADAS",
                        style: TextStyle(
                          color: prata,
                          fontFamily: "BebasNeue",
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Progresso Total: ${getProgressoPorcentagem(context)}%",
                        style: TextStyle(
                          color: primary,
                          fontFamily: "PassionOne",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                getProgressoPorcentagem(context) != 0 ? Flexible(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: getLista(context).length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: getLista(context)
                                      .elementAt(index)
                                      .progressoAluno >
                                  0
                              ? CardConquista(
                                  cor: getLista(context)
                                              .elementAt(index)
                                              .progressoAluno !=
                                          0
                                      ? roxo
                                      : lilas,
                                  titulo:
                                      getLista(context).elementAt(index).titulo,
                                  progresso: getLista(context)
                                      .elementAt(index)
                                      .progressoAluno,
                                  progresso1: getLista(context)
                                      .elementAt(index)
                                      .progresso1,
                                  progresso2: getLista(context)
                                      .elementAt(index)
                                      .progresso2,
                                  progresso3: getLista(context)
                                      .elementAt(index)
                                      .progresso3,
                                )
                              : null,
                        );
                      }),
                ) : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: AutoSizeText(
                    "VOCÊ AINDA NÃO ALCANÇOU NENHUMA CONQUISTA!",
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "PassionOne",
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getProgressoPorcentagem(context) == 100 ? SizedBox() : Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "CONQUISTAS AINDA NÃO ALCANÇADAS",
                          style: TextStyle(
                            color: prata,
                            fontFamily: "BebasNeue",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Flexible(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: getLista(context).length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: getLista(context)
                                            .elementAt(index)
                                            .progressoAluno ==
                                        0
                                    ? CardConquista(
                                        cor: getLista(context)
                                                    .elementAt(index)
                                                    .progressoAluno !=
                                                0
                                            ? roxo
                                            : lilas,
                                        titulo:
                                            getLista(context).elementAt(index).titulo,
                                        progresso: getLista(context)
                                            .elementAt(index)
                                            .progressoAluno,
                                        progresso1: getLista(context)
                                            .elementAt(index)
                                            .progresso1,
                                        progresso2: getLista(context)
                                            .elementAt(index)
                                            .progresso2,
                                        progresso3: getLista(context)
                                            .elementAt(index)
                                            .progresso3,
                                      )
                                    : null,
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
