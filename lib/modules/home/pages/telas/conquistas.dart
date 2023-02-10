import 'package:abntplaybic/modules/home/controllers/topicosController.dart';
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
  List<Conquista> listaComProgresso = [];
  List<Conquista> listaSemProgresso = [];
  final _controllerTopicos = TopicosController();
  bool loading = false;
  var percProgress;

  @override
  void initState() {
    loading = false;
    getLista();
    super.initState();
  }

  getLista() async{
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    
    var listaTopicos = await _controllerTopicos.getTopicos();

    listaComProgresso = getListaComProgresso(context, listaTopicos);
    listaSemProgresso = getListaSemProgresso(context, listaTopicos);
    percProgress = getProgressoPorcentagem(context, listaTopicos);

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

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
      body: !loading
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              height: size.height,
              child: ListView(
                children: [
                  listaComProgresso.isNotEmpty
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 18),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    "Progresso Total: $percProgress%",
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
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: List<Widget>.generate(
                                  listaComProgresso.length, (int index) {
                                return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: CardConquista(
                                      cor: azul,
                                      titulo: listaComProgresso
                                              .elementAt(index)
                                              .titulo ??
                                          "",
                                      progresso: listaComProgresso
                                          .elementAt(index)
                                          .progressoAluno,
                                      progresso1: listaComProgresso
                                              .elementAt(index)
                                              .progresso1 ??
                                          "",
                                      progresso2: listaComProgresso
                                              .elementAt(index)
                                              .progresso2 ??
                                          "",
                                      progresso3: listaComProgresso
                                              .elementAt(index)
                                              .progresso3 ??
                                          "",
                                    ));
                              }),
                            ),
                          ],
                        )
                      : SizedBox(),
                  listaSemProgresso.isEmpty
                      ? SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 0, 18),
                              child: Text(
                                "CONQUISTAS AINDA NÃO ALCANÇADAS",
                                style: TextStyle(
                                  color: prata,
                                  fontFamily: "BebasNeue",
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Column(
                              children: List<Widget>.generate(
                                  listaSemProgresso.length, (int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: CardConquista(
                                    cor: laranja,
                                    titulo: listaSemProgresso
                                            .elementAt(index)
                                            .titulo ??
                                        "",
                                    progresso: listaSemProgresso
                                        .elementAt(index)
                                        .progressoAluno,
                                    progresso1: listaSemProgresso
                                            .elementAt(index)
                                            .progresso1 ??
                                        "",
                                    progresso2: listaSemProgresso
                                            .elementAt(index)
                                            .progresso2 ??
                                        "",
                                    progresso3: listaSemProgresso
                                            .elementAt(index)
                                            .progresso3 ??
                                        "",
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                ],
              ),
            )
          : Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: const LinearProgressIndicator(
                  color: primary,
                  backgroundColor: lilas,
                ),
              ),
            ),
    );
  }
}
