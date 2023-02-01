import 'package:abntplaybic/modules/home/controllers/classificacaoController.dart';
import 'package:abntplaybic/modules/perfil/controller/perfilProvider.dart';
import 'package:abntplaybic/modules/perfil/models/perfilAluno.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/cards/card_classificacao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassificacaoPage extends StatefulWidget {
  const ClassificacaoPage({super.key});

  @override
  State<ClassificacaoPage> createState() => _ClassificacaoPageState();
}

class _ClassificacaoPageState extends State<ClassificacaoPage> {
  ClassificacaoController controller = ClassificacaoController();

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
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Container(
                        width: size.width * 0.9,
                        height: size.height * 0.15,
                        decoration: BoxDecoration(
                          color: lilas,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Ranking",
                          style: TextStyle(
                              color: primary,
                              fontSize: 35,
                              fontFamily: "BebasNeue"),
                        )
                        /*child: Image.asset( ),*/
                        ),
                  ),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: controller.getRanking((context
                              .read<PerfilProvider>()
                              .perfilAtual as PerfilAluno)
                          .turma),
                      builder: (context, snap) {
                        print(snap.data);

                        List<Widget> ranking = [];
                        if (snap.hasData) {
                          for (var i = 0; i < snap.data!.docs.length; i++) {
                            if (snap.data!.docs[i].id ==
                                FirebaseAuth.instance.currentUser!.uid) {
                              if ((context.read<PerfilProvider>().perfilAtual
                                          as PerfilAluno)
                                      .melhorRanking <
                                  i + 1) {
                                FirebaseFirestore.instance
                                    .collection("aluno")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({
                                  "melhorRanking": i + 1,
                                  "rankingAtual": i + 1
                                });
                              } else if ((context
                                          .read<PerfilProvider>()
                                          .perfilAtual as PerfilAluno)
                                      .rankingAtual !=
                                  i + 1) {
                                FirebaseFirestore.instance
                                    .collection("aluno")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({"rankingAtual": i + 1});
                              }
                            }
                            ranking.add(CardClassificacao(
                                classificacao: i + 1,
                                nome: (snap.data!.docs[i].data())["nome"] ??
                                    "\$nome",
                                isUser: snap.data!.docs[i].id ==
                                    FirebaseAuth.instance.currentUser!.uid,
                                pontuacao:
                                    (snap.data!.docs[i].data())["xpAtual"]
                                        .toString()));
                          }
                        }
                        return snap.hasData
                            ? Expanded(
                                child: Column(
                                children: ranking,
                              ))
                            : Expanded(
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
                              );
                      })
                ],
              ),
            ),
          ),
        ));
  }
}
