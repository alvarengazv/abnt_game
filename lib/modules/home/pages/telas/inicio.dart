import 'package:abntplaybic/modules/home/controllers/topicosController.dart';
import 'package:abntplaybic/modules/perfil/controller/perfilProvider.dart';
import 'package:abntplaybic/modules/perfil/models/perfilAluno.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/botoes/botao_inicio.dart';
import 'package:abntplaybic/shared/components/cards/card_notificacao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final TopicosController _topicosController = TopicosController();
  bool loading = false;
  List<Map<String, String>> listaTopicos = [];

  @override
  void initState() {
    super.initState();
    getTopicos();
  }

  getTopicos() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    listaTopicos = await _topicosController.getTopicos();

    if (context.read<PerfilProvider>().perfilAtual.runtimeType == PerfilAluno) {
      var aluno = (context.read<PerfilProvider>().perfilAtual as PerfilAluno);
      if (aluno.turma != null) {
        listaTopicos.sort((a, b) {
          aluno.turma!.topicosAtivos;
          if (aluno.turma!.topicosAtivos[b["id"]]!.contains(true)) {
            return 1;
          } else {
            return -1;
          }
        });
      }
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child:
                    Consumer<PerfilProvider>(builder: (context, value, child) {
                  return value.perfilAtual.runtimeType == PerfilAluno
                      ? Text.rich(
                          TextSpan(
                            text:
                                "${(value.perfilAtual as PerfilAluno).xpAtual} ",
                            style: const TextStyle(
                                fontFamily: "BebasNeue",
                                color: verde,
                                fontSize: 25),
                            children: const [
                              TextSpan(
                                  text: "XP",
                                  style: TextStyle(
                                      fontFamily: "BebasNeue",
                                      color: verde,
                                      fontSize: 15))
                            ],
                          ),
                        )
                      : Container();
                }),
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
        body: !loading && listaTopicos.isNotEmpty
            ? Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: CardNotificacao(),
                  ),
                  Expanded(
                    flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: GridView.builder(
                        itemCount: listaTopicos.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1 / 1.28,
                                crossAxisCount: 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        /*itemCount: listaTopicos.length % 2 == 0
                            ? listaTopicos.length ~/ 2
                            : listaTopicos.length ~/ 2 + 1,*/
                        itemBuilder: ((context, index) {
                          return BotaoInicio(
                            data: listaTopicos.elementAt(index),
                            desbloqueado: context
                                    .read<PerfilProvider>()
                                    .perfilAtual is PerfilAluno
                                ? (context.read<PerfilProvider>().perfilAtual
                                            as PerfilAluno)
                                        .turma
                                        ?.topicosAtivos[listaTopicos[index]
                                            ["id"]]!
                                        .contains(true) ??
                                    true
                                : true,
                          );
                          /*index > 0 && index + j < listaTopicos.length
                              ? index = index + j
                              : null;
                          j++;
                          listaTopicos.length > index + 1 && (index + 1) % 2 != 0
                              ? j
                              : j = 0;
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                BotaoInicio(
                                  data: listaTopicos.length > index &&
                                          index % 2 == 0
                                      ? listaTopicos.elementAt(index)
                                      : <String, String>{"titulo": ""},
                                  desbloqueado: (context
                                              .read<PerfilProvider>()
                                              .perfilAtual as PerfilAluno)
                                          .turma
                                          ?.topicosAtivos[listaTopicos[index]
                                              ["id"]]!
                                          .contains(true) ??
                                      true,
                                ),
                                BotaoInicio(
                                  data: listaTopicos.length > index + 1 &&
                                          (index + 1) % 2 != 0
                                      ? listaTopicos.elementAt(index + 1)
                                      : <String, String>{"titulo": ""},
                                  desbloqueado: listaTopicos.length > index + 1 &&
                                          (index + 1) % 2 != 0
                                      ? (context
                                                  .read<PerfilProvider>()
                                                  .perfilAtual as PerfilAluno)
                                              .turma
                                              ?.topicosAtivos[
                                                  listaTopicos[index + 1]["id"]]!
                                              .contains(true) ??
                                          true
                                      : true,
                                ),
                              ],
                            ),
                          );*/
                        }),
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: const LinearProgressIndicator(
                    color: primary,
                    backgroundColor: lilas,
                  ),
                ),
              ));
  }
}
