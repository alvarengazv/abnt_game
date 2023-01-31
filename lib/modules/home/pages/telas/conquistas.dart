import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/cards/card_conquista.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:im_stepper/main.dart';
import 'package:im_stepper/stepper.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "CONQUISTAS ALCANÇADAS",
                        style: TextStyle(
                          color: prata,
                          fontFamily: "BebasNeue",
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Progresso Total: 52%",
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
                CardConquista(
                  cor: azul,
                  titulo: "COMPLETE: SUMÁRIO",
                  progresso: 2,
                  funcaoBotao: () => showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                      ),
                      context: context,
                      builder: ((context) {
                        return Container(
                          height: size.height * 0.35,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                                child: AutoSizeText(
                                  "COMPLETE: SUMÁRIO",
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "PassionOne",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "SEU PROGRESSO",
                                        style: TextStyle(
                                          color: prata,
                                          fontFamily: "BebasNeue",
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          22, 10, 22, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            "0%",
                                            style: TextStyle(
                                              color: roxo,
                                              fontFamily: "BebasNeue",
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "50%",
                                            style: TextStyle(
                                              color: roxo,
                                              fontFamily: "BebasNeue",
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "100%",
                                            style: TextStyle(
                                              color: roxo,
                                              fontFamily: "BebasNeue",
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        LinearPercentIndicator(
                                          backgroundColor:
                                              lilas.withOpacity(0.5),
                                          progressColor: lilas,
                                          percent: 0.5,
                                          lineHeight: size.height * 0.08,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          barRadius: const Radius.circular(9),
                                          animation: true,
                                          animateFromLastPercent: true,
                                        ),
                                        IconStepper(
                                          lineLength: 90,
                                          stepColor: lilas,
                                          activeStepColor: primary,
                                          activeStepBorderColor:
                                              Colors.transparent,
                                          lineColor: Colors.transparent,
                                          enableNextPreviousButtons: false,
                                          enableStepTapping: false,
                                          activeStep: 1,
                                          stepRadius: 20,
                                          activeStepBorderWidth: 5,
                                          stepReachedAnimationDuration:
                                              const Duration(seconds: 2),
                                          icons: [
                                            const Icon(
                                              MdiIcons.trophy,
                                              color: ouro,
                                              size: 24,
                                            ),
                                            const Icon(
                                              MdiIcons.trophy,
                                              color: ouro,
                                              size: 32,
                                            ),
                                            Icon(
                                              MdiIcons.trophy,
                                              color: ouro.withOpacity(0.3),
                                              size: 40,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Hero(
                                tag: "botao",
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: const BorderSide(color: primary)),
                                    fixedSize: Size(size.width * 0.9, 50),
                                  ),
                                  child: const Text(
                                    "Voltar",
                                    style: TextStyle(
                                        fontFamily: "PassionOne",
                                        fontSize: 32,
                                        color: primary),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      })),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 15, 0, 8),
                  child: Text(
                    "CONQUISTAS AINDA NÃO ALCANÇADAS",
                    style: TextStyle(
                      color: prata,
                      fontFamily: "BebasNeue",
                      fontSize: 18,
                    ),
                  ),
                ),
                CardConquista(
                  titulo: "COMPLETE: TRABALHOS ACADÊMICOS",
                  progresso: 0,
                  funcaoBotao: () {},
                  cor: laranja,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
