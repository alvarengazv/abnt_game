import 'package:abntplaybic/modules/home/controllers/topicosController.dart';
import 'package:abntplaybic/modules/home/models/model_conquista.dart';
import 'package:abntplaybic/modules/perfil/controller/perfilProvider.dart';
import 'package:abntplaybic/modules/perfil/models/perfilAluno.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

getLista(BuildContext context, List<Map<String, String>> listaTopicos, Map<String, List> mapTopicos) {
  

  int xpTotal =
      (Provider.of<PerfilProvider>(context, listen: false).perfilAtual as PerfilAluno).xpTotal;
  int melhorRanking =
      (Provider.of<PerfilProvider>(context, listen: false).perfilAtual as PerfilAluno)
          .melhorRanking;
  Map<String, Map<String, Map<String, bool>>>? feitos =
      (Provider.of<PerfilProvider>(context, listen: false).perfilAtual as PerfilAluno).feitos;

  List<Conquista> lista = [
    Conquista(
      titulo: "MELHOR RANKING",
      progresso1: "Atinja o 3º lugar.",
      progresso2: "Atinja o 2º lugar.",
      progresso3: "Atinja o 1º lugar.",
      progressoAluno: xpTotal > 0
          ? melhorRanking == 3
              ? 1
              : melhorRanking == 2
                  ? 2
                  : melhorRanking == 1
                      ? 3
                      : 0
          : 0,
    ),
    Conquista(
      titulo: "MELHOR PONTUAÇÃO",
      progresso1: "Atinja 2000 XP.",
      progresso2: "Atinja 5000 XP.",
      progresso3: "Atinja 20000 XP.",
      progressoAluno: xpTotal < 5000 && xpTotal >= 2000
          ? 1
          : xpTotal >= 5000 && xpTotal < 20000
              ? 2
              : xpTotal >= 20000
                  ? 3
                  : 0,
    ),
    Conquista(
      titulo: "COMPLETE TODOS OS TESTES",
      progresso1: "Complete 15% dos testes.",
      progresso2: "Complete 50% dos testes.",
      progresso3: "Complete 100% dos testes.",
      progressoAluno: 0,
    ),
  ];

  listaTopicos.forEach((map) {
    Map<String, Map<String, bool>>? temas = feitos?[map['id']];
    int temasSize = 0;
    int progressoAluno = 0;
    if (temas != null) {
      temasSize = mapTopicos[map["id"]]!.length;
      int progresso = 0;

      
    temas.forEach((key, value) {
      if (value['aula'] == true && value['tarefa'] == true) progresso++;
    });
      
      
      if (progresso <= 2) {
        progressoAluno = 1;
      } else if (progresso >= 3 && progresso < temasSize) {
        progressoAluno = 2;
      } else if (progresso == temasSize && temasSize != 0) {
        progressoAluno = 3;
      }
    }

    lista.add(Conquista(
      titulo: "COMPLETE: ${map['titulo']}",
      progresso1: "Complete 1 tema.",
      progresso2: "Complete 3 temas.",
      progresso3: "Complete todos os temas deste tópico.",
      progressoAluno: progressoAluno,
    ));
  });

  lista.sort((a, b) => b.progressoAluno.compareTo(a.progressoAluno));

  return lista;
}

getListaComProgresso(BuildContext context, List<Map<String, String>> listaTopicos, Map<String, List> mapTopicos) {
  List<Conquista> lista = [];
  getLista(context, listaTopicos, mapTopicos).forEach((conquista) {
      conquista.progressoAluno > 0 ? lista.add(conquista) : null;
    });
  return lista;
}

getListaSemProgresso(BuildContext context, List<Map<String, String>> listaTopicos, Map<String, List> mapTopicos) {
  List<Conquista> lista = [];
  getLista(context, listaTopicos, mapTopicos).forEach((conquista) {
        conquista.progressoAluno == 0 ? lista.add(conquista) : null;
      });

  return lista;
}

getProgressoPorcentagem(BuildContext context, List<Map<String, String>> listaTopicos, Map<String, List> mapTopicos) {
  List<Conquista> lista = getLista(context, listaTopicos, mapTopicos);
  int totalTrofeus = lista.length * 3;
  int totalProgresso = 0;

  for (var element in lista) {
    totalProgresso = totalProgresso + element.progressoAluno;
  }

  double porcentagem = ((totalProgresso / totalTrofeus) * 100);

  return !porcentagem.toStringAsFixed(1).endsWith("0")
      ? porcentagem.toStringAsFixed(1)
      : porcentagem.toInt();
}
