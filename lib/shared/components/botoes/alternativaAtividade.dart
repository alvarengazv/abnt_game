import 'package:abntplaybic/modules/atividades/controller/atividadeController.dart';
import 'package:abntplaybic/modules/atividades/model/atividade.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AlternativaAtividade extends StatelessWidget {
  final Alternativa alternativa;
  const AlternativaAtividade(this.alternativa, {super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var controller = context.read<AtividadeController>();
    return InkWell(
      onTap: () async {
        var result = context
            .read<AtividadeController>()
            .atividadeAtual!
            .checkCorrect(alternativa);
        if (result) {
          await showModalBottomSheet(
              enableDrag: false,
              context: context,
              builder: (context) => BottomSheet(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  onClosing: () {},
                  builder: (context) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Resposta correta!",
                              style: TextStyle(
                                  fontFamily: "PassionOne",
                                  fontSize: 40,
                                  color: verde),
                            ),
                            TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13)),
                                  fixedSize: Size(size.width * 0.65, 62),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  var val = controller.proximaAtividade();
                                },
                                child: const Text(
                                  "Próximo",
                                  style: TextStyle(
                                      fontFamily: "PassionOne",
                                      fontSize: 32,
                                      color: Colors.white),
                                ))
                          ],
                        ),
                      )));
        } else {
          await showModalBottomSheet(
              context: context,
              builder: (context) => BottomSheet(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  onClosing: () {},
                  builder: (context) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Resposta incorreta...",
                              style: TextStyle(
                                  fontFamily: "PassionOne",
                                  fontSize: 40,
                                  color: vermelho),
                            ),
                            TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13)),
                                  fixedSize: Size(size.width * 0.65, 62),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  var val = controller.proximaAtividade();
                                },
                                child: const Text(
                                  "Próximo",
                                  style: TextStyle(
                                      fontFamily: "PassionOne",
                                      fontSize: 32,
                                      color: Colors.white),
                                ))
                          ],
                        ),
                      )));
        }
      },
      child: Container(
          decoration: BoxDecoration(
              color: lilas, borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: size.width * .8,
          height: size.width * .15,
          alignment: Alignment.center,
          child: Text(
            alternativa.value,
            style: const TextStyle(
                fontFamily: "PassionOne", color: branco, fontSize: 25),
          )),
    );
  }
}
