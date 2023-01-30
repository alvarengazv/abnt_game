import 'package:abntplaybic/modules/turma/screens/criarTurmaScreen.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:flutter/material.dart';

class TurmasPage extends StatefulWidget {
  const TurmasPage({super.key});

  @override
  State<TurmasPage> createState() => _TurmasPageState();
}

class _TurmasPageState extends State<TurmasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        elevation: 2,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "ABNT Play",
          style: TextStyle(fontFamily: "Righteous", color: roxo, fontSize: 40),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CriarTurmaScreen()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: primary, width: 2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.add_box_outlined,
                    size: 40,
                    color: primary,
                  ),
                  Text(
                    "Criar nova turma",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "BebasNeue", fontSize: 20, color: primary),
                  ),
                ],
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 8),
              child: Text(
                "Suas Turmas",
                style: TextStyle(
                  color: prata,
                  fontFamily: "BebasNeue",
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
