import 'package:abntplaybic/modules/atividades/model/atividade.dart';
import 'package:abntplaybic/shared/components/botoes/alternativaAtividade.dart';
import 'package:abntplaybic/shared/components/normas/back_button.dart';
import 'package:flutter/material.dart';

class AtividadePage extends StatefulWidget {
  final Atividade atividade;
  const AtividadePage(this.atividade, {super.key});

  @override
  State<AtividadePage> createState() => _AtividadePageState();
}

class _AtividadePageState extends State<AtividadePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FutureBuilder<Atividade>(builder: (context, snap) {
      return Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    widget.atividade.title,
                    textAlign: TextAlign.center,
                    style:
                        const TextStyle(fontFamily: "PassionOne", fontSize: 25),
                  ),
                ),
                Column(children: [
                  ...widget.atividade.altenativas
                      .map(
                        (e) => AlternativaAtividade(e),
                      )
                      .toList()
                ])
              ],
            ),
          ),
          const Positioned(top: 5, left: 5, child: BackButtonNormas())
        ],
      );
    }));
  }
}
