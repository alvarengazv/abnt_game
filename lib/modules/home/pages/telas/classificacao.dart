import 'package:abntplaybic/modules/perfil/controller/perfilProvider.dart';
import 'package:abntplaybic/modules/perfil/models/perfilAluno.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/cards/card_classificacao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassificacaoPage extends StatefulWidget {
  const ClassificacaoPage({super.key});

  @override
  State<ClassificacaoPage> createState() => _ClassificacaoPageState();
}

class _ClassificacaoPageState extends State<ClassificacaoPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Consumer<PerfilProvider>(builder: (context, value, child) {
            return Text.rich(
              TextSpan(
                text: value.perfilAtual.runtimeType == PerfilAluno
                    ? "${(value.perfilAtual as PerfilAluno).xpAtual} "
                    : "- ",
                style: const TextStyle(
                    fontFamily: "BebasNeue", color: verde, fontSize: 40),
                children: const [
                  TextSpan(
                      text: "XP",
                      style: TextStyle(
                          fontFamily: "BebasNeue", color: verde, fontSize: 20))
                ],
              ),
            );
          }),
        ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Container(
                    width: size.width * 0.9,
                    height: size.height * 0.15,
                    decoration: BoxDecoration(
                      color: lilas,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    /*child: Image.asset( ),*/ 
                  ),
                ),
                  Expanded(
                    child: Column(
                      children: [
                        CardClassificacao(
                          classificacao: 1,
                          nome: "Guilherme",
                          pontuacao: "1400",
                        ),
                        CardClassificacao(
                          classificacao: 2,
                          nome: "Pedro",
                          isUser: true,
                          pontuacao: "1200",
                        ),
                        CardClassificacao(
                          classificacao: 3,
                          nome: "João",
                          pontuacao: "1150",
                        ),
                        CardClassificacao(
                          classificacao: 4,
                          nome: "Maria",
                          pontuacao: "1036",
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
