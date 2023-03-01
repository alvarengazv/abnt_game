import 'package:abntplaybic/modules/atividades/controller/atividadeController.dart';
import 'package:abntplaybic/modules/atividades/pages/atividadePage.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarregaAtividadesPage extends StatefulWidget {
  const CarregaAtividadesPage(this.idTopico, this.idSubTopicos, {super.key});
  final String idTopico;
  final String idSubTopicos;
  @override
  State<CarregaAtividadesPage> createState() => _CarregaAtividadesPageState();
}

class _CarregaAtividadesPageState extends State<CarregaAtividadesPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AtividadeController>(
      create: (context) =>
          AtividadeController(widget.idTopico, widget.idSubTopicos),
      builder: (context, child) => FutureBuilder(
          future: context.read<AtividadeController>().getAtividades(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.done) {
              return AtividadePage(
                  context.watch<AtividadeController>().atividadeAtual!
                    ..altenativas.shuffle());
            }
            return Scaffold(
              body: Column(
                children: [
                  const Text("Carregando..."),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: const LinearProgressIndicator(
                        color: primary,
                        backgroundColor: lilas,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
