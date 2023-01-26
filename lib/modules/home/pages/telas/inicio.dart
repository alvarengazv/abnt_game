import 'package:abntplaybic/modules/atividades/pages/principal.dart';
import 'package:abntplaybic/modules/home/controllers/topicosController.dart';
import 'package:abntplaybic/modules/perfil/controller/perfilProvider.dart';
import 'package:abntplaybic/modules/perfil/models/perfilAluno.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/botoes/botao_inicio.dart';
import 'package:abntplaybic/shared/components/cards/card_notificacao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final TopicosController _topicosController = TopicosController();
  bool loading = false;
  List<String> listaTopicos = [];
  int j = 0;

  @override
  void initState() {
    super.initState();
    getTopicos();
  }

  getTopicos() async {
    setState(() {
      loading = true;
    });

    listaTopicos = await _topicosController.getTopicos();
    j = 0;

    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    j = 0;
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
                  return Text.rich(
                    TextSpan(
                      text: value.perfilAtual.runtimeType == PerfilAluno
                          ? "${(value.perfilAtual as PerfilAluno).xpAtual} "
                          : "- ",
                      style: const TextStyle(
                          fontFamily: "BebasNeue", color: verde, fontSize: 25),
                      children: const [
                        TextSpan(
                            text: "XP",
                            style: TextStyle(
                                fontFamily: "BebasNeue",
                                color: verde,
                                fontSize: 15))
                      ],
                    ),
                  );
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CardNotificacao(),
                  )
                ),
                Expanded(
                  flex: 9,
                  child: ListView.builder(
                      itemCount: listaTopicos.length % 2 == 0
                          ? listaTopicos.length ~/ 2
                          : listaTopicos.length ~/ 2 + 1,
                      itemBuilder: ((context, index) {
                        index > 0 && index + j < listaTopicos.length
                            ? index = index + j
                            : null;
                        j++;
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              BotaoInicio(
                                texto: listaTopicos.length > index && index % 2 == 0
                                    ? listaTopicos.elementAt(index)
                                    : "",
                                funcaoBotao: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainAtividadesPage(
                                      titulo: listaTopicos.length > index &&
                                              index % 2 == 0
                                          ? listaTopicos.elementAt(index)
                                          : "",
                                    ),
                                  ),
                                ),
                              ),
                              BotaoInicio(
                                texto: listaTopicos.length > index + 1 &&
                                        (index + 1) % 2 != 0
                                    ? listaTopicos.elementAt(index + 1)
                                    : "",
                                funcaoBotao: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainAtividadesPage(
                                        titulo: listaTopicos.length > index + 1 &&
                                                (index + 1) % 2 != 0
                                            ? listaTopicos.elementAt(index + 1)
                                            : ""),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                ),
              ],
            )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
