import 'package:abntplaybic/modules/home/models/model_conquista.dart';
import 'package:abntplaybic/modules/perfil/controller/perfilProvider.dart';
import 'package:abntplaybic/modules/perfil/models/perfilAluno.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

getLista(BuildContext context) {
    List<Conquista> lista = [
      Conquista(
        titulo: "MELHOR RANKING",
        progresso1: "Atinja o 3º lugar.",
        progresso2: "Atinja o 2º lugar.",
        progresso3: "Atinja o 1º lugar.",
        progressoAluno: (context.watch<PerfilProvider>().perfilAtual
                        as PerfilAluno)
                    .melhorRanking ==
                3
            ? 1
            : (context.watch<PerfilProvider>().perfilAtual as PerfilAluno)
                        .melhorRanking ==
                    2
                ? 2
                : (context.watch<PerfilProvider>().perfilAtual as PerfilAluno)
                            .melhorRanking ==
                        1
                    ? 3
                    : 0,
      ),
      Conquista(
        titulo: "MELHOR PONTUAÇÃO",
        progresso1: "Atinja 2000 XP.",
        progresso2: "Atinja 5000 XP.",
        progresso3: "Atinja 20000 XP.",
        progressoAluno: (context.watch<PerfilProvider>().perfilAtual
                            as PerfilAluno)
                        .xpTotal <
                    5000 &&
                (context.watch<PerfilProvider>().perfilAtual as PerfilAluno)
                        .xpTotal >=
                    2000
            ? 1
            : (context.watch<PerfilProvider>().perfilAtual as PerfilAluno)
                            .xpTotal >=
                        5000 &&
                    (context.watch<PerfilProvider>().perfilAtual as PerfilAluno)
                            .xpTotal <
                        20000
                ? 2
                : (context.watch<PerfilProvider>().perfilAtual as PerfilAluno)
                            .xpTotal >=
                        20000
                    ? 3
                    : 0,
      ),
      Conquista(
        titulo: "COMPLETE TODOS OS TESTES",
        progresso1: "Complete 15% dos testes.",
        progresso2: "Complete 50% dos testes.",
        progresso3: "Complete 100% dos testes.",
        progressoAluno: 1,
      ),
    ];
    lista.sort((a, b) => b.progressoAluno.compareTo(a.progressoAluno));
    return lista;
  }

  getProgresso(BuildContext context){
    List<Conquista> lista = getLista(context);
    int totalTrofeus = lista.length * 3;
    int totalProgresso = 0;

    for (var element in lista) {
      totalProgresso = totalProgresso + element.progressoAluno;
    }

    return ((totalProgresso/totalTrofeus)*100).toStringAsFixed(1);
  }